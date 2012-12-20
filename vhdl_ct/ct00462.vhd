-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00462
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.2.5 (1)
--    7.2.5 (5)
--    7.2.5 (6)
--    7.2.5 (7)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00462(ARCH00462)
--    ENT00462_Test_Bench(ARCH00462_Test_Bench)
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
entity ENT00462 is
   generic (
             i_int_1 : integer := c_int_1 ;
             i_int_2 : integer := c_int_2 ;
             i_t_int_1 : t_int := c_t_int_1 ;
             i_t_int_2 : t_int := c_t_int_2 ;
             i_st_int_1 : st_int := c_st_int_1 ;
             i_st_int_2 : st_int := c_st_int_2
             ) ;
end ENT00462 ;

architecture ARCH00462 of ENT00462 is
   constant c2_int_1 : integer :=
     abs i_int_1 + abs i_int_2 ;
   constant c2_t_int_1 : t_int :=
     abs i_t_int_1 + abs i_t_int_2 ;
   constant c2_st_int_1 : st_int :=
     abs i_st_int_1 + abs i_st_int_2 + abs i_t_int_2 ;
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
     abs c_int_1 + abs c_int_2 = 17 and

     abs c_t_int_1 + abs c_t_int_2 = 503 and

     abs c_st_int_1 + abs c_st_int_2 + abs c_t_int_2 = 408
               ) =>
	    null ;
	 when others =>
	    cons_correct := false ;
      end case ;
-- generic expression
      gen_correct := c2_int_1 = 17 and
                     c2_t_int_1 = 503 and
                     c2_st_int_1 = 408 ;
-- dynamic expression
       v2_int_1 :=
         abs v_int_1 + abs v_int_2 ;
       v2_t_int_1 :=
         abs v_t_int_1 + abs v_t_int_2 ;
       v2_st_int_1 :=
         abs v_st_int_1 + abs v_st_int_2 + abs v_t_int_2 ;
      dyn_correct := v2_int_1 = 17 and
                     v2_t_int_1 = 503 and
                     v2_st_int_1 = 408 ;
      STANDARD_TYPES.test_report ( "ARCH00462" ,
		    "abs predefined for integer types" ,
		    cons_correct and gen_correct and dyn_correct ) ;
      wait ;
   end process ;
end ARCH00462 ;

entity ENT00462_Test_Bench is
end ENT00462_Test_Bench ;

architecture ARCH00462_Test_Bench of ENT00462_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00462 ( ARCH00462 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00462_Test_Bench ;
