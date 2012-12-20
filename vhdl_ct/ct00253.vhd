-- NEED RESULT: ENT00253: Open scalar linkage ports with static subtypes passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00253
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
--    ENT00253(ARCH00253)
--    ENT00253_Test_Bench(ARCH00253_Test_Bench)
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
entity ENT00253 is
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
end ENT00253 ;
--
architecture ARCH00253 of ENT00253 is
begin
   process
      variable correct : boolean := true ;
   begin
      test_report ( "ENT00253" ,
      "Open scalar linkage ports with static subtypes" ,
      correct) ;
      wait ;
   end process ;
end ARCH00253 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00253_Test_Bench is
end ENT00253_Test_Bench ;
--
architecture ARCH00253_Test_Bench of ENT00253_Test_Bench is
begin
   L1:
   block
--
      signal toggle : switch ;
--
      component UUT
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00253 ( ARCH00253 )
       port map (
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
end ARCH00253_Test_Bench ;
