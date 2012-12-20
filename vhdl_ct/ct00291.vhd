-- NEED RESULT: ARCH00291: TIME is predefined correctly passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00291
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    3.1.3.1 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00291)
--    ENT00291_Test_Bench(ARCH00291_Test_Bench)
--
-- REVISION HISTORY:
--
--    22-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00291 of E00000 is
begin
   P :
   process
   begin
      test_report ( "ARCH00291" ,
		    "TIME is predefined correctly" ,
		    (time'pos(fs) = 1) and
                    (ps  = 1000 fs) and
                    (ns  = 1000 ps) and
                    (us  = 1000 ns) and
                    (ms  = 1000 us) and
                    (sec   = 1000 ms) and
                    (min =   60  sec) and
                    (hr  =   60 min)
                  ) ;
      wait ;
   end process P ;
end ARCH00291 ;

entity ENT00291_Test_Bench is
end ENT00291_Test_Bench ;

architecture ARCH00291_Test_Bench of ENT00291_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00291 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00291_Test_Bench ;
