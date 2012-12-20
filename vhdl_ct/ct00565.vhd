-- NEED RESULT: ARCH00565: Aliasing - dynamic composite types passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00565
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.4 (2)
--    4.3.4 (14)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00565)
--    ENT00565_Test_Bench(ARCH00565_Test_Bench)
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
architecture ARCH00565 of E00000 is
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
   type test is (initial, intermediate, final) ;
   signal synch : test := initial ;
   signal s_correct1 : boolean ;
   signal s_correct2 : boolean ;
begin
   process
      procedure p1 (
               constant lowb : integer := 1 ;
               constant highb : integer := 10 ;
               constant lowb_i2 : integer := 0 ;
               constant highb_i2 : integer := 1000 ;
               constant lowb_p : integer := -100 ;
               constant highb_p : integer := 1000 ;
               constant lowb_r : real := 0.0 ;
               constant highb_r : real := 1000.0 ;
               constant lowb_r2 : real := 8.0 ;
               constant highb_r2 : real := 80.0
--
                   ) is
         variable correct : boolean := true;
         variable va_st_bit_vector_1 : st_bit_vector
              := c_st_bit_vector_1 ;
         variable va_st_string_1 : st_string
              := c_st_string_1 ;
         variable va_st_rec1_1 : st_rec1
              := c_st_rec1_1 ;
         variable va_st_rec2_1 : st_rec2
              := c_st_rec2_1 ;
         variable va_st_rec3_1 : st_rec3
              := c_st_rec3_1 ;
         variable va_st_arr1_1 : st_arr1
              := c_st_arr1_1 ;
   constant co_st_bit_vector_1 : st_bit_vector
        := c_st_bit_vector_1 ;
   constant co_st_string_1 : st_string
        := c_st_string_1 ;
   constant co_st_rec1_1 : st_rec1
        := c_st_rec1_1 ;
   constant co_st_rec2_1 : st_rec2
        := c_st_rec2_1 ;
   constant co_st_rec3_1 : st_rec3
        := c_st_rec3_1 ;
   constant co_st_arr1_1 : st_arr1
        := c_st_arr1_1 ;
      alias ac_st_bit_vector_1 : st_bit_vector
         is co_st_bit_vector_1   ;
      alias ac_st_string_1 : st_string
         is co_st_string_1   ;
      alias ac_st_rec1_1 : st_rec1
         is co_st_rec1_1   ;
      alias ac_st_rec2_1 : st_rec2
         is co_st_rec2_1   ;
      alias ac_st_rec3_1 : st_rec3
         is co_st_rec3_1   ;
      alias ac_st_arr1_1 : st_arr1
         is co_st_arr1_1   ;
      alias av_st_bit_vector_1 : st_bit_vector
         is va_st_bit_vector_1   ;
      alias av_st_string_1 : st_string
         is va_st_string_1   ;
      alias av_st_rec1_1 : st_rec1
         is va_st_rec1_1   ;
      alias av_st_rec2_1 : st_rec2
         is va_st_rec2_1   ;
      alias av_st_rec3_1 : st_rec3
         is va_st_rec3_1   ;
      alias av_st_arr1_1 : st_arr1
         is va_st_arr1_1   ;
      begin
-- test that variables denote same object
            correct := correct and av_st_bit_vector_1 = c_st_bit_vector_1 ;
            correct := correct and av_st_string_1 = c_st_string_1 ;
            correct := correct and av_st_rec1_1 = c_st_rec1_1 ;
            correct := correct and av_st_rec2_1 = c_st_rec2_1 ;
            correct := correct and av_st_rec3_1 = c_st_rec3_1 ;
            correct := correct and av_st_arr1_1 = c_st_arr1_1 ;
            va_st_bit_vector_1 := c_st_bit_vector_2 ;
            va_st_string_1 := c_st_string_2 ;
            va_st_rec1_1 := c_st_rec1_2 ;
            va_st_rec2_1 := c_st_rec2_2 ;
            va_st_rec3_1 := c_st_rec3_2 ;
            va_st_arr1_1 := c_st_arr1_2 ;
            correct := correct and av_st_bit_vector_1 = c_st_bit_vector_2 ;
            correct := correct and av_st_string_1 = c_st_string_2 ;
            correct := correct and av_st_rec1_1 = c_st_rec1_2 ;
            correct := correct and av_st_rec2_1 = c_st_rec2_2 ;
            correct := correct and av_st_rec3_1 = c_st_rec3_2 ;
            correct := correct and av_st_arr1_1 = c_st_arr1_2 ;
            av_st_bit_vector_1 := c_st_bit_vector_1 ;
            av_st_string_1 := c_st_string_1 ;
            av_st_rec1_1 := c_st_rec1_1 ;
            av_st_rec2_1 := c_st_rec2_1 ;
            av_st_rec3_1 := c_st_rec3_1 ;
            av_st_arr1_1 := c_st_arr1_1 ;
            correct := correct and va_st_bit_vector_1 = c_st_bit_vector_1 ;
            correct := correct and va_st_string_1 = c_st_string_1 ;
            correct := correct and va_st_rec1_1 = c_st_rec1_1 ;
            correct := correct and va_st_rec2_1 = c_st_rec2_1 ;
            correct := correct and va_st_rec3_1 = c_st_rec3_1 ;
            correct := correct and va_st_arr1_1 = c_st_arr1_1 ;
-- test that constants denote same object
            correct := correct and ac_st_bit_vector_1 = c_st_bit_vector_1 ;
            correct := correct and ac_st_string_1 = c_st_string_1 ;
            correct := correct and ac_st_rec1_1 = c_st_rec1_1 ;
            correct := correct and ac_st_rec2_1 = c_st_rec2_1 ;
            correct := correct and ac_st_rec3_1 = c_st_rec3_1 ;
            correct := correct and ac_st_arr1_1 = c_st_arr1_1 ;
         test_report ("ARCH00565",
                      "Aliasing - dynamic composite types",
                      correct ) ;
      end p1 ;
   begin
      p1 ;
      wait ;
   end process ;
end ARCH00565 ;
--
entity ENT00565_Test_Bench is
end ENT00565_Test_Bench ;
--
architecture ARCH00565_Test_Bench of ENT00565_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00565 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00565_Test_Bench ;
