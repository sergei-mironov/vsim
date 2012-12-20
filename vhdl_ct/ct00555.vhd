-- NEED RESULT: ARCH00555: Signal declarations - composite globally static subtypes passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00555
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.1.2 (10)
--
-- DESIGN UNIT ORDERING:
--
--    GENERIC_STANDARD_TYPES(ARCH00555)
--    ENT00555_Test_Bench(ARCH00555_Test_Bench)
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
architecture ARCH00555 of GENERIC_STANDARD_TYPES is
   signal si_st_bit_vector_1 : st_bit_vector
        := c_st_bit_vector_1 ;
   signal si_st_string_1 : st_string
        := c_st_string_1 ;
   signal si_st_rec1_1 : st_rec1
        := c_st_rec1_1 ;
   signal si_st_rec2_1 : st_rec2
        := c_st_rec2_1 ;
   signal si_st_rec3_1 : st_rec3
        := c_st_rec3_1 ;
   signal si_st_arr1_1 : st_arr1
        := c_st_arr1_1 ;
   signal si_st_arr2_1 : st_arr2
        := c_st_arr2_1 ;
   signal si_st_arr3_1 : st_arr3
        := c_st_arr3_1 ;
   signal synch : boolean := false ;
   signal s_correct : boolean := true ;
begin
   process
      variable correct : boolean := true ;
   begin
      correct := correct and si_st_bit_vector_1 = c_st_bit_vector_1 ;
      correct := correct and si_st_string_1 = c_st_string_1 ;
      correct := correct and si_st_rec1_1 = c_st_rec1_1 ;
      correct := correct and si_st_rec2_1 = c_st_rec2_1 ;
      correct := correct and si_st_rec3_1 = c_st_rec3_1 ;
      correct := correct and si_st_arr1_1 = c_st_arr1_1 ;
      correct := correct and si_st_arr2_1 = c_st_arr2_1 ;
      correct := correct and si_st_arr3_1 = c_st_arr3_1 ;
      si_st_bit_vector_1 <= c_st_bit_vector_2 ;
      si_st_string_1 <= c_st_string_2 ;
      si_st_rec1_1 <= c_st_rec1_2 ;
      si_st_rec2_1 <= c_st_rec2_2 ;
      si_st_rec3_1 <= c_st_rec3_2 ;
      si_st_arr1_1 <= c_st_arr1_2 ;
      si_st_arr2_1 <= c_st_arr2_2 ;
      si_st_arr3_1 <= c_st_arr3_2 ;
      synch <= true ;
      s_correct <= s_correct and correct ;
      wait ;
   end process ;
   process (synch)
      variable correct : boolean ;
   begin
      correct := s_correct ;
      if synch = true then
         correct := correct and si_st_bit_vector_1 = c_st_bit_vector_2 ;
         correct := correct and si_st_string_1 = c_st_string_2 ;
         correct := correct and si_st_rec1_1 = c_st_rec1_2 ;
         correct := correct and si_st_rec2_1 = c_st_rec2_2 ;
         correct := correct and si_st_rec3_1 = c_st_rec3_2 ;
         correct := correct and si_st_arr1_1 = c_st_arr1_2 ;
         correct := correct and si_st_arr2_1 = c_st_arr2_2 ;
         correct := correct and si_st_arr3_1 = c_st_arr3_2 ;
         test_report ( "ARCH00555" ,
        "Signal declarations - composite globally static subtypes" ,
         correct) ;
      end if ;
   end process ;
end ARCH00555 ;
--
entity ENT00555_Test_Bench is
end ENT00555_Test_Bench ;
--
architecture ARCH00555_Test_Bench of ENT00555_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.GENERIC_STANDARD_TYPES ( ARCH00555 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00555_Test_Bench ;
