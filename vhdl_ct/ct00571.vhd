-- NEED RESULT: ARCH00571: Package STANDARD tests passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00571
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    14.2 (1)
--    14.2 (2)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00571)
--    ENT00571_Test_Bench(ARCH00571_Test_Bench)
--
-- REVISION HISTORY:
--
--    19-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00571 of E00000 is
   constant t : time := 3 ns ;
   signal z : integer := 0 ;
begin
   P :
   process ( z )
      variable standard : integer := 2 ;   -- this tests 14.2 (2)
      variable n : integer := 0 ;
   begin
      if n = 0 then
	 z <= 10 after t ;
	 n := 1 ;
      else
	 test_report ( "ARCH00571" ,
		       "Package STANDARD tests" ,
		       (standard = 2) and
                       (NOW = t)                 -- this tests 14.2 (1)
                     ) ;
      end if ;
   end process P ;
end ARCH00571 ;
--
entity ENT00571_Test_Bench is
end ENT00571_Test_Bench ;

architecture ARCH00571_Test_Bench of ENT00571_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00571 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00571_Test_Bench ;
--
