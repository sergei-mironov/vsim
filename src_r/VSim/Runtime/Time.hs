module VSim.Runtime.Time (
      Time
    , NextTime
    , TestTime(..)
    , Timeable(..)
    , move_time
    -- , time_after
    -- , time_not_greater
    , before
    , milliSecond
    , microSecond
    , nanoSecond
    , picoSecond
    , femtoSecond
    -- , arbitrary_timeline
    ) where

import Control.Applicative
import Control.Monad
import Text.Printf
import Test.QuickCheck

newtype Time = Time { unTime :: Int }
    deriving(Show,Eq,Ord)

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

-- | >
-- time_after :: (Timeable t1, Timeable t2) => t1 -> t2 -> Bool
-- time_after t1 t2 = (unTime t1) > (unTime t2)

-- | <=
-- time_not_greater :: (Timeable t1, Timeable t2) => t1 -> t2 -> Bool
-- time_not_greater t1 t2 = (unTime t1) <= (unTime t2)

milliSecond, microSecond, nanoSecond, picoSecond, femtoSecond :: Int
milliSecond = 1000*microSecond
microSecond = 1000*nanoSecond
nanoSecond  = 1000*picoSecond
picoSecond  = 1000*femtoSecond
femtoSecond  = 1

instance Arbitrary NextTime where
    arbitrary = suchThat (NextTime <$> arbitrary) (\t -> t>=minBound && t<=maxBound)

-- | Container for time
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

-- arbitrary_timeline :: Int -> Gen [NextTime]
-- arbitrary_timeline sz = do
--     let foldM' a b f = foldM f a b
--     reverse <$> snd <$> (foldM' (minBound,[]) [1..sz] $ \(m, vs) _ -> do
--         v <- suchThat arbitrary (>m)
--         return (v, v:vs))

