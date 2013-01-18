module VSim.Runtime.Time (
      Time
    , NextTime(..) -- FIXME: hide constructors
    , TestTime(..)
    , Timeable(..)
    , move_time
    , before
    , milliSecond
    , microSecond
    , nanoSecond
    , picoSecond
    , femtoSecond
    ) where

import Control.Applicative
import Control.Monad
import Text.Printf
import Test.QuickCheck

-- | Current simulation time representation. Time is measured in femtoseconds.
-- User normally can't do anything with this time except watching at it.
newtype Time = Time { unTime :: Int }
    deriving(Show,Eq,Ord)

-- | Next time representation for future planning.
newtype NextTime = NextTime { unNextTime :: Int }
    deriving(Show,Eq,Ord)

instance Bounded Time where
    minBound = Time 0
    maxBound = Time (maxBound-1)

instance Bounded NextTime where
    minBound = NextTime 1
    maxBound = NextTime (maxBound)

class Timeable x where
    watch :: x -> Int
    ticked :: x -> Int -> NextTime

-- | <
before :: (Timeable t1, Timeable t2) => t1 -> t2 -> Bool
before t1 t2 = (watch t1) < (watch t2)

-- | Move the time after upperBound check
move_time :: NextTime -> NextTime -> Maybe Time
move_time nt@(NextTime t) maxt
    | nt >= maxt = Nothing
    | otherwise = Just (Time t)

instance Timeable Time where
    watch (Time x) = x
    ticked (Time x) v
        | (x + v) <= x = error "ticked: can not decrement time"
        | otherwise = NextTime (x + v)

instance Timeable NextTime where
    watch (NextTime x) = x
    ticked (NextTime x) v
        | (x + v) <= x = error "ticked: can not decrement time"
        | otherwise = NextTime (x + v)

milliSecond, microSecond, nanoSecond, picoSecond, femtoSecond :: Int
milliSecond = 1000*microSecond
microSecond = 1000*nanoSecond
nanoSecond  = 1000*picoSecond
picoSecond  = 1000*femtoSecond
femtoSecond  = 1

instance Arbitrary NextTime where
    arbitrary = suchThat (NextTime <$> arbitrary) (\t -> t>=minBound && t<=maxBound)

-- | Helper for testing purposes. Generates a pir of Time and NextTime
-- which represent the same moment of time.
data TestTime = TestTime NextTime Time
    deriving(Show)

instance Arbitrary TestTime where
    arbitrary = do
        let mx = min (unTime maxBound) (unNextTime maxBound)
        let mn = max (unTime minBound) (unNextTime minBound)
        t <- frequency [
              (1, pure mn)
            , (1, pure (mn+1))
            , (10, suchThat arbitrary (\t -> t>=mn && t <= mx))
            , (1, pure (mx-1))
            , (1, pure mx)
            ]
        return $ TestTime (NextTime t) (Time t)

