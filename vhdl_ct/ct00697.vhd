-- NEED RESULT: ARCH00697: Positional and named associations in same association list passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00697
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.3.2 (3)
--    4.3.3.2 (4)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00697(ARCH00697)
--    ENT00697_Test_Bench(ARCH00697_Test_Bench)
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
entity ENT00697 is
   generic (
             g_integer : integer ;
             g_boolean : boolean ;
             g_st_arr3 : st_arr3
          ) ;
   port (
          p_integer : integer ;
          p_boolean : boolean ;
          p_st_arr3 : st_arr3
         ) ;
end ENT00697 ;
--
architecture ARCH00697 of ENT00697 is
   procedure p1 (
                 pc_integer : integer ;
                 pc_boolean : boolean ;
                 pc_st_arr3 : st_arr3 ;
                 pv_integer : inout integer ;
                 pv_boolean : inout boolean ;
                 pv_st_arr3 : inout st_arr3 ;
                 signal ps_integer : integer ;
                 signal ps_boolean : boolean ;
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
      test_report ( "ARCH00697" ,
		    "Positional and named associations in same association"
                    & " list" ,
		    correct ) ;
   end p1 ;
begin
   process
      variable v_integer : integer := 0 ;
      variable v_boolean : boolean := true ;
      variable v_st_arr3 : st_arr3 := c_st_arr3_1 ;
   begin
      p1 (
           g_integer + p_integer ,
           boolean'val(boolean'pos(g_boolean and v_boolean) - 3 mod 2) ,
           st_arr3 ' (g_st_arr3) ,
           v_integer ,
           v_boolean ,
           v_st_arr3 ,
           ps_integer => p_integer ,
           ps_boolean => p_boolean ,
           ps_st_arr3 => p_st_arr3
          ) ;
      wait ;
   end process ;
end ARCH00697 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00697_Test_Bench is
end ENT00697_Test_Bench ;
--
architecture ARCH00697_Test_Bench of ENT00697_Test_Bench is
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
                   lg_integer : integer ;
                   lg_boolean : boolean ;
                   lg_st_arr3 : st_arr3
                 ) ;
         port (
                   lp_integer : integer ;
                   lp_boolean : boolean ;
                   lp_st_arr3 : st_arr3
              ) ;
      end component ;
      for CIS1 : UUT use entity WORK.ENT00697 ( ARCH00697 )
                            generic map (
                                          lg_integer ,
                                          g_boolean => lg_boolean ,
                                          g_st_arr3 => lg_st_arr3
                                        )
                            port map (
                                       lp_integer ,
                                       p_boolean => lp_boolean ,
                                       p_st_arr3 => lp_st_arr3
                                     ) ;
   begin
      CIS1 : UUT
         generic map (
                       c_integer - 3 ,
                       lg_boolean => boolean'succ(c_boolean) ,
                       lg_st_arr3 => c_st_arr3
                     )
         port map (
                    s_integer ,
                    lp_boolean => s_boolean ,
                    lp_st_arr3 => s_st_arr3
                  ) ;
   end block L1 ;
end ARCH00697_Test_Bench ;
--
