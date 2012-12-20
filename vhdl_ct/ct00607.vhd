-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00607
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
--    PKG00603
--    PKG00603/BODY
--    E00000(ARCH00601)
--    ENT00605_Test_Bench(ARCH00606_Test_Bench)
--    CONF00607
--
-- REVISION HISTORY:
--
--    24-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--    Assumes that tests ct00601, ct00603, ct00604, ct00605, and ct00606 have
--      all been analyzed into library WORK for use by test ct00607.
--
--
configuration CONF00607 of WORK.ENT00605_Test_Bench is
   for ARCH00606_Test_Bench
      for L1
	 for CIS1 : UUT
	    use entity WORK.E00000 ( ARCH00601 );
	 end for ;
      end for ;
   end for ;
end CONF00607 ;
--
