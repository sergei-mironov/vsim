-- NEED RESULT: ARCH00683: Allocators with static scalar subtype indication passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00683
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.3.6 (2)
--    7.3.6 (4)
--    7.3.6 (5)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00683)
--    ENT00683_Test_Bench(ARCH00683_Test_Bench)
--
-- REVISION HISTORY:
--
--    08-SEP-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00683 of E00000 is
begin
   process
      variable correct : boolean := true ;
         type a_boolean is access boolean ;
         variable va_boolean_1, va_boolean_2 : a_boolean
                           := new boolean ;
         type a_bit is access bit ;
         variable va_bit_1, va_bit_2 : a_bit
                           := new bit ;
         type a_severity_level is access severity_level ;
         variable va_severity_level_1, va_severity_level_2 : a_severity_level
                           := new severity_level ;
         type a_character is access character ;
         variable va_character_1, va_character_2 : a_character
                           := new character ;
         type a_t_enum1 is access t_enum1 ;
         variable va_t_enum1_1, va_t_enum1_2 : a_t_enum1
                           := new t_enum1 ;
         type a_st_enum1 is access st_enum1 ;
         variable va_st_enum1_1, va_st_enum1_2 : a_st_enum1
                           := new st_enum1 ;
         type a_integer is access integer ;
         variable va_integer_1, va_integer_2 : a_integer
                           := new integer ;
         type a_t_int1 is access t_int1 ;
         variable va_t_int1_1, va_t_int1_2 : a_t_int1
                           := new t_int1 ;
         type a_st_int1 is access st_int1 ;
         variable va_st_int1_1, va_st_int1_2 : a_st_int1
                           := new st_int1 ;
         type a_time is access time ;
         variable va_time_1, va_time_2 : a_time
                           := new time ;
         type a_t_phys1 is access t_phys1 ;
         variable va_t_phys1_1, va_t_phys1_2 : a_t_phys1
                           := new t_phys1 ;
         type a_st_phys1 is access st_phys1 ;
         variable va_st_phys1_1, va_st_phys1_2 : a_st_phys1
                           := new st_phys1 ;
         type a_real is access real ;
         variable va_real_1, va_real_2 : a_real
                           := new real ;
         type a_t_real1 is access t_real1 ;
         variable va_t_real1_1, va_t_real1_2 : a_t_real1
                           := new t_real1 ;
         type a_st_real1 is access st_real1 ;
         variable va_st_real1_1, va_st_real1_2 : a_st_real1
                           := new st_real1 ;
   begin
         correct := correct and
                     va_boolean_1.all = d_boolean ;
         correct := correct and
                     va_bit_1.all = d_bit ;
         correct := correct and
                     va_severity_level_1.all = d_severity_level ;
         correct := correct and
                     va_character_1.all = d_character ;
         correct := correct and
                     va_t_enum1_1.all = d_t_enum1 ;
         correct := correct and
                     va_st_enum1_1.all = d_st_enum1 ;
         correct := correct and
                     va_integer_1.all = d_integer ;
         correct := correct and
                     va_t_int1_1.all = d_t_int1 ;
         correct := correct and
                     va_st_int1_1.all = d_st_int1 ;
         correct := correct and
                     va_time_1.all = d_time ;
         correct := correct and
                     va_t_phys1_1.all = d_t_phys1 ;
         correct := correct and
                     va_st_phys1_1.all = d_st_phys1 ;
         correct := correct and
                     va_real_1.all = d_real ;
         correct := correct and
                     va_t_real1_1.all = d_t_real1 ;
         correct := correct and
                     va_st_real1_1.all = d_st_real1 ;
      test_report ( "ARCH00683" ,
      "Allocators with static scalar subtype indication" ,
      correct) ;
      wait ;
   end process ;
end ARCH00683 ;
--
entity ENT00683_Test_Bench is
end ENT00683_Test_Bench ;
--
architecture ARCH00683_Test_Bench of ENT00683_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00683 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00683_Test_Bench ;
