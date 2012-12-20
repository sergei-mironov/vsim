-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00455
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.2.4 (7)
--    7.2.4 (11)
--    7.2.4 (12)
--    7.2.4 (13)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00455(ARCH00455)
--    ENT00455_Test_Bench(ARCH00455_Test_Bench)
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
entity ENT00455 is
   generic (
             i_integer_1 : integer := c_int_1 ;
             i_integer_2 : integer := c_int_2 ;
             i_intt_1 : intt := c_intt_1 ;
             i_intt_2 : intt := c_intt_2 ;
             i_intst_1 : intst := c_intst_1 ;
             i_intst_2 : intst := c_intst_2 ;
             i_time_1 : time := c_time_1 ;
             i_time_2 : time := c_time_2 ;
             i_t_phys_1 : t_phys := c_t_phys_1 ;
             i_t_phys_2 : t_phys := c_t_phys_2 ;
             i_st_phys_1 : st_phys := c_st_phys_1 ;
             i_st_phys_2 : st_phys := c_st_phys_2
             ) ;
   constant c2_time_1 : time :=
      i_time_1 / i_intst_1 + i_time_2 / i_integer_1 + 0 ns / i_integer_2 ;
   constant c2_t_phys_1 : t_phys :=
      i_t_phys_1 / i_intst_1 + c_t_phys_2 / i_integer_1 +
      i_t_phys_1 / i_intt_2 + i_t_phys_2 / c_int_2 ;
   constant c2_st_phys_1 : st_phys :=
      i_st_phys_1 / i_intst_1 + c_t_phys_2 / i_integer_1 +
      i_t_phys_1 / i_intt_2 + i_st_phys_2 / c_int_2 ;
end ENT00455 ;

architecture ARCH00455 of ENT00455 is
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
      variable v_integer_1 : integer := i_integer_1 ;
      variable v_integer_2 : integer := i_integer_2 ;
      variable v_intt_1 : intt := i_intt_1 ;
      variable v_intt_2 : intt := i_intt_2 ;
      variable v_intst_1 : intst := i_intst_1 ;
      variable v_intst_2 : intst := i_intst_2 ;
--
   begin
-- static expression
      case bool is
	 when (
      c_time_1 / c_intst_1 + c_time_2 / c_int_1 + 0 ns / c_int_2
         = 200_001 fs and --xx and

      c_t_phys_1 / c_intst_1 + c_t_phys_2 / c_int_1 +
      c_t_phys_1 / c_intt_2 + c_t_phys_2 / c_int_2
         = -66 ones  and --xx and

      c_st_phys_1 / c_intst_1 + c_t_phys_2 / c_int_1 +
      c_t_phys_1 / c_intt_2 + c_st_phys_2 / c_int_2
         = -160 ones --xx
               ) =>
	    null ;
	 when others =>
	    cons_correct := false ;
      end case ;
-- generic expression
      gen_correct := c2_time_1 = 200_001 fs and --xx and
                     c2_t_phys_1 = -66 ones and --xx and
                     c2_st_phys_1 = -160 ones ; --xx ;
-- dynamic expression
      v2_time_1 :=
       v_time_1 / i_intst_1 + v_time_2 / v_integer_1 + 0 ns / v_integer_2 ;

      v2_t_phys_1 :=
       v_t_phys_1 / v_intst_1 + i_t_phys_2 / v_integer_1 +
       v_t_phys_1 / v_intt_2 + v_t_phys_2 / c_int_2 ;

      v2_st_phys_1 :=
       v_st_phys_1 / v_intst_1 + c_t_phys_2 / v_integer_1 +
       i_t_phys_1 / v_intt_2 + v_st_phys_2 / c_int_2 ;

      dyn_correct := v2_time_1 = 200_001 fs and --xx and
                     v2_t_phys_1 = -66 ones and --xx and
                     v2_st_phys_1 = -160 ones ; --xx ;
      STANDARD_TYPES.test_report ( "ARCH00455" ,
		    "/ predefined for physical and integer types" ,
		    dyn_correct and cons_correct and gen_correct ) ;
      wait ;
   end process ;
end ARCH00455 ;

entity ENT00455_Test_Bench is
end ENT00455_Test_Bench ;

architecture ARCH00455_Test_Bench of ENT00455_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00455 ( ARCH00455 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00455_Test_Bench ;
