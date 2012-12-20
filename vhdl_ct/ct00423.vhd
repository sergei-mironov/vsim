-- NEED RESULT: ARCH00423: Basic character set passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00423
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    13.1 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00423)
--    ENT00423_Test_Bench(ARCH00423_Test_Bench)
--
-- REVISION HISTORY:
--
--    31-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00423 of E00000 is
begin
   P :
   process
      constant pi : real := 3.14159 ;
      variable theta : real := 180.0 ;
      variable x_2f : integer := 16#2f# ;
      variable x_67 : integer := 16#67# ;   -- all digits have now been used
      variable ABCDEFGHIJKLM : boolean := true ;
      variable NOPQRSTUVWXYZ : boolean := false ; -- all caps have now been used
      variable c1, c2 : character := 'w';
      subtype string_3 is string (1 to 3) ;
      variable s1 : string_3 := "ABC" ;
      variable s2 : string_3 := "xyz" ;

      -- all special chars except for the operators + - * / & | < = >
      -- have now been used; the | char will be used in the case statement
      -- below; all others will be used in the test_report function call

   begin
      case c1 is
	 when 'x' | 'y' =>
	    c2 := '1' ;
	 when 'w' | 'z' =>
	    c2 := '2' ;
	 when others =>
	    c2 := '3' ;
      end case ;
      test_report ( "ARCH00423" ,
		    "Basic character set" ,
		    (c1 = 'w') and
		    (c2 = '2') and
		    (s1 & s2 = "ABCxyz") and
		    (ABCDEFGHIJKLM and (not NOPQRSTUVWXYZ) = true) and
		    (x_67 > 67) and
		    (x_67 + x_2f = 16#67# + 16#2F#) and
		    (x_67 - x_2f = 16#67# - 16#2F#) and
		    (x_67 * x_2f = 16#67# * 16#2F#) and
		    (theta / pi < 60.0)
                  ) ;
      wait ;
   end process P ;
end ARCH00423 ;

entity ENT00423_Test_Bench is
end ENT00423_Test_Bench ;

architecture ARCH00423_Test_Bench of ENT00423_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00423 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00423_Test_Bench ;

