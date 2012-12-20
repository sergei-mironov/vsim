-- NEED RESULT: ARCH00547: Constant declarations - scalar static subtypes passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00547
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.1.1 (2)
--    4.3.1.1 (3)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00547)
--    ENT00547_Test_Bench(ARCH00547_Test_Bench)
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
architecture ARCH00547 of E00000 is
begin
   process
      variable correct : boolean := true ;
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
   begin
      correct := correct and co_boolean_1 = c_boolean_1 ;
      correct := correct and co_bit_1 = c_bit_1 ;
      correct := correct and co_severity_level_1 = c_severity_level_1 ;
      correct := correct and co_character_1 = c_character_1 ;
      correct := correct and co_t_enum1_1 = c_t_enum1_1 ;
      correct := correct and co_st_enum1_1 = c_st_enum1_1 ;
      correct := correct and co_integer_1 = c_integer_1 ;
      correct := correct and co_t_int1_1 = c_t_int1_1 ;
      correct := correct and co_st_int1_1 = c_st_int1_1 ;
      correct := correct and co_time_1 = c_time_1 ;
      correct := correct and co_t_phys1_1 = c_t_phys1_1 ;
      correct := correct and co_st_phys1_1 = c_st_phys1_1 ;
      correct := correct and co_real_1 = c_real_1 ;
      correct := correct and co_t_real1_1 = c_t_real1_1 ;
      correct := correct and co_st_real1_1 = c_st_real1_1 ;
      test_report ( "ARCH00547" ,
      "Constant declarations - scalar static subtypes" ,
      correct) ;
      wait ;
   end process ;
end ARCH00547 ;
--
entity ENT00547_Test_Bench is
end ENT00547_Test_Bench ;
--
architecture ARCH00547_Test_Bench of ENT00547_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00547 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00547_Test_Bench ;
