module VSim.Runtime.Waveform (
      Change(..)
    , Waveform(..)
    , ProjectedWaveform(..)
    , wconst
    , event
    , valueAt
    , valueAt1
    , concatAt
    , nullPW
    , unPW
    ) where

import Data.List
import Control.Applicative
import Control.Monad
import Control.Monad.Trans
import Test.QuickCheck
import Text.Printf
import Prelude hiding(until)

import VSim.Runtime.Time

-- | Change is a part of a waveform. Semantic is:
-- foreach t . t < until => (value `at_time` t) == cvalue
--             t >= until => value is undefined
data Change a = Change {
      until :: NextTime
    , cvalue :: a
    } deriving(Show,Eq)

fromPair :: (NextTime,a) -> Change a
fromPair (a,b) = Change a b

infinity :: a -> Change a
infinity v = Change maxBound v

wcons :: (Eq a) => Change a -> [Change a] -> [Change a]
wcons c [] = [c]
wcons c@(Change t1 v1) cs@((Change t2 v2):l)
    | v1 == v2 = cs
    | t1 == t2 = c:l
    | otherwise = c:cs

wappend :: (Eq a) => [Change a] -> [Change a] -> [Change a]
wappend [] f = f
wappend p f = (init p) ++ ((last p) `wcons` f)

lsevt :: Waveform a -> [NextTime]
lsevt w = map until (init $ wchanges w)

-- | Non-empty list of changes, sorted by (until::Time). The last element should
-- specify value of the waveform at +infinity time
newtype Waveform a = Waveform {
      wchanges :: [Change a]
    } deriving(Show,Eq)

-- | Returns waveform of a constant value
wconst :: a -> Waveform a
wconst val = Waveform [infinity val]

invariant :: (Eq a) => Waveform a -> Bool
invariant w = and $ map ($w) [invariant1, invariant2]

invariant1 :: Waveform a -> Bool
invariant1 (Waveform cs) = (length cs > 0) && (until $ last cs) == maxBound

invariant2 :: (Eq a) => Waveform a -> Bool
invariant2 (Waveform cs) = and $ map check (cs `zip` (tail cs)) where
    check (Change t1 v1 , Change t2 v2) = t1 < t2 && v1 /= v2

-- | Returns time t such that: t <= t_really_next_event
event :: Waveform a -> (NextTime, Waveform a)
event (Waveform (c@(Change t _):c':cs)) = (t, Waveform (c':cs))
event (Waveform (c@(Change t _):[])) = (t, error "event: passing the end-of-time")
event (Waveform []) = error "event: attempt to unevent empty waveform"

-- | Return the value of a waveform at time t
valueAt :: Time -> Waveform a -> a
valueAt t (Waveform []) = error "valueAt: infinity invariant failed"
valueAt t (Waveform ((Change t' v):cs))
    | t `before` t' = v
    | otherwise = valueAt t (Waveform cs)

-- | Returns the value of a waveform at time t. Fails if the value can't be
-- aquired from the head change.
valueAt1 :: (Timeable t) => t -> Waveform a -> a
valueAt1 t (Waveform []) = error "valueAt1: infinity invariant failed"
valueAt1 t (Waveform ((Change t' v):_))
    | t `before` t' = v
    | otherwise = error "valueAt1: accessability invariant failed"

-- | Detect earliest change of a vaweform
earliest :: Waveform a -> Waveform a -> Ordering
earliest (Waveform ((Change t1 _):_)) (Waveform ((Change t2 _):_)) = compare t1 t2
earliest (Waveform _) (Waveform _) = error "earliest: vmpty waveform"

-- | Concats two waveforms together. Resulting value of a signal at
-- time t is a value of w2.
--
-- w1_ _/- - - -
-- w2- - -\_ _ _
--         t
--
-- r _ _/-\_ _ _
--         t
concatAt :: (Eq a) => NextTime -> Waveform a -> Waveform a -> Waveform a
concatAt t w1 w2 = Waveform (p`wappend`f) where
    (p,f) = (past t w1, future t w2)

past :: NextTime -> Waveform a -> [Change a]
past t (Waveform (c@(Change t' v'):cs))
    | t' < t = c:(past t (Waveform cs))
    | t' >= t = [Change t v']

future :: NextTime -> Waveform a -> [Change a]
future t (Waveform []) = []
future t (Waveform (c@(Change t' v'):cs))
    | t' <= t = future t (Waveform cs)
    | t' > t = c:(future t (Waveform cs))

-- | forall t . t >=  psince => (valueAt t PW) == (valueAt t pwave)
--              t < psince => (valueAt t PW) == undefined
data ProjectedWaveform a = PW {
      psince :: NextTime
    , pwave :: Waveform a
    } deriving(Show)

nullPW = PW maxBound (wconst 0)

-- | Takes the current and the projected waveforms, returns resulting waveform
unPW :: (Eq a) => Waveform a -> ProjectedWaveform a -> Waveform a
unPW w (PW s w') = concatAt s w w'

appendPW :: (Eq a) => ProjectedWaveform a -> ProjectedWaveform a -> ProjectedWaveform a
appendPW (PW s1 w1) (PW s2 w2) = PW (s1 `min` s2) (concatAt (s1`max`s2) w1 w2)

-- new_changes :: Waveform a -> Waveform a -> [NextTime]
-- new_changes wf

{- Tests -}

instance (Arbitrary a) => Arbitrary (Change a) where
    arbitrary = Change <$> arbitrary <*> arbitrary

instance (Eq a, Arbitrary a) => Arbitrary (Waveform a) where
    arbitrary = do
        Ordered ts <- arbitrary
        cinf <- infinity <$> arbitrary
        Waveform <$> foldM f [cinf] (reverse ts)
            where f cs t = wcons <$> (Change <$> pure t <*> arbitrary) <*> pure cs

instance (Eq a, Arbitrary a) => Arbitrary (ProjectedWaveform a) where
    arbitrary = do
        w@(Waveform (c:_)) <- arbitrary
        s <- suchThat arbitrary (<=(until c))
        return $ PW s w

newtype EvenTimes = EvenTimes [NextTime]
    deriving(Show, Eq)

instance Arbitrary EvenTimes where
    arbitrary = EvenTimes <$> (lsevt <$> (arbitrary :: Gen (Waveform Int)))

prop_inv w = invariant w

prop_border1 w1 = (future maxBound w1) == []

prop_border2 w1 = (Waveform $ past maxBound w1) == w1

prop_border3 w1 w2 = (concatAt maxBound w1 w2) == w1 

prop_concat1 (TestTime nt t) w1 w2 = invariant (concatAt nt w1 w2)

prop_concat2 (TestTime nt t) w1 w2 = (valueAt t (concatAt nt w1 w2)) == (valueAt t w2)

prop_concat3 (TestTime nt t) w1 w2 = (valueAt t (concatAt (nt`ticked`1) w1 w2)) == (valueAt t w1)

