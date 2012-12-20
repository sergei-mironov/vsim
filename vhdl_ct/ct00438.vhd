-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00438
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.2.4 (1)
--    7.2.4 (4)
--    7.2.4 (11)
--    7.2.4 (12)
--    7.2.4 (13)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00438(ARCH00438)
--    ENT00438_Test_Bench(ARCH00438_Test_Bench)
--
-- REVISION HISTORY:
--
--    29-JUL-1987   - initial revision
--     5-MAY-1988   - CSW
--     6-JUN-1988   - JTH
--
-- NOTES:
--
--    self-checking
--
use WORK.ARITHMETIC.ALL ;
entity ENT00438 is
   generic (
             i_int_1 : integer := c_int_1 ;
             i_int_2 : integer := c_int_2 ;
             i_t_int_1 : t_int := c_t_int_1 ;
             i_t_int_2 : t_int := c_t_int_2 ;
             i_st_int_1 : st_int := c_st_int_1 ;
             i_st_int_2 : st_int := c_st_int_2
             ) ;
   port ( locally_static_correct : out boolean ;
	  globally_static_correct : out boolean ;
	  dynamic_correct : out boolean ) ;
end ENT00438 ;

architecture ARCH00438 of ENT00438 is
   constant c2_int_1 : integer :=
            (-10) / i_int_1 + i_int_1 / i_int_2 + i_int_1 / i_int_1 -
            i_int_2 / c_int_2 ;
   constant c2_t_int_1 : t_int :=
            (1) / i_t_int_1 + (i_t_int_1) / i_t_int_2 + (-i_t_int_1) / 2 -
            c_t_int_2 / i_t_int_2 ;
   constant c2_st_int_1 : st_int :=
            (-0) / i_st_int_2 + i_t_int_1 / (i_st_int_1) +
            (i_st_int_1 / i_t_int_2) - (c_st_int_2) / i_t_int_2 ;
begin
   process
      variable bool : boolean := true ;
      variable cons_correct, gen_correct, dyn_correct : boolean := true ;
--
      variable v_int_1, v2_int_1 : integer := i_int_1 ;
      variable v_int_2, v2_int_2 : integer := i_int_2 ;
      variable v_t_int_1, v2_t_int_1 : t_int := i_t_int_1 ;
      variable v_t_int_2, v2_t_int_2 : t_int := i_t_int_2 ;
      variable v_st_int_1, v2_st_int_1 : st_int := i_st_int_1 ;
      variable v_st_int_2, v2_st_int_2 : st_int := i_st_int_2 ;
--
   begin
-- static expression
      case bool is
	 when (
            (-10) / c_int_1 + c_int_1 / c_int_2 + c_int_1 / c_int_1 -
            c_int_2 / c_int_2 = -2  and

            (1) / c_t_int_1 + (c_t_int_1) / c_t_int_2 + (-c_t_int_1) / 2 -
            c_t_int_2 / c_t_int_2 = -417 and

            (-0) / c_st_int_2 + c_t_int_1 / (c_st_int_1) +
            (c_st_int_1 / c_t_int_2) - (c_st_int_2) / c_t_int_2 = -34
               ) =>
	    null ;
	 when others =>
	    cons_correct := false ;
      end case ;
-- generic expression

      gen_correct := c2_int_1 = -2 and
                     c2_t_int_1 = -417 and
                     c2_st_int_1 = -34 ;

-- dynamic expression
      v2_int_1 :=
            (-10) / v_int_1 + v_int_1 / v_int_2 + v_int_1 / v_int_1 -
            v_int_2 / c_int_2 ;
      v2_t_int_1 :=
            (1) / v_t_int_1 + (v_t_int_1) / v_t_int_2 + (-v_t_int_1) / 2 -
            v_t_int_2 / i_t_int_2 ;
      v2_st_int_1 :=
            (-0) / v_st_int_2 + v_t_int_1 / (v_st_int_1) +
            (v_st_int_1 / v_t_int_2) - (v_st_int_2) / i_t_int_2 ;

      dyn_correct := v2_int_1 = -2 and
                     v2_t_int_1 = -417 and
                     v2_st_int_1 = -34 ;

      locally_static_correct <= cons_correct ;
      globally_static_correct <= gen_correct ;
      dynamic_correct <= dyn_correct ;
      wait ;
   end process ;
end ARCH00438 ;

use WORK.STANDARD_TYPES.test_report, WORK.STANDARD_TYPES.print ;
use WORK.ARITHMETIC.ALL ;
entity ENT00438_Test_Bench is
end ENT00438_Test_Bench ;

architecture ARCH00438_Test_Bench of ENT00438_Test_Bench is
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

      for CIS1 : UUT use entity WORK.ENT00438 ( ARCH00438 ) ;
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
	    test_report ( "ARCH00438" ,
		          "/ predefined for integer types" ,
		          true ) ;
	 end if ;
      end process ;
   end block L1 ;
end ARCH00438_Test_Bench ;
