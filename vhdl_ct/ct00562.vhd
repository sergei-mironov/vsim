-- NEED RESULT: ARCH00562: Aliasing - scalar generic subtypes passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00562
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.4 (1)
--    4.3.4 (2)
--    4.3.4 (11)
--
-- DESIGN UNIT ORDERING:
--
--    GENERIC_STANDARD_TYPES(ARCH00562)
--    ENT00562_Test_Bench(ARCH00562_Test_Bench)
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
architecture ARCH00562 of GENERIC_STANDARD_TYPES is
   constant co_boolean_1 : boolean
        := c_boolean_1 ;
   constant co_bit_1 : bit
        := c_bit_1 ;
   constant co_severity_level_1 : severity_level
        := c_severity_level_1 ;
   constant co_character_1 : character
        := c_character_1 ;
   constant co_t_enum1_1 : t_enum1
        := c_t_enum1_1 ;
   constant co_st_enum1_1 : st_enum1
        := c_st_enum1_1 ;
   constant co_integer_1 : integer
        := c_integer_1 ;
   constant co_t_int1_1 : t_int1
        := c_t_int1_1 ;
   constant co_st_int1_1 : st_int1
        := c_st_int1_1 ;
   constant co_time_1 : time
        := c_time_1 ;
   constant co_t_phys1_1 : t_phys1
        := c_t_phys1_1 ;
   constant co_st_phys1_1 : st_phys1
        := c_st_phys1_1 ;
   constant co_real_1 : real
        := c_real_1 ;
   constant co_t_real1_1 : t_real1
        := c_t_real1_1 ;
   constant co_st_real1_1 : st_real1
        := c_st_real1_1 ;
   signal si_boolean_1 : boolean
        := c_boolean_1 ;
   signal si_bit_1 : bit
        := c_bit_1 ;
   signal si_severity_level_1 : severity_level
        := c_severity_level_1 ;
   signal si_character_1 : character
        := c_character_1 ;
   signal si_t_enum1_1 : t_enum1
        := c_t_enum1_1 ;
   signal si_st_enum1_1 : st_enum1
        := c_st_enum1_1 ;
   signal si_integer_1 : integer
        := c_integer_1 ;
   signal si_t_int1_1 : t_int1
        := c_t_int1_1 ;
   signal si_st_int1_1 : st_int1
        := c_st_int1_1 ;
   signal si_time_1 : time
        := c_time_1 ;
   signal si_t_phys1_1 : t_phys1
        := c_t_phys1_1 ;
   signal si_st_phys1_1 : st_phys1
        := c_st_phys1_1 ;
   signal si_real_1 : real
        := c_real_1 ;
   signal si_t_real1_1 : t_real1
        := c_t_real1_1 ;
   signal si_st_real1_1 : st_real1
        := c_st_real1_1 ;
      alias as_boolean_1 : boolean
         is si_boolean_1   ;
      alias as_bit_1 : bit
         is si_bit_1   ;
      alias as_severity_level_1 : severity_level
         is si_severity_level_1   ;
      alias as_character_1 : character
         is si_character_1   ;
      alias as_t_enum1_1 : t_enum1
         is si_t_enum1_1   ;
      alias as_st_enum1_1 : st_enum1
         is si_st_enum1_1   ;
      alias as_integer_1 : integer
         is si_integer_1   ;
      alias as_t_int1_1 : t_int1
         is si_t_int1_1   ;
      alias as_st_int1_1 : st_int1
         is si_st_int1_1   ;
      alias as_time_1 : time
         is si_time_1   ;
      alias as_t_phys1_1 : t_phys1
         is si_t_phys1_1   ;
      alias as_st_phys1_1 : st_phys1
         is si_st_phys1_1   ;
      alias as_real_1 : real
         is si_real_1   ;
      alias as_t_real1_1 : t_real1
         is si_t_real1_1   ;
      alias as_st_real1_1 : st_real1
         is si_st_real1_1   ;
   type test is (initial, intermediate, final) ;
   signal synch : test := initial ;
   signal s_correct1 : boolean ;
   signal s_correct2 : boolean ;
