-- NEED RESULT: ENT00701: Open composite inout ports with static subtypes passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00701
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
--    ENT00701(ARCH00701)
--    ENT00701_Test_Bench(ARCH00701_Test_Bench)
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
entity ENT00701 is
   port (
          toggle : inout switch ;
       i_st_rec1_1, i_st_rec1_2 : inout st_rec1
          := c_st_rec1_1
          ;
       i_st_rec2_1, i_st_rec2_2 : inout st_rec2
          := c_st_rec2_1
          ;
       i_st_rec3_1, i_st_rec3_2 : inout st_rec3
          := c_st_rec3_1
          ;
       i_st_arr1_1, i_st_arr1_2 : inout st_arr1
          := c_st_arr1_1
          ;
       i_st_arr2_1, i_st_arr2_2 : inout st_arr2
          := c_st_arr2_1
          ;
       i_st_arr3_1, i_st_arr3_2 : inout st_arr3
          := c_st_arr3_1
            ) ;
begin
end ENT00701 ;
--
architecture ARCH00701 of ENT00701 is
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
      test_report ( "ENT00701" ,
      "Open composite inout ports with static subtypes" ,
      correct) ;
      wait ;
   end process ;
end ARCH00701 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00701_Test_Bench is
end ENT00701_Test_Bench ;
--
architecture ARCH00701_Test_Bench of ENT00701_Test_Bench is
begin
   L1:
   block
--
      signal toggle : switch ;
--
      component UUT
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00701 ( ARCH00701 )
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
end ARCH00701_Test_Bench ;
