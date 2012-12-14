{

module VSim.VIR.AST
    ( parseFiles
    , parseFile
    ) where

import Control.Applicative
import Control.Monad
import Control.Monad.Reader
import Control.Monad.Error

import Data.IORef
import Data.IORefEx
import Data.List
import Data.Ord
import Data.Maybe

import qualified Control.Exception as E
import qualified Data.ByteString.Char8 as B

import System.IO
import System.IO.Error
import System.IO.Unsafe

import VSim.VIR.Monad
import VSim.VIR.Lexer as L
import VSim.VIR.Types as T

import VSim.Data.Line
import VSim.Data.Loc
import VSim.Data.NamePath
import VSim.Data.Int128
import VSim.Data.TInt

}

%monad { Parser }
%lexer { lexer } { L.Eof }
%name toplevel_decls
%tokentype { L.Token }
%error { parseError }

%token
    -- базовый синтаксис
    integer         { L.Integer _ _ }
    double          { L.Double $$ }
    string          { L.String _ _ }
    enum_ident      { L.EnumIdent $$ }
    ident           { L.Ident $$ }
    label           { L.Label $$ }
    lparen          { L.LParen }
    rparen          { L.RParen }
    lbracket        { L.LBracket }
    rbracket        { L.RBracket }
    '{'             { L.LBrace }
    '}'             { L.RBrace }
    '.'             { L.Point }
    ':'             { L.Colon }
    '#'             { L.Hash }
    "i:others"      { L.ChoiceOthers }
    "i:t"           { L.ChoiceType }
    "i:f"           { L.ChoiceField }
    "i:e"           { L.ChoiceExpr }

    -- операторы
    -- logical_operator       ::= and | or  | nand | nor | xor | xnor
    -- bit/boolean, результат такой же как и аргумент
    -- and/or/nand/nor short circuit операторы
    and             { L.And }
    or              { L.Or }
    nand            { L.Nand }
    nor             { L.Nor }
    xor             { L.Xor }
    xnor            { L.Xnor }
    not             { L.Not }
    -- relational_operator    ::=  =  | /=  | <    | <=  | >   | >=
    -- равенство -- любой тип, кроме protected и file
    -- для операций сравнения необходимо указывать тип (автоматом мы
    -- типы не определяем).
    '='             { L.EQ }
    "/="            { L.NEQ }
    -- любой скаляр или массив (причем null-массив всегда меньше
    -- любого не-null-массива. если оба не-null, то сравнивается
    -- первый элемент, а потом хвосты массивов, которые могут быть null)
    '<'             { L.LT }
    "<="            { L.LE }
    '>'             { L.GT }
    ">="            { L.GE }
    -- shift_operator         ::= sll | srl | sla  | sra | rol | ror
    -- шифтят только одномерные массивы bit/boolean. инты не шифтят.
    -- первый агрумент такой же как и тип результата, второй integer
    -- реализуем их в standard.vhd
    -- sll             { L.Sll }
    -- srl             { L.Srl }
    -- sla             { L.Sla }
    -- sra             { L.Sra }
    -- rol             { L.Rol }
    -- ror             { L.Ror }
    -- adding_operator        ::=  +  | -   | &
    -- sign                   ::=  +  | -
    -- +/-/abs для любого numeric типа, аргументы должны быть одинаковых
    -- типов, т.е. аргументы всегда соответсвуют типу результата
    '+'             { L.Plus }
    '-'             { L.Minus }
    abs             { L.Abs }
    -- одинаковые с результатом массивы. может склеивать массивы,
    -- значения, а также массивы и значения. Результат, в принципе,
    -- известен, но лучше пожалуй тоже отдельные ф-ии завести,
    -- что-то вроде |&, |&| и &|
    -- подробнее 7.2.4 Adding operators
    '&'             { L.Concat }
    -- multiplying_operator   ::=  *  | /   | mod  | rem
    -- Два варианта, когда аргумент соответсвует типу результата
    -- integer *(/) integer = integer
    -- float *(/) float = float
    -- сейчас * работает с любыми Num (int, float, physical)
    --        / тоже что div -- Integral (int, physical)
    -- В остальных вариантах по типу свыше непонятно, что должно
    -- быть в аргументах.
    -- physical *(/) integer = physical
    -- physical *(/) real = physical
    -- integer * physical = physical
    -- real * physical = physical
    -- physical / physical = universal_integer
    -- для этих вариантов (а также для float / float) добавляются
    -- операции *g, /g, вместе с которыми также передается тип аргументов
    '*'             { L.Mul }
    '/'             { L.Div }
    "*g"            { L.MulG }
    "/g"            { L.DivG }
    -- работают с integer, тип такой же как результат
    mod             { L.Mod }
    rem             { L.Rem }
    -- miscellaneous_operator ::= **  | abs | not  -- abs,not наверху
    -- тип такой же, как результат, справа integer (как и у всяких shift-ов)
    -- integer ** integer = integer
    -- real ** integer = real
    "**"            { L.Exp }

    -- Типы
    box             { L.Box }
    type            { L.Type }
    enum            { L.Enum }
    array           { L.Array }
    of              { L.Of }
    record          { L.Record }
    physical        { L.Physical }
    access          { L.Access }
    resolved        { L.Resolved }
    range           { L.Range }
    to              { L.To }
    downto          { L.Downto }
    -- Ф-ии/процедуры
    function        { L.Function }
    procedure       { L.Procedure }
    in              { L.In }
    out             { L.Out }
    inout           { L.Inout }
    signal_tok      { L.Signal }
    port_tok        { L.Port }
    variable        { L.Variable }
    constant        { L.Constant }
    generate        { L.Generate }
    file            { L.File }
    -- Утверждения
    wait            { L.Wait }
    return          { L.Return }
    report          { L.Report }
    severity        { L.Severity }
    assert          { L.Assert }
    ":="            { L.Assign }
    send            { L.Send }
    if              { L.If }
    for             { L.For }
    on              { L.On }
    until           { L.Until }
    after           { L.After }
    while           { L.While }
    next            { L.Next }
    exit            { L.Exit }
    case            { L.Case }
    let             { L.Let }
    alias           { L.Alias }
    process         { L.Process }
    nop             { L.Nop }

    "i:index"       { L.Index }
    "i:field"       { L.Field }
    "i:slice"       { L.Slice }
    "i:deref"       { L.Deref }
    -- Атрибуты
    "S_delayed"           { L.SDelayed }
    "S_stable"            { L.SStable }
    "S_quiet"             { L.SQuiet }
    "S_transaction"       { L.STransaction }
    "S_event"             { L.SEvent }
    "S_active"            { L.SActive }
    "S_last_event"        { L.SLast_event }
    "S_last_active"       { L.SLast_active }
    "S_last_value"        { L.SLast_value }
    "S_driving"           { L.SDriving }
    "S_driving_value"     { L.SDriving_value }

    "T_left"          { L.TLeft }
    "T_right"         { L.TRight }
    "T_high"          { L.THigh }
    "T_low"           { L.TLow }
    "T_ascending"     { L.TAscending }
    "T_image"         { L.TImage }
    "t_value"         { L.TValue }
    "T_pos"           { L.TPos }
    "T_val"           { L.TVal }
    "T_succ"          { L.TSucc }
    "T_pred"          { L.TPred }
    "T_leftof"        { L.TLeftof }
    "T_rightof"       { L.TRightof }
    "A_left"          { L.ALeft }
    "A_right"         { L.ARight }
    "A_high"          { L.AHigh }
    "A_low"           { L.ALow }
    "A_range"         { L.ARange }
    "A_reverse_range" { L.AReverseRange }
    "A_length"        { L.ALength }
    "A_ascending"     { L.AAscending }

    "i:qualify_type"  { L.QualifyType }
    "i:vqualify_type" { L.VQualifyType }
    "verilog->vhdl"   { L.VerilogToVhdl }
    "vhdl->verilog"   { L.VhdlToVerilog }

    memory_map_range_keyword { L.MemoryMapRange }
    instanced_by_keyword { L.InstancedBy }

