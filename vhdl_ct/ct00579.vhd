-- NEED RESULT: ARCH00579: Use clause makes this directly visible passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00579
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    10.4 (3)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00579_Test_Bench(ARCH00579_Test_Bench)
--
-- REVISION HISTORY:
--
--    20-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
entity ENT00579_Test_Bench is
   use WORK.all ; -- Make all design units in library directly visible
end ENT00579_Test_Bench ;

architecture ARCH00579_Test_Bench of ENT00579_Test_Bench is
begin
   L1:
   block
      Use STANDARD_TYPES.Test_Report ;  -- Make test_report directly visible
   begin
      test_report ( "ARCH00579" ,
		    "Use clause makes this directly visible" ,
		    True ) ;
   end block L1 ;
end ARCH00579_Test_Bench ;
--
