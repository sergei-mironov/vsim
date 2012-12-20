-- NEED RESULT: ENT00704: Open composite linkage ports with static subtypes passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00704
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
--    ENT00704(ARCH00704)
--    ENT00704_Test_Bench(ARCH00704_Test_Bench)
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
entity ENT00704 is
   port (
       i_st_rec1_1, i_st_rec1_2 : linkage st_rec1
          ;
       i_st_rec2_1, i_st_rec2_2 : linkage st_rec2
          ;
       i_st_rec3_1, i_st_rec3_2 : linkage st_rec3
          ;
       i_st_arr1_1, i_st_arr1_2 : linkage st_arr1
          ;
       i_st_arr2_1, i_st_arr2_2 : linkage st_arr2
          ;
       i_st_arr3_1, i_st_arr3_2 : linkage st_arr3
            ) ;
begin
end ENT00704 ;
--
architecture ARCH00704 of ENT00704 is
begin
   process
      variable correct : boolean := true ;
   begin
      test_report ( "ENT00704" ,
      "Open composite linkage ports with static subtypes" ,
      correct) ;
      wait ;
   end process ;
end ARCH00704 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00704_Test_Bench is
end ENT00704_Test_Bench ;
--
architecture ARCH00704_Test_Bench of ENT00704_Test_Bench is
begin
   L1:
   block
--
      signal toggle : switch ;
--
      component UUT
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00704 ( ARCH00704 )
       port map (
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
end ARCH00704_Test_Bench ;
