module VSimR.Waveform where

import Data.List
import Control.Applicative
import Control.Monad
import Control.Monad.Trans
import Test.QuickCheck
import Prelude hiding(until)

import VSimR.Time

-- | Change is a part of a waveform. More or less formal definition is:
-- foreach t . t <= until => (value `at_time` t) == cvalue
--             t > until => value is undefined
data Change = Change {
      until :: Time
    , cvalue :: Int
    } deriving(Show)

fromPair :: (Time,Int) -> Change
fromPair (a,b) = Change a b

infinity :: Int -> Change
infinity v = Change time_max v

wcons :: Change -> [Change] -> [Change]
wcons c [] = [c]
wcons c@(Change t1 v1) cs@((Change t2 v2):l)
    | v1 == v2 = cs
    | t1 == t2 = c:l
    | otherwise = c:cs

wappend :: [Change] -> [Change] -> [Change]
wappend [] f = f
wappend p f = (init p) ++ ((last p) `wcons` f)

-- | Non-empty list of changes, sorted by (until::Time). The last element should
-- specify value of the waveform at +infinity time
data Waveform = Waveform {
      wchanges :: [Change]
    } deriving(Show)

invariant :: Waveform -> Bool
invariant w = and $ map ($w) [invariant1, invariant2]

invariant1 :: Waveform -> Bool
invariant1 (Waveform cs) = (length cs > 0) && (until $ last cs) == time_max

invariant2 :: Waveform -> Bool
invariant2 (Waveform cs) = and $ map check (cs `zip` (tail cs)) where
    check (Change t1 _ , Change t2 _) = t1 < t2

-- | Returns waveform of a constant value
wconst :: Int -> Waveform
wconst val = Waveform [infinity val]

-- | Modifies the Waveform, example:
-- *Waweform> after 5 2 $ stable 0
-- Waveform [Change {until = 5, cvalue = 0},Change {until = 2147483647, cvalue = 2}] 
-- after :: Time -> Int -> Waveform -> Waveform
-- after t v (Waveform cs) = Waveform (past ++ tweak future) where
--     (future,past) = partition (\(Change t' _) -> t' >= t) cs
--     tweak ((Change t' v'):[])
--         | t' == time_max = (Change t v'):(Change t' v):[]
--         | otherwise = error "Waveform invariant failed"
--     tweak ((Change t' v'):(Change t'' v''):cs)
--         | t == t' = (Change t' v'):(Change t'' v):cs
--         | otherwise = (Change t v'):((Change t' v)):(Change t'' v''):cs

-- | Cuts off all transitions before `now` from the waveform.
-- advance :: Time -> Waveform -> Waveform
-- advance now (Waveform w) = Waveform (filter future w) where
--     future (Change u _) = u >= now

-- | Return next waveform event
event :: Waveform -> (Change, Waveform)
event (Waveform (c:c':cs)) = (c, Waveform (c':cs))
event (Waveform [c]) = (c, Waveform [c])
event (Waveform []) = error "event: attempt to unevent empty waveform"

-- | Return the value of a waveform at time t
valueAt :: Time -> Waveform -> Int
valueAt t (Waveform []) = error "valueAt: infinity invariant failed"
valueAt t (Waveform ((Change t' v):cs))
    | t > t' = valueAt t (Waveform cs)
    | otherwise = v

-- | Returns the value of a waveform at time t. Fails if the value can't be
-- aquired from the head change.
valueAt1 :: Time -> Waveform -> Int
valueAt1 t (Waveform []) = error "valueAt1: infinity invariant failed"
valueAt1 t (Waveform ((Change t' v):_))
    | t <= t' = v
    | otherwise = error "valueAt1: accessability invariant failed"

-- | Detect earliest change of a vaweform
earliest :: Waveform -> Waveform -> Ordering
earliest (Waveform ((Change t1 _):_)) (Waveform ((Change t2 _):_)) = compare t1 t2
earliest (Waveform _) (Waveform _) = error "earliest: vmpty waveform"

-- | Concats two waveforms together. Resulting value of a signal at
-- time t is a value of w1.
--
-- w1_ _/- - - -
-- w2- - -\_ _ _
--         t
--
-- r _ _/- -\_ _
--         t
concatAt :: Time -> Waveform -> Waveform -> Waveform
concatAt t (Waveform c1) (Waveform c2) = Waveform new where
    new = p `wappend` ((Change t v)`wcons`f)
    (p,(Change _ v):_) = span (\(Change t' _) -> t' < t) c1
    (_,f) = span (\(Change t' _) -> t' <= t) c2

-- | forall t . t >  psince => define (valueAt t PW) == valueAt t pwave
--              t <= psince => (valueAt t PW) is undefined
data ProjectedWaveform = PW {
      psince :: Time
    , pwave :: Waveform
    } deriving(Show)

nullPW = PW time_max (wconst 0)

-- | Takes the current and the projected waveforms, returns resulting waveform
unPW :: Waveform -> ProjectedWaveform -> Waveform
unPW w (PW s w') = concatAt s w w'

appendPW :: ProjectedWaveform -> ProjectedWaveform -> ProjectedWaveform
appendPW (PW s1 w1) (PW s2 w2) = PW (s1 `min` s2) (concatAt (s1`max`s2) w1 w2)

concatProjectedAt :: Time -> Waveform -> ProjectedWaveform -> Waveform
concatProjectedAt t w p = concatAt t w (unPW w p)


{- Tests -}

instance Arbitrary Change where
    arbitrary = Change <$> arbitrary <*> arbitrary

instance Arbitrary Waveform where
    arbitrary = oneof [
          do
            let max = 5
            sz <- elements [1..max]
            vs <- vectorOf (max+1) arbitrary
            let foldM' a b f = foldM f a b
            ts <- reverse <$> snd <$> (foldM' (0,[]) [1..sz] $ \(m, vs) _ -> do
                v <- suchThat arbitrary (>m)
                return (v, v:vs))
            let l = map fromPair (ts`zip`vs) ++ [infinity $ last vs]
            return $ Waveform $ l
        , do
            wconst <$> arbitrary
        ]

instance Arbitrary ProjectedWaveform where
    arbitrary = do
        w@(Waveform (c:_)) <- arbitrary
        s <- choose (0,until c)
        return $ PW s w

-- | Container for time
data TestTime = TestTime Time
    deriving(Show)

instance Arbitrary TestTime where
    arbitrary = TestTime <$> frequency [
        (1, pure 0),
        (1, pure 1),
        (1, pure time_max),
        (1, pure (time_max-1)),
        (10, suchThat arbitrary (>=0))]

prop_concat1 (TestTime t) w1 w2 = (valueAt t (concatAt t w1 w2)) == (valueAt t w1)

prop_concat2 (TestTime t) w1 w2 =
    t < time_max && t >= 0 ==> (valueAt (t+1) (concatAt t w1 w2)) == (valueAt (t+1) w2)

prop_concat3 (TestTime t) w1 w2 =
    t <= time_max && t > 0 ==> (valueAt (t-1) (concatAt t w1 w2)) == (valueAt (t-1) w1)

prop_concat4 (TestTime t) w1 w2 = invariant (concatAt t w1 w2)

prop_pconcat1 (TestTime t) w pw = invariant (concatProjectedAt t w pw)
    
prop_pw1 (TestTime t) w = valueAt t (unPW w nullPW) == valueAt t w



