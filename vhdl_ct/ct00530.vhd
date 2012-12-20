-- NEED RESULT: ARCH00530: Predefined attributes are not reserved words passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00530
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    14.1 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00530)
--    ENT00530_Test_Bench(ARCH00530_Test_Bench)
--
-- REVISION HISTORY:
--
--    17-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all;
architecture ARCH00530 of E00000 is
begin
   P :
   process
      constant c : integer := 100 ;
      variable BASE,
               LEFT,
               RIGHT,
               HIGH,
               LOW,
               POS,
               VAL,
               SUCC,
               PRED,
               LENGTH,
               DELAYED,
               STABLE,
               QUIET,
               EVENT,
               ACTIVE,
               LAST_EVENT,
               LAST_ACTIVE,
               LAST_VALUE,
               BEHAVIOR,
               STRUCTURE : integer := c ;
   begin
      test_report ( "ARCH00530" ,
		    "Predefined attributes are not reserved words" ,
                    (BASE = c) and
                    (LEFT = c) and
                    (RIGHT = c) and
                    (HIGH = c) and
                    (LOW = c) and
                    (POS = c) and
                    (VAL = c) and
                    (SUCC = c) and
                    (PRED = c) and
                    (LENGTH = c) and
                    (DELAYED = c) and
                    (STABLE = c) and
                    (QUIET = c) and
                    (EVENT = c) and
                    (ACTIVE = c) and
                    (LAST_EVENT = c) and
                    (LAST_ACTIVE = c) and
                    (LAST_VALUE = c) and
                    (BEHAVIOR = c) and
                    (STRUCTURE  = c)
                  ) ;
      wait ;
   end process P ;
end ARCH00530 ;
--
entity ENT00530_Test_Bench is
end ENT00530_Test_Bench ;

architecture ARCH00530_Test_Bench of ENT00530_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00530 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00530_Test_Bench ;
--
