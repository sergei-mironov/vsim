-- NEED RESULT: ENT00024: Associated scalar ports with static subtypes passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00024
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
--    ENT00024(ARCH00024)
--    ENT00024_Test_Bench(ARCH00024_Test_Bench)
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
entity ENT00024 is
   port (
       i_boolean_1, i_boolean_2 : in boolean
          := c_boolean_1
          ;
       i_bit_1, i_bit_2 : in bit
          := c_bit_1
          ;
       i_severity_level_1, i_severity_level_2 : in severity_level
          := c_severity_level_1
          ;
       i_character_1, i_character_2 : in character
          := c_character_1
          ;
       i_t_enum1_1, i_t_enum1_2 : in t_enum1
          := c_t_enum1_1
          ;
       i_st_enum1_1, i_st_enum1_2 : in st_enum1
          := c_st_enum1_1
          ;
       i_integer_1, i_integer_2 : in integer
          := c_integer_1
          ;
       i_t_int1_1, i_t_int1_2 : in t_int1
          := c_t_int1_1
          ;
       i_st_int1_1, i_st_int1_2 : in st_int1
          := c_st_int1_1
          ;
       i_time_1, i_time_2 : in time
          := c_time_1
          ;
       i_t_phys1_1, i_t_phys1_2 : in t_phys1
          := c_t_phys1_1
          ;
       i_st_phys1_1, i_st_phys1_2 : in st_phys1
          := c_st_phys1_1
          ;
       i_real_1, i_real_2 : in real
          := c_real_1
          ;
       i_t_real1_1, i_t_real1_2 : in t_real1
          := c_t_real1_1
          ;
       i_st_real1_1, i_st_real1_2 : in st_real1
          := c_st_real1_1
            ) ;
begin
end ENT00024 ;
--
architecture ARCH00024 of ENT00024 is
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
      test_report ( "ENT00024" ,
      "Associated scalar ports with static subtypes" ,
      correct) ;
      wait ;
   end process ;
end ARCH00024 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00024_Test_Bench is
end ENT00024_Test_Bench ;
--
architecture ARCH00024_Test_Bench of ENT00024_Test_Bench is
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
      component UUT
         port (
             i_boolean_1, i_boolean_2 : in boolean
                := c_boolean_1
                ;
             i_bit_1, i_bit_2 : in bit
                := c_bit_1
                ;
             i_severity_level_1, i_severity_level_2 : in severity_level
                := c_severity_level_1
                ;
             i_character_1, i_character_2 : in character
                := c_character_1
                ;
             i_t_enum1_1, i_t_enum1_2 : in t_enum1
                := c_t_enum1_1
                ;
             i_st_enum1_1, i_st_enum1_2 : in st_enum1
                := c_st_enum1_1
                ;
             i_integer_1, i_integer_2 : in integer
                := c_integer_1
                ;
             i_t_int1_1, i_t_int1_2 : in t_int1
                := c_t_int1_1
                ;
             i_st_int1_1, i_st_int1_2 : in st_int1
                := c_st_int1_1
                ;
             i_time_1, i_time_2 : in time
                := c_time_1
                ;
             i_t_phys1_1, i_t_phys1_2 : in t_phys1
                := c_t_phys1_1
                ;
             i_st_phys1_1, i_st_phys1_2 : in st_phys1
                := c_st_phys1_1
                ;
             i_real_1, i_real_2 : in real
                := c_real_1
                ;
             i_t_real1_1, i_t_real1_2 : in t_real1
                := c_t_real1_1
                ;
             i_st_real1_1, i_st_real1_2 : in st_real1
                := c_st_real1_1
                  ) ;
      end component ;
      for CIS1 : UUT use entity WORK.ENT00024 (ARCH00024) ;
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
end ARCH00024_Test_Bench ;
