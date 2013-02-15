{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- | Module declares various process-level DSL combinators
module VSim.Runtime.Process where

import Data.Int
import Data.List
import Data.Monoid
import qualified Data.IntMap as IntMap
import Control.Applicative
import Control.Monad.Loop
import Control.Monad.Trans
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.BP2
import Control.Monad
import Text.Printf

import VSim.Runtime.Monad
import VSim.Runtime.Class
import VSim.Runtime.Time
import VSim.Runtime.Waveform
import VSim.Runtime.Ptr

class (Monad m) => Appendable m x where
    (.++.) :: m x -> m x -> m x

instance (Monad m, Monoid x) => Appendable m x where
    (.++.) ms1 ms2 = mappend `liftM` ms1 `ap` ms2

ms :: (MonadProc m) => Int64 -> m NextTime
ms t = ticked <$> now <*> (pure $ t * milliSecond)

us :: (MonadProc m) => Int64 -> m NextTime
us t = ticked <$> now <*> (pure $ t * microSecond)

ps :: (MonadProc m) => Int64 -> m NextTime
ps t = ticked <$> now <*> (pure $ t * picoSecond)

ns :: (MonadProc m) => Int64 -> m NextTime
ns t = ticked <$> now <*> (pure $ t * nanoSecond)

fs :: (MonadProc m) => Int64 -> m NextTime
fs t = ticked <$> now <*> (pure $ t * femtoSecond)

next :: (MonadProc m) => m NextTime
next = fs 1

wait_until nt = nt >>= \t -> wait (PP [] (Just t))
wait_on ss = wait (PP ss Nothing)

{-
plan'n'rsort :: (MonadProc m) =>
    m x -> [(m NextTime, Agg (Assign m) x)] -> m [(NextTime,Plan)]
plan'n'rsort mr ls = do
    r <- mr
    ls' <- forM ls $ \(mt, f) -> do
            t <- mt
            p <- runAssign (f r)
            return (t,p)
    let tcomp (t1,_) (t2,_) = t1`compare`t2
    return (reverse $ sortBy tcomp ls')

-- | Converts time-value pairs to the list of assignments
makePW :: (MonadPtr m) => [(NextTime,Plan)] -> m [Assignment Int]
makePW ls = do
    let retlist = return . map snd . IntMap.toList
    let execM e s = flip execStateT e s >>= retlist
    let merge (Assignment s (PW t w)) (Assignment _ (PW t' w')) = 
         Assignment s (PW t (concatAt t' w w'))
    execM IntMap.empty $ do
        forM_ ls $ \(time, plans) -> do
            forM_ plans $ \(sig,v) -> do
                sigid <- lift $ signalUniqIq sig
                modify $ IntMap.insertWith merge sigid
                    (Assignment sig $ PW time (wconst v))

(.<<=.) :: (MonadProc m) => m x -> [(m NextTime, Agg (Assign m) x)] -> m ()
(.<<=.) mr ls = do
    plan'n'rsort mr ls >>= makePW >>= mapM_ (modify . add_assignment)

-}

(.<=.) :: (MonadProc m) => m x -> (m NextTime, Agg (Assign m) x) -> m ()
(.<=.) mr (mt,f) = do
    time <- mt
    r <- mr
    plan <- runAssign (f r)
    forM_ plan $ \(sig,v) -> apply_simple_assignment sig time v

(.=.) :: (Monad m) => m Variable -> (Agg (Assign m) Variable) -> m ()
(.=.) mr f = mr >>= \r -> runAssign (f r) >> return ()

add, (.+.) :: (MonadPtr m, Valueable m x, Valueable m y) => m x -> m y -> m Int
add ma mb = (+) <$> (val =<< ma) <*> (val =<< mb)
(.+.) = add

minus, (.-.) :: (MonadProc m, Valueable m x, Valueable m y) => m x -> m y -> m Int
minus ma mb = (-) <$> (val =<< ma) <*> (val =<< mb)
(.-.) = minus

greater, (.>.) :: (MonadProc m, Valueable m x, Valueable m y) => m x -> m y -> m Bool
greater ma mb = (>) <$> (val =<< ma) <*> (val =<< mb)
(.>.) = greater

greater_eq, (.>=.) :: (MonadProc m, Valueable m x, Valueable m y) => m x -> m y -> m Bool
greater_eq ma mb = (>=) <$> (val =<< ma) <*> (val =<< mb)
(.>=.) = greater_eq

eq, (.==.) :: (MonadProc m, Valueable m x, Valueable m y) => m x -> m y -> m Bool
eq ma mb = (==) <$> (val =<< ma) <*> (val =<< mb)
(.==.) = eq

-- | if and else
iF :: (MonadProc m) => m Bool -> m () -> m () -> m ()
iF exp m1 m2 = exp >>= \ r -> if r then m1 else m2

-- | if without else
iF_ :: (MonadProc m) => m Bool -> m () -> m ()
iF_ exp m1 = iF exp m1 (return ())

data ForDirection = To | Downto
    deriving(Show)

-- | Monadic for
for :: (MonadProc m) => (m Int, ForDirection, m Int) -> (Int -> m ()) -> m ()
for (ma,dir,mb) body = join $ for' <$> ma <*> pure dir <*> mb <*> pure body

for' a To b body = loopM_ a $ \i -> body i >> return (i+1,i==b)
for' a Downto b body = loopM_ b $ \i -> body i >> return (b-1,i==a)

callf :: Elab (VProc l2) (VProc l1 ()) -> VProc l2 l1
callf e = do
    (p,_) <- runElab e
    e <- catchEarlyV p
    case e of
        Left ret -> return ret
        Right () -> fail "function didn't call return"

callp :: Elab (VProc l2) (VProc () ()) -> VProc l2 ()
callp e = do
    (p,_) <- runElab e
    catchEarlyV p
    return ()

(<<) :: Monad m => (a -> m b) -> m a -> m b
(<<) = (=<<)
infixl 1 <<

retf :: VProc l l -> VProc l ()
retf ml = ml >>= \l -> VProc (retBP l)

retp :: () -> VProc () ()
retp () = VProc (retBP ())

nop () = return ()

