-- NEED RESULT: ARCH00541: DELAYED, STABLE, and QUIET are signals passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00541
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    14.1 (17)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00541)
--    ENT00541_Test_Bench(ARCH00541_Test_Bench)
--
-- REVISION HISTORY:
--
--    18-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--    THIS IS A STATIC TEST ONLY.
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00541 of E00000 is
   signal t : boolean ;
begin
   P :
   process
      variable a,b,c : boolean ;
      function f ( signal s : boolean ) return boolean is
      begin
	 return s ;
      end f ;
   begin
      a :=  f ( t'delayed (1 ns) ) ;
      b :=  f ( t'stable ) ;
      c :=  f ( t'quiet  ) ;
      test_report ( "ARCH00541" ,
		    "DELAYED, STABLE, and QUIET are signals" ,
		    true ) ;
      wait ;
   end process P ;
end ARCH00541 ;
--
entity ENT00541_Test_Bench is
end ENT00541_Test_Bench ;

architecture ARCH00541_Test_Bench of ENT00541_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00541 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00541_Test_Bench ;
--
