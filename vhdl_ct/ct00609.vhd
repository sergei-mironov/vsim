-- NEED RESULT: ARCH00609: Implicit library clause for WORK and STD exists passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00609
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    11.2 (1)
--    11.3 (1)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00609_Test_Bench(ARCH00609_Test_Bench)
--
-- REVISION HISTORY:
--
--    24-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
entity ENT00609_Test_Bench is
end ENT00609_Test_Bench ;

architecture ARCH00609_Test_Bench of ENT00609_Test_Bench is
begin
   L1:
   block
   begin
      process
	 constant C : STD.Standard.Boolean := true ;
      begin
	 WORK.STANDARD_TYPES.test_report ( "ARCH00609" ,
		       "Implicit library clause for WORK and STD exists" ,
		       C ) ;
         wait ;
      end process ;
   end block L1 ;
end ARCH00609_Test_Bench ;
--
