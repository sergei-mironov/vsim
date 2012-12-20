-- NEED RESULT: Passive concurrent procedure call in interface shared among architectures
-- NEED RESULT: ENT00257: Passive process statement in interface shared amongarchitectures
-- NEED RESULT: Passive concurrent procedure call in interface shared among architectures
-- NEED RESULT: ENT00257: Passive process statement in interface shared amongarchitectures
-- NEED RESULT: *** Examine log file to verify that the followingtwo messages appear twice:
-- NEED RESULT: Passive concurrent procedure call in interface sharedamong architectures
-- NEED RESULT: Passive process statement in interface shared amongarchitectures
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00257
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.1.3 (1)
--    1.1.3 (3)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00257(ARCH00257)
--    ENT00257(ARCH00257_1)
--    ENT00257_Test_Bench(ARCH00257_Test_Bench)
--
-- REVISION HISTORY:
--
--    16-JUL-1987   - initial revision
--
-- NOTES:
--
--    simulation log file needs to be checked for result of assertion
--
use WORK.STANDARD_TYPES.all ;
entity ENT00257 is
   port ( s : out boolean ) ;
   procedure proc is
   begin
      assert false
	report "Passive concurrent procedure call in interface shared" &
               " among architectures"
	severity note ;
   end proc ;
begin
   P1 : proc ;
   P2 :
   process
   begin
      assert false
	report "ENT00257: Passive process statement in interface shared among" &
               "architectures"
	severity note ;
      wait ;
   end process P2 ;
end ENT00257 ;

architecture ARCH00257 of ENT00257 is
begin
   A1 : s <=  true ;
end ARCH00257 ;

architecture ARCH00257_1 of ENT00257 is
begin
   A1 : s <=  false ;
end ARCH00257_1 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00257_Test_Bench is
end ENT00257_Test_Bench ;

architecture ARCH00257_Test_Bench of ENT00257_Test_Bench is
begin
   L1:
   block
      signal s1, s2 : boolean := true ;
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00257 ( ARCH00257 )
	 port map ( s1 ) ;
      for CIS2 : UUT use entity WORK.ENT00257 ( ARCH00257_1 )
	 port map ( s2 ) ;
   begin
      CIS1 : UUT ;
      CIS2 : UUT ;
      process ( s1, s2 )
      begin
         if s1 = true and s2 = false then
            print ( "*** Examine log file to verify that the following" &
                    "two messages appear twice:" ) ;
	    print ( "Passive concurrent procedure call in interface shared" &
               "among architectures" ) ;
	    print ( "Passive process statement in interface shared among" &
               "architectures" ) ;
	 end if ;
      end process ;
   end block L1 ;
end ARCH00257_Test_Bench ;
