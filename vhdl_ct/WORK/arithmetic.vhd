-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
package ARITHMETIC is
-- integer definitions
   type t_int is range -2 ** 20 to 2 ** 20 ;
   subtype st_int is t_int range 2 ** 15 downto -2 ** 20 ;
   subtype intt is integer range -2 ** 20 to 2 ** 20 ;
   subtype intst is integer range 2 ** 15 downto -2 ** 20 ;
   constant c_int_1 : integer := 10 ;
   constant c_int_2 : integer := -7 ;
   constant c_t_int_1 : t_int := 500 ;
   constant c_intt_1 : intt := 500 ;
   constant c_t_int_2 : t_int := -3 ;
   constant c_intt_2 : intt := -3 ;
   constant c_st_int_1 : st_int := 5 ;
   constant c_intst_1 : intst := 5 ;
   constant c_st_int_2 : st_int := -400 ;
   constant c_intst_2 : intst := -400 ;
   constant ans_int1 : integer := 0 ;
   constant ans_int2 : t_int := 7 ;
   constant ans_int3 : st_int := -5 ;
-- physical type definitions
   type t_phys is range -2 ** 20 to 2 ** 20
		   units
		      ones ;
		      tens = 10 ones ;
		      hundreds = 10 tens ;
		      five_hundreds = 50 tens ;
		   end units ;
   subtype st_phys is t_phys range 2 ** 15 * ones downto -2 ** 20 * ones ;
   constant c_time_1 : time := 1 ns ;
   constant c_time_2 : time := 10 fs ;
   constant c_t_phys_1 : t_phys := 5 hundreds ;
   constant c_t_phys_2 : t_phys := (-3) * ones ;
   constant c_st_phys_1 : st_phys := 5 ones ;
   constant c_st_phys_2 : st_phys := (-4) * 10 ones ;
   constant ans_phys1 : time := 999990 fs ;
   constant ans_phys2 : t_phys := 7 ones ;
   constant ans_phys3 : t_phys := -5 * 1 ones ;
-- real
   type t_real is range -2.0E20 to 2.0E20 ;
   subtype st_real is t_real range 2.0E15 downto -2.0E20 ;
   subtype realt is real range -2.0E20 to 2.0E20 ;
   subtype realst is real range 2.0E15 downto -2.0E20 ;
   constant c_real_1 : real := 10.5 ;
   constant c_real_2 : real := -7.3 ;
   constant c_t_real_1 : t_real := 500.0 ;
   constant c_realt_1 : realt := 500.0 ;
   constant c_t_real_2 : t_real := -3.5 ;
   constant c_realt_2 : realt := -3.5 ;
   constant c_st_real_1 : st_real := 5.9 ;
   constant c_realst_1 : realst := 5.9 ;
   constant c_st_real_2 : st_real := -400.1 ;
   constant c_realst_2 : realst := -400.1 ;
   constant ans_real1 : real := 0.0 ;
   constant ans_real2 : t_real := 9.0 ;
   constant ans_real3 : t_real := -6.8 ;
   constant acceptable_error : real := 0.001 ;
   constant t_acceptable_error : t_real := 0.001 ;
end ARITHMETIC ;
