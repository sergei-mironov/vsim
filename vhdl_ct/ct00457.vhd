-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00457
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.2.4 (9)
--    7.2.4 (10)
--    7.2.4 (11)
--    7.2.4 (12)
--    7.2.4 (13)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00457(ARCH00457)
--    ENT00457_Test_Bench(ARCH00457_Test_Bench)
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
entity ENT00457 is
   generic (
             i_phys_1 : time := c_time_1 ;
             i_phys_2 : time := c_time_2 ;
             i_t_phys_1 : t_phys := c_t_phys_1 ;
             i_t_phys_2 : t_phys := c_t_phys_2 ;
             i_st_phys_1 : st_phys := c_st_phys_1 ;
             i_st_phys_2 : st_phys := c_st_phys_2
             ) ;
   port ( locally_static_correct : out boolean ;
	  globally_static_correct : out boolean ;
	  dynamic_correct : out boolean ) ;
end ENT00457 ;

architecture ARCH00457 of ENT00457 is
   constant c2_phys_1 : integer :=
            (i_phys_1 + 5 ns) / i_phys_1 + i_phys_1 / i_phys_2 +
            i_phys_2 / i_phys_1 + (4 * i_phys_2) / i_phys_2 ;

   constant c2_t_phys_1 : integer :=
            (i_t_phys_1 + i_t_phys_1) / i_t_phys_1 + i_t_phys_1 / i_t_phys_2 +
            i_t_phys_2 / i_t_phys_1 + (-6 * i_t_phys_2) / i_t_phys_2 ;

   constant c2_st_phys_1 : integer :=
            (i_t_phys_1) / i_st_phys_1 + i_st_phys_1 / i_t_phys_2 +
            i_t_phys_2 / i_t_phys_1 + (5 * i_st_phys_2) / i_t_phys_2 ;

begin
   process
      variable bool : boolean := true ;
      variable cons_correct, gen_correct, dyn_correct : boolean := true ;
--
      variable v_phys_1 : time := i_phys_1 ;
      variable v2_phys_1 : integer ;
      variable v_phys_2 : time := i_phys_2 ;
      variable v_t_phys_1 : t_phys := i_t_phys_1 ;
      variable v2_t_phys_1 : integer ;
      variable v_t_phys_2 : t_phys := i_t_phys_2 ;
      variable v_st_phys_1 : st_phys := i_st_phys_1 ;
      variable v2_st_phys_1 : integer ;
      variable v_st_phys_2 : st_phys := i_st_phys_2 ;
--
   begin
-- static expression
      case bool is
	 when (
            (c_time_1 + 5 ns) / c_time_1 + c_time_1 / c_time_2 +
            c_time_2 / c_time_1 + (4 * c_time_2) / c_time_2
            = 100010 and --xx and

            (c_t_phys_1 + c_t_phys_1) / c_t_phys_1 + c_t_phys_1 / c_t_phys_2 +
            c_t_phys_2 / c_t_phys_1 + (-6 * c_t_phys_2) / c_t_phys_2
            = -170 and --xx and

            (c_t_phys_1) / c_st_phys_1 + c_st_phys_1 / c_t_phys_2 +
            c_t_phys_2 / c_t_phys_1 + (5 * c_st_phys_2) / c_t_phys_2
            = 165 --xx

               ) =>
	    null ;
	 when others =>
	    cons_correct := false ;
      end case ;
-- generic expression
      gen_correct := c2_phys_1 = 100010 and --xx and
                     c2_t_phys_1 = -170 and --xx and
                     c2_st_phys_1 = 165 ; --xx ;
-- dynamic expression
      v2_phys_1 :=
            (v_phys_1 + 5 ns) / v_phys_1 + v_phys_1 / v_phys_2 +
            v_phys_2 / v_phys_1 + (4 * v_phys_2) / c_time_2 ;
      v2_t_phys_1 :=
            (v_t_phys_1 + v_t_phys_1) / v_t_phys_1 + i_t_phys_1 / v_t_phys_2 +
            v_t_phys_2 / i_t_phys_1 + (-6 * v_t_phys_2) / v_t_phys_2 ;
      v2_st_phys_1 :=
            (i_t_phys_1) / v_st_phys_1 + v_st_phys_1 / i_t_phys_2 +
            v_t_phys_2 / v_t_phys_1 + (5 * v_st_phys_2) / v_t_phys_2 ;
      dyn_correct := v2_phys_1 = 100010 and --xx and
                     v2_t_phys_1 = -170 and --xx and
                     v2_st_phys_1 = 165 ; --xx ;
      locally_static_correct <= cons_correct ;
      globally_static_correct <= gen_correct ;
      dynamic_correct <= dyn_correct ;
      wait ;
   end process ;
end ARCH00457 ;

use WORK.STANDARD_TYPES.ALL ;
entity ENT00457_Test_Bench is
end ENT00457_Test_Bench ;

architecture ARCH00457_Test_Bench of ENT00457_Test_Bench is
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

      for CIS1 : UUT use entity WORK.ENT00457 ( ARCH00457 ) ;
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
	    test_report ( "ARCH00457" ,
		          "* predefined for phycial types" ,
		          true ) ;
	 end if ;
      end process ;
   end block L1 ;
end ARCH00457_Test_Bench ;
