-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------


-- 
-- TEST NAME: 
-- 
--    CT00461
-- 
-- AUTHOR: 
-- 
--    A. Wilmot 
-- 
-- TEST OBJECTIVES: 
-- 
--    7.2.5 (2)
--    7.2.5 (5)
--    7.2.5 (6)
--    7.2.5 (7)
-- 
-- DESIGN UNIT ORDERING: 
--
--    PKG00461
--    ENT00461(ARCH00461)
--    ENT00461_Test_Bench(ARCH00461_Test_Bench)
--
-- REVISION HISTORY: 
-- 
--    29-JUL-1987   - initial revision
-- 
-- NOTES:
-- 
--    self-checking
-- 
package PKG00461 is
-- integer definitions
   subtype st_integer is integer range -2 ** 15 to 2 ** 20 ; 
   constant c_integer_1 : integer := 10 ; 
   constant c_integer_2 : integer := -7 ; 
   constant c_st_integer_1 : st_integer := 5 ; 
   constant c_st_integer_2 : st_integer := -4 ; 
-- integer
   type t_real is range -2.0E20 to 2.0E20 ;
   subtype st_real is t_real range -2.0E15 to 2.0E20 ; 
   constant c_real_1 : real := 10.5 ; 
   constant c_real_2 : real := -7.3 ; 
   constant c_t_real_1 : t_real := 5.0 ; 
   constant c_t_real_2 : t_real := -3.5 ; 
   constant c_st_real_1 : st_real := 5.9 ; 
   constant c_st_real_2 : st_real := -4.1 ; 
   constant acceptable_error : real := 0.001 ; 
   constant t_acceptable_error : t_real := 0.001 ; 
end PKG00461 ;

use WORK.STANDARD_TYPES ;
use WORK.PKG00461.ALL ;
entity ENT00461 is
   generic ( 
             i_integer_1 : integer := c_integer_1 ;
             i_integer_2 : integer := c_integer_2 ;
             i_st_integer_1 : st_integer := c_st_integer_1 ;
             i_st_integer_2 : st_integer := c_st_integer_2 ;
             i_real_1 : real := c_real_1 ;
             i_real_2 : real := c_real_2 ;
             i_t_real_1 : t_real := c_t_real_1 ;
             i_t_real_2 : t_real := c_t_real_2 ;
             i_st_real_1 : st_real := c_st_real_1 ;
             i_st_real_2 : st_real := c_st_real_2
             ) ;
   constant c2_real_1 : real :=
      i_real_1 ** i_st_integer_1 ;
   constant c2_real_2 : real :=
      i_real_2 ** i_integer_1 ;
   constant c2_real_3 : real :=
      i_real_1 ** i_integer_2 ;
   constant c2_real_4 : real :=
      i_real_2 ** i_st_integer_2 ;
   constant c2_t_real_1 : t_real :=
      i_t_real_1 ** i_st_integer_1 ;
   constant c2_t_real_2 : t_real :=
      c_t_real_2 ** i_integer_1 ;
   constant c2_t_real_3 : t_real :=
      i_t_real_1 ** i_integer_2 ;
   constant c2_t_real_4 : t_real :=
      i_t_real_2 ** c_integer_2 ;
   constant c2_st_real_1 : st_real :=
      i_st_real_1 ** i_st_integer_1 ;
   constant c2_st_real_2 : st_real :=
      c_t_real_2 ** i_integer_1 ;
   constant c2_st_real_3 : st_real :=
      i_st_real_1 ** i_integer_2 ;
   constant c2_st_real_4 : st_real :=
      i_st_real_2 ** c_st_integer_2 ;
end ENT00461 ;

architecture ARCH00461 of ENT00461 is
begin
   process
      variable bool : boolean := true ;
      variable cons_correct, gen_correct, dyn_correct : boolean := true ;
--
      variable v_real_1, v2_real_1 : real := i_real_1 ;
      variable v_real_2, v2_real_2 : real := i_real_2 ;
      variable v2_real_3, v2_real_4 : real ;
      variable v_t_real_1, v2_t_real_1 : t_real := i_t_real_1 ;
      variable v_t_real_2, v2_t_real_2 : t_real := i_t_real_2 ;
      variable v2_t_real_3, v2_t_real_4 : t_real ;
      variable v_st_real_1, v2_st_real_1 : st_real := i_st_real_1 ;
      variable v_st_real_2, v2_st_real_2 : st_real := i_st_real_2 ;
      variable v2_st_real_3, v2_st_real_4 : st_real ;
      variable v_integer_1 : integer := i_integer_1 ;
      variable v_integer_2 : integer := i_integer_2 ;
      variable v_st_integer_1 : st_integer := i_st_integer_1 ;
      variable v_st_integer_2 : st_integer := i_st_integer_2 ;
--
   begin
