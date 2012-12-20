-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00439
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
--    ENT00439(ARCH00439)
--    ENT00439_Test_Bench(ARCH00439_Test_Bench)
--
-- REVISION HISTORY:
--
--    29-JUL-1987   - initial revision
--     6-JUN-1988   - JTH
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.test_report, WORK.STANDARD_TYPES.print ;
use WORK.ARITHMETIC.ALL ;
entity ENT00439 is
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
end ENT00439 ;

architecture ARCH00439 of ENT00439 is
   constant c2_int_1 : integer :=
            (-10) mod i_int_1 + i_int_1 mod i_int_2 + i_int_1 mod (i_int_1 - 1)
            - i_int_2 mod (c_int_2 + 1) ;
   constant c2_t_int_1 : t_int :=
            (1) mod i_t_int_1 + (i_t_int_1) mod i_t_int_2 + (-i_t_int_1) mod 2 -
            c_t_int_2 mod (i_t_int_2 - 1) ;
   constant c2_st_int_1 : st_int :=
            (-0) mod i_st_int_2 + i_t_int_1 mod (i_st_int_1) +
            (i_st_int_1 mod i_t_int_2) - (c_st_int_2) mod i_t_int_2 ;
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
            (-10) mod c_int_1 + c_int_1 mod c_int_2 + c_int_1 mod (c_int_1 - 1)
            - c_int_2 mod (c_int_2 + 1) = -2 and
            (1) mod c_t_int_1 + (c_t_int_1) mod c_t_int_2 + (-c_t_int_1) mod 2 -
            c_t_int_2 mod (c_t_int_2 - 1) = 3 and
            (-0) mod c_st_int_2 + c_t_int_1 mod (c_st_int_1) +
            (c_st_int_1 mod c_t_int_2) - (c_st_int_2) mod c_t_int_2 = 0
               ) =>
	    null ;
	 when others =>
	    cons_correct := false ;
      end case ;
-- generic expression
      gen_correct := c2_int_1 = -2 and
                     c2_t_int_1 = 3 and
                     c2_st_int_1 = 0 ;
-- dynamic expression
      v2_int_1 :=
            (-10) mod v_int_1 + v_int_1 mod v_int_2 + v_int_1 mod (v_int_1 - 1)
            - v_int_2 mod (i_int_2 + 1) ;
      v2_t_int_1 :=
            (1) mod v_t_int_1 + (v_t_int_1) mod v_t_int_2 + (-v_t_int_1) mod 2 -
            c_t_int_2 mod (v_t_int_2 - 1) ;
      v2_st_int_1 :=
            (-0) mod v_st_int_2 + v_t_int_1 mod (v_st_int_1) +
            (v_st_int_1 mod v_t_int_2) - (i_st_int_2) mod v_t_int_2 ;
      dyn_correct := v2_int_1 = -2 and
                     v2_t_int_1 = 3 and
                     v2_st_int_1 = 0 ;
      locally_static_correct <= cons_correct ;
      globally_static_correct <= gen_correct ;
      dynamic_correct <= dyn_correct ;
      wait ;
   end process ;
end ARCH00439 ;

use WORK.STANDARD_TYPES.test_report, WORK.STANDARD_TYPES.print ;
use WORK.ARITHMETIC.ALL ;
entity ENT00439_Test_Bench is
end ENT00439_Test_Bench ;

architecture ARCH00439_Test_Bench of ENT00439_Test_Bench is
begin
   L1:
   block
      signal locally_static_correct, globally_static_correct,
             dynamic_correct : boolean := false ;

      component UUT
	    port ( locally_static_correct : inout boolean ;
                   globally_static_correct : inout boolean ;
                   dynamic_correct : inout boolean ) ;
      end component ;

      for CIS1 : UUT use entity WORK.ENT00439 ( ARCH00439 ) ;
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
	    test_report ( "ARCH00439" ,
		          "mod predefined for integer types" ,
		          true ) ;
	 end if ;
      end process ;
   end block L1 ;
end ARCH00439_Test_Bench ;
