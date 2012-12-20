-- NEED RESULT: ENT00231.P00231: Associated scalar out ports with static subtypes passed
-- NEED RESULT: ENT00231: Associated scalar out ports with static subtypes passed
-- NEED RESULT: ENT00231.P00231: Associated scalar out ports with static subtypes passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00231
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
--    ENT00231(ARCH00231)
--    ENT00231_Test_Bench(ARCH00231_Test_Bench)
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
entity ENT00231 is
   port (
          toggle : out switch := down;
       i_boolean_1, i_boolean_2 : out boolean
          := c_boolean_1
          ;
       i_bit_1, i_bit_2 : out bit
          := c_bit_1
          ;
       i_severity_level_1, i_severity_level_2 : out severity_level
          := c_severity_level_1
          ;
       i_character_1, i_character_2 : out character
          := c_character_1
          ;
       i_t_enum1_1, i_t_enum1_2 : out t_enum1
          := c_t_enum1_1
          ;
       i_st_enum1_1, i_st_enum1_2 : out st_enum1
          := c_st_enum1_1
          ;
       i_integer_1, i_integer_2 : out integer
          := c_integer_1
          ;
       i_t_int1_1, i_t_int1_2 : out t_int1
          := c_t_int1_1
          ;
       i_st_int1_1, i_st_int1_2 : out st_int1
          := c_st_int1_1
          ;
       i_time_1, i_time_2 : out time
          := c_time_1
          ;
       i_t_phys1_1, i_t_phys1_2 : out t_phys1
          := c_t_phys1_1
          ;
       i_st_phys1_1, i_st_phys1_2 : out st_phys1
          := c_st_phys1_1
          ;
       i_real_1, i_real_2 : out real
          := c_real_1
          ;
       i_t_real1_1, i_t_real1_2 : out t_real1
          := c_t_real1_1
          ;
       i_st_real1_1, i_st_real1_2 : out st_real1
          := c_st_real1_1
            ) ;
begin
end ENT00231 ;
--
architecture ARCH00231 of ENT00231 is
begin
   process
      variable correct : boolean := true ;
   begin
      test_report ( "ENT00231" ,
      "Associated scalar out ports with static subtypes" ,
      correct) ;
--
      toggle <= up ;
      i_boolean_1 <= c_boolean_2 ;
      i_boolean_2 <= c_boolean_2 ;
      i_bit_1 <= c_bit_2 ;
      i_bit_2 <= c_bit_2 ;
      i_severity_level_1 <= c_severity_level_2 ;
      i_severity_level_2 <= c_severity_level_2 ;
      i_character_1 <= c_character_2 ;
      i_character_2 <= c_character_2 ;
      i_t_enum1_1 <= c_t_enum1_2 ;
      i_t_enum1_2 <= c_t_enum1_2 ;
      i_st_enum1_1 <= c_st_enum1_2 ;
      i_st_enum1_2 <= c_st_enum1_2 ;
      i_integer_1 <= c_integer_2 ;
      i_integer_2 <= c_integer_2 ;
      i_t_int1_1 <= c_t_int1_2 ;
      i_t_int1_2 <= c_t_int1_2 ;
      i_st_int1_1 <= c_st_int1_2 ;
      i_st_int1_2 <= c_st_int1_2 ;
      i_time_1 <= c_time_2 ;
      i_time_2 <= c_time_2 ;
      i_t_phys1_1 <= c_t_phys1_2 ;
      i_t_phys1_2 <= c_t_phys1_2 ;
      i_st_phys1_1 <= c_st_phys1_2 ;
      i_st_phys1_2 <= c_st_phys1_2 ;
      i_real_1 <= c_real_2 ;
      i_real_2 <= c_real_2 ;
      i_t_real1_1 <= c_t_real1_2 ;
      i_t_real1_2 <= c_t_real1_2 ;
      i_st_real1_1 <= c_st_real1_2 ;
      i_st_real1_2 <= c_st_real1_2 ;
      wait ;
   end process ;
