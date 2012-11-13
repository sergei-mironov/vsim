{

{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE DeriveDataTypeable #-}

module VSim.VIR.Lexer
    ( Token(..)
    , EnumElement(..)
    , AlexInput, newIrScanInput
    , irScanLineColumn, irScanSetLineColumn
    , irScan, irScanM
    ) where

import Data.Data
import Data.Typeable
import Data.Word
import Control.Monad
import qualified Data.ByteString.Char8 as B
import qualified Data.ByteString.Internal as B

import Prelude hiding (Ordering(..))

import Foreign.Storable
import Foreign.Ptr
import Foreign.ForeignPtr

import VSim.Data.Loc
import System.IO.Unsafe
import Data.Char
import Data.Ratio

}

$digit = 0-9            -- digits
$alpha = [a-zA-Z]       -- alphabetic characters
$symbol = [\!\$\%\&\|\*\+\-\/\:\<\=\>\?\@\^\_\~\"\\]

@basic_identifier = [$alpha $digit $symbol]+  -- может и с '"' начинаться
@extended_identifier = \\ ~\\+ \\
@identifier = @basic_identifier | @extended_identifier

tokens :-

  $white+               ;
  \;.*                  ; -- комментарий
  \.                    { tok Point }
  \(                    { tok LParen }
  \)                    { tok RParen }
  \[                    { tok LBracket }
  \]                    { tok RBracket }
  \{                    { tok LBrace }
  \}                    { tok RBrace }
  \:                    { tok Colon }
  \#                    { tok Hash }
  "i:others"            { tok ChoiceOthers }
  "i:t"                 { tok ChoiceType }
  "i:f"                 { tok ChoiceField }
  "i:e"                 { tok ChoiceExpr }
-- logical_operator       ::= and | or  | nand | nor | xor | xnor
  "and"                 { tok And }
  "or"                  { tok Or }
  "nand"                { tok Nand }
  "nor"                 { tok Nor }
  "xor"                 { tok Xor }
  "xnor"                { tok Xnor }
-- relational_operator    ::=  =  | /=  | <    | <=  | >   | >=
  \=                    { tok EQ }
  \/\=                  { tok NEQ }
  \<                    { tok LT }
  \<\=                  { tok LE }
  \>                    { tok GT }
  \>\=                  { tok GE }
-- -- shift_operator         ::= sll | srl | sla  | sra | rol | ror
--   "sll"                 { tok Sll }
--   "srl"                 { tok Srl }
--   "sla"                 { tok Sla }
--   "sra"                 { tok Sra }
--   "rol"                 { tok Rol }
--   "ror"                 { tok Ror }
-- adding_operator        ::=  +  | -   | &
-- sign                   ::=  +  | -
  \+                    { tok Plus }
  \-                    { tok Minus }
  \&                    { tok Concat }
-- multiplying_operator   ::=  *  | /   | mod  | rem
  \*                    { tok Mul }
  \*"g"                 { tok MulG }
  \/                    { tok Div }
  \/"g"                 { tok DivG }
  "mod"                 { tok Mod }
  "rem"                 { tok Rem }
-- miscellaneous_operator ::= **  | abs | not
  \*\*                  { tok Exp }
  "abs"                 { tok Abs }
  "not"                 { tok Not }
--  "~"                   { tok Not }

  \:\=                  { tok Assign }
  "i:set"               { tok Assign }
  "i:send"              { tok Send }
  "i:vsend"             { tok Send }

  \'.\'                 { f (\ s -> EnumIdent $ EnumChar $ B.index s 1) }
  \' @identifier        { f (EnumIdent . EnumId . bsToFs . B.tail) }
  \: @identifier        { f (Label . B.tail) }
  "<>"                  { tok Box }
  "type"		{ tok Type }
  "t:enum"		{ tok Enum }
  "array"		{ tok Array }
  "of"		        { tok Of }
  "record"		{ tok Record }
  "physical"		{ tok Physical }
  "access"		{ tok Access }
  "resolved"		{ tok Resolved }
  "range"		{ tok Range }
  "to"		        { tok To }
  "downto"		{ tok Downto }
  "function"            { tok Function }
  "procedure"           { tok Procedure }
  "in"                  { tok In }
  "out"                 { tok Out }
  "inout"               { tok Inout }
  "signal"              { tok Signal }
  "port"                { tok Port }
  "variable"            { tok Variable }
  "constant"            { tok Constant }
  "generic"             { tok Constant }
  "generate"            { tok Generate }
  -- пока одно и то же
  "file"                { tok File }

  "i:index"             { tok Index }
  "i:field"             { tok Field }
  "i:slice"             { tok Slice }
  "i:deref"             { tok Deref }

  "i:s'delayed"           { tok SDelayed }
  "i:s'stable"            { tok SStable }
  "i:s'quiet"             { tok SQuiet }
  "i:s'transaction"       { tok STransaction }
  "i:s'event"             { tok SEvent }
  "i:s'active"            { tok SActive }
  "i:s'last_event"        { tok SLast_event }
  "i:s'last_active"       { tok SLast_active }
  "i:s'last_value"        { tok SLast_value }
  "i:s'driving"           { tok SDriving }
  "i:s'driving_value"     { tok SDriving_value }

  "i:t'left"              { tok TLeft }
  "i:t'right"             { tok TRight  }
  "i:t'high"              { tok THigh }
  "i:t'low"               { tok TLow }
  "i:t'ascending"         { tok TAscending }
  "i:t'image"             { tok TImage }
  "i:t'value"             { tok TValue }
  "i:t'pos"               { tok TPos }
  "i:t'val"               { tok TVal }
  "i:t'succ"              { tok TSucc }
  "i:t'pred"              { tok TPred }
  "i:t'leftof"            { tok TLeftof }
  "i:t'rightof"           { tok TRightof }
  "i:a'left"              { tok ALeft }
  "i:a'right"             { tok ARight }
  "i:a'high"              { tok AHigh }
  "i:a'low"               { tok ALow }
  "i:a'range"             { tok ARange }
  "i:a'reverse_range"     { tok AReverseRange }
  "i:a'length"            { tok ALength }
  "i:a'ascending"         { tok AAscending }

  "i:qualify_type"      { tok QualifyType }
  "i:vqualify_type"     { tok VQualifyType }
  "i:vcast"             { tok VQualifyType }

  "i:nop"               { tok Nop }
  "i:wait"              { tok Wait }
  "i:return"            { tok Return }
  "i:report"            { tok Report }
  "severity"            { tok Severity }
  "i:assert"            { tok Assert }
  "i:if"                { tok If }
  "i:for"               { tok For }
  "i:while"             { tok While }
  "i:next"              { tok Next }
  "i:exit"              { tok Exit }
  "i:case"              { tok Case }
  "i:vcase"              { tok Case }
  "i:let"               { tok Let }
  "return"              { tok Return }
  "report"              { tok Report }
  "if"                  { tok If }
  "alias"               { tok Alias }
  "process"             { tok Process }
  "on"                  { tok On }
  "for"                 { tok For }
  "until"               { tok Until }
  "after"               { tok After }
  "verilog->vhdl"       { tok VerilogToVhdl }
  "vhdl->verilog"       { tok VhdlToVerilog }
  "memory-map-range"    { tok MemoryMapRange }
  "instanced-by"        { tok InstancedBy }

  [\+\-]? $digit+       { f (\ t -> Integer (readInteger $ skipFirstPlusB t) t) }
  [\+\-]? $digit+ (\. $digit*)? ([eE] [\+\-]? $digit+)?
                        { f (Double . read . zeroAfterPoint . skipFirstPlus . B.unpack) }
  (\" ~\"* \")+         { f (\ t -> String (B.pack $ init $ removeDoubleQuotes $ tail $
                                            B.unpack t) t) }
  @extended_identifier  { f Ident }
  @basic_identifier     { f Ident }
{

readSigned :: Num a => (B.ByteString -> a) -> B.ByteString -> a
readSigned f b
    | B.index b 0 == '-' = negate (f $ B.drop 1 b)
    | otherwise          = f b
{-# INLINE readSigned #-}

readInteger  = readSigned readUnsignedInteger

readUnsignedInteger :: B.ByteString -> Integer
readUnsignedInteger =
    B.foldl' (\ acc digit -> acc * 10 + fromIntegral (ord digit - ord '0')) 0

bsToFs = id

type Ident = B.ByteString

data EnumElement
    = EnumId   Ident
    | EnumChar Char
    deriving (Eq, Show, Data, Typeable)

tok x = \p s -> x
{-# INLINE tok #-}

f (x :: B.ByteString -> Token) = \p s -> x s
{-# INLINE f #-}

skipFirstPlus ('+':xs) = xs -- read не умеет обрабатывать плюс в начале числа
skipFirstPlus a = a

skipFirstPlusB b
    | B.index b 0 == '+' = B.drop 1 b
    | otherwise          = b

zeroAfterPoint [] = []
zeroAfterPoint ['.'] = ".0"
zeroAfterPoint ('.':e:xs) | e `elem` "eE" = ".0e" ++ xs
zeroAfterPoint (x:xs) = x : zeroAfterPoint xs

removeDoubleQuotes [] = []
removeDoubleQuotes ('"':'"':xs) = '"' : removeDoubleQuotes xs
removeDoubleQuotes (x:xs) = x : removeDoubleQuotes xs

unpack = B.unpack

-- The token type:
data Token
    = Point
    | LParen
    | RParen
    | LBracket
    | RBracket
    | LBrace
    | RBrace
    | Colon
    | Box
    | Integer
      { decodedInteger :: Integer
      , originalString :: B.ByteString
      }
    | EnumIdent EnumElement
    | Double Double
    | Ident B.ByteString
    | Label B.ByteString
    | String
      { decodedString :: B.ByteString
      , originalString :: B.ByteString
      }
    | Eof
    | Type | Enum | Array | Of | Record | Physical | Access | Resolved
    | Range | To | Downto
    | Function | Procedure
    | In | Out | Inout
    | Signal | Port | Variable | Constant | Generate | File
    | Wait | On | Until | Return | If | Report | Severity | Assert
    | For | While | Next | Exit | Case | Let
    | Alias | Process
    | QualifyType | VQualifyType
    | VhdlToVerilog | VerilogToVhdl

-- logical_operator       ::= and | or  | nand | nor | xor | xnor
-- relational_operator    ::=  =  | /=  | <    | <=  | >   | >=
-- shift_operator         ::= sll | srl | sla  | sra | rol | ror
-- adding_operator        ::=  +  | -   | &
-- sign                   ::=  +  | -
-- multiplying_operator   ::=  *  | /   | mod  | rem
-- miscellaneous_operator ::= **  | abs | not

    | And | Or | Nand | Nor | Xor | Xnor
    | EQ | NEQ | LT | LE | GT | GE
    | Sll | Srl | Sla  | Sra | Rol | Ror
    | Plus | Minus | Concat
    | Mul | Div | MulG | DivG | Mod | Rem
    | Exp | Abs | Not

    | Nop
    | Assign | Send | After
    | ChoiceOthers | ChoiceType | ChoiceExpr | ChoiceField

    | Index | Field | Slice | Deref

    | TLeft | TRight | THigh | TLow | TAscending
    | TImage | TValue | TPos | TVal
    | TSucc | TPred | TLeftof | TRightof

    | ALeft | ARight | AHigh | ALow
    | ARange | AReverseRange | ALength | AAscending

    | Hash
    | SDelayed
    | SStable
    | SQuiet
    | STransaction
    | SEvent
    | SActive
    | SLast_event
    | SLast_active
    | SLast_value
    | SDriving
    | SDriving_value
    | MemoryMapRange
    | InstancedBy
    deriving (Eq, Show)

bsForeignPtr :: B.ByteString -> ForeignPtr Word8
bsForeignPtr bs = fp
    where (fp, _offset, _length) = B.toForeignPtr bs
bsPtr :: B.ByteString -> Ptr Word8
bsPtr bs = unsafeForeignPtrToPtr $ bsForeignPtr bs

newIrScanInput :: B.ByteString -> AlexInput
newIrScanInput str =
    AlexInput alexStartPos (bsPtr paddedString) (bsForeignPtr paddedString)
    where paddedString = B.concat [B.pack "\n", str, B.pack "\0"]

irScanLineColumn :: AlexInput -> (Int, Int)
irScanLineColumn (AlexInput (AlexPn l c) _ _) = (l, c)

irScanSetLineColumn :: (Int, Int) -> AlexInput -> AlexInput
irScanSetLineColumn (l, c) (AlexInput (AlexPn _ _) x y) = AlexInput (AlexPn l c) x y

irScan :: AlexInput -> (Either String (Int, Token), AlexInput)
irScan inp@(AlexInput pos cp str) =
    case alexScan inp 0 of
        AlexEOF -> (Right (snd $ irScanLineColumn inp, Eof), inp)
        AlexError inp' -> (Left "lexical error", inp')
        AlexSkip  inp' len     -> irScan inp'
        AlexToken inp' len act ->
            (Right (snd (irScanLineColumn inp') - fromIntegral len,
                    act pos (B.fromForeignPtr str
                                 (cp `minusPtr` unsafeForeignPtrToPtr str + 1)
                                 (fromIntegral len))), inp')

irScanM :: Monad m => m AlexInput -> (AlexInput -> m ()) -> m (Int, Token)
irScanM get set = do
    (result, inp') <- liftM irScan get
    set inp'
    either fail return result

data AlexPosn = AlexPn !Int !Int
    deriving (Eq,Show)

alexStartPos :: AlexPosn
alexStartPos = AlexPn 1 1

tabSize = 4

alexMove :: AlexPosn -> Char -> AlexPosn
alexMove (AlexPn l c) '\t' = AlexPn  l (((c + tabSize - 1) `div` tabSize) * tabSize + 1)
alexMove (AlexPn l c) '\n' = AlexPn (l+1)   1
alexMove (AlexPn l c) _    = AlexPn  l     (c+1)

data AlexInput = AlexInput
    !AlexPosn     -- current position,
    !(Ptr Word8)  -- current ptr
    !(ForeignPtr Word8) -- initial input string

alexInputPrevChar :: AlexInput -> Char
alexInputPrevChar (AlexInput p c s) = B.w2c $ unsafePerformIO $ peek c

alexGetChar :: AlexInput -> Maybe (Char, AlexInput)
alexGetChar (AlexInput p cp cs) = unsafePerformIO $ do
    let cp' = plusPtr cp 1
    w <- peek cp'
    if w == 0
     then return Nothing
     else let c = B.w2c w
              p' = alexMove p c
          in p' `seq` return (Just (c, AlexInput p' cp' cs))

}
