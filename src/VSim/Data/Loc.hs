{-# LANGUAGE DeriveDataTypeable #-}

module VSim.Data.Loc where

import Data.Typeable
import Data.Generics
import Data.Maybe
import VSim.Data.Line (Line(..))

-- | Положение в сорце (и в промежуточном формате)
data Loc = Loc {
      locSrcLine   :: !(Maybe Line)
    , locLine      :: !Int
    , locStartChar :: !Int
    , locEndChar   :: !Int
    , locFn        :: !String
    } | NoLoc
    deriving (Show, Eq, Ord, Data, Typeable)

unknownLoc = Loc Nothing 0 0 0 "<unknown>"

data WithLoc a = WithLoc {
      withLocLoc :: Loc
    , withLocVal :: a
    }
    deriving (Show, Data, Typeable)

instance Functor WithLoc where
    fmap f (WithLoc l x) = WithLoc l (f x)

getLocLine loc = fromMaybe (getLocIrLine loc) (locSrcLine loc)

getLocIrLine loc = Line (locFn loc) (locLine loc) (locStartChar loc)

