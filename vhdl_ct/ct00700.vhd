-- NEED RESULT: ARCH00700: Expressions, signal and variable names allowed as actual designator in association list passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00700
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.3.2 (8)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00700
--    ENT00700(ARCH00700)
--    ENT00700_Test_Bench(ARCH00700_Test_Bench)
--
-- REVISION HISTORY:
--
--    09-SEP-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
package PKG00700 is
   subtype integer1 is integer range -100 to 100 ;
   subtype boolean1 is boolean range false to true ;
   subtype st_arr31 is t_arr3 (highb downto lowb, true downto false ) ;
   subtype integer2 is integer range 100 downto -100 ;
   subtype boolean2 is boolean range true downto false ;
   subtype st_arr32 is t_arr3 (lowb to highb, false to true ) ;
   subtype integer3 is bf_integer integer range -100 to 100 ;
   subtype boolean3 is bf_boolean boolean range true downto false;
   subtype st_arr33 is bf_arr3 t_arr3 (lowb + 5 to highb + 5,
       true downto false ) ;
--
   signal s_integer : integer range 0 to 5 := 5 ;
   signal s_boolean : boolean := true ;
   signal s_st_arr3 : st_arr3 := c_st_arr3_1 ;
end PKG00700 ;

use WORK.STANDARD_TYPES.all ;
use WORK.PKG00700.all ;
entity ENT00700 is
   generic (
             g_integer : integer2 ;
             g_st_arr3 : st_arr32 ;
             g_boolean : boolean2
          ) ;
   port (
          p_integer : integer2 ;
          p_st_arr3 : st_arr32 ;
          p_boolean : boolean2
         ) ;
end ENT00700 ;
--
architecture ARCH00700 of ENT00700 is
   procedure p1 (
                 pc_boolean : boolean3 ;
                 pc_integer : integer range -100 to 100 ;
                 pc_st_arr3 : st_arr33 ;
                 pv_boolean : inout boolean3 ;
                 pv_integer : inout integer3 ;
                 pv_st_arr3 : inout st_arr3 ;
                 signal ps_boolean : boolean3 ;
                 signal ps_integer : integer2 ;
                 signal ps_st_arr3 : st_arr32
                ) is
      variable correct : boolean := true ;
   begin
      correct := correct and pc_integer = -4 ;
      correct := correct and not pc_boolean ;
      correct := correct and pc_st_arr3 = c_st_arr3_2 ;
      correct := correct and pv_integer = 0 ;
      correct := correct and pv_boolean ;
      correct := correct and pv_st_arr3 = c_st_arr3_1 ;
      correct := correct and ps_integer = 5 ;
      correct := correct and ps_boolean ;
      correct := correct and ps_st_arr3 = c_st_arr3_1 ;
      test_report ( "ARCH00700" ,
		    "Expressions, signal and variable names allowed as"
                    & " actual designator in association list" ,
		    correct ) ;
   end p1 ;
begin
   process
      variable v_integer : integer := 0 ;
      variable v_boolean : boolean := true ;
      variable v_st_arr3 : st_arr3 := c_st_arr3_1 ;
   begin
      p1 (
           pc_integer => g_integer + s_integer ,
           pc_boolean =>
               boolean'val(boolean'pos(g_boolean and v_boolean) - 3 mod 2) ,
           pc_st_arr3 => g_st_arr3 ,
           pv_integer => v_integer ,
           pv_boolean => v_boolean ,
           pv_st_arr3 => v_st_arr3 ,
           ps_integer => s_integer ,
           ps_boolean => s_boolean ,
           ps_st_arr3 => s_st_arr3
          ) ;
      wait ;
   end process ;
end ARCH00700 ;
--
use WORK.STANDARD_TYPES.all ;
use WORK.PKG00700.all ;
entity ENT00700_Test_Bench is
end ENT00700_Test_Bench ;
--
architecture ARCH00700_Test_Bench of ENT00700_Test_Bench is
begin
   L1:
   block
      constant c_integer : integer := -6 ;
      constant c_boolean : boolean := false ;
      constant c_st_arr3 : st_arr3 := c_st_arr3_2 ;

      component UUT
         generic (
                   lg_boolean : boolean1 ;
                   lg_st_arr3 : st_arr31 ;
                   lg_integer : integer1
                 ) ;
         port (
                   lp_integer : integer1 ;
                   lp_st_arr3 : st_arr31 ;
                   lp_boolean : boolean1
              ) ;
      end component ;
      for CIS1 : UUT use entity WORK.ENT00700 ( ARCH00700 )
                            generic map (
                                          g_st_arr3 => lg_st_arr3 ,
                                          g_boolean => lg_boolean ,
                                          g_integer => lg_integer
                                        )
                            port map (
                                       p_boolean => lp_boolean ,
                                       p_integer => lp_integer ,
                                       p_st_arr3 => lp_st_arr3
                                     ) ;
   begin
      CIS1 : UUT
         generic map (
                       lg_st_arr3 => c_st_arr3 ,
                       lg_boolean => boolean'succ(c_boolean) ,
                       lg_integer => c_integer - 3
                     )
         port map (
                    lp_st_arr3 => s_st_arr3 ,
                    lp_boolean => s_boolean ,
                    lp_integer => s_integer
                  ) ;
   end block L1 ;
end ARCH00700_Test_Bench ;
--
