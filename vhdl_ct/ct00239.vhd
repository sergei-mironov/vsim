-- NEED RESULT: ENT00239: Associated scalar linkage ports with static subtypes passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00239
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.1.1.2 (4)
--    1.1.1.2 (5)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00239(ARCH00239)
--    ENT00239_Test_Bench(ARCH00239_Test_Bench)
--
-- REVISION HISTORY:
--
--    25-JUN-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
entity ENT00239 is
   port (
       i_boolean_1, i_boolean_2 : linkage boolean
          ;
       i_bit_1, i_bit_2 : linkage bit
          ;
       i_severity_level_1, i_severity_level_2 : linkage severity_level
          ;
       i_character_1, i_character_2 : linkage character
          ;
       i_t_enum1_1, i_t_enum1_2 : linkage t_enum1
          ;
       i_st_enum1_1, i_st_enum1_2 : linkage st_enum1
          ;
       i_integer_1, i_integer_2 : linkage integer
          ;
       i_t_int1_1, i_t_int1_2 : linkage t_int1
          ;
       i_st_int1_1, i_st_int1_2 : linkage st_int1
          ;
       i_time_1, i_time_2 : linkage time
          ;
       i_t_phys1_1, i_t_phys1_2 : linkage t_phys1
          ;
       i_st_phys1_1, i_st_phys1_2 : linkage st_phys1
          ;
       i_real_1, i_real_2 : linkage real
          ;
       i_t_real1_1, i_t_real1_2 : linkage t_real1
          ;
       i_st_real1_1, i_st_real1_2 : linkage st_real1
            ) ;
begin
end ENT00239 ;
--
architecture ARCH00239 of ENT00239 is
begin
   process
      variable correct : boolean := true ;
   begin
      test_report ( "ENT00239" ,
      "Associated scalar linkage ports with static subtypes" ,
      correct) ;
      wait ;
   end process ;
end ARCH00239 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00239_Test_Bench is
end ENT00239_Test_Bench ;
--
architecture ARCH00239_Test_Bench of ENT00239_Test_Bench is
begin
   L1:
   block
      signal i_boolean_1, i_boolean_2 : boolean
          := c_boolean_1 ;
      signal i_bit_1, i_bit_2 : bit
          := c_bit_1 ;
      signal i_severity_level_1, i_severity_level_2 : severity_level
          := c_severity_level_1 ;
      signal i_character_1, i_character_2 : character
          := c_character_1 ;
      signal i_t_enum1_1, i_t_enum1_2 : t_enum1
          := c_t_enum1_1 ;
      signal i_st_enum1_1, i_st_enum1_2 : st_enum1
          := c_st_enum1_1 ;
      signal i_integer_1, i_integer_2 : integer
          := c_integer_1 ;
      signal i_t_int1_1, i_t_int1_2 : t_int1
          := c_t_int1_1 ;
      signal i_st_int1_1, i_st_int1_2 : st_int1
          := c_st_int1_1 ;
      signal i_time_1, i_time_2 : time
          := c_time_1 ;
      signal i_t_phys1_1, i_t_phys1_2 : t_phys1
          := c_t_phys1_1 ;
      signal i_st_phys1_1, i_st_phys1_2 : st_phys1
          := c_st_phys1_1 ;
      signal i_real_1, i_real_2 : real
          := c_real_1 ;
      signal i_t_real1_1, i_t_real1_2 : t_real1
          := c_t_real1_1 ;
      signal i_st_real1_1, i_st_real1_2 : st_real1
          := c_st_real1_1 ;
--
      component UUT
         port (
             i_boolean_1, i_boolean_2 : linkage boolean
                ;
             i_bit_1, i_bit_2 : linkage bit
                ;
             i_severity_level_1, i_severity_level_2 : linkage severity_level
                ;
             i_character_1, i_character_2 : linkage character
                ;
             i_t_enum1_1, i_t_enum1_2 : linkage t_enum1
                ;
             i_st_enum1_1, i_st_enum1_2 : linkage st_enum1
                ;
             i_integer_1, i_integer_2 : linkage integer
                ;
             i_t_int1_1, i_t_int1_2 : linkage t_int1
                ;
             i_st_int1_1, i_st_int1_2 : linkage st_int1
                ;
             i_time_1, i_time_2 : linkage time
                ;
             i_t_phys1_1, i_t_phys1_2 : linkage t_phys1
                ;
             i_st_phys1_1, i_st_phys1_2 : linkage st_phys1
                ;
             i_real_1, i_real_2 : linkage real
                ;
             i_t_real1_1, i_t_real1_2 : linkage t_real1
                ;
             i_st_real1_1, i_st_real1_2 : linkage st_real1
                ) ;
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00239 ( ARCH00239 ) ;
--
   begin
      CIS1 : UUT
       port map (
                               i_boolean_1, i_boolean_2,
                               i_bit_1, i_bit_2,
                               i_severity_level_1, i_severity_level_2,
                               i_character_1, i_character_2,
                               i_t_enum1_1, i_t_enum1_2,
                               i_st_enum1_1, i_st_enum1_2,
                               i_integer_1, i_integer_2,
                               i_t_int1_1, i_t_int1_2,
                               i_st_int1_1, i_st_int1_2,
                               i_time_1, i_time_2,
                               i_t_phys1_1, i_t_phys1_2,
                               i_st_phys1_1, i_st_phys1_2,
                               i_real_1, i_real_2,
                               i_t_real1_1, i_t_real1_2,
                               i_st_real1_1, i_st_real1_2
                                      ) ;
   end block L1 ;
end ARCH00239_Test_Bench ;
