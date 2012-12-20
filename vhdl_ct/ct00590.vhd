-- NEED RESULT: ARCH00590: Variable declarations - composite globally static access subtypes passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00590
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.1.3 (11)
--
-- DESIGN UNIT ORDERING:
--
--    GENERIC_STANDARD_TYPES(ARCH00590)
--    ENT00590_Test_Bench(ARCH00590_Test_Bench)
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
architecture ARCH00590 of GENERIC_STANDARD_TYPES is
begin
   process
      variable correct : boolean := true ;
      type a_bit_vector is access bit_vector ;
      variable av_bit_vector_1, av_bit_vector_2 : a_bit_vector
                        := new st_bit_vector ;
      type a_string is access string ;
      variable av_string_1, av_string_2 : a_string
                        := new st_string ;
      type a_t_rec1 is access t_rec1 ;
      variable av_t_rec1_1, av_t_rec1_2 : a_t_rec1
                        := new st_rec1 ;
      type a_st_rec1 is access st_rec1 ;
      variable av_st_rec1_1, av_st_rec1_2 : a_st_rec1
                        := new st_rec1 ;
      type a_t_rec2 is access t_rec2 ;
      variable av_t_rec2_1, av_t_rec2_2 : a_t_rec2
                        := new st_rec2 ;
      type a_st_rec2 is access st_rec2 ;
      variable av_st_rec2_1, av_st_rec2_2 : a_st_rec2
                        := new st_rec2 ;
      type a_t_rec3 is access t_rec3 ;
      variable av_t_rec3_1, av_t_rec3_2 : a_t_rec3
                        := new st_rec3 ;
      type a_st_rec3 is access st_rec3 ;
      variable av_st_rec3_1, av_st_rec3_2 : a_st_rec3
                        := new st_rec3 ;
      type a_t_arr1 is access t_arr1 ;
      variable av_t_arr1_1, av_t_arr1_2 : a_t_arr1
                        := new st_arr1 ;
      type a_st_arr1 is access st_arr1 ;
      variable av_st_arr1_1, av_st_arr1_2 : a_st_arr1
                        := new st_arr1 ;
      type a_t_arr2 is access t_arr2 ;
      variable av_t_arr2_1, av_t_arr2_2 : a_t_arr2
                        := new st_arr2 ;
      type a_st_arr2 is access st_arr2 ;
      variable av_st_arr2_1, av_st_arr2_2 : a_st_arr2
                        := new st_arr2 ;
      type a_t_arr3 is access t_arr3 ;
      variable av_t_arr3_1, av_t_arr3_2 : a_t_arr3
                        := new st_arr3 ;
      type a_st_arr3 is access st_arr3 ;
      variable av_st_arr3_1, av_st_arr3_2 : a_st_arr3
                        := new st_arr3 ;
   begin
      av_bit_vector_1 := new st_bit_vector'(c_st_bit_vector_1) ;
      av_string_1 := new st_string'(c_st_string_1) ;
      av_t_rec1_1 := new st_rec1'(c_st_rec1_1) ;
      av_st_rec1_1 := new st_rec1'(c_st_rec1_1) ;
      av_t_rec2_1 := new st_rec2'(c_st_rec2_1) ;
      av_st_rec2_1 := new st_rec2'(c_st_rec2_1) ;
      av_t_rec3_1 := new st_rec3'(c_st_rec3_1) ;
      av_st_rec3_1 := new st_rec3'(c_st_rec3_1) ;
      av_t_arr1_1 := new st_arr1'(c_st_arr1_1) ;
      av_st_arr1_1 := new st_arr1'(c_st_arr1_1) ;
      av_t_arr2_1 := new st_arr2'(c_st_arr2_1) ;
      av_st_arr2_1 := new st_arr2'(c_st_arr2_1) ;
      av_t_arr3_1 := new st_arr3'(c_st_arr3_1) ;
      av_st_arr3_1 := new st_arr3'(c_st_arr3_1) ;
      correct := correct and av_bit_vector_1.all
        = c_st_bit_vector_1 ;
      correct := correct and av_string_1.all
        = c_st_string_1 ;
      correct := correct and av_t_rec1_1.all
        = c_st_rec1_1 ;
      correct := correct and av_st_rec1_1.all
        = c_st_rec1_1 ;
      correct := correct and av_t_rec2_1.all
        = c_st_rec2_1 ;
      correct := correct and av_st_rec2_1.all
        = c_st_rec2_1 ;
      correct := correct and av_t_rec3_1.all
        = c_st_rec3_1 ;
      correct := correct and av_st_rec3_1.all
        = c_st_rec3_1 ;
      correct := correct and av_t_arr1_1.all
        = c_st_arr1_1 ;
      correct := correct and av_st_arr1_1.all
        = c_st_arr1_1 ;
      correct := correct and av_t_arr2_1.all
        = c_st_arr2_1 ;
      correct := correct and av_st_arr2_1.all
        = c_st_arr2_1 ;
      correct := correct and av_t_arr3_1.all
        = c_st_arr3_1 ;
      correct := correct and av_st_arr3_1.all
        = c_st_arr3_1 ;
      av_bit_vector_1.all := c_st_bit_vector_2 ;
      av_string_1.all := c_st_string_2 ;
      av_t_rec1_1.all := c_st_rec1_2 ;
      av_st_rec1_1.all := c_st_rec1_2 ;
      av_t_rec2_1.all := c_st_rec2_2 ;
      av_st_rec2_1.all := c_st_rec2_2 ;
      av_t_rec3_1.all := c_st_rec3_2 ;
      av_st_rec3_1.all := c_st_rec3_2 ;
      av_t_arr1_1.all := c_st_arr1_2 ;
      av_st_arr1_1.all := c_st_arr1_2 ;
      av_t_arr2_1.all := c_st_arr2_2 ;
      av_st_arr2_1.all := c_st_arr2_2 ;
      av_t_arr3_1.all := c_st_arr3_2 ;
      av_st_arr3_1.all := c_st_arr3_2 ;
      correct := correct and av_bit_vector_1.all
        = c_st_bit_vector_2 ;
      correct := correct and av_string_1.all
        = c_st_string_2 ;
      correct := correct and av_t_rec1_1.all
        = c_st_rec1_2 ;
      correct := correct and av_st_rec1_1.all
        = c_st_rec1_2 ;
      correct := correct and av_t_rec2_1.all
        = c_st_rec2_2 ;
      correct := correct and av_st_rec2_1.all
        = c_st_rec2_2 ;
      correct := correct and av_t_rec3_1.all
        = c_st_rec3_2 ;
      correct := correct and av_st_rec3_1.all
        = c_st_rec3_2 ;
      correct := correct and av_t_arr1_1.all
        = c_st_arr1_2 ;
      correct := correct and av_st_arr1_1.all
        = c_st_arr1_2 ;
      correct := correct and av_t_arr2_1.all
        = c_st_arr2_2 ;
      correct := correct and av_st_arr2_1.all
        = c_st_arr2_2 ;
      correct := correct and av_t_arr3_1.all
        = c_st_arr3_2 ;
      correct := correct and av_st_arr3_1.all
        = c_st_arr3_2 ;
      test_report ( "ARCH00590" ,
    "Variable declarations - composite globally static access subtypes" ,
      correct) ;
      wait ;
   end process ;
end ARCH00590 ;
--
entity ENT00590_Test_Bench is
end ENT00590_Test_Bench ;
--
architecture ARCH00590_Test_Bench of ENT00590_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.GENERIC_STANDARD_TYPES ( ARCH00590 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00590_Test_Bench ;
