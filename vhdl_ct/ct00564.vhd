-- NEED RESULT: ARCH00564: Aliasing - composite generic subtypes passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00564
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.4 (1)
--    4.3.4 (2)
--    4.3.4 (13)
--
-- DESIGN UNIT ORDERING:
--
--    GENERIC_STANDARD_TYPES(ARCH00564)
--    ENT00564_Test_Bench(ARCH00564_Test_Bench)
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
architecture ARCH00564 of GENERIC_STANDARD_TYPES is
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
      alias as_st_bit_vector_1 : st_bit_vector
         is si_st_bit_vector_1   ;
      alias as_st_string_1 : st_string
         is si_st_string_1   ;
      alias as_st_rec1_1 : st_rec1
         is si_st_rec1_1   ;
      alias as_st_rec2_1 : st_rec2
         is si_st_rec2_1   ;
      alias as_st_rec3_1 : st_rec3
         is si_st_rec3_1   ;
      alias as_st_arr1_1 : st_arr1
         is si_st_arr1_1   ;
   type test is (initial, intermediate, final) ;
   signal synch : test := initial ;
   signal s_correct1 : boolean ;
   signal s_correct2 : boolean ;
begin
   process
      variable correct : boolean := true ;
   begin
      if synch = initial then
         correct := correct and as_st_bit_vector_1 = c_st_bit_vector_1 ;
         correct := correct and as_st_string_1 = c_st_string_1 ;
         correct := correct and as_st_rec1_1 = c_st_rec1_1 ;
         correct := correct and as_st_rec2_1 = c_st_rec2_1 ;
         correct := correct and as_st_rec3_1 = c_st_rec3_1 ;
         correct := correct and as_st_arr1_1 = c_st_arr1_1 ;
         si_st_bit_vector_1 <= c_st_bit_vector_2 ;
         si_st_string_1 <= c_st_string_2 ;
         si_st_rec1_1 <= c_st_rec1_2 ;
         si_st_rec2_1 <= c_st_rec2_2 ;
         si_st_rec3_1 <= c_st_rec3_2 ;
         si_st_arr1_1 <= c_st_arr1_2 ;
         synch <= intermediate ;
         as_st_bit_vector_1 <= transport c_st_bit_vector_1 after 1 ns ;
         as_st_string_1 <= transport c_st_string_1 after 1 ns ;
         as_st_rec1_1 <= transport c_st_rec1_1 after 1 ns ;
         as_st_rec2_1 <= transport c_st_rec2_1 after 1 ns ;
         as_st_rec3_1 <= transport c_st_rec3_1 after 1 ns ;
         as_st_arr1_1 <= transport c_st_arr1_1 after 1 ns ;
         synch <= transport final after 1 ns ;
         s_correct1 <= correct ;
      end if ;
      wait ;
   end process ;
   process (synch)
      procedure p1 is
         variable correct : boolean ;
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
         if synch = intermediate then
-- test that variables denote same object
            correct := s_correct1 ;
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
-- test that signals denote same object
            correct := correct and as_st_bit_vector_1 = c_st_bit_vector_2 ;
            correct := correct and as_st_string_1 = c_st_string_2 ;
            correct := correct and as_st_rec1_1 = c_st_rec1_2 ;
            correct := correct and as_st_rec2_1 = c_st_rec2_2 ;
            correct := correct and as_st_rec3_1 = c_st_rec3_2 ;
            correct := correct and as_st_arr1_1 = c_st_arr1_2 ;
            correct := correct and si_st_bit_vector_1 = c_st_bit_vector_2 ;
            correct := correct and si_st_string_1 = c_st_string_2 ;
            correct := correct and si_st_rec1_1 = c_st_rec1_2 ;
            correct := correct and si_st_rec2_1 = c_st_rec2_2 ;
            correct := correct and si_st_rec3_1 = c_st_rec3_2 ;
            correct := correct and si_st_arr1_1 = c_st_arr1_2 ;
-- test that constants denote same object
            correct := correct and ac_st_bit_vector_1 = c_st_bit_vector_1 ;
            correct := correct and ac_st_string_1 = c_st_string_1 ;
            correct := correct and ac_st_rec1_1 = c_st_rec1_1 ;
            correct := correct and ac_st_rec2_1 = c_st_rec2_1 ;
            correct := correct and ac_st_rec3_1 = c_st_rec3_1 ;
            correct := correct and ac_st_arr1_1 = c_st_arr1_1 ;
            s_correct2 <= correct ;
         end if ;
      end p1 ;
   begin
      p1 ;
   end process ;
--
   process (synch)
      variable correct : boolean ;
   begin
      if synch = final then
         correct := s_correct2 ;
            correct := correct and si_st_bit_vector_1 = c_st_bit_vector_1 ;
            correct := correct and si_st_string_1 = c_st_string_1 ;
            correct := correct and si_st_rec1_1 = c_st_rec1_1 ;
            correct := correct and si_st_rec2_1 = c_st_rec2_1 ;
            correct := correct and si_st_rec3_1 = c_st_rec3_1 ;
            correct := correct and si_st_arr1_1 = c_st_arr1_1 ;
         test_report ( "ARCH00564" ,
           "Aliasing - composite generic subtypes" ,
         correct) ;
      end if ;
   end process ;
end ARCH00564 ;
--
entity ENT00564_Test_Bench is
end ENT00564_Test_Bench ;
--
architecture ARCH00564_Test_Bench of ENT00564_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.GENERIC_STANDARD_TYPES ( ARCH00564 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00564_Test_Bench ;
