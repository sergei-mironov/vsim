-- NEED RESULT: ARCH00442: Lexical elements, separators, and delimiters passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00442
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    13.2 (1)
--    13.2 (2)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00442)
--    ENT00442_Test_Bench(ARCH00442_Test_Bench)
--
-- REVISION HISTORY:
--
--     4-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00442 of E00000 is
   function xory return boolean is
   begin
      return true ;
   end xory ;
begin
   P :
   process
      variable a,b,c,d : integer ;        -- this tests , : ;
      variable e : WORK.STANDARD_TYPES.t_enum1 ;
      variable x,y : boolean := false ;
      variable c1, c2 : character := 'w';
      type ary is array ( integer range <> ) of boolean ;
      subtype s_ary is ary (-1 to 1) ;
      subtype string3 is string (1 to 3) ;
      variable sa : s_ary ;
      variable s1,s2 : string3 ;
   begin
      a := 15 ;
      b := 10 ;
      c := 12 ;
      d :=  4 ;
      e := WORK.STANDARD_TYPES.en1 ;
      s1 := "abc" ;
      s2 := "def" ;
      for i in integer (-1) to 1 loop
         sa (i) := boolean'val(abs(i)) ;
      end loop ;
      case c1 is              -- this tests | => :=
	 when 'x' | 'y' =>
	    c2 := '1' ;
	 when 'w' | 'z' =>
	    c2 := '2' ;
	 when others =>
	    c2 := '3' ;
      end case ;
      test_report ( "ARCH00442" ,
		    "Lexical elements, separators, and delimiters" ,
		    (c1 = 'w' and c2 = '2') and
                    -- this tests + - * / = ( ) **
		    ( ((a+b-1)*(c/d))**2 = ((15+10-1)*(12/4))**2 ) and
                    -- this tests < >
                    ( a > b and d < c ) and
                    -- this tests /= <= >=
                    ( a >= b and d <= c and b /= c ) and
                    -- this tests &
                    ( s1 & s2 = "abcdef" ) and
                    -- this tests . '
                    ( WORK.STANDARD_TYPES.t_enum1'pos(e) = 0 ) and
                    -- these test <>  (from the definition of type ary)
                    (sa(-1) = true) and
                    (sa(0) = false) and
                    (sa(1) = true) and
                    -- these test 13.2 (2)
                    ( x or y  = false ) and
                    ( xory  = true )
                  ) ;
      wait ;
   end process P ;
end ARCH00442 ;

entity ENT00442_Test_Bench is
end ENT00442_Test_Bench ;

architecture ARCH00442_Test_Bench of ENT00442_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00442 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00442_Test_Bench ;

