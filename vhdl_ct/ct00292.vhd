-- NEED RESULT: ARCH00292: Floating point types and predefined floating point types passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00292
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    3.1.4 (1)
--    3.1.4 (2)
--    3.1.4 (3)
--    3.1.4.1 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00292)
--    ENT00292_Test_Bench(ARCH00292_Test_Bench)
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
architecture ARCH00292 of E00000 is
begin
   P :
   process
      type negative_interval is range -1.0 to 0.0 ;
      type positive_interval is range 0.0 to +1.0 ;

      -- this tests 3.1.4 (1)
      type symmetric_interval is range
                      negative_interval'left to positive_interval'right ;

      -- this tests 3.1.4 (3)
      type backward_interval is range
                      positive_interval'right downto negative_interval'left ;

      -- this tests 3.1.4 (2)
      type big_interval is range -1.0E31 to +1.0E31 ;

   begin
      test_report ( "ARCH00292" ,
		    "Floating point types and predefined floating point types" ,
		    (symmetric_interval'left  = -1.0) and
		    (symmetric_interval'right = +1.0) and
		    (backward_interval'left  = +1.0) and
		    (backward_interval'right = -1.0) and
		    (big_interval'left   = -1.0E31) and
		    (big_interval'right  = +1.0E31) and
                    -- these test 3.1.4.1 (1) :
                    (real'left  < real'right) and
                    (real'left  <= -1.0E31) and
                    (real'right >= +1.0E31)
                  ) ;
      wait ;
   end process P ;
end ARCH00292 ;

entity ENT00292_Test_Bench is
end ENT00292_Test_Bench ;

architecture ARCH00292_Test_Bench of ENT00292_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00292 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00292_Test_Bench ;

