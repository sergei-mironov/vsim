-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00444
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.2.4 (2)
--    7.2.4 (11)
--    7.2.4 (12)
--    7.2.4 (13)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00444(ARCH00444)
--    ENT00444_Test_Bench(ARCH00444_Test_Bench)
--
-- REVISION HISTORY:
--
--    29-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.ARITHMETIC.ALL ;
entity ENT00444 is
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
end ENT00444 ;

architecture ARCH00444 of ENT00444 is
   constant c2_real_1 : real :=
            10.4 * i_real_1 + i_real_1 * i_real_2 + i_real_1 * i_real_1 -
            i_real_2 * c_real_2 ;
   constant c2_t_real_1 : t_real :=
            (1.0) * 500.2 + (i_t_real_1 / 2.0) * i_t_real_2 + i_t_real_1 * 2.0 -
            i_t_real_2 * i_t_real_2 ;
   constant c2_st_real_1 : st_real :=
            (-0.0) * i_st_real_2 + i_st_real_1 * (i_t_real_1 / 10.8) +
            (i_t_real_2 * i_st_real_1) - (i_st_real_2 / 10.7) * i_t_real_2 ;
begin
   process
      variable bool : boolean := true ;
      variable cons_correct, gen_correct, dyn_correct : boolean := true ;
--
      variable v_real_1, v2_real_1 : real := i_real_1 ;
      variable v_real_2, v2_real_2 : real := i_real_2 ;
      variable v_t_real_1, v2_t_real_1 : t_real := i_t_real_1 ;
      variable v_t_real_2, v2_t_real_2 : t_real := i_t_real_2 ;
      variable v_st_real_1, v2_st_real_1 : st_real := i_st_real_1 ;
      variable v_st_real_2, v2_st_real_2 : st_real := i_st_real_2 ;
--
   begin
-- static expression
      case bool is
	 when (
            abs (
            10.4 * c_real_1 + c_real_1 * c_real_2 + c_real_1 * c_real_1 -
            c_real_2 * c_real_2
            - 89.51) < acceptable_error and
            abs (
            (1.0) * 500.2 + (c_t_real_1 / 2.0) * c_t_real_2 + c_t_real_1 * 2.0 -
            c_t_real_2 * c_t_real_2
            - 612.95) < t_acceptable_error and
            abs (
            (-0.0) * c_st_real_2 + c_st_real_1 * (c_t_real_1 / 10.8) +
            (c_t_real_2 * c_st_real_1) - (c_st_real_2 / 10.7) * c_t_real_2
            - 121.6243 ) < t_acceptable_error
               ) =>
	    null ;
	 when others =>
	    cons_correct := false ;
      end case ;
-- generic expression
      gen_correct := abs (c2_real_1 - 89.51) < acceptable_error and
                     abs (c2_t_real_1 - 612.95) < t_acceptable_error and
                     abs (c2_st_real_1 - 121.6243) < t_acceptable_error ;

-- dynamic expression
      v2_real_1 :=
            10.4 * v_real_1 + v_real_1 * v_real_2 + v_real_1 * v_real_1 -
            v_real_2 * c_real_2 ;
      v2_t_real_1 :=
            (1.0) * 500.2 + (v_t_real_1 / 2.0) * v_t_real_2 + v_t_real_1 * 2.0 -
            v_t_real_2 * v_t_real_2 ;
      v2_st_real_1 :=
            (-0.0) * v_st_real_2 + v_st_real_1 * (v_t_real_1 / 10.8) +
            (v_t_real_2 * v_st_real_1) - (v_st_real_2 / 10.7) * v_t_real_2 ;
      dyn_correct := abs (v2_real_1 - 89.51) < acceptable_error and
                     abs (v2_t_real_1 - 612.95) < t_acceptable_error and
                     abs (v2_st_real_1 - 121.6243) < t_acceptable_error ;

      locally_static_correct <= cons_correct ;
      globally_static_correct <= gen_correct ;
      dynamic_correct <= dyn_correct ;
      wait ;
   end process ;
end ARCH00444 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00444_Test_Bench is
end ENT00444_Test_Bench ;

architecture ARCH00444_Test_Bench of ENT00444_Test_Bench is
begin
   L1:
   block
      signal locally_static_correct, globally_static_correct,
             dynamic_correct : boolean := false ;

      component UUT
         port ( locally_static_correct : out boolean := false ;
	        globally_static_correct : out boolean := false ;
	        dynamic_correct : out boolean := false ) ;
      end component ;

      for CIS1 : UUT use entity WORK.ENT00444 ( ARCH00444 ) ;
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
	    test_report ( "ARCH00444" ,
		          "* predefined for real types" ,
		          true ) ;
	 end if ;
      end process ;
   end block L1 ;
end ARCH00444_Test_Bench ;
