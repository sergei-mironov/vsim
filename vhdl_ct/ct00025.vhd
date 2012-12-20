-- NEED RESULT: ENT00025: Associated composite in ports with static subtypes passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00025
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.1.1.2 (4)
--    1.1.1.2 (7)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00025(ARCH00025)
--    ENT00025_Test_Bench(ARCH00025_Test_Bench)
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
entity ENT00025 is
   port (
       i_bit_vector_1, i_bit_vector_2 : in bit_vector
          := c_st_bit_vector_1
          ;
       i_string_1, i_string_2 : in string
          := c_st_string_1
          ;
       i_t_rec1_1, i_t_rec1_2 : in t_rec1
          := c_st_rec1_1
          ;
       i_st_rec1_1, i_st_rec1_2 : in st_rec1
          := c_st_rec1_1
          ;
       i_t_rec2_1, i_t_rec2_2 : in t_rec2
          := c_st_rec2_1
          ;
       i_st_rec2_1, i_st_rec2_2 : in st_rec2
          := c_st_rec2_1
          ;
       i_t_rec3_1, i_t_rec3_2 : in t_rec3
          := c_st_rec3_1
          ;
       i_st_rec3_1, i_st_rec3_2 : in st_rec3
          := c_st_rec3_1
          ;
       i_t_arr1_1, i_t_arr1_2 : in t_arr1
          := c_st_arr1_1
          ;
       i_st_arr1_1, i_st_arr1_2 : in st_arr1
          := c_st_arr1_1
          ;
       i_t_arr2_1, i_t_arr2_2 : in t_arr2
          := c_st_arr2_1
          ;
       i_st_arr2_1, i_st_arr2_2 : in st_arr2
          := c_st_arr2_1
          ;
       i_t_arr3_1, i_t_arr3_2 : in t_arr3
          := c_st_arr3_1
          ;
       i_st_arr3_1, i_st_arr3_2 : in st_arr3
          := c_st_arr3_1
            ) ;
begin
end ENT00025 ;
--
architecture ARCH00025 of ENT00025 is
begin
   process
      variable correct : boolean := true ;
   begin
      correct := correct and i_bit_vector_1 = c_st_bit_vector_1
                 and i_bit_vector_2 = c_st_bit_vector_1 ;
      correct := correct and i_string_1 = c_st_string_1
                 and i_string_2 = c_st_string_1 ;
      correct := correct and i_t_rec1_1 = c_st_rec1_1
                 and i_t_rec1_2 = c_st_rec1_1 ;
      correct := correct and i_st_rec1_1 = c_st_rec1_1
                 and i_st_rec1_2 = c_st_rec1_1 ;
      correct := correct and i_t_rec2_1 = c_st_rec2_1
                 and i_t_rec2_2 = c_st_rec2_1 ;
      correct := correct and i_st_rec2_1 = c_st_rec2_1
                 and i_st_rec2_2 = c_st_rec2_1 ;
      correct := correct and i_t_rec3_1 = c_st_rec3_1
                 and i_t_rec3_2 = c_st_rec3_1 ;
      correct := correct and i_st_rec3_1 = c_st_rec3_1
                 and i_st_rec3_2 = c_st_rec3_1 ;
      correct := correct and i_t_arr1_1 = c_st_arr1_1
                 and i_t_arr1_2 = c_st_arr1_1 ;
      correct := correct and i_st_arr1_1 = c_st_arr1_1
                 and i_st_arr1_2 = c_st_arr1_1 ;
      correct := correct and i_t_arr2_1 = c_st_arr2_1
                 and i_t_arr2_2 = c_st_arr2_1 ;
      correct := correct and i_st_arr2_1 = c_st_arr2_1
                 and i_st_arr2_2 = c_st_arr2_1 ;
      correct := correct and i_t_arr3_1 = c_st_arr3_1
                 and i_t_arr3_2 = c_st_arr3_1 ;
      correct := correct and i_st_arr3_1 = c_st_arr3_1
                 and i_st_arr3_2 = c_st_arr3_1 ;
--
      test_report ( "ENT00025" ,
      "Associated composite in ports with static subtypes" ,
      correct) ;
      wait ;
   end process ;
