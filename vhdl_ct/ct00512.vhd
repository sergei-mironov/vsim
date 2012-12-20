-- NEED RESULT: ARCH00512: The expression in an initialization specification may be globally static passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00512
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    5.2 (6)
--    5.2 (7)
--    5.2 (9)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00512)
--    ENT00512_Test_Bench(ARCH00512_Test_Bench)
--
-- REVISION HISTORY:
--
--    10-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00512 of E00000 is
   signal S_boolean : boolean := c_boolean_1 ;
--
   signal S_bit : bit := c_bit_1 ;
--
   signal S_severity_level : severity_level := c_severity_level_1 ;
--
   signal S_character : character := c_character_1 ;
--
   signal S_st_enum1 : st_enum1 := c_st_enum1_1 ;
--
   signal S_integer : integer := c_integer_1 ;
--
   signal S_st_int1 : st_int1 := c_st_int1_1 ;
--
   signal S_time : time := c_time_1 ;
--
   signal S_st_phys1 : st_phys1 := c_st_phys1_1 ;
--
   signal S_real : real := c_real_1 ;
--
   signal S_st_real1 : st_real1 := c_st_real1_1 ;
--
   signal S_st_rec1 : st_rec1 := c_st_rec1_1 ;
--
   signal S_st_rec2 : st_rec2 := c_st_rec2_1 ;
--
   signal S_st_rec3 : st_rec3 := c_st_rec3_1 ;
--
   signal S_st_arr1 : st_arr1 := c_st_arr1_1 ;
--
   signal S_st_arr2 : st_arr2 := c_st_arr2_1 ;
--
   signal S_st_arr3 : st_arr3 := c_st_arr3_1 ;
--
--
begin
   process
      variable correct : boolean := true;
   begin
      correct := correct and
                 (S_boolean = c_boolean_1) ;
      correct := correct and
                 (S_bit = c_bit_1) ;
      correct := correct and
                 (S_severity_level = c_severity_level_1) ;
      correct := correct and
                 (S_character = c_character_1) ;
      correct := correct and
                 (S_st_enum1 = c_st_enum1_1) ;
      correct := correct and
                 (S_integer = c_integer_1) ;
      correct := correct and
                 (S_st_int1 = c_st_int1_1) ;
      correct := correct and
                 (S_time = c_time_1) ;
      correct := correct and
                 (S_st_phys1 = c_st_phys1_1) ;
      correct := correct and
                 (S_real = c_real_1) ;
      correct := correct and
                 (S_st_real1 = c_st_real1_1) ;
      correct := correct and
                 (S_st_rec1 = c_st_rec1_1) ;
      correct := correct and
                 (S_st_rec2 = c_st_rec2_1) ;
      correct := correct and
                 (S_st_rec3 = c_st_rec3_1) ;
      correct := correct and
                 (S_st_arr1 = c_st_arr1_1) ;
      correct := correct and
                 (S_st_arr2 = c_st_arr2_1) ;
      correct := correct and
                 (S_st_arr3 = c_st_arr3_1) ;
      test_report ( "ARCH00512" ,
                    "The expression in an initialization specification "&
                    "may be globally static" ,
                    correct );
      wait ;
   end process ;
end ARCH00512 ;
--
--
entity ENT00512_Test_Bench is
end ENT00512_Test_Bench ;

architecture ARCH00512_Test_Bench of ENT00512_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00512 ) ;
   begin
      CIS1 : UUT;
   end block L1 ;
end ARCH00512_Test_Bench ;
