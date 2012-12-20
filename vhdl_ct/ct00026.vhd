-- NEED RESULT: *** An assertion violation should follow 
-- NEED RESULT: ARCH00026: Assertion Violation only occurs when condition is false passed
-- NEED RESULT: *** No assertion violation should follow 
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00026
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.2 (6)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00026_Test_Bench(ARCH00026_Test_Bench)
--
-- REVISION HISTORY:
--
--    26-JUN-1987   - initial revision
--
-- NOTES:
--
--    Verify that assertion messages match output comment messages
--
entity ENT00026_Test_Bench is
   signal False_Signal : Boolean := false ;
end ENT00026_Test_Bench ;

use WORK.STANDARD_TYPES.all;
architecture ARCH00026_Test_Bench of ENT00026_Test_Bench is
begin
   P1 :
   process ( False_Signal )
   begin
      print ( "*** An assertion violation should follow " ) ;
      assert False_Signal
	report "ARCH00026: Assertion Violation only occurs when " &
               "condition is false passed"
	severity NOTE ;
   end process P1 ;

   P2 :
   process ( False_Signal )
   begin
      print ( "*** No assertion violation should follow " ) ;
      assert Not False_Signal
	report "ARCH00026: Assertion Violation only occurs when " &
               "condition is false failed"
	severity NOTE ;
   end process P2 ;
end ARCH00026_Test_Bench ;

