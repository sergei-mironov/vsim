-- NEED RESULT: ARCH00698: Formal parameters of mode in may be left unspecified in association list if they have default expressions passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00698
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.3.2 (7)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00698(ARCH00698)
--    ENT00698_Test_Bench(ARCH00698_Test_Bench)
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
entity ENT00698 is
   port (
          p_integer : integer :=  5 ;
          p_boolean : boolean := true ;
          p_st_arr3 : st_arr3 := c_st_arr3_1
         ) ;
end ENT00698 ;
--
architecture ARCH00698 of ENT00698 is
   procedure p1 (
                 pc_integer : integer := -4 ;
                 pc_boolean : boolean := false ;
                 pc_st_arr3 : st_arr3 := c_st_arr3_2 ;
                 pv_integer : integer := 3 ;
                 pv_boolean : boolean := true ;
                 pv_st_arr3 : st_arr3 := c_st_arr3_1 ;
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
      test_report ( "ARCH00698" ,
		    "Formal parameters of mode in may be left unspecified"
                    & " in association list if they have default expressions" ,
		    correct ) ;
   end p1 ;
begin
   process
      variable v_integer : integer := 0 ;
      variable v_boolean : boolean := true ;
      variable v_st_arr3 : st_arr3 := c_st_arr3_1 ;
   begin
      p1 (
           ps_integer => p_integer ,
           ps_boolean => p_boolean ,
           ps_st_arr3 => p_st_arr3 ,
           pv_integer => 0
          ) ;
      wait ;
   end process ;
end ARCH00698 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00698_Test_Bench is
end ENT00698_Test_Bench ;
--
architecture ARCH00698_Test_Bench of ENT00698_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.ENT00698 ( ARCH00698 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00698_Test_Bench ;
--
