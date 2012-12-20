-- NEED RESULT: ARCH00696: Expressions, signal and variable names allowed as actual designator in association list passed
-- NEED RESULT: ARCH00696_1: Actual designator may be 'open' passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00696
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.3.2 (3)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00696(ARCH00696)
--    ENT00696_1(ARCH00696_1)
--    ENT00696_Test_Bench(ARCH00696_Test_Bench)
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
entity ENT00696 is
   generic (
             g_integer : integer ;
             g_st_arr3 : st_arr3 ;
             g_boolean : boolean
          ) ;
   port (
          p_integer : integer ;
          p_st_arr3 : st_arr3 ;
          p_boolean : boolean
         ) ;
end ENT00696 ;
--
architecture ARCH00696 of ENT00696 is
   procedure p1 (
                 pc_boolean : boolean ;
                 pc_integer : integer ;
                 pc_st_arr3 : st_arr3 ;
                 pv_boolean : inout boolean ;
                 pv_integer : inout integer ;
                 pv_st_arr3 : inout st_arr3 ;
                 signal ps_boolean : boolean ;
                 signal ps_integer : integer ;
                 signal ps_st_arr3 : st_arr3
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
      test_report ( "ARCH00696" ,
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
           pc_integer => g_integer + p_integer ,
           pc_boolean =>
               boolean'val(boolean'pos(g_boolean and v_boolean) - 3 mod 2) ,
           pc_st_arr3 => st_arr3 ' (g_st_arr3) ,
           pv_integer => v_integer ,
           pv_boolean => v_boolean ,
           pv_st_arr3 => v_st_arr3 ,
           ps_integer => p_integer ,
           ps_boolean => p_boolean ,
           ps_st_arr3 => p_st_arr3
          ) ;
      wait ;
   end process ;
end ARCH00696 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00696_1 is
   port (
          p_boolean : boolean := true ;
          p_integer : integer := 3 ;
          p_st_arr3 : st_arr3 := c_st_arr3_1
         ) ;
end ENT00696_1 ;
--
architecture ARCH00696_1 of ENT00696_1 is
begin
   process
   begin
      test_report ( "ARCH00696_1" ,
		    "Actual designator may be 'open'" ,
		    p_integer = 3 and p_boolean and p_st_arr3 = c_st_arr3_1 ) ;
      wait ;
   end process ;
end ARCH00696_1 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00696_Test_Bench is
end ENT00696_Test_Bench ;
--
architecture ARCH00696_Test_Bench of ENT00696_Test_Bench is
begin
   L1:
   block
      signal s_integer : integer := 5 ;
      signal s_boolean : boolean := true ;
      signal s_st_arr3 : st_arr3 := c_st_arr3_1 ;
      constant c_integer : integer := -6 ;
      constant c_boolean : boolean := false ;
      constant c_st_arr3 : st_arr3 := c_st_arr3_2 ;

      component UUT
         generic (
                   lg_boolean : boolean ;
                   lg_st_arr3 : st_arr3 ;
                   lg_integer : integer
                 ) ;
         port (
                   lp_integer : integer ;
                   lp_st_arr3 : st_arr3 ;
                   lp_boolean : boolean
              ) ;
      end component ;
      component UUT_1
      end component ;
      for CIS1 : UUT use entity WORK.ENT00696 ( ARCH00696 )
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
      for CIS2 : UUT_1 use entity WORK.ENT00696_1 ( ARCH00696_1 ) ;
   begin
      CIS1 : UUT
         generic map (
                       lg_st_arr3 => c_st_arr3_2 ,
                       lg_boolean => boolean'succ(c_boolean) ,
                       lg_integer => c_integer - 3
                     )
         port map (
                    lp_st_arr3 => s_st_arr3 ,
                    lp_boolean => s_boolean ,
                    lp_integer => s_integer
                  ) ;
      CIS2 : UUT_1 ;
   end block L1 ;
end ARCH00696_Test_Bench ;
--
