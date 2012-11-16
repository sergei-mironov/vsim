module VSim.Runtime.Time where

import Control.Monad

type Time = Int

time_max :: Time
time_max = maxBound

time_min :: Time
time_min = 0

milliSecond, microSecond, nanoSecond, picoSecond :: Time
milliSecond = 1000*microSecond
microSecond = 1000*nanoSecond
nanoSecond  = 1000*picoSecond
picoSecond  = 1000*femtoSecond
femtoSecond  = 1
