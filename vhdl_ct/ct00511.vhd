-- NEED RESULT: ARCH00511: The expression in an initialization specification may be globally static passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00511
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    5.2 (5)
--    5.2 (6)
--    5.2 (8)
--    5.2 (10)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00511(ARCH00511)
--    ENT00511_Test_Bench(ARCH00511_Test_Bench)
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
entity ENT00511 is
   generic (
        g_boolean_1 : in boolean
      ; g_bit_1 : in bit
      ; g_severity_level_1 : in severity_level
      ; g_character_1 : in character
      ; g_st_enum1_1 : in st_enum1
      ; g_integer_1 : in integer
      ; g_st_int1_1 : in st_int1
      ; g_time_1 : in time
      ; g_st_phys1_1 : in st_phys1
      ; g_real_1 : in real
      ; g_st_real1_1 : in st_real1
      ; g_st_rec1_1 : in st_rec1
      ; g_st_rec2_1 : in st_rec2
      ; g_st_rec3_1 : in st_rec3
      ; g_st_arr1_1 : in st_arr1
      ; g_st_arr2_1 : in st_arr2
      ; g_st_arr3_1 : in st_arr3
           );
end ENT00511;
--
--
architecture ARCH00511 of ENT00511 is
   signal S_boolean : boolean := g_boolean_1 ;
--
   signal S_bit : bit := g_bit_1 ;
--
   signal S_severity_level : severity_level := g_severity_level_1 ;
--
   signal S_character : character := g_character_1 ;
--
   signal S_st_enum1 : st_enum1 := g_st_enum1_1 ;
--
   signal S_integer : integer := g_integer_1 ;
--
   signal S_st_int1 : st_int1 := g_st_int1_1 ;
--
   signal S_time : time := g_time_1 ;
--
   signal S_st_phys1 : st_phys1 := g_st_phys1_1 ;
--
   signal S_real : real := g_real_1 ;
--
   signal S_st_real1 : st_real1 := g_st_real1_1 ;
--
   signal S_st_rec1 : st_rec1 := g_st_rec1_1 ;
--
   signal S_st_rec2 : st_rec2 := g_st_rec2_1 ;
--
   signal S_st_rec3 : st_rec3 := g_st_rec3_1 ;
--
   signal S_st_arr1 : st_arr1 := g_st_arr1_1 ;
--
   signal S_st_arr2 : st_arr2 := g_st_arr2_1 ;
--
   signal S_st_arr3 : st_arr3 := g_st_arr3_1 ;
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
      test_report ( "ARCH00511" ,
                    "The expression in an initialization specification "&
                    "may be globally static" ,
                    correct );
      wait ;
   end process ;
end ARCH00511 ;
--
--
entity ENT00511_Test_Bench is
end ENT00511_Test_Bench ;
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00511_Test_Bench of ENT00511_Test_Bench is
begin
   L1:
   block
      component UUT
         generic (
              g_boolean_1 : in boolean
            ; g_bit_1 : in bit
            ; g_severity_level_1 : in severity_level
            ; g_character_1 : in character
            ; g_st_enum1_1 : in st_enum1
            ; g_integer_1 : in integer
            ; g_st_int1_1 : in st_int1
            ; g_time_1 : in time
            ; g_st_phys1_1 : in st_phys1
            ; g_real_1 : in real
            ; g_st_real1_1 : in st_real1
            ; g_st_rec1_1 : in st_rec1
            ; g_st_rec2_1 : in st_rec2
            ; g_st_rec3_1 : in st_rec3
            ; g_st_arr1_1 : in st_arr1
            ; g_st_arr2_1 : in st_arr2
            ; g_st_arr3_1 : in st_arr3
           ) ;
      end component ;
      for CIS1 : UUT use entity WORK.ENT00511 ( ARCH00511 ) ;
   begin
      CIS1 : UUT
         generic map (
              c_boolean_1
            , c_bit_1
            , c_severity_level_1
            , c_character_1
            , c_st_enum1_1
            , c_integer_1
            , c_st_int1_1
            , c_time_1
            , c_st_phys1_1
            , c_real_1
            , c_st_real1_1
            , c_st_rec1_1
            , c_st_rec2_1
            , c_st_rec3_1
            , c_st_arr1_1
            , c_st_arr2_1
            , c_st_arr3_1
                     )
             ;
   end block L1 ;
end ARCH00511_Test_Bench ;
