module VSim.Runtime.Waveform where

import Data.List
import Control.Applicative
import Control.Monad
import Control.Monad.Trans
import Test.QuickCheck
import Text.Printf
import Prelude hiding(until)

import VSim.Runtime.Time

-- | Change is a part of a waveform. More or less formal definition is:
-- foreach t . t <= until => (value `at_time` t) == cvalue
--             t > until => value is undefined
data Change = Change {
      until :: NextTime
    , cvalue :: Int
    } deriving(Show,Eq)

fromPair :: (NextTime,Int) -> Change
fromPair (a,b) = Change a b

infinity :: Int -> Change
infinity v = Change maxBound v

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
    } deriving(Show,Eq)

-- | Returns waveform of a constant value
wconst :: Int -> Waveform
wconst val = Waveform [infinity val]

invariant :: Waveform -> Bool
invariant w = and $ map ($w) [invariant1, invariant2]

invariant1 :: Waveform -> Bool
invariant1 (Waveform cs) = (length cs > 0) && (until $ last cs) == maxBound

invariant2 :: Waveform -> Bool
invariant2 (Waveform cs) = and $ map check (cs `zip` (tail cs)) where
    check (Change t1 v1 , Change t2 v2) = t1 < t2 && v1 /= v2

-- | Returns time t such that: t <= t_really_next_event
event :: Waveform -> (NextTime, Waveform)
event (Waveform (c@(Change t _):c':cs)) = (t, Waveform (c':cs))
event (Waveform (c@(Change t _):[])) = (t, undefined)
event (Waveform []) = error "event: attempt to unevent empty waveform"

-- | Return the value of a waveform at time t
valueAt :: Time -> Waveform -> Int
valueAt t (Waveform []) = error "valueAt: infinity invariant failed"
valueAt t (Waveform ((Change t' v):cs))
    | t `time_before` t' = v
    | otherwise = valueAt t (Waveform cs)

-- | Returns the value of a waveform at time t. Fails if the value can't be
-- aquired from the head change.
valueAt1 :: (Timeable t) => t -> Waveform -> Int
valueAt1 t (Waveform []) = error "valueAt1: infinity invariant failed"
valueAt1 t (Waveform ((Change t' v):_))
    | t `time_before` t' = v
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
-- r _ _/-\_ _ _
--         t
concatAt :: NextTime -> Waveform -> Waveform -> Waveform
concatAt t w1 w2 = Waveform new where
    new = p `wappend` ((Change t v)`wcons`f)
    (p, v) = past_and_current t w1
    f = future t w2

past_and_current :: NextTime -> Waveform -> ([Change],[Change],Int)
past_and_current t (Waveform c1)
    | tb == t = (p,[c],v)
    | otherwise = (p,[], v)
    where
        (p,c@(Change tb v):_) = span (\(Change t' _) -> t' `time_before` t) c1

future :: NextTime -> Waveform -> [Change]
future t (Waveform c2) = f where
    (_,f) = span (\(Change t' _) -> t' `time_not_greater` t) c2


printWaveform :: Waveform -> String
printWaveform (Waveform cs) = concat $ map pc cs where
    pc (Change t c)
        | t < maxBound = printf "< %d until %d >" c (unTime t)
        | otherwise = printf "< %d until inf >" c

-- | forall t . t >  psince => (valueAt t PW) == (valueAt t pwave)
--              t <= psince => (valueAt t PW) == undefined
data ProjectedWaveform = PW {
      psince :: NextTime
    , pwave :: Waveform
    } deriving(Show)

nullPW = PW maxBound (wconst 0)

-- | Takes the current and the projected waveforms, returns resulting waveform
unPW :: Waveform -> ProjectedWaveform -> Waveform
unPW w (PW s w') = concatAt s w w'

appendPW :: ProjectedWaveform -> ProjectedWaveform -> ProjectedWaveform
appendPW (PW s1 w1) (PW s2 w2) = PW (s1 `min` s2) (concatAt (s1`max`s2) w1 w2)

-- concatProjectedAt :: Time -> Waveform -> ProjectedWaveform -> Waveform
-- concatProjectedAt t w p = concatAt t w (unPW w p)


{- Tests -}

instance Arbitrary Change where
    arbitrary = Change <$> arbitrary <*> arbitrary

instance Arbitrary Waveform where
    arbitrary = oneof [
          do
            let max = 1
            sz <- elements [1..max]
            vs <- vectorOf (max+1) arbitrary
            ts <- arbitrary_timeline sz
            let l = map fromPair (ts`zip`vs) ++ [infinity $ last vs]
            return $ Waveform $ l
        , do
            wconst <$> arbitrary
        ]

instance Arbitrary ProjectedWaveform where
    arbitrary = do
        w@(Waveform (c:_)) <- arbitrary
        s <- suchThat arbitrary (<=(until c))
        return $ PW s w

prop_border1 w1 = (future maxBound w1) == []

prop_border2 (TestTime nt t) w1 = (snd $ past_and_current nt w1) == valueAt t w1

-- prop_border2 w1 w2 = (concatAt maxBound w1 w2) == w1 

prop_border3 w1 w2 = invariant (concatAt maxBound w1 w2)

prop_concat2 (TestTime nt t) w1 w2 = (valueAt t (concatAt nt w1 w2)) == (valueAt t w2)

prop_concat3 (TestTime nt t) w1 w2 = (valueAt t (concatAt (nt`ticked`1) w1 w2)) == (valueAt t w1)

prop_concat4 (TestTime nt t) w1 w2 = invariant (concatAt nt w1 w2)

{-
-- prop_pconcat1 (TestTime t) w pw = invariant (concatProjectedAt t w pw)
    
prop_pw1 (TestTime t) w = valueAt t (unPW w nullPW) == valueAt t w

-}
