{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}

module VSim.Runtime.Timeline (
      timewheel
    ) where

import Control.Applicative
import Control.Monad
import Control.Monad.Trans
import Data.Maybe
import Data.Monoid
import Text.Printf

import VSim.Runtime.Monad
import VSim.Runtime.Time
import VSim.Runtime.Waveform
import VSim.Runtime.Process

data ES = ES [(Ptr Signal, Waveform)] Event
    deriving(Show)

instance Monoid ES where
    mempty = ES mempty mempty
    mappend (ES a b) (ES x y) = ES (a`mappend`x) (b`mappend`y)

class Eventable x where
    next_event :: (MonadIO m, Applicative m, MonadMem m)
        => NextTime -> x -> m (NextTime, ES)

instance Eventable (Ptr Signal) where
    next_event tdef r = do
        s <- derefM r
        let (t,w) = event $ scurr s
        return (t, ES [(r,w)] $ Event (proc s) [])

instance Eventable (Ptr Waitable) where
    next_event tdef r = do
        t' <- fst <$> fromMaybe (tdef, undefined) <$> wnext <$> derefM r
        return (t', ES [] $ Event [] [r])

collect :: (MonadIO m, Applicative m, Eventable e, MonadMem m)
    => NextTime -> [e] -> (NextTime, ES) -> m (NextTime, ES)
collect tdef es init = foldM cmp init es where
    cmp (t,e) x = do
        (t',e') <- next_event tdef x
        case (compare t' t) of
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

-- | Calculates next event and updates the memory
update_mem :: (MonadSim m) => NextTime -> m (NextTime, Event)
update_mem tdef = do
    (ss,ws) <- (\a b -> (a,b)) <$> (msignals<$>get_mem) <*> (mwaitbales<$>get_mem)
    (t', ES sas ev) <- (collect tdef ss >=> collect tdef ws) (maxBound, mempty)
    forM_ sas (\(r,w) -> updateM (chwave w) r)
    return (t', ev)

timewheel :: (Time, Event) -> VSim (NextTime, Event)
timewheel (t, Event ps ws) = do
    let wupdate (x,(r,w)) = writeM r w >> return x
    as1 <- concat <$> mapM (derefM >=> runProcess t) ps
    as2 <- concat <$> mapM (derefM' >=> runWaitable t >=> wupdate) ws
    commit t $ concat [as1,as2]
    update_mem (t`ticked`1)

