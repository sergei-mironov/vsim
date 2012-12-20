-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00464
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.2.5 (1)
--    7.2.4 (5)
--    7.2.4 (6)
--    7.2.4 (7)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00464(ARCH00464)
--    ENT00464_Test_Bench(ARCH00464_Test_Bench)
--
-- REVISION HISTORY:
--
--    29-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES ;
use WORK.ARITHMETIC.ALL ;
entity ENT00464 is
   generic (
             i_real_1 : real := c_real_1 ;
             i_real_2 : real := c_real_2 ;
             i_t_real_1 : t_real := c_t_real_1 ;
             i_t_real_2 : t_real := c_t_real_2 ;
             i_st_real_1 : st_real := c_st_real_1 ;
             i_st_real_2 : st_real := c_st_real_2
             ) ;
end ENT00464 ;

architecture ARCH00464 of ENT00464 is
   constant c2_real_1 : real :=
     abs i_real_1 + abs i_real_2 ;
   constant c2_t_real_1 : t_real :=
     abs i_t_real_1 + abs i_t_real_2 ;
   constant c2_st_real_1 : st_real :=
     abs i_st_real_1 + abs i_st_real_2 + abs i_t_real_2 ;
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
     abs (abs c_real_1 + abs c_real_2 - 17.8) < acceptable_error  and

     abs (abs c_t_real_1 + abs c_t_real_2 - 503.5) < t_acceptable_error and

     abs (abs c_st_real_1 + abs c_st_real_2 + abs c_t_real_2 - 409.5) <
       t_acceptable_error
               ) =>
	    null ;
	 when others =>
	    cons_correct := false ;
      end case ;
-- generic expression
      gen_correct := abs (c2_real_1 - 17.8) < acceptable_error and
                     abs (c2_t_real_1 - 503.5) < t_acceptable_error and
                     abs (c2_st_real_1 - 409.5) < t_acceptable_error ;
-- dynamic expression
       v2_real_1 :=
         abs v_real_1 + abs v_real_2 ;
       v2_t_real_1 :=
         abs v_t_real_1 + abs v_t_real_2 ;
       v2_st_real_1 :=
         abs v_st_real_1 + abs v_st_real_2 + abs v_t_real_2 ;
      dyn_correct := abs (v2_real_1 - 17.8) < acceptable_error and
                     abs (v2_t_real_1 - 503.5) < t_acceptable_error and
                     abs (v2_st_real_1 - 409.5) < t_acceptable_error ;
      STANDARD_TYPES.test_report ( "ARCH00464" ,
		    "abs predefined for real types" ,
		    cons_correct and gen_correct and dyn_correct ) ;
      wait ;
   end process ;
end ARCH00464 ;

entity ENT00464_Test_Bench is
end ENT00464_Test_Bench ;

architecture ARCH00464_Test_Bench of ENT00464_Test_Bench is
begin
   L1:
   block

      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00464 ( ARCH00464 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00464_Test_Bench ;
