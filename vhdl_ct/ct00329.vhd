-- NEED RESULT: ARCH00329_Test_Bench: Component is declared but not instantiated passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00329
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.6 (3)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00329_Test_Bench(ARCH00329_Test_Bench)
--
-- REVISION HISTORY:
--
--    30-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00329_Test_Bench is
end ENT00329_Test_Bench ;

architecture ARCH00329_Test_Bench of ENT00329_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

   begin
      process
      begin
	 test_report ( "ARCH00329_Test_Bench" ,
		       "Component is declared but not instantiated" ,
		       True ) ;
         wait ;
      end process ;
   end block L1 ;
end ARCH00329_Test_Bench ;
