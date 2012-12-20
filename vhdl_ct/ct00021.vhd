-- NEED RESULT: ENT00021: Unassociated composite ports with static subtypes take on default expression failed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00021
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.1.1.2 (2)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00021(ARCH00021)
--    ENT00021_Test_Bench(ARCH00021_Test_Bench)
--
-- REVISION HISTORY:
--
--    26-JUN-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
entity ENT00021 is
   port (
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
end ENT00021 ;
--
architecture ARCH00021 of ENT00021 is
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
      test_report ( "ENT00021" ,
     "Unassociated composite ports with static subtypes" &
            " take on default expression" ,
      correct) ;
      wait ;
   end process ;
end ARCH00021 ;
--
entity ENT00021_Test_Bench is
end ENT00021_Test_Bench ;
--
architecture ARCH00021_Test_Bench of ENT00021_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.ENT00021 ( ARCH00021 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00021_Test_Bench ;