end ARCH00025 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00025_Test_Bench is
end ENT00025_Test_Bench ;
--
architecture ARCH00025_Test_Bench of ENT00025_Test_Bench is
begin
   L1:
   block
      signal i_bit_vector_1, i_bit_vector_2 : st_bit_vector
          := c_st_bit_vector_1 ;
      signal i_string_1, i_string_2 : st_string
          := c_st_string_1 ;
      signal i_t_rec1_1, i_t_rec1_2 : st_rec1
          := c_st_rec1_1 ;
      signal i_st_rec1_1, i_st_rec1_2 : st_rec1
          := c_st_rec1_1 ;
      signal i_t_rec2_1, i_t_rec2_2 : st_rec2
          := c_st_rec2_1 ;
      signal i_st_rec2_1, i_st_rec2_2 : st_rec2
          := c_st_rec2_1 ;
      signal i_t_rec3_1, i_t_rec3_2 : st_rec3
          := c_st_rec3_1 ;
      signal i_st_rec3_1, i_st_rec3_2 : st_rec3
          := c_st_rec3_1 ;
      signal i_t_arr1_1, i_t_arr1_2 : st_arr1
          := c_st_arr1_1 ;
      signal i_st_arr1_1, i_st_arr1_2 : st_arr1
          := c_st_arr1_1 ;
      signal i_t_arr2_1, i_t_arr2_2 : st_arr2
          := c_st_arr2_1 ;
      signal i_st_arr2_1, i_st_arr2_2 : st_arr2
          := c_st_arr2_1 ;
      signal i_t_arr3_1, i_t_arr3_2 : st_arr3
          := c_st_arr3_1 ;
      signal i_st_arr3_1, i_st_arr3_2 : st_arr3
          := c_st_arr3_1 ;
--
      component UUT
         port (
             i_bit_vector_1, i_bit_vector_2 : in bit_vector
                := c_st_bit_vector_1
                ;
             i_string_1, i_string_2 : in string
                := c_st_string_1
                ;
             i_t_rec1_1, i_t_rec1_2 : in t_rec1
                := c_st_rec1_1
                ;
             i_st_rec1_1, i_st_rec1_2 : in st_rec1
                := c_st_rec1_1
                ;
             i_t_rec2_1, i_t_rec2_2 : in t_rec2
                := c_st_rec2_1
                ;
             i_st_rec2_1, i_st_rec2_2 : in st_rec2
                := c_st_rec2_1
                ;
             i_t_rec3_1, i_t_rec3_2 : in t_rec3
                := c_st_rec3_1
                ;
             i_st_rec3_1, i_st_rec3_2 : in st_rec3
                := c_st_rec3_1
                ;
             i_t_arr1_1, i_t_arr1_2 : in t_arr1
                := c_st_arr1_1
                ;
             i_st_arr1_1, i_st_arr1_2 : in st_arr1
                := c_st_arr1_1
                ;
             i_t_arr2_1, i_t_arr2_2 : in t_arr2
                := c_st_arr2_1
                ;
             i_st_arr2_1, i_st_arr2_2 : in st_arr2
                := c_st_arr2_1
                ;
             i_t_arr3_1, i_t_arr3_2 : in t_arr3
                := c_st_arr3_1
                ;
             i_st_arr3_1, i_st_arr3_2 : in st_arr3
                := c_st_arr3_1
                ) ;
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00025 ( ARCH00025 ) ;
--
   begin
      CIS1 : UUT
       port map (
                               i_bit_vector_1, i_bit_vector_2,
                               i_string_1, i_string_2,
                               i_t_rec1_1, i_t_rec1_2,
                               i_st_rec1_1, i_st_rec1_2,
                               i_t_rec2_1, i_t_rec2_2,
                               i_st_rec2_1, i_st_rec2_2,
                               i_t_rec3_1, i_t_rec3_2,
                               i_st_rec3_1, i_st_rec3_2,
                               i_t_arr1_1, i_t_arr1_2,
                               i_st_arr1_1, i_st_arr1_2,
                               i_t_arr2_1, i_t_arr2_2,
                               i_st_arr2_1, i_st_arr2_2,
                               i_t_arr3_1, i_t_arr3_2,
                               i_st_arr3_1, i_st_arr3_2
                                      ) ;
   end block L1 ;
end ARCH00025_Test_Bench ;
