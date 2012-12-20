-- NEED RESULT: ARCH00549: Constant declarations - composite static subtypes failed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00549
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.1.1 (5)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00549)
--    ENT00549_Test_Bench(ARCH00549_Test_Bench)
--
-- REVISION HISTORY:
--
--    19-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00549 of E00000 is
begin
   process
      variable correct : boolean := true ;
      constant co_bit_vector_1 : bit_vector
           := c_st_bit_vector_1 ;
      constant co_string_1 : string
           := c_st_string_1 ;
      constant co_t_rec1_1 : t_rec1
           := c_st_rec1_1 ;
      constant co_st_rec1_1 : st_rec1
           := c_st_rec1_1 ;
      constant co_t_rec2_1 : t_rec2
           := c_st_rec2_1 ;
      constant co_st_rec2_1 : st_rec2
           := c_st_rec2_1 ;
      constant co_t_rec3_1 : t_rec3
           := c_st_rec3_1 ;
      constant co_st_rec3_1 : st_rec3
           := c_st_rec3_1 ;
      constant co_t_arr1_1 : t_arr1
           := c_st_arr1_1 ;
      constant co_st_arr1_1 : st_arr1
           := c_st_arr1_1 ;
      constant co_t_arr2_1 : t_arr2
           := c_st_arr2_1 ;
      constant co_st_arr2_1 : st_arr2
           := c_st_arr2_1 ;
      constant co_t_arr3_1 : t_arr3
           := c_st_arr3_1 ;
      constant co_st_arr3_1 : st_arr3
           := c_st_arr3_1 ;
   begin
      correct := correct and co_bit_vector_1 = c_st_bit_vector_1 ;
      correct := correct and co_string_1 = c_st_string_1 ;
      correct := correct and co_t_rec1_1 = c_t_rec1_1 ;
      correct := correct and co_st_rec1_1 = c_st_rec1_1 ;
      correct := correct and co_t_rec2_1 = c_t_rec2_1 ;
      correct := correct and co_st_rec2_1 = c_st_rec2_1 ;
      correct := correct and co_t_rec3_1 = c_t_rec3_1 ;
      correct := correct and co_st_rec3_1 = c_st_rec3_1 ;
      correct := correct and co_t_arr1_1 = c_t_arr1_1 ;
      correct := correct and co_st_arr1_1 = c_st_arr1_1 ;
      correct := correct and co_t_arr2_1 = c_t_arr2_1 ;
      correct := correct and co_st_arr2_1 = c_st_arr2_1 ;
      correct := correct and co_t_arr3_1 = c_t_arr3_1 ;
      correct := correct and co_st_arr3_1 = c_st_arr3_1 ;
      test_report ( "ARCH00549" ,
      "Constant declarations - composite static subtypes" ,
      correct) ;
      wait ;
   end process ;
end ARCH00549 ;
--
entity ENT00549_Test_Bench is
end ENT00549_Test_Bench ;
--
architecture ARCH00549_Test_Bench of ENT00549_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00549 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00549_Test_Bench ;
