{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}

module VSim.Runtime.Timeline (
      tupdate
    ) where

import Control.Applicative
import Control.Monad
import Control.Monad.Trans
import Control.Monad.Maybe
import Data.Maybe
import Data.Monoid
import Text.Printf

import VSim.Runtime.Monad
import VSim.Runtime.Time
import VSim.Runtime.Waveform
import VSim.Runtime.Process
import VSim.Runtime.Constraint

data E1 = E1 {
      e1signal :: [(Ptr Signal, Waveform)]
    , e1event :: Event
    } deriving(Show)

instance Monoid E1 where
    mempty = E1 mempty mempty
    mappend (E1 a b) (E1 x y) = E1 (a`mappend`x) (b`mappend`y)

class Eventable x where
    next_event :: (MonadIO m, Applicative m, MonadMem m)
        => NextTime -> x -> m (Maybe (NextTime, E1))

instance MonadMem m => MonadMem (MaybeT m) where
    get_mem = lift $ get_mem
    put_mem = lift . put_mem

instance Eventable (Ptr Signal) where
    next_event tdef r = runMaybeT $ do
        s <- derefM r
        (t,w) <- MaybeT $ return $ event $ scurr s
        return (t, E1 [(r,w)] $ Event (proc s) [])

instance Eventable (Ptr Waitable) where
    next_event tdef r = do
        t' <- fst <$> fromMaybe (tdef, undefined) <$> wnext <$> derefM r
        return $ Just (t', E1 [] $ Event [] [r])

collect :: (MonadIO m, Applicative m, Eventable e, MonadMem m)
    => NextTime -> [e] -> (NextTime, E1) -> m (NextTime, E1)
collect tdef es init = foldM cmp init es where
    cmp (t,e) x = do
        me <- next_event tdef x
        case me of
            Nothing -> return (t,e)
            Just (t',e') -> case (compare t' t) of
                LT -> return (t', e')
                EQ -> return (t, e'`mappend`e)
                _ -> return (t,e)

-- | Commits signal assignments
-- FIXME: monitor multiple assignments, implement resolvers
-- FIXME: return some hint on signals to process next
-- FIXME: for each signal, take only the last assignment into account
commit :: (MonadSim m) => Time -> [Assignment] -> m ()
commit t as = do
    forM_ as $ \(Assignment r pw) -> do
        s@(Signal n w o c p) <- derefM r
        let s' = chwave (unPW w pw) s
        case (within s') of
            True -> writeM r s'
            False -> do
                let err = printf "constraint check failed: signal %s" (sname s)
                terminate t err

-- | Next time
advance :: (MonadSim m) =>
    NextTime -> [Ptr Signal] -> [Ptr Waitable] -> m (NextTime, Event)
advance tn ss ws = do
    (t', E1 us ev) <- (collect tn ss >=> collect tn ws) (maxBound, mempty)
    forM_ us (\(r,w) -> updateM (chwave w) r)
    return (t', ev)

tupdate :: (Time, Event) -> VSim (NextTime, Event)
tupdate (t, Event ps ws) = do
    as1 <- concat <$> mapM (derefM >=> runProcess t) ps
    as2 <- concat <$> mapM (derefM' >=> runWaitable t >=> wupdate) ws
    commit t $ concat [as1,as2]
    m <- get_mem
    advance (t`ticked`1) (msignals m) (mwaitbales m)
    where
        wupdate (x,(r,w)) = writeM r w >> return x

