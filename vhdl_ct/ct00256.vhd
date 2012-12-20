-- NEED RESULT: ARCH00256_Test_Bench: Concurrent statements need not appear in entity passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00256
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.1.3 (2)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00256_Test_Bench(ARCH00256_Test_Bench)
--
-- REVISION HISTORY:
--
--    16-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
entity ENT00256_Test_Bench is
   constant c : boolean := true ;
begin
end ENT00256_Test_Bench ;

architecture ARCH00256_Test_Bench of ENT00256_Test_Bench is
begin
   process
   begin
      test_report ( "ARCH00256_Test_Bench" ,
		    "Concurrent statements need not appear in entity" ,
		    true ) ;
      wait ;
   end process ;
end ARCH00256_Test_Bench ;
