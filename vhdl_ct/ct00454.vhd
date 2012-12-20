-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00454
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.2.4 (6)
--    7.2.4 (11)
--    7.2.4 (12)
--    7.2.4 (13)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00454(ARCH00454)
--    ENT00454_Test_Bench(ARCH00454_Test_Bench)
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
entity ENT00454 is
   generic (
             i_real_1 : real := c_real_1 ;
             i_real_2 : real := c_real_2 ;
             i_realt_1 : realt := c_realt_1 ;
             i_realt_2 : realt := c_realt_2 ;
             i_realst_1 : realst := c_realst_1 ;
             i_realst_2 : realst := c_realst_2 ;
             i_time_1 : time := c_time_1 ;
             i_time_2 : time := c_time_2 ;
             i_t_phys_1 : t_phys := c_t_phys_1 ;
             i_t_phys_2 : t_phys := c_t_phys_2 ;
             i_st_phys_1 : st_phys := c_st_phys_1 ;
             i_st_phys_2 : st_phys := c_st_phys_2
             ) ;
   constant c2_time_1 : time :=
      i_time_1 * i_realst_1 + i_time_2 * i_real_1 -
      i_realst_1 * i_time_1 - i_real_1 * i_time_2 ;

   constant c2_t_phys_1 : t_phys :=
      i_t_phys_1 * i_realst_1 +
      i_t_phys_1 * i_realt_2  + i_t_phys_2 * c_real_2 +
      i_realt_1  * c_t_phys_1 + i_realst_2 * i_t_phys_1 +
      i_realst_2 * i_t_phys_2 + i_real_2   * i_t_phys_2 ;

   constant c2_st_phys_1 : st_phys :=
   -( i_st_phys_1 * i_realst_1  +
      i_t_phys_1  * i_realt_2   + i_st_phys_2 * c_real_2 +
      i_realt_1   * c_t_phys_1  + i_realst_2  * i_t_phys_2 +
      c_real_1    * i_st_phys_2 + i_real_2    * i_t_phys_2) ;

end ENT00454 ;

architecture ARCH00454 of ENT00454 is
begin
   process
      variable bool : boolean := true ;
      variable cons_correct, gen_correct, dyn_correct : boolean := true ;
--
      variable v_time_1, v2_time_1 : time := i_time_1 ;
      variable v_time_2, v2_time_2 : time := i_time_2 ;
      variable v_t_phys_1, v2_t_phys_1 : t_phys := i_t_phys_1 ;
      variable v_t_phys_2, v2_t_phys_2 : t_phys := i_t_phys_2 ;
      variable v_st_phys_1, v2_st_phys_1 : st_phys := i_st_phys_1 ;
      variable v_st_phys_2, v2_st_phys_2 : st_phys := i_st_phys_2 ;
      variable v_real_1 : real := i_real_1 ;
      variable v_real_2 : real := i_real_2 ;
      variable v_realt_1 : realt := i_realt_1 ;
      variable v_realt_2 : realt := i_realt_2 ;
      variable v_realst_1 : realst := i_realst_1 ;
      variable v_realst_2 : realst := i_realst_2 ;
--
   begin
-- static expression
      case bool is
	 when (
      c_time_1 * c_realst_1 + c_time_2 * c_real_1 -
      c_realst_1 * c_time_1 - c_real_1 * c_time_2 = 0 ns  and --xx and

      c_t_phys_1 * c_realst_1 +
      c_t_phys_1 * c_realt_2 + c_t_phys_2 * c_real_2 +
      c_realt_1 * c_t_phys_1 + c_realst_2 * c_t_phys_1 +
      c_realst_2 * c_t_phys_2 + c_real_2 * c_t_phys_2 = 52394 ones  and --xx and

      -( c_st_phys_1 * c_realst_1 +
      c_t_phys_1 * c_realt_2 + c_st_phys_2 * c_real_2 +
      c_realt_1 * c_t_phys_1 + c_realst_2 * c_t_phys_2 +
      c_real_1 * c_st_phys_2 + c_real_2 * c_t_phys_2 ) =  -249374 ones --xx
               ) =>
	    null ;
	 when others =>
	    cons_correct := false ;
      end case ;
-- generic expression
      gen_correct := c2_time_1 = 0 ns and --xx and
                     c2_t_phys_1 = 52394 ones and --xx and
                     c2_st_phys_1 = -249374 ones ; --xx ;

-- dynamic expression
      v2_time_1 :=
       v_time_1 * i_realst_1 + v_time_2 * i_real_1 -
       v_realst_1 * c_time_1 - v_real_1 * i_time_2 ;

      v2_t_phys_1 :=
       v_t_phys_1 * v_realst_1 +
       v_t_phys_1 * v_realt_2 + v_t_phys_2 * c_real_2 +
       v_realt_1 * c_t_phys_1 + v_realst_2 * v_t_phys_1 +
       i_realst_2 * v_t_phys_2 + v_real_2 * v_t_phys_2 ;

      v2_st_phys_1 :=
       -( v_st_phys_1 * v_realst_1 +
          v_t_phys_1 * v_realt_2 + v_st_phys_2 * c_real_2 +
          v_realt_1 * c_t_phys_1 + v_realst_2 * v_t_phys_2 +
          i_real_1 * v_st_phys_2 + v_real_2 * v_t_phys_2) ;
      dyn_correct := v2_time_1 = 0 ns and --xx and
                     v2_t_phys_1 = 52394 ones and --xx and
                     v2_st_phys_1 = -249374 ones ; --xx ;

      STANDARD_TYPES.test_report ( "ARCH00454" ,
		    "* predefined for physical and real types" ,
		    dyn_correct and cons_correct and gen_correct ) ;
      wait ;
   end process ;
end ARCH00454 ;

entity ENT00454_Test_Bench is
end ENT00454_Test_Bench ;

architecture ARCH00454_Test_Bench of ENT00454_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00454 ( ARCH00454 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00454_Test_Bench ;
