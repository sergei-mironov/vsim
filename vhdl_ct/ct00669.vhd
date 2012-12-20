-- NEED RESULT: ARCH00669: Variable default initial values - generic subtypes passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00669
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.1.3 (1)
--    4.3.1.3 (2)
--    4.3.1.3 (3)
--    4.3.1.3 (4)
--
-- DESIGN UNIT ORDERING:
--
--    GENERIC_STANDARD_TYPES(ARCH00669)
--    ENT00669_Test_Bench(ARCH00669_Test_Bench)
--
-- REVISION HISTORY:
--
--    01-SEP-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
--
architecture ARCH00669 of GENERIC_STANDARD_TYPES is
begin
   process
      variable correct : boolean := true ;
      variable va_boolean_1 : boolean ;
      variable va_boolean_2 : boolean
           := d_boolean ;
      variable va_bit_1 : bit ;
      variable va_bit_2 : bit
           := d_bit ;
      variable va_severity_level_1 : severity_level ;
      variable va_severity_level_2 : severity_level
           := d_severity_level ;
      variable va_character_1 : character ;
      variable va_character_2 : character
           := d_character ;
      variable va_t_enum1_1 : t_enum1 ;
      variable va_t_enum1_2 : t_enum1
           := d_t_enum1 ;
      variable va_st_enum1_1 : st_enum1 ;
      variable va_st_enum1_2 : st_enum1
           := d_st_enum1 ;
      variable va_integer_1 : integer ;
      variable va_integer_2 : integer
           := d_integer ;
      variable va_t_int1_1 : t_int1 ;
      variable va_t_int1_2 : t_int1
           := d_t_int1 ;
      variable va_st_int1_1 : st_int1 ;
      variable va_st_int1_2 : st_int1
           := d_st_int1 ;
      variable va_time_1 : time ;
      variable va_time_2 : time
           := d_time ;
      variable va_t_phys1_1 : t_phys1 ;
      variable va_t_phys1_2 : t_phys1
           := d_t_phys1 ;
      variable va_st_phys1_1 : st_phys1 ;
      variable va_st_phys1_2 : st_phys1
           := d_st_phys1 ;
      variable va_real_1 : real ;
      variable va_real_2 : real
           := d_real ;
      variable va_t_real1_1 : t_real1 ;
      variable va_t_real1_2 : t_real1
           := d_t_real1 ;
      variable va_st_real1_1 : st_real1 ;
      variable va_st_real1_2 : st_real1
           := d_st_real1 ;
      variable va_st_bit_vector_1 : st_bit_vector ;
      variable va_st_bit_vector_2 : st_bit_vector
           := d_st_bit_vector ;
      variable va_st_string_1 : st_string ;
      variable va_st_string_2 : st_string
           := d_st_string ;
      variable va_t_rec1_1 : t_rec1 ;
      variable va_t_rec1_2 : t_rec1
           := d_t_rec1 ;
      variable va_st_rec1_1 : st_rec1 ;
      variable va_st_rec1_2 : st_rec1
           := d_st_rec1 ;
      variable va_t_rec2_1 : t_rec2 ;
      variable va_t_rec2_2 : t_rec2
           := d_t_rec2 ;
      variable va_st_rec2_1 : st_rec2 ;
      variable va_st_rec2_2 : st_rec2
           := d_st_rec2 ;
      variable va_t_rec3_1 : t_rec3 ;
      variable va_t_rec3_2 : t_rec3
           := d_t_rec3 ;
      variable va_st_rec3_1 : st_rec3 ;
      variable va_st_rec3_2 : st_rec3
           := d_st_rec3 ;
      variable va_st_arr1_1 : st_arr1 ;
      variable va_st_arr1_2 : st_arr1
           := d_st_arr1 ;
      variable va_st_arr2_1 : st_arr2 ;
      variable va_st_arr2_2 : st_arr2
           := d_st_arr2 ;
      variable va_st_arr3_1 : st_arr3 ;
      variable va_st_arr3_2 : st_arr3
           := d_st_arr3 ;
   begin
      correct := correct and
                  va_boolean_1 = va_boolean_2 and
                  va_boolean_2 = d_boolean ;
      correct := correct and
                  va_bit_1 = va_bit_2 and
                  va_bit_2 = d_bit ;
      correct := correct and
                  va_severity_level_1 = va_severity_level_2 and
                  va_severity_level_2 = d_severity_level ;
      correct := correct and
                  va_character_1 = va_character_2 and
                  va_character_2 = d_character ;
      correct := correct and
                  va_t_enum1_1 = va_t_enum1_2 and
                  va_t_enum1_2 = d_t_enum1 ;
      correct := correct and
                  va_st_enum1_1 = va_st_enum1_2 and
                  va_st_enum1_2 = d_st_enum1 ;
      correct := correct and
                  va_integer_1 = va_integer_2 and
                  va_integer_2 = d_integer ;
      correct := correct and
                  va_t_int1_1 = va_t_int1_2 and
                  va_t_int1_2 = d_t_int1 ;
      correct := correct and
                  va_st_int1_1 = va_st_int1_2 and
                  va_st_int1_2 = d_st_int1 ;
      correct := correct and
                  va_time_1 = va_time_2 and
                  va_time_2 = d_time ;
      correct := correct and
                  va_t_phys1_1 = va_t_phys1_2 and
                  va_t_phys1_2 = d_t_phys1 ;
      correct := correct and
                  va_st_phys1_1 = va_st_phys1_2 and
                  va_st_phys1_2 = d_st_phys1 ;
      correct := correct and
                  va_real_1 = va_real_2 and
                  va_real_2 = d_real ;
      correct := correct and
                  va_t_real1_1 = va_t_real1_2 and
                  va_t_real1_2 = d_t_real1 ;
      correct := correct and
                  va_st_real1_1 = va_st_real1_2 and
                  va_st_real1_2 = d_st_real1 ;
      correct := correct and
                  va_st_bit_vector_1 = va_st_bit_vector_2 and
                  va_st_bit_vector_2 = d_st_bit_vector ;
      correct := correct and
                  va_st_string_1 = va_st_string_2 and
                  va_st_string_2 = d_st_string ;
      correct := correct and
                  va_t_rec1_1 = va_t_rec1_2 and
                  va_t_rec1_2 = d_t_rec1 ;
      correct := correct and
                  va_st_rec1_1 = va_st_rec1_2 and
                  va_st_rec1_2 = d_st_rec1 ;
      correct := correct and
                  va_t_rec2_1 = va_t_rec2_2 and
                  va_t_rec2_2 = d_t_rec2 ;
      correct := correct and
                  va_st_rec2_1 = va_st_rec2_2 and
                  va_st_rec2_2 = d_st_rec2 ;
      correct := correct and
                  va_t_rec3_1 = va_t_rec3_2 and
                  va_t_rec3_2 = d_t_rec3 ;
      correct := correct and
                  va_st_rec3_1 = va_st_rec3_2 and
                  va_st_rec3_2 = d_st_rec3 ;
      correct := correct and
                  va_st_arr1_1 = va_st_arr1_2 and
                  va_st_arr1_2 = d_st_arr1 ;
      correct := correct and
                  va_st_arr2_1 = va_st_arr2_2 and
                  va_st_arr2_2 = d_st_arr2 ;
      correct := correct and
                  va_st_arr3_1 = va_st_arr3_2 and
                  va_st_arr3_2 = d_st_arr3 ;
      test_report ( "ARCH00669" ,
      "Variable default initial values - generic subtypes" ,
      correct) ;
      wait ;
   end process ;
end ARCH00669 ;
--
entity ENT00669_Test_Bench is
end ENT00669_Test_Bench ;
--
architecture ARCH00669_Test_Bench of ENT00669_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.GENERIC_STANDARD_TYPES ( ARCH00669 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00669_Test_Bench ;