begin
   process
      variable correct : boolean := true ;
   begin
      if synch = initial then
         correct := correct and as_boolean_1 = c_boolean_1 ;
         correct := correct and as_bit_1 = c_bit_1 ;
         correct := correct and as_severity_level_1 = c_severity_level_1 ;
         correct := correct and as_character_1 = c_character_1 ;
         correct := correct and as_t_enum1_1 = c_t_enum1_1 ;
         correct := correct and as_st_enum1_1 = c_st_enum1_1 ;
         correct := correct and as_integer_1 = c_integer_1 ;
         correct := correct and as_t_int1_1 = c_t_int1_1 ;
         correct := correct and as_st_int1_1 = c_st_int1_1 ;
         correct := correct and as_time_1 = c_time_1 ;
         correct := correct and as_t_phys1_1 = c_t_phys1_1 ;
         correct := correct and as_st_phys1_1 = c_st_phys1_1 ;
         correct := correct and as_real_1 = c_real_1 ;
         correct := correct and as_t_real1_1 = c_t_real1_1 ;
         correct := correct and as_st_real1_1 = c_st_real1_1 ;
         si_boolean_1 <= c_boolean_2 ;
         si_bit_1 <= c_bit_2 ;
         si_severity_level_1 <= c_severity_level_2 ;
         si_character_1 <= c_character_2 ;
         si_t_enum1_1 <= c_t_enum1_2 ;
         si_st_enum1_1 <= c_st_enum1_2 ;
         si_integer_1 <= c_integer_2 ;
         si_t_int1_1 <= c_t_int1_2 ;
         si_st_int1_1 <= c_st_int1_2 ;
         si_time_1 <= c_time_2 ;
         si_t_phys1_1 <= c_t_phys1_2 ;
         si_st_phys1_1 <= c_st_phys1_2 ;
         si_real_1 <= c_real_2 ;
         si_t_real1_1 <= c_t_real1_2 ;
         si_st_real1_1 <= c_st_real1_2 ;
         synch <= intermediate ;
         as_boolean_1 <= transport c_boolean_1 after 1 ns ;
         as_bit_1 <= transport c_bit_1 after 1 ns ;
         as_severity_level_1 <= transport c_severity_level_1 after 1 ns ;
         as_character_1 <= transport c_character_1 after 1 ns ;
         as_t_enum1_1 <= transport c_t_enum1_1 after 1 ns ;
         as_st_enum1_1 <= transport c_st_enum1_1 after 1 ns ;
         as_integer_1 <= transport c_integer_1 after 1 ns ;
         as_t_int1_1 <= transport c_t_int1_1 after 1 ns ;
         as_st_int1_1 <= transport c_st_int1_1 after 1 ns ;
         as_time_1 <= transport c_time_1 after 1 ns ;
         as_t_phys1_1 <= transport c_t_phys1_1 after 1 ns ;
         as_st_phys1_1 <= transport c_st_phys1_1 after 1 ns ;
         as_real_1 <= transport c_real_1 after 1 ns ;
         as_t_real1_1 <= transport c_t_real1_1 after 1 ns ;
         as_st_real1_1 <= transport c_st_real1_1 after 1 ns ;
         synch <= transport final after 1 ns ;
         s_correct1 <= correct ;
      end if ;
      wait ;
   end process ;
   process (synch)
      procedure p1 is
         variable correct : boolean ;
         variable va_boolean_1 : boolean
              := c_boolean_1 ;
         variable va_bit_1 : bit
              := c_bit_1 ;
         variable va_severity_level_1 : severity_level
              := c_severity_level_1 ;
         variable va_character_1 : character
              := c_character_1 ;
         variable va_t_enum1_1 : t_enum1
              := c_t_enum1_1 ;
         variable va_st_enum1_1 : st_enum1
              := c_st_enum1_1 ;
         variable va_integer_1 : integer
              := c_integer_1 ;
         variable va_t_int1_1 : t_int1
              := c_t_int1_1 ;
         variable va_st_int1_1 : st_int1
              := c_st_int1_1 ;
         variable va_time_1 : time
              := c_time_1 ;
         variable va_t_phys1_1 : t_phys1
              := c_t_phys1_1 ;
         variable va_st_phys1_1 : st_phys1
              := c_st_phys1_1 ;
         variable va_real_1 : real
              := c_real_1 ;
         variable va_t_real1_1 : t_real1
              := c_t_real1_1 ;
         variable va_st_real1_1 : st_real1
              := c_st_real1_1 ;
      alias ac_boolean_1 : boolean
         is co_boolean_1   ;
      alias ac_bit_1 : bit
         is co_bit_1   ;
      alias ac_severity_level_1 : severity_level
         is co_severity_level_1   ;
      alias ac_character_1 : character
         is co_character_1   ;
      alias ac_t_enum1_1 : t_enum1
         is co_t_enum1_1   ;
      alias ac_st_enum1_1 : st_enum1
         is co_st_enum1_1   ;
      alias ac_integer_1 : integer
         is co_integer_1   ;
      alias ac_t_int1_1 : t_int1
         is co_t_int1_1   ;
      alias ac_st_int1_1 : st_int1
         is co_st_int1_1   ;
      alias ac_time_1 : time
         is co_time_1   ;
      alias ac_t_phys1_1 : t_phys1
         is co_t_phys1_1   ;
      alias ac_st_phys1_1 : st_phys1
         is co_st_phys1_1   ;
      alias ac_real_1 : real
         is co_real_1   ;
      alias ac_t_real1_1 : t_real1
         is co_t_real1_1   ;
      alias ac_st_real1_1 : st_real1
         is co_st_real1_1   ;
      alias av_boolean_1 : boolean
         is va_boolean_1   ;
      alias av_bit_1 : bit
         is va_bit_1   ;
      alias av_severity_level_1 : severity_level
         is va_severity_level_1   ;
      alias av_character_1 : character
         is va_character_1   ;
      alias av_t_enum1_1 : t_enum1
         is va_t_enum1_1   ;
      alias av_st_enum1_1 : st_enum1
         is va_st_enum1_1   ;
      alias av_integer_1 : integer
         is va_integer_1   ;
      alias av_t_int1_1 : t_int1
         is va_t_int1_1   ;
      alias av_st_int1_1 : st_int1
         is va_st_int1_1   ;
      alias av_time_1 : time
         is va_time_1   ;
      alias av_t_phys1_1 : t_phys1
         is va_t_phys1_1   ;
      alias av_st_phys1_1 : st_phys1
         is va_st_phys1_1   ;
      alias av_real_1 : real
         is va_real_1   ;
      alias av_t_real1_1 : t_real1
         is va_t_real1_1   ;
      alias av_st_real1_1 : st_real1
         is va_st_real1_1   ;
      begin
         correct := s_correct1 ;
         if synch = intermediate then
