-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00606
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    11.1 (1)
--
-- DESIGN UNIT ORDERING:
--
--    N/A
--
-- REVISION HISTORY:
--
--    24-AUG-1987   - initial revision
--
-- NOTES:
--
--    will be used in conjunction with test ct00607.
--
--
architecture ARCH00606_Test_Bench of ENT00605_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00606_Test_Bench ;
--
