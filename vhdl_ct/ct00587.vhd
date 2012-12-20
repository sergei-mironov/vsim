-- NEED RESULT: ARCH00587: Variable declarations - scalar static access subtypes passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00587
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.1.3 (10)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00587)
--    ENT00587_Test_Bench(ARCH00587_Test_Bench)
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
architecture ARCH00587 of E00000 is
begin
   process
      variable correct : boolean := true ;
      type a_boolean is access boolean ;
      variable av_boolean_1, av_boolean_2 : a_boolean
                        := new boolean ;
      type a_bit is access bit ;
      variable av_bit_1, av_bit_2 : a_bit
                        := new bit ;
      type a_severity_level is access severity_level ;
      variable av_severity_level_1, av_severity_level_2 : a_severity_level
                        := new severity_level ;
      type a_character is access character ;
      variable av_character_1, av_character_2 : a_character
                        := new character ;
      type a_t_enum1 is access t_enum1 ;
      variable av_t_enum1_1, av_t_enum1_2 : a_t_enum1
                        := new t_enum1 ;
      type a_st_enum1 is access st_enum1 ;
      variable av_st_enum1_1, av_st_enum1_2 : a_st_enum1
                        := new st_enum1 ;
      type a_integer is access integer ;
      variable av_integer_1, av_integer_2 : a_integer
                        := new integer ;
      type a_t_int1 is access t_int1 ;
      variable av_t_int1_1, av_t_int1_2 : a_t_int1
                        := new t_int1 ;
      type a_st_int1 is access st_int1 ;
      variable av_st_int1_1, av_st_int1_2 : a_st_int1
                        := new st_int1 ;
      type a_time is access time ;
      variable av_time_1, av_time_2 : a_time
                        := new time ;
      type a_t_phys1 is access t_phys1 ;
      variable av_t_phys1_1, av_t_phys1_2 : a_t_phys1
                        := new t_phys1 ;
      type a_st_phys1 is access st_phys1 ;
      variable av_st_phys1_1, av_st_phys1_2 : a_st_phys1
                        := new st_phys1 ;
      type a_real is access real ;
      variable av_real_1, av_real_2 : a_real
                        := new real ;
      type a_t_real1 is access t_real1 ;
      variable av_t_real1_1, av_t_real1_2 : a_t_real1
                        := new t_real1 ;
      type a_st_real1 is access st_real1 ;
      variable av_st_real1_1, av_st_real1_2 : a_st_real1
                        := new st_real1 ;
   begin
      av_boolean_1 := new boolean'(c_boolean_1) ;
      av_bit_1 := new bit'(c_bit_1) ;
      av_severity_level_1 := new severity_level'(c_severity_level_1) ;
      av_character_1 := new character'(c_character_1) ;
      av_t_enum1_1 := new t_enum1'(c_t_enum1_1) ;
      av_st_enum1_1 := new st_enum1'(c_st_enum1_1) ;
      av_integer_1 := new integer'(c_integer_1) ;
      av_t_int1_1 := new t_int1'(c_t_int1_1) ;
      av_st_int1_1 := new st_int1'(c_st_int1_1) ;
      av_time_1 := new time'(c_time_1) ;
      av_t_phys1_1 := new t_phys1'(c_t_phys1_1) ;
      av_st_phys1_1 := new st_phys1'(c_st_phys1_1) ;
      av_real_1 := new real'(c_real_1) ;
      av_t_real1_1 := new t_real1'(c_t_real1_1) ;
      av_st_real1_1 := new st_real1'(c_st_real1_1) ;
      correct := correct and av_boolean_1.all
        = c_boolean_1 ;
      correct := correct and av_bit_1.all
        = c_bit_1 ;
      correct := correct and av_severity_level_1.all
        = c_severity_level_1 ;
      correct := correct and av_character_1.all
        = c_character_1 ;
      correct := correct and av_t_enum1_1.all
        = c_t_enum1_1 ;
      correct := correct and av_st_enum1_1.all
        = c_st_enum1_1 ;
      correct := correct and av_integer_1.all
        = c_integer_1 ;
      correct := correct and av_t_int1_1.all
        = c_t_int1_1 ;
      correct := correct and av_st_int1_1.all
        = c_st_int1_1 ;
      correct := correct and av_time_1.all
        = c_time_1 ;
      correct := correct and av_t_phys1_1.all
        = c_t_phys1_1 ;
      correct := correct and av_st_phys1_1.all
        = c_st_phys1_1 ;
      correct := correct and av_real_1.all
        = c_real_1 ;
      correct := correct and av_t_real1_1.all
        = c_t_real1_1 ;
      correct := correct and av_st_real1_1.all
        = c_st_real1_1 ;
      av_boolean_1.all := c_boolean_2 ;
      av_bit_1.all := c_bit_2 ;
      av_severity_level_1.all := c_severity_level_2 ;
      av_character_1.all := c_character_2 ;
      av_t_enum1_1.all := c_t_enum1_2 ;
      av_st_enum1_1.all := c_st_enum1_2 ;
      av_integer_1.all := c_integer_2 ;
      av_t_int1_1.all := c_t_int1_2 ;
      av_st_int1_1.all := c_st_int1_2 ;
      av_time_1.all := c_time_2 ;
      av_t_phys1_1.all := c_t_phys1_2 ;
      av_st_phys1_1.all := c_st_phys1_2 ;
      av_real_1.all := c_real_2 ;
      av_t_real1_1.all := c_t_real1_2 ;
      av_st_real1_1.all := c_st_real1_2 ;
      correct := correct and av_boolean_1.all
        = c_boolean_2 ;
      correct := correct and av_bit_1.all
        = c_bit_2 ;
      correct := correct and av_severity_level_1.all
        = c_severity_level_2 ;
      correct := correct and av_character_1.all
        = c_character_2 ;
      correct := correct and av_t_enum1_1.all
        = c_t_enum1_2 ;
      correct := correct and av_st_enum1_1.all
        = c_st_enum1_2 ;
      correct := correct and av_integer_1.all
        = c_integer_2 ;
      correct := correct and av_t_int1_1.all
        = c_t_int1_2 ;
      correct := correct and av_st_int1_1.all
        = c_st_int1_2 ;
      correct := correct and av_time_1.all
        = c_time_2 ;
      correct := correct and av_t_phys1_1.all
        = c_t_phys1_2 ;
      correct := correct and av_st_phys1_1.all
        = c_st_phys1_2 ;
      correct := correct and av_real_1.all
        = c_real_2 ;
      correct := correct and av_t_real1_1.all
        = c_t_real1_2 ;
      correct := correct and av_st_real1_1.all
        = c_st_real1_2 ;
      test_report ( "ARCH00587" ,
      "Variable declarations - scalar static access subtypes" ,
      correct) ;
      wait ;
   end process ;
end ARCH00587 ;
--
entity ENT00587_Test_Bench is
end ENT00587_Test_Bench ;
--
architecture ARCH00587_Test_Bench of ENT00587_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00587 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00587_Test_Bench ;
