-- NEED RESULT: ARCH00260: Verify that resolution functions can be recursive passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00260
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    2.4 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00260)
--    ENT00260_Test_Bench(ARCH00260_Test_Bench)
--
-- REVISION HISTORY:
--
--    16-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00260 of E00000 is
   function resolution ( i_a : integer_vector ) return integer is
   -- this "resolution" function resolves an integer array by
   -- adding its components (recursively)
      variable l : integer ;
      variable r : integer ;
   begin
      l := i_a'left ;
      r := i_a'right ;
      if l = r then
	 return i_a(r);
      else
	 return resolution(i_a(l to r-1)) + i_a(r);
      end if ;
   end resolution ;
begin
   P :
   process
      variable A : integer_vector ( 1 to 3 ) ;
   begin
      A (1) := 7 ;
      A (2) := 2 ;
      A (3) := 8 ;
      test_report ( "ARCH00260" ,
		    "Verify that resolution functions can be recursive" ,
		    resolution(A) = 7+2+8 ) ;
      wait ;
   end process P ;
end ARCH00260 ;

entity ENT00260_Test_Bench is
end ENT00260_Test_Bench ;

architecture ARCH00260_Test_Bench of ENT00260_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00260 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00260_Test_Bench ;
