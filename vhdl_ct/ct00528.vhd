-- NEED RESULT: ARCH00528: Signal parameters passed
-- NEED RESULT: ARCH00528: Signal parameters passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00528
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    2.1.1.2 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00528)
--    ENT00528_Test_Bench(ARCH00528_Test_Bench)
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
use WORK.STANDARD_TYPES.all ;
architecture ARCH00528 of E00000 is
   signal t,z : integer := 10 ;
   signal P1_ran : boolean := false ;
begin
   P1 :
   process
      procedure proc (signal q : inout integer) is
      begin
	 q <= q + 1 ;      -- read & updata the signal parameter
	 wait ;            -- but do not complete
      end proc ;
   begin
      P1_ran <= true ;     -- notify P2 that this process ran
      proc (t) ;           -- & call proc to update signal t.
   end process P1 ;
   P2 :
   process ( t, z )
   begin
      if not P1_ran then
	 z <= z + 1 after 1 ns ;   -- if P1 hasn't run yet, wait for it
      else
                                   -- if here, P1 has run and signal t
                                   -- must have a value of 11
	 test_report ( "ARCH00528" ,
		       "Signal parameters" ,
		       t = 11 ) ;
      end if ;
   end process P2 ;
end ARCH00528 ;
--
entity ENT00528_Test_Bench is
end ENT00528_Test_Bench ;

architecture ARCH00528_Test_Bench of ENT00528_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00528 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00528_Test_Bench ;
--