-- T'image -- строковое представление скалярного типа
-- T'value -- значение строкового представления скалярного типа
-- T'pos  -- identity
-- T'val  -- identity с проверкой на попадание в range
-- T'succ/pred -- +1/-1 вне зависимости от направления range-а
--    (могут использоваться в циклах? лучше напрямую сделать)
-- T'leftof/rightof -- шаг влево/вправо с учетом направления диапазона
%%

toplevel_decls :: { [IRTop] }
    : toplevel_decl toplevel_decls { $1 : $2 }
    | '(' push_location toplevel_decls pop_location ')' { $3 }
    | {[]}

toplevel_decl :: { IRTop }
    : type_decl { IRTType $1 }
    | constant_decl { IRTConstant $1 }
    | signal_decl   { IRTSignal $1 }
    | alias_decl    { IRTAlias $1 }
    | port_decl     { IRTPort $1 }
    | function_decl { IRTFunction $1 }
    | procedure_decl { IRTProcedure $1 }
    | generate_decl { IRTGenerate $1 }
    | process_decl { IRTProcess $1 }
    | memory_map_range { IRTMM $1 }
    | instanced_by_correspondence { IRTCorresp ([],[]) }
    | '(' push_location toplevel_decl pop_location ')' { $3 }

generate_decl :: { IRGen }
    : '(' if expr generate toplevel_decls ')'
        {  IRGenIf $3 $5 }

    | '(' for withloc_hier_name_wpath withloc_hier_name_wpath '(' range integer to integer ')' generate toplevel_decls ')'
        {  
            let f (L.Integer v7 _) (L.Integer v9 _) = IRGenFor (show $3) $4 v7 v9 $12
            in f $7 $9
        }

