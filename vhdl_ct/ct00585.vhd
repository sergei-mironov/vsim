-- NEED RESULT: ARCH00585: Attribute declarations - composite generic subtypes with dynamic initial values passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00585
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.4 (7)
--
-- DESIGN UNIT ORDERING:
--
--    GENERIC_STANDARD_TYPES(ARCH00585)
--    ENT00585_Test_Bench(ARCH00585_Test_Bench)
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
use WORK.STANDARD_TYPES.test_report ;
--
architecture ARCH00585 of GENERIC_STANDARD_TYPES is
      attribute at_bit_vector_1 : bit_vector ;
      attribute at_string_1 : string ;
      attribute at_t_rec1_1 : t_rec1 ;
      attribute at_st_rec1_1 : st_rec1 ;
      attribute at_t_rec2_1 : t_rec2 ;
      attribute at_st_rec2_1 : st_rec2 ;
      attribute at_t_rec3_1 : t_rec3 ;
      attribute at_st_rec3_1 : st_rec3 ;
      attribute at_t_arr1_1 : t_arr1 ;
      attribute at_st_arr1_1 : st_arr1 ;
      attribute at_t_arr2_1 : t_arr2 ;
      attribute at_st_arr2_1 : st_arr2 ;
      attribute at_t_arr3_1 : t_arr3 ;
      attribute at_st_arr3_1 : st_arr3 ;
      procedure p2 (
    i_bit_vector_1, i_bit_vector_2 : bit_vector
       := c_bit_vector_1 ;
    i_string_1, i_string_2 : string
       := c_string_1 ;
    i_t_rec1_1, i_t_rec1_2 : t_rec1
       := c_t_rec1_1 ;
    i_st_rec1_1, i_st_rec1_2 : st_rec1
       := c_st_rec1_1 ;
    i_t_rec2_1, i_t_rec2_2 : t_rec2
       := c_t_rec2_1 ;
    i_st_rec2_1, i_st_rec2_2 : st_rec2
       := c_st_rec2_1 ;
    i_t_rec3_1, i_t_rec3_2 : t_rec3
       := c_t_rec3_1 ;
    i_st_rec3_1, i_st_rec3_2 : st_rec3
       := c_st_rec3_1 ;
    i_t_arr1_1, i_t_arr1_2 : t_arr1
       := c_t_arr1_1 ;
    i_st_arr1_1, i_st_arr1_2 : st_arr1
       := c_st_arr1_1 ;
    i_t_arr2_1, i_t_arr2_2 : t_arr2
       := c_t_arr2_1 ;
    i_st_arr2_1, i_st_arr2_2 : st_arr2
       := c_st_arr2_1 ;
    i_t_arr3_1, i_t_arr3_2 : t_arr3
       := c_t_arr3_1 ;
    i_st_arr3_1, i_st_arr3_2 : st_arr3
       := c_st_arr3_1
                   ) is
         procedure p1 ;
         attribute at_bit_vector_1 of p1 : procedure is
              i_bit_vector_1 ;
         attribute at_string_1 of p1 : procedure is
              i_string_1 ;
         attribute at_t_rec1_1 of p1 : procedure is
              i_t_rec1_1 ;
         attribute at_st_rec1_1 of p1 : procedure is
              i_st_rec1_1 ;
         attribute at_t_rec2_1 of p1 : procedure is
              i_t_rec2_1 ;
         attribute at_st_rec2_1 of p1 : procedure is
              i_st_rec2_1 ;
         attribute at_t_rec3_1 of p1 : procedure is
              i_t_rec3_1 ;
         attribute at_st_rec3_1 of p1 : procedure is
              i_st_rec3_1 ;
         attribute at_t_arr1_1 of p1 : procedure is
              i_t_arr1_1 ;
         attribute at_st_arr1_1 of p1 : procedure is
              i_st_arr1_1 ;
         attribute at_t_arr2_1 of p1 : procedure is
              i_t_arr2_1 ;
         attribute at_st_arr2_1 of p1 : procedure is
              i_st_arr2_1 ;
         attribute at_t_arr3_1 of p1 : procedure is
              i_t_arr3_1 ;
         attribute at_st_arr3_1 of p1 : procedure is
              i_st_arr3_1 ;
         procedure p1 is
            variable correct : boolean := true ;
         begin
            correct := correct and p1'at_bit_vector_1
              = c_bit_vector_1 ;
            correct := correct and p1'at_string_1
              = c_string_1 ;
            correct := correct and p1'at_t_rec1_1
              = c_t_rec1_1 ;
            correct := correct and p1'at_st_rec1_1
              = c_st_rec1_1 ;
            correct := correct and p1'at_t_rec2_1
              = c_t_rec2_1 ;
            correct := correct and p1'at_st_rec2_1
              = c_st_rec2_1 ;
            correct := correct and p1'at_t_rec3_1
              = c_t_rec3_1 ;
            correct := correct and p1'at_st_rec3_1
              = c_st_rec3_1 ;
            correct := correct and p1'at_t_arr1_1
              = c_t_arr1_1 ;
            correct := correct and p1'at_st_arr1_1
              = c_st_arr1_1 ;
            correct := correct and p1'at_t_arr2_1
              = c_t_arr2_1 ;
            correct := correct and p1'at_st_arr2_1
              = c_st_arr2_1 ;
            correct := correct and p1'at_t_arr3_1
              = c_t_arr3_1 ;
            correct := correct and p1'at_st_arr3_1
              = c_st_arr3_1 ;
            test_report ( "ARCH00585" ,
           "Attribute declarations - composite generic subtypes"
                          & " with dynamic initial values" ,
            correct) ;
         end p1 ;
      begin
         p1 ;
      end p2 ;
begin
   process
   begin
      p2 ;
      wait ;
   end process ;
end ARCH00585 ;
--
entity ENT00585_Test_Bench is
end ENT00585_Test_Bench ;
--
architecture ARCH00585_Test_Bench of ENT00585_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.GENERIC_STANDARD_TYPES ( ARCH00585 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00585_Test_Bench ;
