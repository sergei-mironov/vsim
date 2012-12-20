-- NEED RESULT: ENT00251: Open scalar out ports with static subtypes passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00251
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.1.1.2 (3)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00251(ARCH00251)
--    ENT00251_Test_Bench(ARCH00251_Test_Bench)
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
entity ENT00251 is
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
begin
end ENT00251 ;
--
architecture ARCH00251 of ENT00251 is
begin
   process
      variable correct : boolean := true ;
   begin
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
      test_report ( "ENT00251" ,
      "Open scalar out ports with static subtypes" ,
      correct) ;
      wait ;
   end process ;
end ARCH00251 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00251_Test_Bench is
end ENT00251_Test_Bench ;
--
architecture ARCH00251_Test_Bench of ENT00251_Test_Bench is
begin
   L1:
   block
--
      signal toggle : switch ;
--
      component UUT
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00251 ( ARCH00251 )
       port map (
                                       toggle ,
                               open, open,
                               open, open,
                               open, open,
                               open, open,
                               open, open,
                               open, open,
                               open, open,
                               open, open,
                               open, open,
                               open, open,
                               open, open,
                               open, open,
                               open, open,
                               open, open,
                               open, open
                                      ) ;
--
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00251_Test_Bench ;
