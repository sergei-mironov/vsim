-- NEED RESULT: ARCH00671: Signal default initial values - static subtypes passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00671
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.1.2 (2)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00671)
--    ENT00671_Test_Bench(ARCH00671_Test_Bench)
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
architecture ARCH00671 of E00000 is
   signal si_boolean_1 : boolean ;
   signal si_boolean_2 : boolean
        := d_boolean ;
   signal si_bit_1 : bit ;
   signal si_bit_2 : bit
        := d_bit ;
   signal si_severity_level_1 : severity_level ;
   signal si_severity_level_2 : severity_level
        := d_severity_level ;
   signal si_character_1 : character ;
   signal si_character_2 : character
        := d_character ;
   signal si_t_enum1_1 : t_enum1 ;
   signal si_t_enum1_2 : t_enum1
        := d_t_enum1 ;
   signal si_st_enum1_1 : st_enum1 ;
   signal si_st_enum1_2 : st_enum1
        := d_st_enum1 ;
   signal si_integer_1 : integer ;
   signal si_integer_2 : integer
        := d_integer ;
   signal si_t_int1_1 : t_int1 ;
   signal si_t_int1_2 : t_int1
        := d_t_int1 ;
   signal si_st_int1_1 : st_int1 ;
   signal si_st_int1_2 : st_int1
        := d_st_int1 ;
   signal si_time_1 : time ;
   signal si_time_2 : time
        := d_time ;
   signal si_t_phys1_1 : t_phys1 ;
   signal si_t_phys1_2 : t_phys1
        := d_t_phys1 ;
   signal si_st_phys1_1 : st_phys1 ;
   signal si_st_phys1_2 : st_phys1
        := d_st_phys1 ;
   signal si_real_1 : real ;
   signal si_real_2 : real
        := d_real ;
   signal si_t_real1_1 : t_real1 ;
   signal si_t_real1_2 : t_real1
        := d_t_real1 ;
   signal si_st_real1_1 : st_real1 ;
   signal si_st_real1_2 : st_real1
        := d_st_real1 ;
   signal si_st_bit_vector_1 : st_bit_vector ;
   signal si_st_bit_vector_2 : st_bit_vector
        := d_st_bit_vector ;
   signal si_st_string_1 : st_string ;
   signal si_st_string_2 : st_string
        := d_st_string ;
   signal si_t_rec1_1 : t_rec1 ;
   signal si_t_rec1_2 : t_rec1
        := d_t_rec1 ;
   signal si_st_rec1_1 : st_rec1 ;
   signal si_st_rec1_2 : st_rec1
        := d_st_rec1 ;
   signal si_t_rec2_1 : t_rec2 ;
   signal si_t_rec2_2 : t_rec2
        := d_t_rec2 ;
   signal si_st_rec2_1 : st_rec2 ;
   signal si_st_rec2_2 : st_rec2
        := d_st_rec2 ;
   signal si_t_rec3_1 : t_rec3 ;
   signal si_t_rec3_2 : t_rec3
        := d_t_rec3 ;
   signal si_st_rec3_1 : st_rec3 ;
   signal si_st_rec3_2 : st_rec3
        := d_st_rec3 ;
   signal si_st_arr1_1 : st_arr1 ;
   signal si_st_arr1_2 : st_arr1
        := d_st_arr1 ;
   signal si_st_arr2_1 : st_arr2 ;
   signal si_st_arr2_2 : st_arr2
        := d_st_arr2 ;
   signal si_st_arr3_1 : st_arr3 ;
   signal si_st_arr3_2 : st_arr3
        := d_st_arr3 ;
begin
   process
      variable correct : boolean := true ;
   begin
      correct := correct and
                  si_boolean_1 = si_boolean_2 and
                  si_boolean_2 = d_boolean ;
      correct := correct and
                  si_bit_1 = si_bit_2 and
                  si_bit_2 = d_bit ;
      correct := correct and
                  si_severity_level_1 = si_severity_level_2 and
                  si_severity_level_2 = d_severity_level ;
      correct := correct and
                  si_character_1 = si_character_2 and
                  si_character_2 = d_character ;
      correct := correct and
                  si_t_enum1_1 = si_t_enum1_2 and
                  si_t_enum1_2 = d_t_enum1 ;
      correct := correct and
                  si_st_enum1_1 = si_st_enum1_2 and
                  si_st_enum1_2 = d_st_enum1 ;
      correct := correct and
                  si_integer_1 = si_integer_2 and
                  si_integer_2 = d_integer ;
      correct := correct and
                  si_t_int1_1 = si_t_int1_2 and
                  si_t_int1_2 = d_t_int1 ;
      correct := correct and
                  si_st_int1_1 = si_st_int1_2 and
                  si_st_int1_2 = d_st_int1 ;
      correct := correct and
                  si_time_1 = si_time_2 and
                  si_time_2 = d_time ;
      correct := correct and
                  si_t_phys1_1 = si_t_phys1_2 and
                  si_t_phys1_2 = d_t_phys1 ;
      correct := correct and
                  si_st_phys1_1 = si_st_phys1_2 and
                  si_st_phys1_2 = d_st_phys1 ;
      correct := correct and
                  si_real_1 = si_real_2 and
                  si_real_2 = d_real ;
      correct := correct and
                  si_t_real1_1 = si_t_real1_2 and
                  si_t_real1_2 = d_t_real1 ;
      correct := correct and
                  si_st_real1_1 = si_st_real1_2 and
                  si_st_real1_2 = d_st_real1 ;
      correct := correct and
                  si_st_bit_vector_1 = si_st_bit_vector_2 and
                  si_st_bit_vector_2 = d_st_bit_vector ;
      correct := correct and
                  si_st_string_1 = si_st_string_2 and
                  si_st_string_2 = d_st_string ;
      correct := correct and
                  si_t_rec1_1 = si_t_rec1_2 and
                  si_t_rec1_2 = d_t_rec1 ;
      correct := correct and
                  si_st_rec1_1 = si_st_rec1_2 and
                  si_st_rec1_2 = d_st_rec1 ;
      correct := correct and
                  si_t_rec2_1 = si_t_rec2_2 and
                  si_t_rec2_2 = d_t_rec2 ;
      correct := correct and
                  si_st_rec2_1 = si_st_rec2_2 and
                  si_st_rec2_2 = d_st_rec2 ;
      correct := correct and
                  si_t_rec3_1 = si_t_rec3_2 and
                  si_t_rec3_2 = d_t_rec3 ;
      correct := correct and
                  si_st_rec3_1 = si_st_rec3_2 and
                  si_st_rec3_2 = d_st_rec3 ;
      correct := correct and
                  si_st_arr1_1 = si_st_arr1_2 and
                  si_st_arr1_2 = d_st_arr1 ;
      correct := correct and
                  si_st_arr2_1 = si_st_arr2_2 and
                  si_st_arr2_2 = d_st_arr2 ;
      correct := correct and
                  si_st_arr3_1 = si_st_arr3_2 and
                  si_st_arr3_2 = d_st_arr3 ;
      test_report ( "ARCH00671" ,
      "Signal default initial values - static subtypes" ,
      correct) ;
      wait ;
   end process ;
end ARCH00671 ;
--
entity ENT00671_Test_Bench is
end ENT00671_Test_Bench ;
--
architecture ARCH00671_Test_Bench of ENT00671_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00671 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00671_Test_Bench ;