-- test that variables denote same object
            correct := correct and av_boolean_1 = c_boolean_1 ;
            correct := correct and av_bit_1 = c_bit_1 ;
            correct := correct and av_severity_level_1 = c_severity_level_1 ;
            correct := correct and av_character_1 = c_character_1 ;
            correct := correct and av_t_enum1_1 = c_t_enum1_1 ;
            correct := correct and av_st_enum1_1 = c_st_enum1_1 ;
            correct := correct and av_integer_1 = c_integer_1 ;
            correct := correct and av_t_int1_1 = c_t_int1_1 ;
            correct := correct and av_st_int1_1 = c_st_int1_1 ;
            correct := correct and av_time_1 = c_time_1 ;
            correct := correct and av_t_phys1_1 = c_t_phys1_1 ;
            correct := correct and av_st_phys1_1 = c_st_phys1_1 ;
            correct := correct and av_real_1 = c_real_1 ;
            correct := correct and av_t_real1_1 = c_t_real1_1 ;
            correct := correct and av_st_real1_1 = c_st_real1_1 ;
            va_boolean_1 := c_boolean_2 ;
            va_bit_1 := c_bit_2 ;
            va_severity_level_1 := c_severity_level_2 ;
            va_character_1 := c_character_2 ;
            va_t_enum1_1 := c_t_enum1_2 ;
            va_st_enum1_1 := c_st_enum1_2 ;
            va_integer_1 := c_integer_2 ;
            va_t_int1_1 := c_t_int1_2 ;
            va_st_int1_1 := c_st_int1_2 ;
            va_time_1 := c_time_2 ;
            va_t_phys1_1 := c_t_phys1_2 ;
            va_st_phys1_1 := c_st_phys1_2 ;
            va_real_1 := c_real_2 ;
            va_t_real1_1 := c_t_real1_2 ;
            va_st_real1_1 := c_st_real1_2 ;
            correct := correct and av_boolean_1 = c_boolean_2 ;
            correct := correct and av_bit_1 = c_bit_2 ;
            correct := correct and av_severity_level_1 = c_severity_level_2 ;
            correct := correct and av_character_1 = c_character_2 ;
            correct := correct and av_t_enum1_1 = c_t_enum1_2 ;
            correct := correct and av_st_enum1_1 = c_st_enum1_2 ;
            correct := correct and av_integer_1 = c_integer_2 ;
            correct := correct and av_t_int1_1 = c_t_int1_2 ;
            correct := correct and av_st_int1_1 = c_st_int1_2 ;
            correct := correct and av_time_1 = c_time_2 ;
            correct := correct and av_t_phys1_1 = c_t_phys1_2 ;
            correct := correct and av_st_phys1_1 = c_st_phys1_2 ;
            correct := correct and av_real_1 = c_real_2 ;
            correct := correct and av_t_real1_1 = c_t_real1_2 ;
            correct := correct and av_st_real1_1 = c_st_real1_2 ;
            av_boolean_1 := c_boolean_1 ;
            av_bit_1 := c_bit_1 ;
            av_severity_level_1 := c_severity_level_1 ;
            av_character_1 := c_character_1 ;
            av_t_enum1_1 := c_t_enum1_1 ;
            av_st_enum1_1 := c_st_enum1_1 ;
            av_integer_1 := c_integer_1 ;
            av_t_int1_1 := c_t_int1_1 ;
            av_st_int1_1 := c_st_int1_1 ;
            av_time_1 := c_time_1 ;
            av_t_phys1_1 := c_t_phys1_1 ;
            av_st_phys1_1 := c_st_phys1_1 ;
            av_real_1 := c_real_1 ;
            av_t_real1_1 := c_t_real1_1 ;
            av_st_real1_1 := c_st_real1_1 ;
            correct := correct and va_boolean_1 = c_boolean_1 ;
            correct := correct and va_bit_1 = c_bit_1 ;
            correct := correct and va_severity_level_1 = c_severity_level_1 ;
            correct := correct and va_character_1 = c_character_1 ;
            correct := correct and va_t_enum1_1 = c_t_enum1_1 ;
            correct := correct and va_st_enum1_1 = c_st_enum1_1 ;
            correct := correct and va_integer_1 = c_integer_1 ;
            correct := correct and va_t_int1_1 = c_t_int1_1 ;
            correct := correct and va_st_int1_1 = c_st_int1_1 ;
            correct := correct and va_time_1 = c_time_1 ;
            correct := correct and va_t_phys1_1 = c_t_phys1_1 ;
            correct := correct and va_st_phys1_1 = c_st_phys1_1 ;
            correct := correct and va_real_1 = c_real_1 ;
            correct := correct and va_t_real1_1 = c_t_real1_1 ;
            correct := correct and va_st_real1_1 = c_st_real1_1 ;