type_decl :: { IRType }
    : '(' type withloc_hier_name_wpath type_descr ')'
        { IRType $3 $4 }

enum_element :: { EnumElement }
    : enum_ident { $1 }
    | identifier { EnumId $1 }

type_descr :: { IRTypeDescr }
    : withloc_hier_name_wpath                { ITDName $1 }
    | range_descr                            { ITDRangeDescr $1 }
    | '(' enum enum_element_list ')'         { ITDEnum $3 }
    | '(' array '(' constrained_array_range_descr_list1 ')'
          of type_descr ')'                  { ITDArray $4 $7 }
    | '(' physical range_descr identifier
          unit_decl_list ')'                 { ITDPhysical $3 $4 $5 }
    | '(' record record_field_list ')'       { ITDRecord $3 }
    | '(' access type_descr ')'              { ITDAccess $3 }
    | '(' resolved loc hier_name type_descr ')' { ITDResolved $3 $4 $5 }
    | '(' withloc_hier_name_wpath
          array_range_descr_list1 ')'
          { ITDConstraint (withLocLoc $2) (ITDName $2) $3 }

unit_decl :: { UnitDecl }
    : '(' loc identifier '{' int128 identifier '}' ')'
      { UnitDecl $2 $3 $5 $6 }

record_field :: { (Loc, Ident, IRTypeDescr) }
    : '(' loc identifier type_descr ')' { ($2, $3, $4) }

direction :: { Direction }
    : to     { DirTo }
    | downto { DirDownto }

range_descr :: { IRRangeDescr }
    : '(' loc range expr direction expr ')' { IRDRange $2 $4 $5 $6 }
    | '(' "A_range" loc expr expr_name ')'  { IRDARange $3 $4 $5 }
    | '(' "A_reverse_range" loc expr expr_name ')'
                                                { IRDAReverseRange $3 $4 $5 }

array_range_descr :: { IRArrayRangeDescr }
    : range_descr                           { IRARDRange $1 }
    | withloc_hier_name_wpath
      { IRARDTypeMark (withLocLoc $1) (ITDName $1) }
    | '(' withloc_hier_name_wpath range_descr ')'
      { IRARDConstrained (withLocLoc $2) (ITDName $2) $3 }

constrained_array_range_descr :: { Constrained IRArrayRangeDescr }
    : array_range_descr                            { Constrained False $1 }
    | '[' array_range_descr '(' range box ')' ']'  { Unconstrained $2 }

constant_decl :: { IRConstant }
    : '(' constant withloc_hier_name_wpath type_descr loc expr ')'  
        {
          IRConstant $3 $4 $5 $6
        }

variable_decl :: { IRVariable }
    : '(' variable withloc_hier_name_wpath type_descr opt_expr ')'  {
              IRVariable $3 $4 $5
            }
signal_decl :: { IRSignal }
    : '(' signal withloc_hier_name_wpath type_descr opt_expr ')'  { IRSignal $3 $4 $5 }
opt_expr :: { IROptExpr }
    : loc expr     { IOEJustExpr $1 $2 }
        | loc          { IOENothing $1 }

alias_decl :: { IRAlias }
    : '(' alias withloc_hier_name_wpath type_descr loc expr_name ')' {
              IRAlias $3 $4 $5 $6
            }

port_decl :: { IRPort }
    : '(' port withloc_hier_name_wpath type_descr port_map_element ')' {
          IRPort $3 $4 $5
        }
    | '(' "vhdl->verilog"
          port withloc_hier_name_wpath type_descr loc port_map_element ')'
        {
          IRPort $4 $5 (IOENothing $6)
        }
    | '(' "verilog->vhdl"
          port withloc_hier_name_wpath type_descr loc port_map_element ')'
        {
          IRPort $4 $5 (IOENothing $6)
        }
port_map_element :: { IROptExpr }
    : loc                           { IOENothing $1 }
    | '(' hier_name loc expr ')'    { IOEJustExpr $3 $4 }
    | '(' push_location port_map_element pop_location ')' { $3 }

