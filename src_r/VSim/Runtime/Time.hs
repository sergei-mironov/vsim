module VSim.Runtime.Time (
      Time
    , NextTime(..)
    , TestTime(..)
    , Timeable(..)
    , move_time
    , time_after
    , time_not_greater
    , time_before
    , milliSecond
    , microSecond
    , nanoSecond
    , picoSecond
    , femtoSecond
    , arbitrary_timeline
    ) where

import Control.Applicative
import Control.Monad
import Test.QuickCheck

newtype Time = Time Int
    deriving(Show,Eq,Ord)

newtype NextTime = NextTime Int
    deriving(Show,Eq,Ord)

instance Bounded Time where
    minBound = Time 0
    maxBound = Time (maxBound-1)

instance Bounded NextTime where
    minBound = NextTime 1
    maxBound = NextTime (maxBound)

class Timeable x where
    unTime :: x -> Int
    ticked :: x -> Int -> NextTime

move_time :: NextTime -> Maybe Time
move_time (NextTime t)
    | (Time t) <= maxBound && (Time t) >= minBound = Just (Time t)
    | otherwise = Nothing

instance Timeable Time where
    unTime (Time x) = x
    ticked (Time x) v
        | (x + v) <= x = error "ticked: can not decrement time"
        | otherwise = NextTime $ x + v

instance Timeable NextTime where
    unTime (NextTime x) = x
    ticked (NextTime x) v
        | (x + v) <= x = error "ticked: can not decrement time"
        | otherwise = NextTime $ x + v

-- | >
time_after :: (Timeable t1, Timeable t2) => t1 -> t2 -> Bool
time_after t1 t2 = (unTime t1) > (unTime t2)

-- | >
time_before :: (Timeable t1, Timeable t2) => t1 -> t2 -> Bool
time_before t1 t2 = (unTime t1) < (unTime t2)

-- | <=
time_not_greater :: (Timeable t1, Timeable t2) => t1 -> t2 -> Bool
time_not_greater t1 t2 = (unTime t1) <= (unTime t2)

milliSecond, microSecond, nanoSecond, picoSecond, femtoSecond :: Int
milliSecond = 1000*microSecond
microSecond = 1000*nanoSecond
nanoSecond  = 1000*picoSecond
picoSecond  = 1000*femtoSecond
femtoSecond  = 1

instance Arbitrary NextTime where
    arbitrary = NextTime <$> suchThat arbitrary (\x -> x>=1 && x <= maxBound)

-- | Container for time
data TestTime = TestTime NextTime Time
    deriving(Show)

instance Arbitrary TestTime where
    arbitrary = do
        t <- frequency [
            (1, pure 0),
            (1, pure 1),
            (1, pure (maxBound-2)),
            (1, pure (maxBound-1)),
            (10, suchThat arbitrary (>=0))]
        return $ TestTime (NextTime t) (Time t)

arbitrary_timeline :: Int -> Gen [NextTime]
arbitrary_timeline sz = do
    let foldM' a b f = foldM f a b
    reverse <$> snd <$> (foldM' (minBound,[]) [1..sz] $ \(m, vs) _ -> do
        v <- suchThat arbitrary (>m)
        return (v, v:vs))

