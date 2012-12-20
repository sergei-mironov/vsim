-- NEED RESULT: ENT00254: Assertion in entity shared among architectures
-- NEED RESULT: ENT00254: Assertion in entity shared among architectures
-- NEED RESULT: *** Examine log file to verify that the followingmessage appears twice:
-- NEED RESULT: Assertion in entity shared among architectures
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00254
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.1.3 (1)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00254(ARCH00254)
--    ENT00254(ARCH00254_1)
--    ENT00254_Test_Bench(ARCH00254_Test_Bench)
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
entity ENT00254 is
   port ( s : out boolean ) ;
   constant test : boolean := false ;
begin
   A1 : assert test
	  report "ENT00254: Assertion in entity shared among architectures"
	  severity note ;
end ENT00254 ;

architecture ARCH00254 of ENT00254 is
begin
   A2 : s <=  true ;
end ARCH00254 ;

architecture ARCH00254_1 of ENT00254 is
begin
   A2 : s <=  false ;
end ARCH00254_1 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00254_Test_Bench is
end ENT00254_Test_Bench ;

architecture ARCH00254_Test_Bench of ENT00254_Test_Bench is
begin
   L1:
   block
      signal s1, s2 : boolean := true ;
      component UUT
         port ( s : out boolean ) ;
      end component ;

      for CIS1 : UUT use entity WORK.ENT00254 ( ARCH00254 ) ;
      for CIS2 : UUT use entity WORK.ENT00254 ( ARCH00254_1 ) ;
   begin
      CIS1 : UUT
	 port map ( s1 ) ;
      CIS2 : UUT
	 port map ( s2 ) ;
      process ( s1, s2 )
      begin
         if s1 = true and s2 = false then
            print ( "*** Examine log file to verify that the following" &
                    "message appears twice:" ) ;
            print ( "Assertion in entity shared among architectures" ) ;
	 end if ;
      end process ;
   end block L1 ;
end ARCH00254_Test_Bench ;
