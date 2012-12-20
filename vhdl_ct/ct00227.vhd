-- NEED RESULT: ENT00227.P00227: Associated scalar inout ports with static subtypes passed
-- NEED RESULT: ENT00227: Associated scalar inout ports with static subtypes passed
-- NEED RESULT: ENT00227.P00227: Associated scalar inout ports with static subtypes passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00227
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
--    ENT00227(ARCH00227)
--    ENT00227_Test_Bench(ARCH00227_Test_Bench)
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
entity ENT00227 is
   port (
          toggle : inout switch := down;
       i_boolean_1, i_boolean_2 : inout boolean
          := c_boolean_1
          ;
       i_bit_1, i_bit_2 : inout bit
          := c_bit_1
          ;
       i_severity_level_1, i_severity_level_2 : inout severity_level
          := c_severity_level_1
          ;
       i_character_1, i_character_2 : inout character
          := c_character_1
          ;
       i_t_enum1_1, i_t_enum1_2 : inout t_enum1
          := c_t_enum1_1
          ;
       i_st_enum1_1, i_st_enum1_2 : inout st_enum1
          := c_st_enum1_1
          ;
       i_integer_1, i_integer_2 : inout integer
          := c_integer_1
          ;
       i_t_int1_1, i_t_int1_2 : inout t_int1
          := c_t_int1_1
          ;
       i_st_int1_1, i_st_int1_2 : inout st_int1
          := c_st_int1_1
          ;
       i_time_1, i_time_2 : inout time
          := c_time_1
          ;
       i_t_phys1_1, i_t_phys1_2 : inout t_phys1
          := c_t_phys1_1
          ;
       i_st_phys1_1, i_st_phys1_2 : inout st_phys1
          := c_st_phys1_1
          ;
       i_real_1, i_real_2 : inout real
          := c_real_1
          ;
       i_t_real1_1, i_t_real1_2 : inout t_real1
          := c_t_real1_1
          ;
       i_st_real1_1, i_st_real1_2 : inout st_real1
          := c_st_real1_1
            ) ;
begin
end ENT00227 ;
--
architecture ARCH00227 of ENT00227 is
begin
   process
      variable correct : boolean := true ;
   begin
      correct := correct and i_boolean_1 = c_boolean_1
                 and i_boolean_2 = c_boolean_1 ;
      correct := correct and i_bit_1 = c_bit_1
                 and i_bit_2 = c_bit_1 ;
      correct := correct and i_severity_level_1 = c_severity_level_1
                 and i_severity_level_2 = c_severity_level_1 ;
      correct := correct and i_character_1 = c_character_1
                 and i_character_2 = c_character_1 ;
      correct := correct and i_t_enum1_1 = c_t_enum1_1
                 and i_t_enum1_2 = c_t_enum1_1 ;
      correct := correct and i_st_enum1_1 = c_st_enum1_1
                 and i_st_enum1_2 = c_st_enum1_1 ;
      correct := correct and i_integer_1 = c_integer_1
                 and i_integer_2 = c_integer_1 ;
      correct := correct and i_t_int1_1 = c_t_int1_1
                 and i_t_int1_2 = c_t_int1_1 ;
      correct := correct and i_st_int1_1 = c_st_int1_1
                 and i_st_int1_2 = c_st_int1_1 ;
      correct := correct and i_time_1 = c_time_1
                 and i_time_2 = c_time_1 ;
      correct := correct and i_t_phys1_1 = c_t_phys1_1
                 and i_t_phys1_2 = c_t_phys1_1 ;
      correct := correct and i_st_phys1_1 = c_st_phys1_1
                 and i_st_phys1_2 = c_st_phys1_1 ;
      correct := correct and i_real_1 = c_real_1
                 and i_real_2 = c_real_1 ;
      correct := correct and i_t_real1_1 = c_t_real1_1
                 and i_t_real1_2 = c_t_real1_1 ;
      correct := correct and i_st_real1_1 = c_st_real1_1
                 and i_st_real1_2 = c_st_real1_1 ;
--
      test_report ( "ENT00227" ,
      "Associated scalar inout ports with static subtypes" ,
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
end ARCH00227 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00227_Test_Bench is
end ENT00227_Test_Bench ;
--
architecture ARCH00227_Test_Bench of ENT00227_Test_Bench is
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
                toggle : inout switch ;
             i_boolean_1, i_boolean_2 : inout boolean
                := c_boolean_1
                ;
             i_bit_1, i_bit_2 : inout bit
                := c_bit_1
                ;
             i_severity_level_1, i_severity_level_2 : inout severity_level
                := c_severity_level_1
                ;
             i_character_1, i_character_2 : inout character
                := c_character_1
                ;
             i_t_enum1_1, i_t_enum1_2 : inout t_enum1
                := c_t_enum1_1
                ;
             i_st_enum1_1, i_st_enum1_2 : inout st_enum1
                := c_st_enum1_1
                ;
             i_integer_1, i_integer_2 : inout integer
                := c_integer_1
                ;
             i_t_int1_1, i_t_int1_2 : inout t_int1
                := c_t_int1_1
                ;
             i_st_int1_1, i_st_int1_2 : inout st_int1
                := c_st_int1_1
                ;
             i_time_1, i_time_2 : inout time
                := c_time_1
                ;
             i_t_phys1_1, i_t_phys1_2 : inout t_phys1
                := c_t_phys1_1
                ;
             i_st_phys1_1, i_st_phys1_2 : inout st_phys1
                := c_st_phys1_1
                ;
             i_real_1, i_real_2 : inout real
                := c_real_1
                ;
             i_t_real1_1, i_t_real1_2 : inout t_real1
                := c_t_real1_1
                ;
             i_st_real1_1, i_st_real1_2 : inout st_real1
                := c_st_real1_1
                ) ;
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00227 ( ARCH00227 ) ;
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
      P00227 :
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
         test_report ( "ENT00227.P00227" ,
        "Associated scalar inout ports with static subtypes",
                   correct) ;
      end process P00227 ;
   end block L1 ;
end ARCH00227_Test_Bench ;
