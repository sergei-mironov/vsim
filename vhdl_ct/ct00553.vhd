-- NEED RESULT: ARCH00553: Signal declarations - scalar globally static subtypes passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00553
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.1.2 (8)
--
-- DESIGN UNIT ORDERING:
--
--    GENERIC_STANDARD_TYPES(ARCH00553)
--    ENT00553_Test_Bench(ARCH00553_Test_Bench)
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
architecture ARCH00553 of GENERIC_STANDARD_TYPES is
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
   signal synch : boolean := false ;
   signal s_correct : boolean := true ;
begin
   process
      variable correct : boolean := true ;
   begin
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
      synch <= true ;
      s_correct <= s_correct and correct ;
      wait ;
   end process ;
   process (synch)
      variable correct : boolean ;
   begin
      correct := s_correct ;
      if synch = true then
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
         test_report ( "ARCH00553" ,
         "Signal declarations - scalar globally static subtypes" ,
         correct) ;
      end if ;
   end process ;
end ARCH00553 ;
--
entity ENT00553_Test_Bench is
end ENT00553_Test_Bench ;
--
architecture ARCH00553_Test_Bench of ENT00553_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.GENERIC_STANDARD_TYPES ( ARCH00553 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00553_Test_Bench ;
