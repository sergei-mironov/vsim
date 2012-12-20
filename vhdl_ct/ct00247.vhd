-- NEED RESULT: ARCH00247: Test of operator overloading passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00247
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    2.1 (3)
--    2.1 (4)
--    2.3.1 (1)
--    2.3.1 (2)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00247)
--    ENT00247_Test_Bench(ARCH00247_Test_Bench)
--
-- REVISION HISTORY:
--
--    15-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--    This test overloads the operators listed in LRM Section 7.2 on the
--    enumeration type t_enum1 in STANDARD_TYPES. For some of the operators,
--    a reasonable value is defined; in the other cases, only a stub value is
--    returned.
--
--    The operators "mod" and "rem" are defined for testing purposes as the
--    left and right projection operators, respectively (for test
--    objective 2.3.1 (1) ). They are called using both the operator notation
--    and function notation (for test objective 2.3.1 (2) ).
--
--    Objective 2.1 (4) is met by defining the operators in upper case and
--    by referencing them in lower case.
--
--    The type t_enum1 is taken from STANDARD_TYPES.
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00247 of E00000 is

   -- logical operators

   function "AND" ( left, right : in t_enum1 ) return t_enum1 is
   begin
      if t_enum1'pos(left) <= t_enum1'pos(right) then
         return left;
      else
         return right ;
      end if;
   end ;

   function "OR" ( left, right : in t_enum1 ) return t_enum1 is
   begin
      if t_enum1'pos(left) >= t_enum1'pos(right) then
         return left;
      else
         return right ;
      end if;
   end ;

   function "NAND" ( left, right : in t_enum1 ) return t_enum1 is
   begin
      return t_enum1'left ;
   end ;

   function "NOR" ( left, right : in t_enum1 ) return t_enum1 is
   begin
      return t_enum1'left ;
   end ;

   function "XOR" ( left, right : in t_enum1 ) return t_enum1 is
   begin
      return t_enum1'left ;
   end ;

   -- relational operators  (these test 2.1 (3))

   function "=" ( left, right : in t_enum1 ) return boolean is
   begin
      return t_enum1'pos(left) = t_enum1'pos(right) ;
   end ;

   function "/=" ( left, right : in t_enum1 ) return boolean is
   begin
      return t_enum1'pos(left) /= t_enum1'pos(right) ;
   end ;

   function "<" ( left, right : in t_enum1 ) return boolean is
   begin
      return t_enum1'pos(left) < t_enum1'pos(right) ;
   end ;

   function "<=" ( left, right : in t_enum1 ) return boolean is
   begin
      return t_enum1'pos(left) <= t_enum1'pos(right) ;
   end ;

   function ">" ( left, right : in t_enum1 ) return boolean is
   begin
      return t_enum1'pos(left) > t_enum1'pos(right) ;
   end ;

   function ">=" ( left, right : in t_enum1 ) return boolean is
   begin
      return t_enum1'pos(left) >= t_enum1'pos(right) ;
   end ;

   -- adding operators

   function "+" ( left, right : in t_enum1 ) return t_enum1 is
   begin
      return t_enum1'val( ( t_enum1'pos(left) + t_enum1'pos(right) ) mod
                          ( 1 + t_enum1'pos(right) ) ) ;
   end ;

   function "-" ( left, right : in t_enum1 ) return t_enum1 is
   begin
      return t_enum1'left ;
   end ;

   function "&" ( left, right : in t_enum1 ) return t_enum1 is
   begin
      return t_enum1'left ;
   end ;

   -- signs

   function "+" ( operand : in t_enum1 ) return t_enum1 is
   begin
      return operand ;
   end ;

   function "-" ( operand : in t_enum1 ) return t_enum1 is
   begin
      return t_enum1'left ;
   end ;

   -- multiplying operators

   function "*" ( left, right : in t_enum1 ) return t_enum1 is
   begin
      return t_enum1'left ;
   end ;

   function "/" ( left, right : in t_enum1 ) return t_enum1 is
   begin
      return t_enum1'left ;
   end ;

   function "MOD" ( left, right : in t_enum1 ) return t_enum1 is
   begin
      return left ;
   end ;

   function "REM" ( left, right : in t_enum1 ) return t_enum1 is
   begin
      return right ;
   end ;

   -- miscellaneous operators

   function "**" ( left, right : in t_enum1 ) return t_enum1 is
   begin
      return t_enum1'left ;
   end ;

   function "ABS" ( operand : in t_enum1 ) return t_enum1 is
   begin
      return t_enum1'left ;
   end ;

   function "NOT" ( operand : in t_enum1 ) return t_enum1 is
   begin
      return t_enum1'left ;
   end ;

begin
   P :
   process
   begin
      test_report ( "ARCH00247" ,
		    "Test of operator overloading" ,
                    -- logical operators
             	    ((t_enum1'left and  t_enum1'right) =  t_enum1'left) and
             	    ((t_enum1'left or   t_enum1'right) =  t_enum1'right) and
             	    ((t_enum1'left nand t_enum1'right) =  t_enum1'left) and
             	    ((t_enum1'left nor  t_enum1'right) =  t_enum1'left) and
             	    ((t_enum1'left xor  t_enum1'right) =  t_enum1'left) and
                    -- relational operators
             	    (t_enum1'left  =  t_enum1'left) and
		    (t_enum1'left  /= t_enum1'right) and
		    (t_enum1'left  <  t_enum1'right) and
		    (t_enum1'left  <= t_enum1'right) and
		    (t_enum1'right >  t_enum1'left) and
		    (t_enum1'right >= t_enum1'left) and
                   -- adding operators
             	    (t_enum1'left  +  t_enum1'right  =  t_enum1'right) and
             	    (t_enum1'left  -  t_enum1'right  =  t_enum1'left)  and
             	    (t_enum1'left  &  t_enum1'right  =  t_enum1'left)  and
                   -- signs
             	    ( + t_enum1'right =  t_enum1'right) and
             	    ( - t_enum1'right =  t_enum1'left)  and
                   -- multiplying operators
             	    (t_enum1'left   mod  t_enum1'right  =  t_enum1'left)  and
             	    (t_enum1'right  mod  t_enum1'left   =  t_enum1'right) and
             	    (t_enum1'left   rem  t_enum1'right  =  t_enum1'right) and
             	    (t_enum1'right  rem  t_enum1'left   =  t_enum1'left)  and
             	    ("mod" (t_enum1'left , t_enum1'right) =  t_enum1'left)  and
             	    ("mod" (t_enum1'right, t_enum1'left ) =  t_enum1'right) and
             	    ("rem" (t_enum1'left , t_enum1'right) =  t_enum1'right) and
             	    ("rem" (t_enum1'right, t_enum1'left ) =  t_enum1'left)  and
                   -- miscellaneous operators
             	    (t_enum1'left   **  t_enum1'right  =  t_enum1'left) and
             	    (t_enum1'right  **  t_enum1'left   =  t_enum1'left) and
             	    (abs (t_enum1'right ) =  t_enum1'left)  and
             	    (not (t_enum1'right ) =  t_enum1'left)
                  ) ;
      wait ;
   end process P ;
end ARCH00247 ;

entity ENT00247_Test_Bench is
end ENT00247_Test_Bench ;

architecture ARCH00247_Test_Bench of ENT00247_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00247 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00247_Test_Bench ;

