-- NEED RESULT: This should only come out once
-- NEED RESULT: *** An assertion with report = 'This should only come out once' and severity level = 'Note'
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00327
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.4 (7)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00327_Test_Bench(ARCH00327_Test_Bench)
--
-- REVISION HISTORY:
--
--    29-JUL-1987   - initial revision
--
-- NOTES:
--
--    Verify that assertion messages match comment messages output
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00327_Test_Bench is
end ENT00327_Test_Bench ;

architecture ARCH00327_Test_Bench of ENT00327_Test_Bench is
begin
   assert False
     report "This should only come out once"
     severity Note ;

   process
   begin
      print ( "*** An assertion with report = "&
              "'This should only come out once' and severity level = "&
              "'Note'" ) ;
      wait ;
   end process ;
end ARCH00327_Test_Bench ;
