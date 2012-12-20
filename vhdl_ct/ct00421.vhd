-- NEED RESULT: ARCH00421: Block statements passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00421
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    12.4.1 (1)
--    12.4.1 (2)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00421)
--    ENT00421_Test_Bench(ARCH00421_Test_Bench)
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
architecture ARCH00421 of E00000 is
begin
   B :
   block
      generic ( g : integer := 10 ) ;
      constant c : integer := g - 1 ;
   begin
      P :
      process
	 variable v : integer := 2 * c ;
      begin
	 test_report ( "ARCH00421" ,
		       "Block statements" ,
		       (c = 9) and   -- this tests 12.4 1 (1)
                       (v = 18)      -- this tests 12.4.1 (2)
                     ) ;
         wait ;
      end process P ;
   end block B ;
end ARCH00421 ;

entity ENT00421_Test_Bench is
end ENT00421_Test_Bench ;

architecture ARCH00421_Test_Bench of ENT00421_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00421 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00421_Test_Bench ;

