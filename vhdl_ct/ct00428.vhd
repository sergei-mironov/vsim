-- NEED RESULT: ARCH00428: Based literals passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00428
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    13.4.2 (1)
--    13.4.2 (2)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00428)
--    ENT00428_Test_Bench(ARCH00428_Test_Bench)
--
-- REVISION HISTORY:
--
--     3-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--

use WORK.STANDARD_TYPES.all ;
architecture ARCH00428 of E00000 is
begin
   process
   begin
      test_report ( "ARCH00428" ,
		    "Based literals" ,
                    -- these test 13.4.2 (1) for integers
		    (16#aA# = 16*10+10) and
		    (16#bB# = 16*11+11) and
		    (16#cC# = 16*12+12) and
		    (16#dD# = 16*13+13) and
		    (16#eE# = 16*14+14) and
		    (16#fF# = 16*15+15) and
                    -- these test 13.4.2 (1) for reals
		    (16#aA.c# = 16.0*10.0+10.0+0.75) and
		    (16#bB.C# = 16.0*11.0+11.0+0.75) and
		    (16#cC.c# = 16.0*12.0+12.0+0.75) and
		    (16#dD.C# = 16.0*13.0+13.0+0.75) and
		    (16#eE.c# = 16.0*14.0+14.0+0.75) and
		    (16#fF.C# = 16.0*15.0+15.0+0.75) and
                    -- these test 13.4.2 (2)
		    (2#100# = 2**2) and
		    (3#100# = 3**2) and
		    (4#100# = 4**2) and
		    (5#100# = 5**2) and
		    (6#100# = 6**2) and
		    (7#100# = 7**2) and
		    (8#100# = 8**2) and
		    (9#100# = 9**2) and
		    (10#100# = 10**2) and
		    (11#100# = 11**2) and
		    (12#100# = 12**2) and
		    (13#100# = 13**2) and
		    (14#100# = 14**2) and
		    (15#100# = 15**2) and
		    (16#100# = 16**2)
                  ) ;
      wait ;
   end process ;
end ARCH00428 ;

entity ENT00428_Test_Bench is
end ENT00428_Test_Bench ;

architecture ARCH00428_Test_Bench of ENT00428_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00428 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00428_Test_Bench ;

