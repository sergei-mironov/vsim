module VSimR.Waveform where

import Data.List
import VSimR.Time

-- | Change is a part of a waveform. More or less formal definition is:
-- foreach t . t <= until => (value `at_time` t) == cvalue
data Change = Change {
      until :: Time
    , cvalue :: Int
    } deriving(Show)

-- | Non-empty list of changes, sorted by (until::Time). The last element should
-- specify value of the waveform at +infinity time
data Waveform = Waveform [Change]
    deriving(Show)

-- | Returns waveform of a constant value
wconst :: Int -> Waveform
wconst val = Waveform [Change time_max val]

-- | Modifies the Waveform, example:
-- *Waweform> after 5 2 $ wconst 0
-- Waveform [Change {until = 5, cvalue = 0},Change {until = 2147483647, cvalue = 2}] 
after :: Time -> Int -> Waveform -> Waveform
after t v (Waveform cs) = Waveform (past ++ tweak future) where
    (future,past) = partition (\(Change t' _) -> t' >= t) cs
    tweak ((Change t' v'):[])
        | t' == time_max = (Change t v'):(Change t' v):[]
        | otherwise = error "Waveform invariant failed"
    tweak ((Change t' v'):(Change t'' v''):cs)
        | t == t' = (Change t' v'):(Change t'' v):cs
        | otherwise = (Change t v'):((Change t' v)):(Change t'' v''):cs

-- | Cuts all transitions before now from the waveform.
advance :: Time -> Waveform -> Waveform
advance now (Waveform w) = Waveform (filter future w) where
    future (Change u _) = u >= now

-- | Return next waveform event
event :: Waveform -> Change
event (Waveform (c:_)) = c
event (Waveform _) = error "event: empty waveform"

-- | Return the value of a waveform at time t
valueAt :: Time -> Waveform -> Int
valueAt t (Waveform cs) = cvalue $ head future where
    (future,past) = partition (\(Change t' _) -> t' >= t) cs

earliest :: Waveform -> Waveform -> Ordering
earliest (Waveform ((Change t1 _):_)) (Waveform ((Change t2 _):_)) = compare t1 t2
earliest (Waveform _) (Waveform _) = error "earliest: vmpty waveform"

