-- NEED RESULT: ENT00702: Open composite out ports with static subtypes passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00702
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
--    ENT00702(ARCH00702)
--    ENT00702_Test_Bench(ARCH00702_Test_Bench)
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
entity ENT00702 is
   port (
          toggle : out switch ;
       i_st_rec1_1, i_st_rec1_2 : out st_rec1
          := c_st_rec1_1
          ;
       i_st_rec2_1, i_st_rec2_2 : out st_rec2
          := c_st_rec2_1
          ;
       i_st_rec3_1, i_st_rec3_2 : out st_rec3
          := c_st_rec3_1
          ;
       i_st_arr1_1, i_st_arr1_2 : out st_arr1
          := c_st_arr1_1
          ;
       i_st_arr2_1, i_st_arr2_2 : out st_arr2
          := c_st_arr2_1
          ;
       i_st_arr3_1, i_st_arr3_2 : out st_arr3
          := c_st_arr3_1
            ) ;
begin
end ENT00702 ;
--
architecture ARCH00702 of ENT00702 is
begin
   process
      variable correct : boolean := true ;
   begin
--
      toggle <= up ;
      i_st_rec1_1 <= c_st_rec1_2 ;
      i_st_rec1_2 <= c_st_rec1_2 ;
      i_st_rec2_1 <= c_st_rec2_2 ;
      i_st_rec2_2 <= c_st_rec2_2 ;
      i_st_rec3_1 <= c_st_rec3_2 ;
      i_st_rec3_2 <= c_st_rec3_2 ;
      i_st_arr1_1 <= c_st_arr1_2 ;
      i_st_arr1_2 <= c_st_arr1_2 ;
      i_st_arr2_1 <= c_st_arr2_2 ;
      i_st_arr2_2 <= c_st_arr2_2 ;
      i_st_arr3_1 <= c_st_arr3_2 ;
      i_st_arr3_2 <= c_st_arr3_2 ;
      test_report ( "ENT00702" ,
      "Open composite out ports with static subtypes" ,
      correct) ;
      wait ;
   end process ;
end ARCH00702 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00702_Test_Bench is
end ENT00702_Test_Bench ;
--
architecture ARCH00702_Test_Bench of ENT00702_Test_Bench is
begin
   L1:
   block
--
      signal toggle : switch ;
--
      component UUT
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00702 ( ARCH00702 )
       port map (
                                       toggle ,
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
end ARCH00702_Test_Bench ;
