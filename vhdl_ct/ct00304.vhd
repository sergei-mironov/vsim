-- NEED RESULT: ARCH00304_Test_Bench: Block with no block declarative item passed
-- NEED RESULT: ARCH00304_Test_Bench: Previous block has no concurrent statement passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00304
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.1 (11)
--    9.1 (12)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00304_Test_Bench(ARCH00304_Test_Bench)
--
-- REVISION HISTORY:
--
--    27-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00304_Test_Bench is
end ENT00304_Test_Bench ;

architecture ARCH00304_Test_Bench of ENT00304_Test_Bench is
begin
   L1:
   block
   begin
      process
      begin
	 test_report ( "ARCH00304_Test_Bench" ,
		       "Block with no block declarative item" ,
		       True ) ;
         wait ;
      end process ;
   end block L1 ;

   L2 :
   block
   begin
      L2_sub :
      block
      begin
      end block L2_sub ;

      process
      begin
	 test_report ( "ARCH00304_Test_Bench" ,
		       "Previous block has no concurrent statement" ,
		       True ) ;
         wait ;
      end process ;
   end block L2 ;
end ARCH00304_Test_Bench ;
