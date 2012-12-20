-- NEED RESULT: ARCH00437: comments passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00437
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    13.8 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00437)
--    ENT00437_Test_Bench(ARCH00437_Test_Bench)
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
architecture ARCH00437 of E00000 is
begin
   P :
   process
      variable x,y,z,w : integer := 999;
   begin
      x := 25 ;
--    x := 26 ;
      y := -25 ; -- y := 299 ;
      z := x -- + 1
           - 2*y ;
      w -- !
      := -- !
      x -- !
      + -- !
      1 -- !
      ; -- !
      test_report ( "ARCH00437" ,
		    "comments" ,
                    (x = 25) and
                    (y = -25) and
                    (z = 75) and
                    (w = 26)
                  ) ;
      wait ;
   end process P ;
end ARCH00437 ;

entity ENT00437_Test_Bench is
end ENT00437_Test_Bench ;

architecture ARCH00437_Test_Bench of ENT00437_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00437 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00437_Test_Bench ;

