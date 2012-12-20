-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00242
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.1.1.2 (8)
--
-- DESIGN UNIT ORDERING:
--
--    GENERIC_STANDARD_TYPES(ARCH00242)
--    ENT00242_Test_Bench(ARCH00242_Test_Bench)
--
-- REVISION HISTORY:
--
--    15-JUN-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES ;
use STANDARD_TYPES.test_report, STANDARD_TYPES.switch,
    STANDARD_TYPES.up, STANDARD_TYPES.down, STANDARD_TYPES.toggle,
    STANDARD_TYPES."=" ;
architecture ARCH00242 of GENERIC_STANDARD_TYPES is
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
begin
   L1:
   block
   port (
          i_bit_vector_1, i_bit_vector_2 : linkage bit_vector
             ;
          i_string_1, i_string_2 : linkage string
             ;
          i_t_rec1_1, i_t_rec1_2 : linkage t_rec1
             ;
          i_st_rec1_1, i_st_rec1_2 : linkage st_rec1
             ;
          i_t_rec2_1, i_t_rec2_2 : linkage t_rec2
             ;
          i_st_rec2_1, i_st_rec2_2 : linkage st_rec2
             ;
          i_t_rec3_1, i_t_rec3_2 : linkage t_rec3
             ;
          i_st_rec3_1, i_st_rec3_2 : linkage st_rec3
             ;
          i_t_arr1_1, i_t_arr1_2 : linkage t_arr1
             ;
          i_st_arr1_1, i_st_arr1_2 : linkage st_arr1
             ;
          i_t_arr2_1, i_t_arr2_2 : linkage t_arr2
             ;
          i_st_arr2_1, i_st_arr2_2 : linkage st_arr2
             ;
          i_t_arr3_1, i_t_arr3_2 : linkage t_arr3
             ;
          i_st_arr3_1, i_st_arr3_2 : linkage st_arr3
            ) ;
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
--
   begin
      process
         variable correct : boolean := true ;
      begin
         test_report ( "ENT00242" ,
         "Associated composite linkage ports with generic subtypes" ,
          correct) ;
         wait ;
      end process ;
   end block L1 ;
end ARCH00242 ;
--
entity ENT00242_Test_Bench is
end ENT00242_Test_Bench ;
--
architecture ARCH00242_Test_Bench of ENT00242_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
--
      for CIS1 : UUT use entity WORK.GENERIC_STANDARD_TYPES ( ARCH00242 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00242_Test_Bench ;
