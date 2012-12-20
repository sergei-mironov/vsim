-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00463
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
--    ENT00463(ARCH00463)
--    ENT00463_Test_Bench(ARCH00463_Test_Bench)
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
entity ENT00463 is
   generic (
             i_phys_1 : time := c_time_1 ;
             i_phys_2 : time := c_time_2 ;
             i_t_phys_1 : t_phys := c_t_phys_1 ;
             i_t_phys_2 : t_phys := c_t_phys_2 ;
             i_st_phys_1 : st_phys := c_st_phys_1 ;
             i_st_phys_2 : st_phys := c_st_phys_2
             ) ;
end ENT00463 ;

architecture ARCH00463 of ENT00463 is
   constant c2_phys_1 : time :=
     abs i_phys_1 + abs i_phys_2 ;
   constant c2_t_phys_1 : t_phys :=
     abs i_t_phys_1 + abs i_t_phys_2 ;
   constant c2_st_phys_1 : st_phys :=
     abs i_st_phys_1 + abs i_st_phys_2 + abs i_t_phys_2 ;
begin
   process
      variable bool : boolean := true ;
      variable cons_correct, gen_correct, dyn_correct : boolean := true ;
--
      variable v_phys_1, v2_phys_1 : time := i_phys_1 ;
      variable v_phys_2, v2_phys_2 : time := i_phys_2 ;
      variable v_t_phys_1, v2_t_phys_1 : t_phys := i_t_phys_1 ;
      variable v_t_phys_2, v2_t_phys_2 : t_phys := i_t_phys_2 ;
      variable v_st_phys_1, v2_st_phys_1 : st_phys := i_st_phys_1 ;
      variable v_st_phys_2, v2_st_phys_2 : st_phys := i_st_phys_2 ;
--
   begin
-- static expression
      case bool is
	 when (
     abs c_time_1 + abs c_time_2 = 1000010 fs and

     abs c_t_phys_1 + abs c_t_phys_2 = 503 ones and

     abs c_st_phys_1 + abs c_st_phys_2 + abs c_t_phys_2 = 48 ones
               ) =>
	    null ;
	 when others =>
	    cons_correct := false ;
      end case ;
-- generic expression
      gen_correct := c2_phys_1 = 1000010 fs and
                     c2_t_phys_1 = 503 ones and
                     c2_st_phys_1 = 48 ones ;
-- dynamic expression
       v2_phys_1 :=
         abs v_phys_1 + abs v_phys_2 ;
       v2_t_phys_1 :=
         abs v_t_phys_1 + abs v_t_phys_2 ;
       v2_st_phys_1 :=
         abs v_st_phys_1 + abs v_st_phys_2 + abs v_t_phys_2 ;
      dyn_correct := v2_phys_1 = 1000010 fs and
                     v2_t_phys_1 = 503 ones and
                     v2_st_phys_1 = 48 ones ;
      WORK.STANDARD_TYPES.test_report ( "ARCH00463" ,
		    "abs predefined for physical types" ,
		    cons_correct and gen_correct and dyn_correct ) ;
      wait ;
   end process ;
end ARCH00463 ;

entity ENT00463_Test_Bench is
end ENT00463_Test_Bench ;

architecture ARCH00463_Test_Bench of ENT00463_Test_Bench is
begin
   L1:
   block

      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00463 ( ARCH00463 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00463_Test_Bench ;