-- test that signals denote same object
            correct := correct and as_boolean_1 = c_boolean_2 ;
            correct := correct and as_bit_1 = c_bit_2 ;
            correct := correct and as_severity_level_1 = c_severity_level_2 ;
            correct := correct and as_character_1 = c_character_2 ;
            correct := correct and as_t_enum1_1 = c_t_enum1_2 ;
            correct := correct and as_st_enum1_1 = c_st_enum1_2 ;
            correct := correct and as_integer_1 = c_integer_2 ;
            correct := correct and as_t_int1_1 = c_t_int1_2 ;
            correct := correct and as_st_int1_1 = c_st_int1_2 ;
            correct := correct and as_time_1 = c_time_2 ;
            correct := correct and as_t_phys1_1 = c_t_phys1_2 ;
            correct := correct and as_st_phys1_1 = c_st_phys1_2 ;
            correct := correct and as_real_1 = c_real_2 ;
            correct := correct and as_t_real1_1 = c_t_real1_2 ;
            correct := correct and as_st_real1_1 = c_st_real1_2 ;
            correct := correct and si_boolean_1 = c_boolean_2 ;
            correct := correct and si_bit_1 = c_bit_2 ;
            correct := correct and si_severity_level_1 = c_severity_level_2 ;
            correct := correct and si_character_1 = c_character_2 ;
            correct := correct and si_t_enum1_1 = c_t_enum1_2 ;
            correct := correct and si_st_enum1_1 = c_st_enum1_2 ;
            correct := correct and si_integer_1 = c_integer_2 ;
            correct := correct and si_t_int1_1 = c_t_int1_2 ;
            correct := correct and si_st_int1_1 = c_st_int1_2 ;
            correct := correct and si_time_1 = c_time_2 ;
            correct := correct and si_t_phys1_1 = c_t_phys1_2 ;
            correct := correct and si_st_phys1_1 = c_st_phys1_2 ;
            correct := correct and si_real_1 = c_real_2 ;
            correct := correct and si_t_real1_1 = c_t_real1_2 ;
            correct := correct and si_st_real1_1 = c_st_real1_2 ;
