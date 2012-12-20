-- NEED RESULT: ARCH00540: Attributes for multi-dimensional arrays passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00540
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    14.1 (12)
--    14.1 (14)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00540)
--    ENT00540_Test_Bench(ARCH00540_Test_Bench)
--
-- REVISION HISTORY:
--
--    18-AUG-1987   - initial revision
--    18-JAN-1988   - remove function calls as prefixes of predefined attributes
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00540 of E00000 is
begin
   P :
   process
      type tt_arr2 is array (lowb to highb, false to true) of st_arr1;
      variable a : st_arr2 ;
      function f return st_arr2 is
	 variable x : st_arr2 ;
      begin
	 return x ;
      end f ;
      subtype a_range_1 is integer range a'range ;
      subtype a_range_2 is boolean range a'range(2) ;
--      subtype f_range_1 is integer range f'range ;
--      subtype f_range_2 is boolean range f'range(2) ;
      subtype s_range_1 is integer range st_arr2'range ;
      subtype s_range_2 is boolean range st_arr2'range(2) ;
      subtype t_range_1 is integer range tt_arr2'range ;
      subtype t_range_2 is boolean range tt_arr2'range(2) ;
      subtype a_reverse_range_1 is integer range a'reverse_range ;
      subtype a_reverse_range_2 is boolean range a'reverse_range(2) ;
--      subtype f_reverse_range_1 is integer range f'reverse_range ;
--      subtype f_reverse_range_2 is boolean range f'reverse_range(2) ;
      subtype s_reverse_range_1 is integer range st_arr2'reverse_range ;
      subtype s_reverse_range_2 is boolean range st_arr2'reverse_range(2) ;
      subtype t_reverse_range_1 is integer range tt_arr2'reverse_range ;
      subtype t_reverse_range_2 is boolean range tt_arr2'reverse_range(2) ;
   begin
      test_report ( "ARCH00540" ,
		    "Attributes for multi-dimensional arrays" ,
                    -- these test 14.1 (12)
		    (a'left(2) = false) and
		    (a'right(2) = true) and
		    (a'low(2) = false) and
		    (a'high(2) = true) and
		    (a_range_2'left = false) and
		    (a_reverse_range_2'left = true) and
		    (a'length(2) = 2) and
--		    (f'left(2) = false) and
--		    (f'right(2) = true) and
--		    (f'low(2) = false) and
--		    (f'high(2) = true) and
--		    (f_range_2'left = false) and
--		    (f_reverse_range_2'left = true) and
--		    (f'length(2) = 2) and
		    (tt_arr2'left(2) = false) and
		    (tt_arr2'right(2) = true) and
		    (tt_arr2'low(2) = false) and
		    (tt_arr2'high(2) = true) and
		    (t_range_2'left = false) and
		    (t_reverse_range_2'left = true) and
		    (tt_arr2'length(2) = 2) and
		    (st_arr2'left(2) = false) and
		    (st_arr2'right(2) = true) and
		    (st_arr2'low(2) = false) and
		    (st_arr2'high(2) = true) and
		    (s_range_2'left = false) and
		    (s_reverse_range_2'left = true) and
		    (st_arr2'length(2) = 2) and
                    -- these test 14.1 (14)
		    (a_range_1'left = lowb) and
		    (a_reverse_range_1'left = highb) and
		    (a'length = highb-lowb+1) and
--		    (f_range_1'left = lowb) and
--		    (f_reverse_range_1'left = highb) and
--		    (f'length = highb-lowb+1) and
		    (t_range_1'left = lowb) and
		    (t_reverse_range_1'left = highb) and
		    (tt_arr2'length = highb-lowb+1) and
		    (s_range_1'left = lowb) and
		    (s_reverse_range_1'left = highb) and
		    (st_arr2'length = highb-lowb+1)
                  ) ;
      wait ;
   end process P ;
end ARCH00540 ;
--
entity ENT00540_Test_Bench is
end ENT00540_Test_Bench ;

architecture ARCH00540_Test_Bench of ENT00540_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00540 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00540_Test_Bench ;
--