-- static expression
      case bool is
	 when (


	      abs ((c_real_1 ** c_st_integer_1 - 127628.1562) 
	      / (c_real_1 ** c_st_integer_1)) < acceptable_error and


	      abs ((c_real_2 ** c_integer_1 - 429762582.9) 
	      / (c_real_2 ** c_integer_1)) < acceptable_error and


	      abs ((c_real_1 ** c_integer_2 - 7.107E-8) 
	      / (c_real_1 ** c_integer_2)) < acceptable_error and


	      abs ((c_real_2 ** c_st_integer_2 - 3.52134E-4) 
	      / (c_real_2 ** c_st_integer_2)) < acceptable_error and


	      abs ((c_t_real_1 ** c_st_integer_1 - 3125.0) 
	      / (c_t_real_1 ** c_st_integer_1)) < t_acceptable_error and


	      abs ((c_t_real_2 ** c_integer_1 - 275854.74) 
	      / (c_t_real_2 ** c_integer_1)) < t_acceptable_error and


	      abs ((c_t_real_1 ** c_integer_2 - 1.28E-5) 
	      / (c_t_real_1 ** c_integer_2)) < t_acceptable_error and


	      abs ((c_t_real_2 ** c_integer_2 - (-1.554E-4)) 
	      / (c_t_real_2 ** c_integer_2)) < t_acceptable_error and


	      abs ((c_st_real_1 ** c_st_integer_1 - 7.14924E3) 
	      / (c_st_real_1 ** c_st_integer_1)) < t_acceptable_error and


	      abs ((c_t_real_2 ** c_integer_1 - 2.7585473E5) 
	      / (c_t_real_2 ** c_integer_1)) < t_acceptable_error and


	      abs ((c_st_real_1 ** c_integer_2 - 4.0182E-6) 
	      / (c_st_real_1 ** c_integer_2)) < t_acceptable_error and


	      abs ((c_st_real_2 ** c_st_integer_2 - 3.539E-3) 
	      / (c_st_real_2 ** c_st_integer_2)) < t_acceptable_error
               ) =>
	    null ;
	 when others => 
	    cons_correct := false ;
      end case ;
-- generic expression
      gen_correct := 
         abs ((c2_real_1 - 127628.1562) / c2_real_1) < acceptable_error and
         abs ((c2_real_2 - 429762582.9) / c2_real_2) < acceptable_error and
         abs ((c2_real_3 - 7.107E-8) / c2_real_3) < acceptable_error and
         abs ((c2_real_4 - 3.52134E-4) / c2_real_4) < acceptable_error and
         abs ((c2_t_real_1 - 3125.0) / c2_t_real_1) < t_acceptable_error and
         abs ((c2_t_real_2 - 275854.74) / c2_t_real_1) < t_acceptable_error and
         abs ((c2_t_real_3 - 1.28E-5) / c2_t_real_1) < t_acceptable_error and
         abs ((c2_t_real_4 - (-1.554E-4)) / c2_t_real_1) < t_acceptable_error and
         abs ((c2_st_real_1 - 7.14924E3) / c2_st_real_1) < t_acceptable_error and
         abs ((c2_st_real_2 - 2.7585473E5) / c2_st_real_1) < t_acceptable_error and
         abs ((c2_st_real_3 - 4.0182E-6) / c2_st_real_1) < t_acceptable_error and
         abs ((c2_st_real_4 - 3.539E-3) / c2_st_real_1) < t_acceptable_error ;
-- dynamic expression
      v2_real_1 :=
       i_real_1 ** i_st_integer_1 ;
      v2_real_2 :=
       i_real_2 ** i_integer_1 ;
      v2_real_3 :=
       i_real_1 ** i_integer_2 ;
      v2_real_4 :=
       i_real_2 ** i_st_integer_2 ;
      v2_t_real_1 :=
       i_t_real_1 ** i_st_integer_1 ;
      v2_t_real_2 :=
       c_t_real_2 ** i_integer_1 ;
      v2_t_real_3 :=
       i_t_real_1 ** i_integer_2 ;
      v2_t_real_4 :=
       i_t_real_2 ** c_integer_2 ;
      v2_st_real_1 :=
       i_st_real_1 ** i_st_integer_1 ;
      v2_st_real_2 :=
       c_t_real_2 ** i_integer_1 ;
      v2_st_real_3 :=
       i_st_real_1 ** i_integer_2 ;
      v2_st_real_4 :=
       i_st_real_2 ** c_st_integer_2 ;
      dyn_correct := 
         abs ((v2_real_1 - 127628.1562) / v2_real_1) < acceptable_error and
         abs ((v2_real_2 - 429762582.9) / v2_real_2) < acceptable_error and
         abs ((v2_real_3 - 7.107E-8) / v2_real_3) < acceptable_error and
         abs ((v2_real_4 - 3.52134E-4) / v2_real_4) < acceptable_error and
         abs ((v2_t_real_1 - 3125.0) / v2_t_real_1) < t_acceptable_error and
         abs ((v2_t_real_2 - 275854.74) / v2_t_real_1) < t_acceptable_error and
         abs ((v2_t_real_3 - 1.28E-5) / v2_t_real_1) < t_acceptable_error and
         abs ((v2_t_real_4 - (-1.554E-4)) / v2_t_real_1) < t_acceptable_error and
         abs ((v2_st_real_1 - 7.14924E3) / v2_st_real_1) < t_acceptable_error and
         abs ((v2_st_real_2 - 2.7585473E5) / v2_st_real_1) < t_acceptable_error and
         abs ((v2_st_real_3 - 4.0182E-6) / v2_st_real_1) < t_acceptable_error and
         abs ((v2_st_real_4 - 3.539E-3) / v2_st_real_1) < t_acceptable_error ;
      STANDARD_TYPES.test_report ( "ARCH00461" ,
		    "** predefined for real base and integer exponent" ,
		    dyn_correct and cons_correct and gen_correct ) ;
      wait ;
   end process ;
end ARCH00461 ;

entity ENT00461_Test_Bench is
end ENT00461_Test_Bench ;

architecture ARCH00461_Test_Bench of ENT00461_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
 
      for CIS1 : UUT use entity WORK.ENT00461 ( ARCH00461 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00461_Test_Bench ;
