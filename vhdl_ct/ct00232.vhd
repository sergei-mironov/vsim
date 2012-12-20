-- NEED RESULT: ENT00232.P00232: Associated composite out ports with static subtypes passed
-- NEED RESULT: ENT00232: Associated composite out ports with static subtypes passed
-- NEED RESULT: ENT00232.P00232: Associated composite out ports with static subtypes passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00232
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
--    ENT00232(ARCH00232)
--    ENT00232_Test_Bench(ARCH00232_Test_Bench)
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
entity ENT00232 is
   port (
          toggle : out switch := down;
       i_bit_vector_1, i_bit_vector_2 : out bit_vector
          := c_st_bit_vector_1
          ;
       i_string_1, i_string_2 : out string
          := c_st_string_1
          ;
       i_t_rec1_1, i_t_rec1_2 : out t_rec1
          := c_st_rec1_1
          ;
       i_st_rec1_1, i_st_rec1_2 : out st_rec1
          := c_st_rec1_1
          ;
       i_t_rec2_1, i_t_rec2_2 : out t_rec2
          := c_st_rec2_1
          ;
       i_st_rec2_1, i_st_rec2_2 : out st_rec2
          := c_st_rec2_1
          ;
       i_t_rec3_1, i_t_rec3_2 : out t_rec3
          := c_st_rec3_1
          ;
       i_st_rec3_1, i_st_rec3_2 : out st_rec3
          := c_st_rec3_1
          ;
       i_t_arr1_1, i_t_arr1_2 : out t_arr1
          := c_st_arr1_1
          ;
       i_st_arr1_1, i_st_arr1_2 : out st_arr1
          := c_st_arr1_1
          ;
       i_t_arr2_1, i_t_arr2_2 : out t_arr2
          := c_st_arr2_1
          ;
       i_st_arr2_1, i_st_arr2_2 : out st_arr2
          := c_st_arr2_1
          ;
       i_t_arr3_1, i_t_arr3_2 : out t_arr3
          := c_st_arr3_1
          ;
       i_st_arr3_1, i_st_arr3_2 : out st_arr3
          := c_st_arr3_1
            ) ;
begin
end ENT00232 ;
--
architecture ARCH00232 of ENT00232 is
begin
   process
      variable correct : boolean := true ;
   begin
      test_report ( "ENT00232" ,
      "Associated composite out ports with static subtypes" ,
      correct) ;
--
      toggle <= up ;
      i_bit_vector_1 <= c_st_bit_vector_2 ;
      i_bit_vector_2 <= c_st_bit_vector_2 ;
      i_string_1 <= c_st_string_2 ;
      i_string_2 <= c_st_string_2 ;
      i_t_rec1_1 <= c_st_rec1_2 ;
      i_t_rec1_2 <= c_st_rec1_2 ;
      i_st_rec1_1 <= c_st_rec1_2 ;
      i_st_rec1_2 <= c_st_rec1_2 ;
      i_t_rec2_1 <= c_st_rec2_2 ;
      i_t_rec2_2 <= c_st_rec2_2 ;
      i_st_rec2_1 <= c_st_rec2_2 ;
      i_st_rec2_2 <= c_st_rec2_2 ;
      i_t_rec3_1 <= c_st_rec3_2 ;
      i_t_rec3_2 <= c_st_rec3_2 ;
      i_st_rec3_1 <= c_st_rec3_2 ;
      i_st_rec3_2 <= c_st_rec3_2 ;
      i_t_arr1_1 <= c_st_arr1_2 ;
      i_t_arr1_2 <= c_st_arr1_2 ;
      i_st_arr1_1 <= c_st_arr1_2 ;
      i_st_arr1_2 <= c_st_arr1_2 ;
      i_t_arr2_1 <= c_st_arr2_2 ;
      i_t_arr2_2 <= c_st_arr2_2 ;
      i_st_arr2_1 <= c_st_arr2_2 ;
      i_st_arr2_2 <= c_st_arr2_2 ;
      i_t_arr3_1 <= c_st_arr3_2 ;
      i_t_arr3_2 <= c_st_arr3_2 ;
      i_st_arr3_1 <= c_st_arr3_2 ;
      i_st_arr3_2 <= c_st_arr3_2 ;
      wait ;
   end process ;
end ARCH00232 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00232_Test_Bench is
end ENT00232_Test_Bench ;
--
architecture ARCH00232_Test_Bench of ENT00232_Test_Bench is
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
                toggle : out switch ;
             i_bit_vector_1, i_bit_vector_2 : out bit_vector
                := c_st_bit_vector_1
                ;
             i_string_1, i_string_2 : out string
                := c_st_string_1
                ;
             i_t_rec1_1, i_t_rec1_2 : out t_rec1
                := c_st_rec1_1
                ;
             i_st_rec1_1, i_st_rec1_2 : out st_rec1
                := c_st_rec1_1
                ;
             i_t_rec2_1, i_t_rec2_2 : out t_rec2
                := c_st_rec2_1
                ;
             i_st_rec2_1, i_st_rec2_2 : out st_rec2
                := c_st_rec2_1
                ;
             i_t_rec3_1, i_t_rec3_2 : out t_rec3
                := c_st_rec3_1
                ;
             i_st_rec3_1, i_st_rec3_2 : out st_rec3
                := c_st_rec3_1
                ;
             i_t_arr1_1, i_t_arr1_2 : out t_arr1
                := c_st_arr1_1
                ;
             i_st_arr1_1, i_st_arr1_2 : out st_arr1
                := c_st_arr1_1
                ;
             i_t_arr2_1, i_t_arr2_2 : out t_arr2
                := c_st_arr2_1
                ;
             i_st_arr2_1, i_st_arr2_2 : out st_arr2
                := c_st_arr2_1
                ;
             i_t_arr3_1, i_t_arr3_2 : out t_arr3
                := c_st_arr3_1
                ;
             i_st_arr3_1, i_st_arr3_2 : out st_arr3
                := c_st_arr3_1
                ) ;
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00232 ( ARCH00232 ) ;
--
   begin
      CIS1 : UUT
       port map (
                                       toggle ,
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
      P00232 :
      process ( toggle )
         variable correct : boolean := true ;
      begin
         if toggle = up then
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
         end if ;
--
         test_report ( "ENT00232.P00232" ,
        "Associated composite out ports with static subtypes",
                   correct) ;
      end process P00232 ;
   end block L1 ;
end ARCH00232_Test_Bench ;
