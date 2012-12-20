-- NEED RESULT: ARCH00558: Variable declarations - composite static subtypes passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00558
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.1.3 (10)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00558)
--    ENT00558_Test_Bench(ARCH00558_Test_Bench)
--
-- REVISION HISTORY:
--
--    19-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00558 of E00000 is
begin
   process
      variable correct : boolean := true ;
      variable va_st_bit_vector_1 : st_bit_vector
           := c_st_bit_vector_1 ;
      variable va_st_string_1 : st_string
           := c_st_string_1 ;
      variable va_st_rec1_1 : st_rec1
           := c_st_rec1_1 ;
      variable va_st_rec2_1 : st_rec2
           := c_st_rec2_1 ;
      variable va_st_rec3_1 : st_rec3
           := c_st_rec3_1 ;
      variable va_st_arr1_1 : st_arr1
           := c_st_arr1_1 ;
      variable va_st_arr2_1 : st_arr2
           := c_st_arr2_1 ;
      variable va_st_arr3_1 : st_arr3
           := c_st_arr3_1 ;
   begin
      correct := correct and va_st_bit_vector_1 = c_st_bit_vector_1 ;
      correct := correct and va_st_string_1 = c_st_string_1 ;
      correct := correct and va_st_rec1_1 = c_st_rec1_1 ;
      correct := correct and va_st_rec2_1 = c_st_rec2_1 ;
      correct := correct and va_st_rec3_1 = c_st_rec3_1 ;
      correct := correct and va_st_arr1_1 = c_st_arr1_1 ;
      correct := correct and va_st_arr2_1 = c_st_arr2_1 ;
      correct := correct and va_st_arr3_1 = c_st_arr3_1 ;
      va_st_bit_vector_1 := c_st_bit_vector_2 ;
      va_st_string_1 := c_st_string_2 ;
      va_st_rec1_1 := c_st_rec1_2 ;
      va_st_rec2_1 := c_st_rec2_2 ;
      va_st_rec3_1 := c_st_rec3_2 ;
      va_st_arr1_1 := c_st_arr1_2 ;
      va_st_arr2_1 := c_st_arr2_2 ;
      va_st_arr3_1 := c_st_arr3_2 ;
      correct := correct and va_st_bit_vector_1 = c_st_bit_vector_2 ;
      correct := correct and va_st_string_1 = c_st_string_2 ;
      correct := correct and va_st_rec1_1 = c_st_rec1_2 ;
      correct := correct and va_st_rec2_1 = c_st_rec2_2 ;
      correct := correct and va_st_rec3_1 = c_st_rec3_2 ;
      correct := correct and va_st_arr1_1 = c_st_arr1_2 ;
      correct := correct and va_st_arr2_1 = c_st_arr2_2 ;
      correct := correct and va_st_arr3_1 = c_st_arr3_2 ;
      test_report ( "ARCH00558" ,
      "Variable declarations - composite static subtypes" ,
      correct) ;
      wait ;
   end process ;
end ARCH00558 ;
--
entity ENT00558_Test_Bench is
end ENT00558_Test_Bench ;
--
architecture ARCH00558_Test_Bench of ENT00558_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00558 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00558_Test_Bench ;