end ARCH00231 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00231_Test_Bench is
end ENT00231_Test_Bench ;
--
architecture ARCH00231_Test_Bench of ENT00231_Test_Bench is
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
                toggle : out switch ;
             i_boolean_1, i_boolean_2 : out boolean
                := c_boolean_1
                ;
             i_bit_1, i_bit_2 : out bit
                := c_bit_1
                ;
             i_severity_level_1, i_severity_level_2 : out severity_level
                := c_severity_level_1
                ;
             i_character_1, i_character_2 : out character
                := c_character_1
                ;
             i_t_enum1_1, i_t_enum1_2 : out t_enum1
                := c_t_enum1_1
                ;
             i_st_enum1_1, i_st_enum1_2 : out st_enum1
                := c_st_enum1_1
                ;
             i_integer_1, i_integer_2 : out integer
                := c_integer_1
                ;
             i_t_int1_1, i_t_int1_2 : out t_int1
                := c_t_int1_1
                ;
             i_st_int1_1, i_st_int1_2 : out st_int1
                := c_st_int1_1
                ;
             i_time_1, i_time_2 : out time
                := c_time_1
                ;
             i_t_phys1_1, i_t_phys1_2 : out t_phys1
                := c_t_phys1_1
                ;
             i_st_phys1_1, i_st_phys1_2 : out st_phys1
                := c_st_phys1_1
                ;
             i_real_1, i_real_2 : out real
                := c_real_1
                ;
             i_t_real1_1, i_t_real1_2 : out t_real1
                := c_t_real1_1
                ;
             i_st_real1_1, i_st_real1_2 : out st_real1
                := c_st_real1_1
                ) ;
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00231 ( ARCH00231 ) ;
--
   begin
      CIS1 : UUT
       port map (
                                       toggle ,
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
      P00231 :
      process ( toggle )
         variable correct : boolean := true ;
      begin
         if toggle = up then
               correct := correct and i_boolean_1 = c_boolean_2
                          and i_boolean_2 = c_boolean_2 ;
               correct := correct and i_bit_1 = c_bit_2
                          and i_bit_2 = c_bit_2 ;
               correct := correct and i_severity_level_1 = c_severity_level_2
                          and i_severity_level_2 = c_severity_level_2 ;
               correct := correct and i_character_1 = c_character_2
                          and i_character_2 = c_character_2 ;
               correct := correct and i_t_enum1_1 = c_t_enum1_2
                          and i_t_enum1_2 = c_t_enum1_2 ;
               correct := correct and i_st_enum1_1 = c_st_enum1_2
                          and i_st_enum1_2 = c_st_enum1_2 ;
               correct := correct and i_integer_1 = c_integer_2
                          and i_integer_2 = c_integer_2 ;
               correct := correct and i_t_int1_1 = c_t_int1_2
                          and i_t_int1_2 = c_t_int1_2 ;
               correct := correct and i_st_int1_1 = c_st_int1_2
                          and i_st_int1_2 = c_st_int1_2 ;
               correct := correct and i_time_1 = c_time_2
                          and i_time_2 = c_time_2 ;
               correct := correct and i_t_phys1_1 = c_t_phys1_2
                          and i_t_phys1_2 = c_t_phys1_2 ;
               correct := correct and i_st_phys1_1 = c_st_phys1_2
                          and i_st_phys1_2 = c_st_phys1_2 ;
               correct := correct and i_real_1 = c_real_2
                          and i_real_2 = c_real_2 ;
               correct := correct and i_t_real1_1 = c_t_real1_2
                          and i_t_real1_2 = c_t_real1_2 ;
               correct := correct and i_st_real1_1 = c_st_real1_2
                          and i_st_real1_2 = c_st_real1_2 ;
         end if ;
--
         test_report ( "ENT00231.P00231" ,
        "Associated scalar out ports with static subtypes",
                   correct) ;
      end process P00231 ;
   end block L1 ;
end ARCH00231_Test_Bench ;
