-- NEED RESULT: ARCH00318_Test_Bench: Process with no statements passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00318
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.2 (6)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00318_Test_Bench(ARCH00318_Test_Bench)
--
-- REVISION HISTORY:
--
--    29-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00318_Test_Bench is
end ENT00318_Test_Bench ;

architecture ARCH00318_Test_Bench of ENT00318_Test_Bench is
begin
   L1:
   block
      signal s1 : boolean := false ;
   begin
      P :
      process ( s1 )
      begin
      end process P ;

      process
      begin
	 test_report ( "ARCH00318_Test_Bench" ,
		       "Process with no statements" ,
		       True ) ;
         wait ;
      end process ;
   end block L1 ;
end ARCH00318_Test_Bench ;
