-- NEED RESULT: ARCH00452: No statement need appear in a generate statement passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00452
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.7 (2)
--    9.7 (4)
--    9.7 (8)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00452_Test_Bench(ARCH00452_Test_Bench)
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
entity ENT00452_Test_Bench is
end ENT00452_Test_Bench ;

architecture ARCH00452_Test_Bench of ENT00452_Test_Bench is
   constant C : boolean := True;
begin
   For_Gen :
   for i in 1 to 1 generate
   end generate For_Gen ;

   If_Gen :
   if C generate
   end generate If_Gen ;

   process
   begin
      test_report ( "ARCH00452" ,
		    "No statement need appear in a generate statement" ,
		    True ) ;
      wait ;
   end process ;

end ARCH00452_Test_Bench ;
