-- NEED RESULT: ARCH00441: Allowable replacement of characters passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00441
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    13.10 (1)
--    13.10 (2)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00441)
--    ENT00441_Test_Bench(ARCH00441_Test_Bench)
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
architecture ARCH00441 of E00000 is
begin
   P :
   process
      variable ch : character := 'B' ;
      variable i : integer := 0 ;
      constant cstr1 : string := "A" ;
      constant cstr2 : string := "abc%xyz" ;
   begin
      case ch is
	 when 'a' | 'b' | 'c' =>
	    i := 200 ;
	 when 'A' ! 'B' ! 'C' =>
	    i := 201 ;
	 when 'w' | 'x' | 'y' | 'z' =>
	    i := 300 ;
	 when 'W' ! 'X' ! 'Y' ! 'Z' =>
	    i := 301 ;
	 when others =>
	    i := 400 ;
      end case ;
      test_report ( "ARCH00441" ,
		    "Allowable replacement of characters" ,
		    (i = 201) and
                    (16:9ABCDEF: = 16#9ABCDEF#) and
                    (cstr1 = %A%) and
                    (B"101" = B%101%) and
                    (cstr2 = %abc%%xyz%)
                  ) ;
      wait ;
   end process P ;
end ARCH00441 ;

entity ENT00441_Test_Bench is
end ENT00441_Test_Bench ;

architecture ARCH00441_Test_Bench of ENT00441_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00441 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00441_Test_Bench ;

