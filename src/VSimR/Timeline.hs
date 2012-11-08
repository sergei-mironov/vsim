module VSimR.Timeline where

import Control.Applicative
import Control.Monad
import Control.Monad.Trans

import VSimR.Ptr
import VSimR.Time
import VSimR.Signal
import VSimR.Waveform

-- | Select signals to change next
--
-- TODO: take waitable processes into account
next_event :: (MonadIO m) => [Ptr Signal] -> m ([Ptr Signal], Time)
next_event ss = foldM cmp ([],time_max) ss where
    cmp o@(l,t) r = do
        Change t' c <- event `liftM` wcurr `liftM` deref r
        case compare t' t of
            LT -> return ([r], t')
            EQ -> return (r:l, t)
            _ -> return o

advance :: (MonadIO m) => [Ptr Signal] -> Time -> m [Ptr Process]
advance (r:rs) = do
    


-- class Elaborate x 
-- elab :: (MonadIO m, MonadState Memory m) => ss -> m ()
-- elab = undefined

