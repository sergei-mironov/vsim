module Data.Range where

-- | VHDL Range type
data RangeT = RangeT {
      rbegin :: Int
    , rend :: Int
    } | UnconstrT
      | NullRangeT
    deriving(Show)

inner_of NullRangeT _ = True
inner_of _ UnconstrT = True
inner_of UnconstrT _ = False
inner_of _ NullRangeT = False
inner_of (RangeT b1 e1) (RangeT b2 e2) = (b1 >= b2) && (e1 <= e2)

inrage :: Int -> RangeT -> Bool
inrage x (RangeT l r) = x >= l && x <= r
inrage x (UnconstrT) = True
inrage x (NullRangeT) = False

toList UnconstrT = error "toList: unable to make list out of unconstained range"
toList (RangeT l u) = [l..u]
toList (NullRangeT) = []

left (RangeT l _) = l
left x = error $ "left: undefined for " ++ (show x)
right (RangeT _ r) = r
right x = error $ "right: undefined for " ++ (show x)