function_decl :: { IRFunction }
    : '(' function withloc_hier_name_wpath '(' arguments ')' type_descr
          statements
      ')' { IRFunction $3 $5 $7 $8 }

procedure_decl :: { IRProcedure }
    : '(' procedure withloc_hier_name_wpath '(' arguments ')'
          statements
      ')' { IRProcedure $3 $5 $7 }

arguments :: { [IRArg] }
    : argument_list { $1 }

argument :: { IRArg }
    : '(' withloc_identifier ':' type_descr arg_class arg_mode ')'
          { IRArg $2 $4 $5 $6 }
    | '(' push_location argument pop_location ')' { $3 }

arg_mode :: { ArgMode }
    : in            { AMIn }
    | out           { AMOut }
    | inout         { AMInout }
    | {- empty -}   { AMIn }

arg_class :: { NamedItemKind }
    : constant      { NIKConstant }
    | variable      { NIKVariable }
    | signal        { NIKSignal }
    | file          { NIKFile }
    | {- empty -}   { NIKVariable }

sensitivity_item :: { IRNameG }
    : name { $1 }

process_decl :: { IRProcess }
    : '(' process withloc_hier_name_wpath '(' sensitivity_item_list ')'
        '(' let '(' let_decl_list ')' statements ')' ')'
      { IRProcess $3 $5 $10 $12 }
    | '(' process withloc_hier_name_wpath '(' sensitivity_item_list ')'
        statements_no_let ')'
      { IRProcess $3 $5 [] $7 }

statement :: { IRStat }
    : statement_no_let { $1 }
    | '(' let '(' let_decl_list ')' statements ')' { ISLet $4 $6 }

statement_no_let :: { IRStat }
    : '(' loc return ')' { ISReturn $2 }
    | '(' loc return expr ')' { ISReturnExpr $2 $4 }
    | '(' withloc_hier_name exprs loc ')' { ISProcCall $2 $3 $4 }
    | '(' loc if expr '(' statements ')' '(' statements ')' ')'
      { ISIf $2 $4 $6 $9 }
    | '(' loc ":=" assignment_name loc expr ')' { ISAssign $2 $4 $5 $6 }
    | '(' loc send signal_name loc expr ')'
      { ISSignalAssign $2 $4 $5 [IRAfter $6 Nothing]
        --[IRAfter $6 (IEPhysical (WithLoc $5 0) (WithLoc $5 (fsLit "sec")))]
      }
    | '(' loc send signal_name loc afters ')'
      { ISSignalAssign $2 $4 $5 $6 }
       -- пока то же самое, что и assign
    | '(' loc assert expr assert_report assert_severity ')'
      { ISAssert $2 $4 $5 $6 }
    | '(' loc report expr ')'
      { ISReport $2 $4 $ IEEnumIdent $2 (EnumId $ fsLit $ "NOTE") }
    | '(' loc report expr expr ')'
      { ISReport $2 $4 $5 }
    | '(' loc wait wait_on wait_until wait_for ')'
      { ISWait $2 $4 $5 $6 }
    | '(' loc nop ')'
      { ISNop $2 }
    | '(' loc case '(' expr ':' type_descr ')' case_element_list ')'
      { ISCase $2 $5 $7 $9 }
    | '(' loc for loop_label withloc_identifier type_descr statements ')'
      { ISFor $4 $2 $5 $6 $7 }
    | '(' loc while loop_label expr statements ')'
      { ISWhile $4 $2 $5 $6 }
    | '(' loc exit next_label ')'
      { ISExit $2 $4 }
    | '(' loc next next_label ')'
      { ISNext $2 $4 }
    | '(' push_location statement pop_location ')'  { $3 }
      -- развернуто, т.к. иначе типы становятся less polymorphic

loop_label :: { LoopLabel }
    : {- empty -}  { fsLit "" }
    | label        { bsToFs $1 }
next_label :: { LoopLabel }
    : {- empty -}  { fsLit "" }
    | identifier   { $1 }

after_expr :: { IRAfter }
    : expr after expr { IRAfter $1 (Just $3) }
afters :: { [IRAfter] }
    : after_expr_list1 { $1 }

wait_on :: { [IRNameG] }
    : on '(' sensitivity_item_list ')' { $3 }
    | {- empty -} { [] }
wait_until :: { Maybe IRExpr }
    : until expr  { Just $2 }
    | {- empty -} { Nothing }
wait_for :: { Maybe IRExpr }
    : for expr    { Just $2 }
    | {- empty -} { Nothing }

