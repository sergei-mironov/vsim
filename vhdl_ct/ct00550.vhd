-- NEED RESULT: ARCH00550: Constant declarations - composite globally static subtypes passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00550
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.1.1 (6)
--
-- DESIGN UNIT ORDERING:
--
--    GENERIC_STANDARD_TYPES(ARCH00550)
--    ENT00550_Test_Bench(ARCH00550_Test_Bench)
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
architecture ARCH00550 of GENERIC_STANDARD_TYPES is
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
      test_report ( "ARCH00550" ,
     "Constant declarations - composite globally static subtypes" ,
      correct) ;
      wait ;
   end process ;
end ARCH00550 ;
--
entity ENT00550_Test_Bench is
end ENT00550_Test_Bench ;
--
architecture ARCH00550_Test_Bench of ENT00550_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.GENERIC_STANDARD_TYPES ( ARCH00550 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00550_Test_Bench ;