-- test that constants denote same object
            correct := correct and ac_boolean_1 = c_boolean_1 ;
            correct := correct and ac_bit_1 = c_bit_1 ;
            correct := correct and ac_severity_level_1 = c_severity_level_1 ;
            correct := correct and ac_character_1 = c_character_1 ;
            correct := correct and ac_t_enum1_1 = c_t_enum1_1 ;
            correct := correct and ac_st_enum1_1 = c_st_enum1_1 ;
            correct := correct and ac_integer_1 = c_integer_1 ;
            correct := correct and ac_t_int1_1 = c_t_int1_1 ;
            correct := correct and ac_st_int1_1 = c_st_int1_1 ;
            correct := correct and ac_time_1 = c_time_1 ;
            correct := correct and ac_t_phys1_1 = c_t_phys1_1 ;
            correct := correct and ac_st_phys1_1 = c_st_phys1_1 ;
            correct := correct and ac_real_1 = c_real_1 ;
            correct := correct and ac_t_real1_1 = c_t_real1_1 ;
            correct := correct and ac_st_real1_1 = c_st_real1_1 ;
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
            correct := correct and si_boolean_1 = c_boolean_1 ;
            correct := correct and si_bit_1 = c_bit_1 ;
            correct := correct and si_severity_level_1 = c_severity_level_1 ;
            correct := correct and si_character_1 = c_character_1 ;
            correct := correct and si_t_enum1_1 = c_t_enum1_1 ;
            correct := correct and si_st_enum1_1 = c_st_enum1_1 ;
            correct := correct and si_integer_1 = c_integer_1 ;
            correct := correct and si_t_int1_1 = c_t_int1_1 ;
            correct := correct and si_st_int1_1 = c_st_int1_1 ;
            correct := correct and si_time_1 = c_time_1 ;
            correct := correct and si_t_phys1_1 = c_t_phys1_1 ;
            correct := correct and si_st_phys1_1 = c_st_phys1_1 ;
            correct := correct and si_real_1 = c_real_1 ;
            correct := correct and si_t_real1_1 = c_t_real1_1 ;
            correct := correct and si_st_real1_1 = c_st_real1_1 ;
         test_report ( "ARCH00562" ,
           "Aliasing - scalar generic subtypes" ,
         correct) ;
      end if ;
   end process ;
end ARCH00562 ;
--
entity ENT00562_Test_Bench is
end ENT00562_Test_Bench ;
--
architecture ARCH00562_Test_Bench of ENT00562_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.GENERIC_STANDARD_TYPES ( ARCH00562 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00562_Test_Bench ;
