-- NEED RESULT: ENT00255_Test_Bench: Declarative items need not be present in entity declaration passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00255
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.1.2 (2)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00255_Test_Bench(ARCH00255_Test_Bench)
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
entity ENT00255_Test_Bench is
begin
end ENT00255_Test_Bench ;

architecture ARCH00255_Test_Bench of ENT00255_Test_Bench is
begin
   process
   begin
      test_report ( "ENT00255_Test_Bench" ,
    "Declarative items need not be present in entity declaration" ,
		    true ) ;
      wait ;
   end process ;
end ARCH00255_Test_Bench ;