assert_report :: { IRExpr }
    : report expr { $2 }
    | loc {- empty -} { IEString $1 (B.pack "Assertion violation") }
assert_severity :: { IRExpr }
    : severity expr { $2 }
    | loc {- empty -} { IEEnumIdent $1 (EnumId $ fsLit $ "ERROR") }

case_element :: { IRCaseElement }
    : '(' '(' loc "i:others" ')' statements ')' { ICEOthers $3 $6 }
    | '(' '(' loc exprs ')' statements ')' { ICEExpr $3 $4 $6 }

let_decl :: { IRLetDecl }
    : constant_decl { ILDConstant $1 }
    | variable_decl { ILDVariable $1 }
    | alias_decl    { ILDAlias $1 }
    | function_decl    { ILDFunction $1 }
    | procedure_decl   { ILDProcedure $1 }
    | '(' type withloc_hier_name_wpath type_descr ')' { ILDType $3 $4 }
    | '(' push_location let_decl pop_location ')' { $3 }

statements1 :: { IRStat }
    : statement { $1 }
    | statements1 statement { ISSeq $1 $2 }
statements :: { IRStat }
    : statements1 { $1 }
    | {- empty -} { ISNil }

statements_no_let1 :: { IRStat }
    : statement_no_let { $1 }
    | statements_no_let1 statement { ISSeq $1 $2 }
statements_no_let :: { IRStat }
    : statements_no_let1 { $1 }
    | {- empty -} { ISNil }

------------------------------------------------------------------------------
-- Выражения

element_association :: { IRElementAssociation }
    : expr loc { IEAExpr $2 $1 }
    -- TODO: loc не там, где надо,
    -- withloc вызывает reduce/reduce конфликт
    -- видимо стоит сохранять локацию прямо в ExprGen
    | '(' loc "i:others" expr ')'       { IEAOthers $2 $4 }
    | '(' loc "i:t" array_range_descr expr ')'
                                        { IEAType  $2 $4 $5 }
    | '(' loc "i:f" identifier expr ')' { IEAField $2 $4 $5 }
    | '(' loc "i:e" expr expr ')'       { IEAExprIndex  $2 $4 $5 }

name_noloc :: { IRNameG }
    : '(' '[' loc element_association_list ']' ':' type_descr ')'
                                            { INAggregate $3 $4 $7 }
    | withloc_hier_name_wpath               { INIdent $1 }
    | '(' "i:field" name loc identifier ')' { INField $3 $4 $5 }
    -- quick patch for translator incorrect behaviour.
    | '(' "i:field" '(' name ')' loc identifier ')' { INField $4 $6 $7 }
    | '(' loc "i:index" name exprs ')'      { INIndex NEKDynamic $4 $2 $5 }
    | '(' loc "i:slice" name array_range_descr ')'
                                                { INSlice NEKDynamic $4 $2 $5 }
name :: { IRNameG }
    : name_noloc { $1 }
    | '(' push_location name pop_location ')' { $3 }

expr_name :: { IRName }
    : name { IRName $1 ExprCheck }
assignment_name :: { IRName }
    : name { IRName $1 AssignCheck }
signal_name :: { IRName }
    : name { IRName $1 SignalCheck }
type_name :: { IRName }
    : name { IRName $1 TypeCheck }

