-- NEED RESULT: ARCH00557: Variable declarations - scalar globally static subtypes passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00557
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.1.3 (9)
--
-- DESIGN UNIT ORDERING:
--
--    GENERIC_STANDARD_TYPES(ARCH00557)
--    ENT00557_Test_Bench(ARCH00557_Test_Bench)
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
architecture ARCH00557 of GENERIC_STANDARD_TYPES is
begin
   process
      variable correct : boolean := true ;
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
   begin
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
      correct := correct and va_boolean_1 = c_boolean_2 ;
      correct := correct and va_bit_1 = c_bit_2 ;
      correct := correct and va_severity_level_1 = c_severity_level_2 ;
      correct := correct and va_character_1 = c_character_2 ;
      correct := correct and va_t_enum1_1 = c_t_enum1_2 ;
      correct := correct and va_st_enum1_1 = c_st_enum1_2 ;
      correct := correct and va_integer_1 = c_integer_2 ;
      correct := correct and va_t_int1_1 = c_t_int1_2 ;
      correct := correct and va_st_int1_1 = c_st_int1_2 ;
      correct := correct and va_time_1 = c_time_2 ;
      correct := correct and va_t_phys1_1 = c_t_phys1_2 ;
      correct := correct and va_st_phys1_1 = c_st_phys1_2 ;
      correct := correct and va_real_1 = c_real_2 ;
      correct := correct and va_t_real1_1 = c_t_real1_2 ;
      correct := correct and va_st_real1_1 = c_st_real1_2 ;
      test_report ( "ARCH00557" ,
      "Variable declarations - scalar globally static subtypes" ,
      correct) ;
      wait ;
   end process ;
end ARCH00557 ;
--
entity ENT00557_Test_Bench is
end ENT00557_Test_Bench ;
--
architecture ARCH00557_Test_Bench of ENT00557_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.GENERIC_STANDARD_TYPES ( ARCH00557 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00557_Test_Bench ;
