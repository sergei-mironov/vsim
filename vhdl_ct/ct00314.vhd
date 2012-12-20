-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00314
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
--    ENT00314(ARCH00314)
--    ENT00314_Test_Bench(ARCH00314_Test_Bench)
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
entity ENT00314 is
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
end ENT00314 ;

architecture ARCH00314 of ENT00314 is
begin
   process
      variable bool : boolean := true ;
      variable cons_correct, gen_correct, dyn_correct : boolean := true ;
--
      variable v_int_1, v2_int_1 : integer := c_int_1 ;
      variable v_int_2, v2_int_2 : integer := c_int_2 ;
      variable v_t_int_1, v2_t_int_1 : t_int := c_t_int_1 ;
      variable v_t_int_2, v2_t_int_2 : t_int := c_t_int_2 ;
      variable v_st_int_1, v2_st_int_1 : st_int := c_st_int_1 ;
      variable v_st_int_2, v2_st_int_2 : st_int := c_st_int_2 ;
--
      constant c2_int_1 : integer :=
               (((+i_int_1) + (-i_int_2)) + ((-i_int_1) + (-i_int_2)))
               -
               (((+i_int_1) - (-c_int_2)) - ((-c_int_2) - (-i_int_1))) - 28 ;

      constant c2_t_int_1 : t_int :=
               (((+i_t_int_1) + (-i_t_int_2)) + ((-i_t_int_1) + (-i_t_int_2)))
               -
               (((+i_t_int_1) - (-c_t_int_2)) - ((-c_t_int_2) - (-i_t_int_1)))
               - 5 ;

      constant c2_st_int_1 : st_int :=
             -(((+i_st_int_1) + (-i_t_int_2)) + ((-i_st_int_1) + (-i_st_int_2)))
              -
              (((+i_st_int_1) - (-c_st_int_2)) - ((-c_t_int_2) - (-i_st_int_1)))
               - 5 ;
   begin
--
-- static expression
--
      case bool is
	 when ( (((+c_int_1) + (-c_int_2)) + ((-c_int_1) + (-c_int_2)))
               -
                (((+c_int_1) - (-c_int_2)) - ((-c_int_2) - (-c_int_1))) - 28

               = ans_int1   and

               (((+c_t_int_1) + (-c_t_int_2)) + ((-c_t_int_1) + (-c_t_int_2)))
               -
               (((+c_t_int_1) - (-c_t_int_2)) - ((-c_t_int_2) - (-c_t_int_1)))
               - 5
               = ans_int2  and

             -(((+c_st_int_1) + (-c_t_int_2)) + ((-c_st_int_1) + (-c_st_int_2)))
              -
              (((+c_st_int_1) - (-c_st_int_2)) - ((-c_t_int_2) - (-c_st_int_1)))
               - 5
               = ans_int3
            ) =>
	    null ;
	 when others =>
	    cons_correct := false ;
      end case ;
--
-- generic expression
--
      gen_correct := c2_int_1 = ans_int1 and
                     c2_t_int_1 = ans_int2 and
                     c2_st_int_1= ans_int3 ;
--
-- dynamic expression
--
      v_int_1 :=
         (((+v2_int_1) + (-v2_int_2)) + ((-v2_int_1) + (-v2_int_2)))
         -
         (((+v2_int_1) - (-c_int_2)) - ((-c_int_2) - (-v2_int_1))) - 28 ;

      v_t_int_1 :=
         (((+v2_t_int_1) + (-v2_t_int_2)) + ((-v2_t_int_1) + (-v2_t_int_2)))
         -
         (((+v2_t_int_1) - (-i_t_int_2)) - ((-c_t_int_2) - (-v2_t_int_1)))
         - 5 ;

      v_st_int_1 :=
        -(((+v2_st_int_1) + (-v2_t_int_2)) + ((-v2_st_int_1) + (-v2_st_int_2)))
         -
         (((+v2_st_int_1) - (-c_st_int_2)) - ((-i_t_int_2) - (-v2_st_int_1)))
         - 5 ;
      dyn_correct := true ;
      dyn_correct := v_int_1 = ans_int1 and
                     v_t_int_1 = ans_int2 and
                     v_st_int_1 = ans_int3 ;
      locally_static_correct <= cons_correct ;
      globally_static_correct <= gen_correct ;
      dynamic_correct <= dyn_correct ;
      wait ;
   end process ;
end ARCH00314 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00314_Test_Bench is
end ENT00314_Test_Bench ;

architecture ARCH00314_Test_Bench of ENT00314_Test_Bench is
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

      for CIS1 : UUT use entity WORK.ENT00314 ( ARCH00314 ) ;
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
	    WORK.STANDARD_TYPES.test_report ( "ARCH00314" ,
		          "+ and - unary and binary operators are correctly"
			  & " predefined for integer types" ,
		          true ) ;
	 end if ;
      end process ;
   end block L1 ;
end ARCH00314_Test_Bench ;