expr :: {  IRExpr  }
    : name_noloc loc { IEName $2 (IRName $1 ExprCheck)
      -- loc в конце, т.к. лезут shift reduce конфликты
    }
    | loc string { IEString $1 (L.decodedString $2) }
    | '[' loc element_association_list ']' { IEAggregate $2 $3 }
    | '(' "i:qualify_type" loc type_descr expr ')'
      { IEQualifyType $3 $4 $5 }
    | '(' "i:vqualify_type" loc type_descr type_descr expr ')'
      { IEVQualifyType $3 $4 $5 $6 }

    | '(' "T_left" loc type_descr ')' { IETypeAttr $3 T_left $4 }
    | '(' "T_right" loc type_descr ')' { IETypeAttr $3 T_right $4 }
    | '(' "T_high" loc type_descr ')' { IETypeAttr $3 T_high $4 }
    | '(' "T_low" loc type_descr ')' { IETypeAttr $3 T_low $4 }
    | '(' "T_ascending" loc type_descr ')' { IETypeAttr $3 T_ascending $4 }


    | '(' "T_succ" loc type_descr expr ')' { IETypeValueAttr $3 T_succ $5 $4 }
    | '(' "T_pred" loc type_descr expr ')' { IETypeValueAttr $3 T_pred $5 $4 }
    | '(' "T_val" loc type_descr expr ')' { IETypeValueAttr $3 T_val $5 $4 }
    | '(' "T_pos" loc type_descr expr ')' { IETypeValueAttr $3 T_pos $5 $4 }
    | '(' "T_image" loc type_descr expr ')' { IETypeValueAttr $3 T_image $5 $4 }


    | '(' "A_left" loc expr expr_name ')' { IEArrayAttr $3 A_left $4 $5 }
    | '(' "A_right" loc expr expr_name ')' { IEArrayAttr $3 A_right $4 $5 }
    | '(' "A_high" loc expr expr_name ')' { IEArrayAttr $3 A_high $4 $5 }
    | '(' "A_low" loc expr expr_name ')' { IEArrayAttr $3 A_low $4 $5 }
    | '(' "A_ascending" loc expr expr_name ')' { IEArrayAttr $3 A_ascending $4 $5 }
    | '(' "A_length" loc expr expr_name ')' { IEArrayAttr $3 A_length $4 $5 }


    | '(' "S_event" loc signal_name ')' { IESignalAttr $3 S_event $4 }
    | '(' "S_active" loc signal_name ')' { IESignalAttr $3 S_active $4 }
    | '(' "S_last_value" loc signal_name ')' { IESignalAttr $3 S_last_value $4 }


    | '(' "S_stable" loc signal_name opt_time ')' { IESignalAttrTimed $3 S_stable $4 $5 }
    | '(' "S_delayed" loc signal_name opt_time ')' { IESignalAttrTimed $3 S_delayed $4 $5 }
    | '(' "S_quiet" loc signal_name opt_time ')' { IESignalAttrTimed $3 S_quiet $4 $5 }
    | loc enum_ident { IEEnumIdent $1 $2 }
    | loc int { IEInt $1 $2 }
    | loc double { IEDouble $1 $2 }
    | '{' withloc_int128 withloc_identifier '}' { IEPhysical $2 $3 }
    | '(' withloc_hier_name exprs loc ')' { IEFunctionCall $2 $3 $4 }


    | '(' loc '=' type_descr expr expr ')' { IERelOp $2 IEq $4 $5 $6 }
    | '(' loc "/=" type_descr expr expr ')' { IERelOp $2 INeq $4 $5 $6 }
    | '(' loc '<' type_descr expr expr ')' { IERelOp $2 ILess $4 $5 $6 }
    | '(' loc "<=" type_descr expr expr ')' { IERelOp $2 ILessEqual $4 $5 $6 }
    | '(' loc '>' type_descr expr expr ')' { IERelOp $2 IGreater $4 $5 $6 }
    | '(' loc ">=" type_descr expr expr ')' { IERelOp $2 IGreaterEqual $4 $5 $6 }


    | '(' loc mod expr expr ')' { IEBinOp $2 IMod $4 $5 }
    | '(' loc rem expr expr ')' { IEBinOp $2 IRem $4 $5 }
    | '(' loc '/' expr expr ')' { IEBinOp $2 IDiv $4 $5 }
    | '(' loc '+' expr expr ')' { IEBinOp $2 IPlus $4 $5 }
    | '(' loc '*' expr expr ')' { IEBinOp $2 IMul $4 $5 }
    | '(' loc '-' expr expr ')' { IEBinOp $2 IMinus $4 $5 }
    | '(' loc "**" expr expr ')' { IEBinOp $2 IExp $4 $5 }
      -- TODO: еще есть вариант real ** int ^
    | '(' loc "/g" type_descr type_descr expr expr ')'
      { IEGenericBinop $2 (IRGenericDiv) $4 $5 $6 $7 }
    | '(' loc "*g" type_descr type_descr expr expr ')'
      { IEGenericBinop $2 (IRGenericMul) $4 $5 $6 $7 }
    | '(' loc and expr expr ')' { IEBinOp $2 IAnd $4 $5 }
    | '(' loc nand expr expr ')' { IEBinOp $2 INand $4 $5 }
    | '(' loc or expr expr ')' { IEBinOp $2 IOr $4 $5 }
    | '(' loc nor expr expr ')' { IEBinOp $2 INor $4 $5 }
    | '(' loc xor expr expr ')' { IEBinOp $2 IXor $4 $5 }
    | '(' loc xnor expr expr ')' { IEBinOp $2 IXNor $4 $5 }
    | '(' loc '&' expr expr ')' { IEBinOp $2 IConcat $4 $5 }

    | '(' loc '+' expr ')' { IEUnOp $2 IUPlus $4 }
    | '(' loc '-' expr ')' { IEUnOp $2 IUMinus $4 }
    | '(' loc abs expr ')' { IEUnOp $2 IAbs $4 }
    | '(' loc not expr ')' { IEUnOp $2 INot $4 }
    | '(' push_location expr pop_location ')'  { $3 }
      -- развернуто, т.к. иначе типы становятся less polymorphic

