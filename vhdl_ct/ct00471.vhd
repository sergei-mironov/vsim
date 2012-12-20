-- NEED RESULT: ARCH00471: Object declarations passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00471
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    12.3.1.4 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00471)
--    ENT00471_Test_Bench(ARCH00471_Test_Bench)
--
-- REVISION HISTORY:
--
--     5-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00471 of E00000 is
begin
   P :
   process
      variable a,b : WORK.STANDARD_TYPES.st_arr1 ;
   begin
      for i in st_arr1'left to st_arr1'right loop
	 a (i) := 8 ;
         b (i) := st_int1 ( 2 * (i+5) ) ;
      end loop ;
      a (2 to 4) := b (3 to 5) ;
      test_report ( "ARCH00471" ,
		    "Object declarations" ,
		    (a(1) = 8) and
		    (a(2) = 2 * 8) and
		    (a(3) = 2 * 9) and
		    (a(4) = 2 * 10) and
		    (a(5) = 8)
                  ) ;
      wait ;
   end process P ;
end ARCH00471 ;

entity ENT00471_Test_Bench is
end ENT00471_Test_Bench ;

architecture ARCH00471_Test_Bench of ENT00471_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00471 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00471_Test_Bench ;

