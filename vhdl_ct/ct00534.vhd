-- NEED RESULT: ARCH00534: LEFT, RIGHT, HIGH, LOW attributes passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00534
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    14.1 (4)
--    14.1 (5)
--    14.1 (6)
--    14.1 (13)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00534)
--    ENT00534_Test_Bench(ARCH00534_Test_Bench)
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
architecture ARCH00534 of E00000 is
begin
   P :
   process
   begin
      test_report ( "ARCH00534" ,
		    "LEFT, RIGHT, HIGH, LOW attributes" ,
		    (t_enum1'left  = en1) and
		    (t_enum1'right = en4) and
		    (t_enum1'low   = en1) and
		    (t_enum1'high  = en4) and
		    (st_enum1'left  = en4) and
		    (st_enum1'right = en1) and
		    (st_enum1'low   = en1) and
		    (st_enum1'high  = en4) and
		    (t_int1'left  = 0) and
		    (t_int1'right = 100) and
		    (t_int1'low   = 0) and
		    (t_int1'high  = 100) and
		    (st_int1'left  = 8) and
		    (st_int1'right = 60) and
		    (st_int1'low   = 8) and
		    (st_int1'high  = 60) and
		    (t_phys1'left  = t_phys1'val(lowb_p)) and
		    (t_phys1'right = t_phys1'val(highb_p)) and
		    (t_phys1'low   = t_phys1'val(lowb_p)) and
		    (t_phys1'high  = t_phys1'val(highb_p)) and
		    (st_phys1'left  = phys1_2) and
		    (st_phys1'right = phys1_4) and
		    (st_phys1'low   = phys1_2) and
		    (st_phys1'high  = phys1_4) and
		    (t_real1'left  = 0.0) and
		    (t_real1'right = 1000.0) and
		    (t_real1'low   = 0.0) and
		    (t_real1'high  = 1000.0) and
		    (st_real1'left  = 8.0) and
		    (st_real1'right = 80.0) and
		    (st_real1'low   = 8.0) and
		    (st_real1'high  = 80.0) and
		    (st_arr2'left(1)  = lowb) and
		    (st_arr2'right(1) = highb) and
		    (st_arr2'low(1)   = lowb) and
		    (st_arr2'high(1)  = highb) and
		    (st_arr2'left(2)  = false) and
		    (st_arr2'right(2) = true) and
		    (st_arr2'low(2)   = false) and
		    (st_arr2'high(2)  = true) and
		    (st_arr2'left  = lowb) and      -- these test 14.1 (13)
		    (st_arr2'right = highb) and
		    (st_arr2'low   = lowb) and
		    (st_arr2'high  = highb)
                  ) ;
      wait ;
   end process P ;
end ARCH00534 ;
--
entity ENT00534_Test_Bench is
end ENT00534_Test_Bench ;

architecture ARCH00534_Test_Bench of ENT00534_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00534 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00534_Test_Bench ;
--