exprs :: { IREGList }
    : rev_exprs1        { reverse $1 }
    | {- empty -}       { [] }
rev_exprs1 :: { IREGList }
    : loc expr              { [($1, $2)] }
    | rev_exprs1 loc expr   {  ($2, $3) : $1 }

hier_name_internal :: { [B.ByteString] }
    : ident { [$1] }
    | hier_name_internal '.' identifier_bs { $3 : $1 }
    | hier_name_internal '.' integer { L.originalString $3 : $1 }
    | hier_name_internal '.' string { L.originalString $3 : $1 }
hier_name :: { Ident }
    : hier_name_internal { bsToFs $ B.concat $ intersperse (B.pack ".") $ reverse $1 }
hier_name_wpath :: { (Ident, [Ident]) }
    : hier_name_internal { (bsToFs $ B.concat $ intersperse (B.pack ".") $ reverse $1, map bsToFs $1) }

identifier :: { Ident }
    : ident    { bsToFs $1 }
    | resolved { fsLit "resolved" }
identifier_bs :: { B.ByteString }
    : ident    { $1 }
    | resolved { B.pack "resolved" }

int :: { TInt }
int : loc integer
            {% let i = L.decodedInteger $2 in
               if i >= fromIntegral (minBound::TInt) &&
                  i <= fromIntegral (maxBound::TInt) then
                   return $ fromIntegral i
               else failLoc $1 "Integer literal is too large"
            }
int128 :: { Int128 }
int128  : loc integer
            {% let i = L.decodedInteger $2 in
               if i >= fromIntegral (minBound::Int128) &&
                  i <= fromIntegral (maxBound::Int128) then
                   return $ fromIntegral i
               else failLoc $1 "Integer literal is too large"
            }

'(' :: {}
'(' : lparen {}
')' :: {}
')' : rparen {}
'[' :: {}
'[' : lbracket {}
']' :: {}
']' : rbracket {}
loc :: { Loc  }
loc : {% getLoc }
prevTokenEnd :: { Int }
prevTokenEnd : {% readRef psPrevTokenEnd }

push_location :: {}
    : '#' string integer integer
          {% modifyRef psLocationStack
                 (Line (B.unpack $ L.decodedString $2)
                           (fromIntegral $ L.decodedInteger $3)
                           (fromIntegral $ L.decodedInteger $4) : ) }
pop_location :: {}
    : {- empty -} {% modifyRef psLocationStack tail }

signal :: {}
    : signal_tok string {}
    | signal_tok {}
port :: {}
    : port_tok string {}
    | port_tok {}

opt_time :: { IRExpr }
    : expr { $1 }
    | loc {- empty -} { IEPhysical (WithLoc $1 0) (WithLoc $1 (fsLit "fs")) }

memory_map_range :: { T.MemoryMapRange }
    : '(' memory_map_range_keyword
    hier_name_internal hier_name_internal
    int128 int128 ')' { T.MemoryMapRange $3 $4 (fromIntegral $5) (fromIntegral $6) }

instanced_by_correspondence :: { ([Ident], [Ident]) }
    : '(' instanced_by_keyword
    hier_name_internal hier_name_internal ')' { (map bsToFs $3,map bsToFs $4) }


-- List boilerplate definitions
enum_element_rev_list1 :: { [EnumElement] }
    : enum_element { [$1] } | enum_element_rev_list1 enum_element { $2 : $1 }
enum_element_list1 :: { [EnumElement] } : enum_element_rev_list1 { reverse $1 }
enum_element_list :: { [EnumElement] } : enum_element_list1 { $1 } | {- empty -} { [] }

unit_decl_rev_list1 :: { [UnitDecl] }
    : unit_decl { [$1] } | unit_decl_rev_list1 unit_decl { $2 : $1 }
unit_decl_list1 :: { [UnitDecl] } : unit_decl_rev_list1 { reverse $1 }
unit_decl_list :: { [UnitDecl] } : unit_decl_list1 { $1 } | {- empty -} { [] }

record_field_rev_list1 :: { [(Loc, Ident, IRTypeDescr)] }
    : record_field { [$1] } | record_field_rev_list1 record_field { $2 : $1 }
record_field_list1 :: { [(Loc, Ident, IRTypeDescr)] } : record_field_rev_list1 { reverse $1 }
record_field_list :: { [(Loc, Ident, IRTypeDescr)] } : record_field_list1 { $1 } | {- empty -} { [] }

