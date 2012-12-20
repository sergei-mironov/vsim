-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00334
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
--    ENT00334(ARCH00334)
--    ENT00334_Test_Bench(ARCH00334_Test_Bench)
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
entity ENT00334 is
   generic (
             i_time_1 : time := c_time_1 ;
             i_time_2 : time := c_time_2 ;
             i_t_phys_1 : t_phys := c_t_phys_1 ;
             i_t_phys_2 : t_phys := c_t_phys_2 ;
             i_st_phys_1 : st_phys := c_st_phys_1 ;
             i_st_phys_2 : st_phys := c_st_phys_2
             ) ;
   port ( locally_static_correct : out boolean ;
	  globally_static_correct : out boolean ;
	  dynamic_correct : out boolean ) ;
end ENT00334 ;

architecture ARCH00334 of ENT00334 is
begin
   process
      variable bool : boolean := true ;
      variable cons_correct, gen_correct, dyn_correct : boolean := true ;
--
      variable v_time_1, v2_time_1 : time := c_time_1 ;
      variable v_time_2, v2_time_2 : time := c_time_2 ;
      variable v_t_phys_1, v2_t_phys_1 : t_phys := c_t_phys_1 ;
      variable v_t_phys_2, v2_t_phys_2 : t_phys := c_t_phys_2 ;
      variable v_st_phys_1, v2_st_phys_1 : st_phys := c_st_phys_1 ;
      variable v_st_phys_2, v2_st_phys_2 : st_phys := c_st_phys_2 ;

--
      constant c2_time_1 : time :=
             (i_time_1 - (+i_time_2)) - i_time_2 + c_time_2 ;

      constant c2_t_phys_1 : t_phys :=
             (((+i_t_phys_1) + (-i_t_phys_2)) + ((-i_t_phys_1) + (-i_t_phys_2)))
             -
             (((+i_t_phys_1) - (-c_t_phys_2)) - ((-c_t_phys_2) - (-i_t_phys_1)))
             - 5ones ;

      constant c2_st_phys_1 : st_phys :=
         -(((+i_st_phys_1) + (-i_t_phys_2)) + ((-i_st_phys_1) + (-i_st_phys_2)))
          -
          (((+i_st_phys_1) - (-c_st_phys_2)) - ((-c_t_phys_2) - (-i_st_phys_1)))
          - 5ones ;
   begin
-- static expression
      case bool is
	 when ( (c_time_1 - (+c_time_2)) - c_time_2 + c_time_2
          = ans_phys1 and

          (((+c_t_phys_1) + (-c_t_phys_2)) + ((-c_t_phys_1) + (-c_t_phys_2)))
          -
          (((+c_t_phys_1) - (-c_t_phys_2)) - ((-c_t_phys_2) - (-c_t_phys_1)))
          - 5ones
          = ans_phys2 and

         -(((+c_st_phys_1) + (-c_t_phys_2)) + ((-c_st_phys_1) + (-c_st_phys_2)))
          -
          (((+c_st_phys_1) - (-c_st_phys_2)) - ((-c_t_phys_2) - (-c_st_phys_1)))
          - 5ones
          = ans_phys3
           ) => null ;
	 when others =>
	    cons_correct := false ;
      end case ;
-- generic expression
      gen_correct := c2_time_1 = ans_phys1 and
                     c2_t_phys_1 = ans_phys2 and
                     c2_st_phys_1 = ans_phys3 ;
-- dynamic expression
      v_time_1 := (v2_time_1 - (+v2_time_2)) - v2_time_2 + c_time_2 ;
--
      v_t_phys_1 :=
         (((+v2_t_phys_1) + (-v2_t_phys_2)) + ((-v2_t_phys_1) + (-v2_t_phys_2)))
         -
         (((+v2_t_phys_1) - (-i_t_phys_2)) - ((-c_t_phys_2) - (-v2_t_phys_1)))
         - 5ones ;
--
      v_st_phys_1 :=
     -(((+v2_st_phys_1) + (-v2_t_phys_2)) + ((-v2_st_phys_1) + (-v2_st_phys_2)))
      -
      (((+v2_st_phys_1) - (-c_st_phys_2)) - ((-i_t_phys_2) - (-v2_st_phys_1)))
      - 5ones ;

      dyn_correct := v_time_1 = ans_phys1 and
                     v_t_phys_1 = ans_phys2 and
                     v_st_phys_1 = ans_phys3 ;
      locally_static_correct <= cons_correct ;
      globally_static_correct <= gen_correct ;
      dynamic_correct <= dyn_correct ;
      wait ;
   end process ;
end ARCH00334 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00334_Test_Bench is
end ENT00334_Test_Bench ;

architecture ARCH00334_Test_Bench of ENT00334_Test_Bench is
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

      for CIS1 : UUT use entity WORK.ENT00334 ( ARCH00334 ) ;
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
	    test_report ( "ARCH00334" ,
		          "+ and - unary and binary operators are correctly"
			  & " predefined for physical types" ,
		          true ) ;
	 end if ;
      end process ;
   end block L1 ;
end ARCH00334_Test_Bench ;
