-- NEED RESULT: ARCH00522: Optional parameters on procedure call passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00522
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    8.5 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00522)
--    ENT00522_Test_Bench(ARCH00522_Test_Bench)
--
-- REVISION HISTORY:
--
--    13-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00522 of E00000 is
begin
   P :
   process
      variable x0,x1,x2 : integer := 1 ;
      procedure proc_with_no_parms is
      begin
	 x0 := 25;
      end proc_with_no_parms ;
      procedure proc_with_2_parms (b : boolean := true;
                                   i : integer := 10) is
      begin
	 if b then
	    x1 := i ;
	 else
	    x2 := i ;
	 end if ;
      end proc_with_2_parms ;
   begin
      proc_with_no_parms ;
      proc_with_2_parms ( false, 5 ) ;
      proc_with_2_parms ;
      test_report ( "ARCH00522" ,
		    "Optional parameters on procedure call" ,
		    (x0 = 25) and
		    (x1 = 10) and
		    (x2 = 5)
                  ) ;
      wait ;
   end process P ;
end ARCH00522 ;

entity ENT00522_Test_Bench is
end ENT00522_Test_Bench ;

architecture ARCH00522_Test_Bench of ENT00522_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00522 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00522_Test_Bench ;