array_range_descr_rev_list1 :: { [IRArrayRangeDescr] }
    : array_range_descr { [$1] } | array_range_descr_rev_list1 array_range_descr { $2 : $1 }
array_range_descr_list1 :: { [IRArrayRangeDescr] } : array_range_descr_rev_list1 { reverse $1 }
array_range_descr_list :: { [IRArrayRangeDescr] } : array_range_descr_list1 { $1 } | {- empty -} { [] }

constrained_array_range_descr_rev_list1 :: { [Constrained IRArrayRangeDescr] }
    : constrained_array_range_descr { [$1] }
    | constrained_array_range_descr_rev_list1 constrained_array_range_descr { $2 : $1 }
constrained_array_range_descr_list1 :: { [Constrained IRArrayRangeDescr] }
    : constrained_array_range_descr_rev_list1 { reverse $1 }
constrained_array_range_descr_list :: { [Constrained IRArrayRangeDescr] }
    : constrained_array_range_descr_list1 { $1 } | {- empty -} { [] }

argument_rev_list1 :: { [IRArg] } : argument { [$1] } | argument_rev_list1 argument { $2 : $1 }
argument_list1 :: { [IRArg] } : argument_rev_list1 { reverse $1 }
argument_list :: { [IRArg] } : argument_list1 { $1 } | {- empty -} { [] }

sensitivity_item_rev_list1 :: { [IRNameG] }
        : sensitivity_item { [$1] } | sensitivity_item_rev_list1 sensitivity_item { $2 : $1 }
sensitivity_item_list1 :: { [IRNameG] } : sensitivity_item_rev_list1 { reverse $1 }
sensitivity_item_list :: { [IRNameG] } : sensitivity_item_list1 { $1 } | {- empty -} { [] }

let_decl_rev_list1 :: { [IRLetDecl] } : let_decl { [$1] } | let_decl_rev_list1 let_decl { $2 : $1 }
let_decl_list1 :: { [IRLetDecl] } : let_decl_rev_list1 { reverse $1 }
let_decl_list :: { [IRLetDecl] } : let_decl_list1 { $1 } | {- empty -} { [] }

case_element_rev_list1 :: { [IRCaseElement] } : case_element { [$1] } | case_element_rev_list1 case_element { $2 : $1 }
case_element_list1 :: { [IRCaseElement] } : case_element_rev_list1 { reverse $1 }
case_element_list :: { [IRCaseElement] } : case_element_list1 { $1 } | {- empty -} { [] }

element_association_rev_list1 :: { [IRElementAssociation] }
    : element_association { [$1] } | element_association_rev_list1 element_association { $2 : $1 }
element_association_list1 :: { [IRElementAssociation] } : element_association_rev_list1 { reverse $1 }
element_association_list :: { [IRElementAssociation] } : element_association_list1 { $1 } | {- empty -} { [] }

after_expr_rev_list1 :: { [IRAfter] } : after_expr { [$1] } | after_expr_rev_list1 after_expr { $2 : $1 }
after_expr_list1 :: { [IRAfter] } : after_expr_rev_list1 { reverse $1 }
after_expr_list :: { [IRAfter] } : after_expr_list1 { $1 } | {- empty -} { [] }

withloc_int128 :: { WithLoc Int128 }
    : loc int128 prevTokenEnd { WithLoc ($1 { locEndChar = $3 }) $2 }

withloc_identifier :: { WithLoc Ident }
    : loc identifier prevTokenEnd { WithLoc ($1 { locEndChar = $3 }) $2 }

withloc_hier_name :: { WithLoc Ident }
    : loc hier_name prevTokenEnd { WithLoc ($1 { locEndChar = $3 }) $2 }

withloc_hier_name_wpath :: { WithLoc (Ident, [Ident]) }
    : loc hier_name_wpath prevTokenEnd { WithLoc ($1 { locEndChar = $3 }) $2 }

{

-- | FastString compatibility functions
fsLit :: String -> Ident
fsLit = B.pack

-- | FastString compatibility functions
bsToFs :: B.ByteString -> Ident
bsToFs = id

parseFile :: FilePath -> IO [IRTop]
parseFile f = do
    inp <- B.readFile f
    ps <- newState f inp
    runParser ps toplevel_decls

parseFiles :: [FilePath] -> IO [IRTop]
parseFiles fn = concat <$> forM fn parseFile

failLoc :: Loc -> String -> Parser a
failLoc loc err = throwError $ ParserError $ formatErr loc $ "error: " ++ err

}

