-- NEED RESULT: ARCH00505: One or more signal names may appear in a signal list in an initialization spec passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00505
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    5.2 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00505)
--    ENT00505_Test_Bench(ARCH00505_Test_Bench)
--
-- REVISION HISTORY:
--
--    10-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00505 of E00000 is
   signal s1, s2 : boolean := True ;
   signal s3 : boolean := True ;
begin
   process
   begin
      test_report ( "ARCH00505" ,
		    "One or more signal names may appear in a signal "&
                    "list in an initialization spec" ,
		    s1 and s2 and s3 ) ;
      wait ;
   end process ;
end ARCH00505 ;

entity ENT00505_Test_Bench is
end ENT00505_Test_Bench ;

architecture ARCH00505_Test_Bench of ENT00505_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00505 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00505_Test_Bench ;
