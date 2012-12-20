-- NEED RESULT: *** There should be two default assertion messages output
-- NEED RESULT: Assertion Violation.
-- NEED RESULT: Assertion Violation.
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00321
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.4 (1)
--    9.4 (2)
--    9.4 (3)
--    9.4 (4)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00321_Test_Bench(ARCH00321_Test_Bench)
--
-- REVISION HISTORY:
--
--    29-JUL-1987   - initial revision
--
-- NOTES:
--
--    Verify that assertion messages match
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00321_Test_Bench is
end ENT00321_Test_Bench ;

architecture ARCH00321_Test_Bench of ENT00321_Test_Bench is
begin
   process
   begin
      print ( "*** There should be two default assertion messages output" ) ;
      wait ;
   end process ;

   L : assert False severity Note ;  -- Assertion with a label

       assert False severity Note ;  -- Assertion without a label;

end ARCH00321_Test_Bench ;
