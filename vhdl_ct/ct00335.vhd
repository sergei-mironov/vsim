-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00335
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.2.3 (1)
--    7.2.3 (2)
--    7.2.3 (8)
--    7.2.3 (9)
--    7.2.3 (10)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00335(ARCH00335)
--    ENT00335_Test_Bench(ARCH00335_Test_Bench)
--
-- REVISION HISTORY:
--
--    29-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.ARITHMETIC.all ;
entity ENT00335 is
   generic (
             i_real_1 : real := c_real_1 ;
             i_real_2 : real := c_real_2 ;
             i_t_real_1 : t_real := c_t_real_1 ;
             i_t_real_2 : t_real := c_t_real_2 ;
             i_st_real_1 : st_real := c_st_real_1 ;
             i_st_real_2 : st_real := c_st_real_2
             ) ;
   port ( locally_static_correct : out boolean ;
	  globally_static_correct : out boolean ;
	  dynamic_correct : out boolean ) ;
end ENT00335 ;

architecture ARCH00335 of ENT00335 is
begin
   process
      variable bool : boolean := true ;
      variable cons_correct, gen_correct, dyn_correct : boolean := true ;
--
      variable v_real_1, v2_real_1 : real := c_real_1 ;
      variable v_real_2, v2_real_2 : real := c_real_2 ;
      variable v_t_real_1, v2_t_real_1 : t_real := c_t_real_1 ;
      variable v_t_real_2, v2_t_real_2 : t_real := c_t_real_2 ;
      variable v_st_real_1, v2_st_real_1 : st_real := c_st_real_1 ;
      variable v_st_real_2, v2_st_real_2 : st_real := c_st_real_2 ;
--
      constant c2_real_1 : real :=
         (((+i_real_1) + (-i_real_2)) + ((-i_real_1) + (-i_real_2)))
         -
         (((+i_real_1) - (-c_real_2)) - ((-c_real_2) - (-i_real_1))) - 29.2 ;
      constant c2_t_real_1 : t_real :=
         (((+i_t_real_1) + (-i_t_real_2)) + ((-i_t_real_1) + (-i_t_real_2)))
         -
         (((+i_t_real_1) - (-c_t_real_2)) - ((-c_t_real_2) - (-i_t_real_1)))
         - 5.0 ;
      constant c2_st_real_1 : st_real :=
        -(((+i_st_real_1) + (-i_t_real_2)) + ((-i_st_real_1) + (-i_st_real_2)))
         -
         (((+i_st_real_1) - (-c_st_real_2)) - ((-c_t_real_2) - (-i_st_real_1)))
           - 6.8 ;
   begin
-- static expression
      case bool is
	 when (
          abs (
          (((+c_real_1) + (-c_real_2)) + ((-c_real_1) + (-c_real_2)))
          -
          (((+c_real_1) - (-c_real_2)) - ((-c_real_2) - (-c_real_1))) - 29.2
          - ans_real1) < acceptable_error and
          abs (
          (((+c_t_real_1) + (-c_t_real_2)) + ((-c_t_real_1) + (-c_t_real_2)))
          -
          (((+c_t_real_1) - (-c_t_real_2)) - ((-c_t_real_2) - (-c_t_real_1)))
          - 5.0
          - ans_real2) < t_acceptable_error and
          abs (
         -(((+c_st_real_1) + (-c_t_real_2)) + ((-c_st_real_1) + (-c_st_real_2)))
          -
          (((+c_st_real_1) - (-c_st_real_2)) - ((-c_t_real_2) - (-c_st_real_1)))
          - 6.8
          - ans_real3) < t_acceptable_error ) =>
	    null ;
	 when others =>
	    cons_correct := false ;
      end case ;
-- generic expression
      gen_correct := abs(c2_real_1 - ans_real1) < acceptable_error and
                     abs(c2_t_real_1 - ans_real2) < t_acceptable_error and
                     abs(c2_st_real_1 - ans_real3) < t_acceptable_error ;
-- dynamic expression
      v_real_1 :=
         (((+v2_real_1) + (-v2_real_2)) + ((-v2_real_1) + (-v2_real_2)))
         -
         (((+v2_real_1) - (-c_real_2)) - ((-c_real_2) - (-v2_real_1))) - 29.2 ;
      v_t_real_1 :=
         (((+v2_t_real_1) + (-v2_t_real_2)) + ((-v2_t_real_1) + (-v2_t_real_2)))
         -
         (((+v2_t_real_1) - (-i_t_real_2)) - ((-c_t_real_2) - (-v2_t_real_1)))
         - 5.0 ;
      v_st_real_1 :=
     -(((+v2_st_real_1) + (-v2_t_real_2)) + ((-v2_st_real_1) + (-v2_st_real_2)))
      -
      (((+v2_st_real_1) - (-c_st_real_2)) - ((-i_t_real_2) - (-v2_st_real_1)))
      - 6.8 ;
      dyn_correct := abs(v_real_1 - ans_real1) < acceptable_error and
                     abs(v_t_real_1 - ans_real2) < t_acceptable_error and
                     abs(v_st_real_1 - ans_real3) < t_acceptable_error ;
      locally_static_correct <= cons_correct ;
      globally_static_correct <= gen_correct ;
      dynamic_correct <= dyn_correct  ;
      wait ;
   end process ;
end ARCH00335 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00335_Test_Bench is
end ENT00335_Test_Bench ;

architecture ARCH00335_Test_Bench of ENT00335_Test_Bench is
begin
   L1:
   block
      signal locally_static_correct, globally_static_correct,
             dynamic_correct : boolean := false ;

      component UUT
         port ( locally_static_correct : out boolean ;
	        globally_static_correct : out boolean ;
	        dynamic_correct : out boolean ) ;
      end component ;

      for CIS1 : UUT use entity WORK.ENT00335 ( ARCH00335 ) ;
   begin
      CIS1 : UUT
	    port map ( locally_static_correct,
                       globally_static_correct,
                       dynamic_correct ) ;
      process ( locally_static_correct, globally_static_correct,
                dynamic_correct )
      begin
         if locally_static_correct and globally_static_correct and
            dynamic_correct then
	    test_report ( "ARCH00335" ,
		          "+ and - unary and binary operators are correctly"
			  & " predefined for real types" ,
		          true ) ;
	 end if ;
      end process ;
   end block L1 ;
end ARCH00335_Test_Bench ;
