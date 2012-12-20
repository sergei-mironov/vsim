-- NEED RESULT: ARCH00552: Signal declarations - scalar static subtypes passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00552
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.1.2 (6)
--    4.3.1.2 (7)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00552)
--    ENT00552_Test_Bench(ARCH00552_Test_Bench)
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
architecture ARCH00552 of E00000 is
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
         test_report ( "ARCH00552" ,
         "Signal declarations - scalar static subtypes" ,
         correct) ;
      end if ;
   end process ;
end ARCH00552 ;
--
entity ENT00552_Test_Bench is
end ENT00552_Test_Bench ;
--
architecture ARCH00552_Test_Bench of ENT00552_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00552 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00552_Test_Bench ;
