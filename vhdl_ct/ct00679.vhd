-- NEED RESULT: ARCH00679: Type conversion from one to type to same type passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00679
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.3.5 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00679)
--    ENT00679_Test_Bench(ARCH00679_Test_Bench)
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
architecture ARCH00679 of E00000 is
begin
   process
      variable correct : boolean := true ;
   begin
         correct := correct and
                     boolean ( c_boolean_1 ) = c_boolean_1 ;
         correct := correct and
                     bit ( c_bit_1 ) = c_bit_1 ;
         correct := correct and
                     severity_level ( c_severity_level_1 ) = c_severity_level_1
;
         correct := correct and
                     character ( c_character_1 ) = c_character_1 ;
         correct := correct and
                     t_enum1 ( c_t_enum1_1 ) = c_t_enum1_1 ;
         correct := correct and
                     st_enum1 ( c_st_enum1_1 ) = c_st_enum1_1 ;
         correct := correct and
                     integer ( c_integer_1 ) = c_integer_1 ;
         correct := correct and
                     t_int1 ( c_t_int1_1 ) = c_t_int1_1 ;
         correct := correct and
                     st_int1 ( c_st_int1_1 ) = c_st_int1_1 ;
         correct := correct and
                     time ( c_time_1 ) = c_time_1 ;
         correct := correct and
                     t_phys1 ( c_t_phys1_1 ) = c_t_phys1_1 ;
         correct := correct and
                     st_phys1 ( c_st_phys1_1 ) = c_st_phys1_1 ;
         correct := correct and
                     real ( c_real_1 ) = c_real_1 ;
         correct := correct and
                     t_real1 ( c_t_real1_1 ) = c_t_real1_1 ;
         correct := correct and
                     st_real1 ( c_st_real1_1 ) = c_st_real1_1 ;
         correct := correct and
                     bit_vector ( c_st_bit_vector_1 ) = c_st_bit_vector_1 ;
         correct := correct and
                     string ( c_st_string_1 ) = c_st_string_1 ;
         correct := correct and
                     t_rec1 ( c_st_rec1_1 ) = c_st_rec1_1 ;
         correct := correct and
                     st_rec1 ( c_st_rec1_1 ) = c_st_rec1_1 ;
         correct := correct and
                     t_rec2 ( c_st_rec2_1 ) = c_st_rec2_1 ;
         correct := correct and
                     st_rec2 ( c_st_rec2_1 ) = c_st_rec2_1 ;
         correct := correct and
                     t_rec3 ( c_st_rec3_1 ) = c_st_rec3_1 ;
         correct := correct and
                     st_rec3 ( c_st_rec3_1 ) = c_st_rec3_1 ;
         correct := correct and
                     t_arr1 ( c_st_arr1_1 ) = c_st_arr1_1 ;
         correct := correct and
                     st_arr1 ( c_st_arr1_1 ) = c_st_arr1_1 ;
         correct := correct and
                     t_arr2 ( c_st_arr2_1 ) = c_st_arr2_1 ;
         correct := correct and
                     st_arr2 ( c_st_arr2_1 ) = c_st_arr2_1 ;
         correct := correct and
                     t_arr3 ( c_st_arr3_1 ) = c_st_arr3_1 ;
         correct := correct and
                     st_arr3 ( c_st_arr3_1 ) = c_st_arr3_1 ;
      test_report ( "ARCH00679" ,
      "Type conversion from one to type to same type",
      correct) ;
      wait ;
   end process ;
end ARCH00679 ;
--
entity ENT00679_Test_Bench is
end ENT00679_Test_Bench ;
--
architecture ARCH00679_Test_Bench of ENT00679_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00679 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00679_Test_Bench ;
