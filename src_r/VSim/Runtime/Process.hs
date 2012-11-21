{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeSynonymInstances #-}

module VSim.Runtime.Process where

import Control.Applicative
import Control.Monad.Trans
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.BP
import Control.Monad
import Text.Printf

import VSim.Runtime.Monad
import VSim.Runtime.Time
import VSim.Runtime.Ptr
import VSim.Runtime.Waveform
import VSim.Runtime.Constraint

class Valueable x where
    val :: (MonadProc PS m) => x -> m Int

instance Valueable Int where
    val r = return r

data Variable = Variable {
      vname :: String
    , vval :: Int
    , vconstr :: Constraint
    } deriving(Show)

instance Valueable (Ptr Variable) where
    val r = vval `liftM` deref r

instance Constrained Variable where
    within v = within (vval v, vconstr v)

data Signal = Signal {
      sname :: String
    , scurr :: Waveform
    , oldvalue :: Int
    , sconstr :: Constraint
    , proc :: [Ptr Process]
    } deriving(Show)

chwave :: Waveform -> Signal -> Signal
chwave w s = s { scurr = w }

addproc :: Ptr Process -> Signal -> Signal
addproc p s = s { proc = p:(proc s) }

instance Constrained Signal where
    within s = and $ map f $ wchanges $ scurr s where
        f (Change _ v) = within (v, sconstr s)

instance Valueable (Ptr Signal) where
    val r = valueAt1 <$> now <*> (scurr `liftM` deref r)

printSignalM :: (MonadIO m) => Ptr Signal -> m String
printSignalM r = deref r >>= return . printSignal

printSignal :: Signal -> String
printSignal s = printf "signal %s wave %s" (sname s) (printWaveform (scurr s))

-- | Assignment event
data Assignment = Assignment {
      acurr :: Ptr Signal
    , anext :: ProjectedWaveform
    } deriving(Show)

-- | Process State
data PS = PS {
      ptime :: Time
    , passignments :: [Assignment]
    } deriving(Show)

add_assignment :: Assignment -> PS -> PS
add_assignment a (PS t as) = PS t (a:as)

type ProcessHandler = VProc PS VSim ()

-- | Representation of VHDL's process
data Process = Process {
      pname :: String
    -- ^ The name of a process
    , phandler :: ProcessHandler
    -- ^ Returns newly-assigned signals
    }

instance Show Process where
    show p = printf "Process { pname = \"%s\", <handler> }" (pname p)

now :: (MonadProc PS m) => m Time
now = ptime <$> get

ms :: (MonadProc PS m) => Time -> m Time
ms t = (+) <$> now <*> (pure $ t * milliSecond)

us :: (MonadProc PS m) => Time -> m Time
us t = (+) <$> now <*> (pure $ t * microSecond)

ps :: (MonadProc PS m) => Time -> m Time
ps t = (+) <$> now <*> (pure $ t * picoSecond)

ns :: (MonadProc PS m) => Time -> m Time
ns t = (+) <$> now <*> (pure $ t * nanoSecond)

fs :: (MonadProc PS m) => Time -> m Time
fs t = (+) <$> now <*> (pure $ t * femtoSecond)

int :: (MonadProc s m) => Int -> m Int
int = return

str :: (MonadProc s m) => String -> m String
str = return

-- | Tweaks time for 'after' clause
--
-- VHDL standatd says:
-- > If the after clause of a waveform element is not present, then an
-- > implicit “after 0 ns” is assumed.
--
-- So "after 0 fs" means "next delta-cycle" and "after 1 fs" means "next
-- delta-cycle" since our delta cycle is 1 fs. So we have to substract 1 cycle
-- from 'after' time @t@ if it is greater then current time @n@.
tweak_after :: Time -> Time -> Time
tweak_after n t
    | t <= n = t
    | t > n = t-1

-- | Assigns new constant waveform to a signal
assign :: (MonadProc PS m) => Ptr Signal -> (m Time, m Int) -> m ()
assign p (mt,mv) = do
    time <- liftM2 tweak_after now mt
    a <- Assignment <$> pure p <*> (PW <$> pure time <*> (wconst <$> mv))
    modify (add_assignment a)

add, (.+.) :: (MonadProc PS m) => m Int -> m Int -> m Int
add a b = (+) <$> a <*> b
(.+.) = add

minus, (.-.) :: (MonadProc PS m) => m Int -> m Int -> m Int
minus a b = (-) <$> a <*> b
(.-.) = minus

greater, (.>.) :: (MonadProc PS m) => m Int -> m Int -> m Bool
greater a b = (>) <$> a <*> b
(.>.) = greater

greater_eq, (.>=.) :: (MonadProc PS m) => m Int -> m Int -> m Bool
greater_eq a b = (>=) <$> a <*> b
(.>=.) = greater_eq

eq, (.==.) :: (MonadProc PS m) => m Int -> m Int -> m Bool
eq a b = (==) <$> a <*> b
(.==.) = eq

iF :: (MonadProc PS m) => m Bool -> m () -> m () -> m ()
iF exp m1 m2 = exp >>= \ r -> if r then m1 else m2

stable :: (Monad m) => Int -> m Int
stable i = return i

runProcess :: Time -> Process -> VSim [Assignment]
runProcess t (Process _ h) = passignments <$> runVProc h (PS t [])

report :: (MonadProc PS m) => m String -> m ()
report s = pause =<< (Report <$> now <*> pure Low <*> s)

assert :: (MonadProc PS m) => m ()
assert = pause =<< (Report <$> now <*> pure High <*> pure "assert")

breakpoint :: (MonadProc PS m) => m ()
breakpoint = pause =<< (BreakHit <$> now <*> pure 0)

