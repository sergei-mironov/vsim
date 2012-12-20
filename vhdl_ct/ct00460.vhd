-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00460
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.2.5 (2)
--    7.2.5 (5)
--    7.2.5 (6)
--    7.2.5 (7)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00460
--    ENT00460(ARCH00460)
--    ENT00460_Test_Bench(ARCH00460_Test_Bench)
--
-- REVISION HISTORY:
--
--    29-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
package PKG00460 is
-- integer definitions
   subtype st_integer is integer range -2 ** 15 to 2 ** 20 ;
   constant c_integer_1 : integer := 10 ;
   constant c_integer_2 : integer := 7 ;
   constant c_st_integer_1 : st_integer := 5 ;
   constant c_st_integer_2 : st_integer := -4 ;
-- integer
   type t_int is range -2 ** 20 to 2 ** 20 ;
   subtype st_int is t_int range -2 ** 15 to 2 ** 20 ;
   constant c_int_1 : integer := 2 ;
   constant c_int_2 : integer := 1 ;
   constant c_t_int_1 : t_int := -3 ;
   constant c_t_int_2 : t_int := 4  ;
   constant c_st_int_1 : st_int := 7 ;
   constant c_st_int_2 : st_int := -1 ;
end PKG00460 ;

use WORK.STANDARD_TYPES ;
use WORK.PKG00460.ALL ;
entity ENT00460 is
   generic (
             i_integer_1 : integer := c_integer_1 ;
             i_integer_2 : integer := c_integer_2 ;
             i_st_integer_1 : st_integer := c_st_integer_1 ;
             i_st_integer_2 : st_integer := c_st_integer_2 ;
             i_int_1 : integer := c_int_1 ;
             i_int_2 : integer := c_int_2 ;
             i_t_int_1 : t_int := c_t_int_1 ;
             i_t_int_2 : t_int := c_t_int_2 ;
             i_st_int_1 : st_int := c_st_int_1 ;
             i_st_int_2 : st_int := c_st_int_2
             ) ;
   constant c2_integer_1 : integer :=
      i_int_1 ** i_st_integer_1 ;
   constant c2_integer_2 : integer :=
      i_int_2 ** i_integer_1 ;
   constant c2_t_int_1 : t_int :=
      i_t_int_1 ** i_integer_2 ;
   constant c2_t_int_2 : t_int :=
      i_t_int_2 ** i_integer_1 ;
   constant c2_st_int_1 : st_int :=
      i_st_int_1 ** i_st_integer_1 ;
   constant c2_st_int_2 : st_int :=
      i_st_int_2 ** i_integer_1 ;
end ENT00460 ;

architecture ARCH00460 of ENT00460 is
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
      variable v_integer_1 : integer := i_integer_1 ;
      variable v_integer_2 : integer := i_integer_2 ;
      variable v_st_integer_1 : st_integer := i_st_integer_1 ;
      variable v_st_integer_2 : st_integer := i_st_integer_2 ;
--
   begin
-- static expression
      case bool is
	 when (
	      c_int_1 ** c_st_integer_1 = 32 and

	      c_int_2 ** c_integer_1 = 1 and

	      c_t_int_1 ** c_integer_2 = (-2187) and

	      c_t_int_2 ** c_integer_1 = 1048576 and

	      c_st_int_1 ** c_st_integer_1 = 16807 and

	      c_st_int_2 ** c_integer_1 = 1
               ) =>
	    null ;
	 when others =>
	    cons_correct := false ;
      end case ;
-- generic expression
      gen_correct :=
         c2_integer_1 = 32 and
         c2_integer_2 = 1 and
         c2_t_int_1 = (-2187) and
         c2_t_int_2 = 1048576 and
         c2_st_int_1 = 16807 and
         c2_st_int_2 = 1 ;
-- dynamic expression
      v2_int_1 :=
       v_int_1 ** v_st_integer_1 ;
      v2_int_2 :=
       v_int_2 ** v_integer_1 ;
      v2_t_int_1 :=
       v_t_int_1 ** v_integer_2 ;
      v2_t_int_2 :=
       v_t_int_2 ** v_integer_1 ;
      v2_st_int_1 :=
       v_st_int_1 ** v_st_integer_1 ;
      v2_st_int_2 :=
       v_st_int_2 ** v_integer_1 ;
      dyn_correct :=
         v2_int_1 = 32 and
         v2_int_2 = 1 and
         v2_t_int_1 = (-2187) and
         v2_t_int_2 = 1048576 and
         v2_st_int_1 = 16807 and
         v2_st_int_2 = 1 ;
      STANDARD_TYPES.test_report ( "ARCH00460" ,
		    "** predefined for integer base and integer exponent" ,
		    dyn_correct and cons_correct and gen_correct ) ;
      wait ;
   end process ;
end ARCH00460 ;

entity ENT00460_Test_Bench is
end ENT00460_Test_Bench ;

architecture ARCH00460_Test_Bench of ENT00460_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00460 ( ARCH00460 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00460_Test_Bench ;
