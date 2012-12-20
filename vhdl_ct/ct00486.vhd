-- NEED RESULT: ARCH00486: The expression in an attribute specification may be globally static passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00486
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    5.1 (9)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00486(ARCH00486)
--    ENT00486_Test_Bench(ARCH00486_Test_Bench)
--
-- REVISION HISTORY:
--
--    07-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
entity ENT00486 is
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
end ENT00486;
--
--
architecture ARCH00486 of ENT00486 is
   signal S : Integer := 0 ;
   attribute A_boolean : boolean ;
   attribute A_boolean of S : signal is g_boolean_1 ;
--
   attribute A_bit : bit ;
   attribute A_bit of S : signal is g_bit_1 ;
--
   attribute A_severity_level : severity_level ;
   attribute A_severity_level of S : signal is g_severity_level_1 ;
--
   attribute A_character : character ;
   attribute A_character of S : signal is g_character_1 ;
--
   attribute A_st_enum1 : st_enum1 ;
   attribute A_st_enum1 of S : signal is g_st_enum1_1 ;
--
   attribute A_integer : integer ;
   attribute A_integer of S : signal is g_integer_1 ;
--
   attribute A_st_int1 : st_int1 ;
   attribute A_st_int1 of S : signal is g_st_int1_1 ;
--
   attribute A_time : time ;
   attribute A_time of S : signal is g_time_1 ;
--
   attribute A_st_phys1 : st_phys1 ;
   attribute A_st_phys1 of S : signal is g_st_phys1_1 ;
--
   attribute A_real : real ;
   attribute A_real of S : signal is g_real_1 ;
--
   attribute A_st_real1 : st_real1 ;
   attribute A_st_real1 of S : signal is g_st_real1_1 ;
--
   attribute A_st_rec1 : st_rec1 ;
   attribute A_st_rec1 of S : signal is g_st_rec1_1 ;
--
   attribute A_st_rec2 : st_rec2 ;
   attribute A_st_rec2 of S : signal is g_st_rec2_1 ;
--
   attribute A_st_rec3 : st_rec3 ;
   attribute A_st_rec3 of S : signal is g_st_rec3_1 ;
--
   attribute A_st_arr1 : st_arr1 ;
   attribute A_st_arr1 of S : signal is g_st_arr1_1 ;
--
   attribute A_st_arr2 : st_arr2 ;
   attribute A_st_arr2 of S : signal is g_st_arr2_1 ;
--
   attribute A_st_arr3 : st_arr3 ;
   attribute A_st_arr3 of S : signal is g_st_arr3_1 ;
--
--
begin
   process
      variable correct : boolean := true;
   begin
      correct := correct and
                 (S'A_boolean = c_boolean_1) ;
      correct := correct and
                 (S'A_bit = c_bit_1) ;
      correct := correct and
                 (S'A_severity_level = c_severity_level_1) ;
      correct := correct and
                 (S'A_character = c_character_1) ;
      correct := correct and
                 (S'A_st_enum1 = c_st_enum1_1) ;
      correct := correct and
                 (S'A_integer = c_integer_1) ;
      correct := correct and
                 (S'A_st_int1 = c_st_int1_1) ;
      correct := correct and
                 (S'A_time = c_time_1) ;
      correct := correct and
                 (S'A_st_phys1 = c_st_phys1_1) ;
      correct := correct and
                 (S'A_real = c_real_1) ;
      correct := correct and
                 (S'A_st_real1 = c_st_real1_1) ;
      correct := correct and
                 (S'A_st_rec1 = c_st_rec1_1) ;
      correct := correct and
                 (S'A_st_rec2 = c_st_rec2_1) ;
      correct := correct and
                 (S'A_st_rec3 = c_st_rec3_1) ;
      correct := correct and
                 (S'A_st_arr1 = c_st_arr1_1) ;
      correct := correct and
                 (S'A_st_arr2 = c_st_arr2_1) ;
      correct := correct and
                 (S'A_st_arr3 = c_st_arr3_1) ;
      test_report ( "ARCH00486" ,
                    "The expression in an attribute specification "&
                    "may be globally static" ,
                    correct );
      wait ;
   end process ;
end ARCH00486 ;
--
--
entity ENT00486_Test_Bench is
end ENT00486_Test_Bench ;
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00486_Test_Bench of ENT00486_Test_Bench is
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
      for CIS1 : UUT use entity WORK.ENT00486 ( ARCH00486 ) ;
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
end ARCH00486_Test_Bench ;
