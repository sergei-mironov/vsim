-- NEED RESULT: ENT00014: Associated composite generics with static subtypes passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00014
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.1.1.1 (2)
--    1.1.1.1 (5)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00014(ARCH00014)
--    ENT00014_Test_Bench(ARCH00014_Test_Bench)
--
-- REVISION HISTORY:
--
--    25-JUN-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
entity ENT00014 is
   generic (
       i_bit_vector_1, i_bit_vector_2 : bit_vector
          := c_st_bit_vector_1 ;
       i_string_1, i_string_2 : string
          := c_st_string_1 ;
       i_t_rec1_1, i_t_rec1_2 : t_rec1
          := c_st_rec1_1 ;
       i_st_rec1_1, i_st_rec1_2 : st_rec1
          := c_st_rec1_1 ;
       i_t_rec2_1, i_t_rec2_2 : t_rec2
          := c_st_rec2_1 ;
       i_st_rec2_1, i_st_rec2_2 : st_rec2
          := c_st_rec2_1 ;
       i_t_rec3_1, i_t_rec3_2 : t_rec3
          := c_st_rec3_1 ;
       i_st_rec3_1, i_st_rec3_2 : st_rec3
          := c_st_rec3_1 ;
       i_t_arr1_1, i_t_arr1_2 : t_arr1
          := c_st_arr1_1 ;
       i_st_arr1_1, i_st_arr1_2 : st_arr1
          := c_st_arr1_1 ;
       i_t_arr2_1, i_t_arr2_2 : t_arr2
          := c_st_arr2_1 ;
       i_st_arr2_1, i_st_arr2_2 : st_arr2
          := c_st_arr2_1 ;
       i_t_arr3_1, i_t_arr3_2 : t_arr3
          := c_st_arr3_1 ;
       i_st_arr3_1, i_st_arr3_2 : st_arr3
          := c_st_arr3_1
            ) ;
begin
end ENT00014 ;
--
architecture ARCH00014 of ENT00014 is
begin
   process
      variable correct : boolean := true ;
   begin
      correct := correct and i_bit_vector_1 = c_st_bit_vector_2
                 and i_bit_vector_2 = c_st_bit_vector_2 ;
      correct := correct and i_string_1 = c_st_string_2
                 and i_string_2 = c_st_string_2 ;
      correct := correct and i_t_rec1_1 = c_st_rec1_2
                 and i_t_rec1_2 = c_st_rec1_2 ;
      correct := correct and i_st_rec1_1 = c_st_rec1_2
                 and i_st_rec1_2 = c_st_rec1_2 ;
      correct := correct and i_t_rec2_1 = c_st_rec2_2
                 and i_t_rec2_2 = c_st_rec2_2 ;
      correct := correct and i_st_rec2_1 = c_st_rec2_2
                 and i_st_rec2_2 = c_st_rec2_2 ;
      correct := correct and i_t_rec3_1 = c_st_rec3_2
                 and i_t_rec3_2 = c_st_rec3_2 ;
      correct := correct and i_st_rec3_1 = c_st_rec3_2
                 and i_st_rec3_2 = c_st_rec3_2 ;
      correct := correct and i_t_arr1_1 = c_st_arr1_2
                 and i_t_arr1_2 = c_st_arr1_2 ;
      correct := correct and i_st_arr1_1 = c_st_arr1_2
                 and i_st_arr1_2 = c_st_arr1_2 ;
      correct := correct and i_t_arr2_1 = c_st_arr2_2
                 and i_t_arr2_2 = c_st_arr2_2 ;
      correct := correct and i_st_arr2_1 = c_st_arr2_2
                 and i_st_arr2_2 = c_st_arr2_2 ;
      correct := correct and i_t_arr3_1 = c_st_arr3_2
                 and i_t_arr3_2 = c_st_arr3_2 ;
      correct := correct and i_st_arr3_1 = c_st_arr3_2
                 and i_st_arr3_2 = c_st_arr3_2 ;
      test_report ( "ENT00014" ,
      "Associated composite generics with static subtypes" ,
      correct) ;
      wait ;
   end process ;
end ARCH00014 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00014_Test_Bench is
end ENT00014_Test_Bench ;
--
architecture ARCH00014_Test_Bench of ENT00014_Test_Bench is
begin
   L1:
   block
      component UUT
         generic (
             i_bit_vector_1, i_bit_vector_2 : bit_vector ;
             i_string_1, i_string_2 : string ;
             i_t_rec1_1, i_t_rec1_2 : t_rec1 ;
             i_st_rec1_1, i_st_rec1_2 : st_rec1 ;
             i_t_rec2_1, i_t_rec2_2 : t_rec2 ;
             i_st_rec2_1, i_st_rec2_2 : st_rec2 ;
             i_t_rec3_1, i_t_rec3_2 : t_rec3 ;
             i_st_rec3_1, i_st_rec3_2 : st_rec3 ;
             i_t_arr1_1, i_t_arr1_2 : t_arr1 ;
             i_st_arr1_1, i_st_arr1_2 : st_arr1 ;
             i_t_arr2_1, i_t_arr2_2 : t_arr2 ;
             i_st_arr2_1, i_st_arr2_2 : st_arr2 ;
             i_t_arr3_1, i_t_arr3_2 : t_arr3 ;
             i_st_arr3_1, i_st_arr3_2 : st_arr3
                   ) ;
      end component ;
      for CIS1 : UUT use entity WORK.ENT00014 ( ARCH00014 ) ;
   begin
      CIS1 : UUT
    generic map (
                c_st_bit_vector_2, c_st_bit_vector_2,
                c_st_string_2, c_st_string_2,
                c_st_rec1_2, c_st_rec1_2,
                c_st_rec1_2, c_st_rec1_2,
                c_st_rec2_2, c_st_rec2_2,
                c_st_rec2_2, c_st_rec2_2,
                c_st_rec3_2, c_st_rec3_2,
                c_st_rec3_2, c_st_rec3_2,
                c_st_arr1_2, c_st_arr1_2,
                c_st_arr1_2, c_st_arr1_2,
                c_st_arr2_2, c_st_arr2_2,
                c_st_arr2_2, c_st_arr2_2,
                c_st_arr3_2, c_st_arr3_2,
                c_st_arr3_2, c_st_arr3_2
                       ) ;
   end block L1 ;
end ARCH00014_Test_Bench ;
