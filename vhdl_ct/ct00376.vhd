-- NEED RESULT: ARCH00376.P1: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00376: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00376: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: P1: Transport transactions completed entirely passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00376
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.5 (2)
--    9.5.1 (1)
--    9.5.1 (2)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00376(ARCH00376)
--    ENT00376_Test_Bench(ARCH00376_Test_Bench)
--
-- REVISION HISTORY:
--
--    30-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
entity ENT00376 is
end ENT00376 ;
--
--
architecture ARCH00376 of ENT00376 is
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_st_rec3 : chk_sig_type := -1 ;
--
   subtype chk_time_type is Time ;
   signal s_st_rec3_savt : chk_time_type := 0 ns ;
--
   subtype chk_cnt_type is Integer ;
   signal s_st_rec3_cnt : chk_cnt_type := 0 ;
--
   type select_type is range 1 to 3 ;
   signal st_rec3_select : select_type := 1 ;
--
   signal s_st_rec3 : st_rec3
     := c_st_rec3_1 ;
--
begin
   CHG1 :
   process ( s_st_rec3 )
      variable correct : boolean ;
   begin
      case s_st_rec3_cnt is
         when 0
         => null ;
              -- s_st_rec3.f2.f2 <= transport
              --   c_st_rec3_2.f2.f2 after 10 ns,
              --   c_st_rec3_1.f2.f2 after 20 ns ;
--
         when 1
         => correct :=
               s_st_rec3.f2.f2 =
                 c_st_rec3_2.f2.f2 and
               (s_st_rec3_savt + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_rec3.f2.f2 =
                 c_st_rec3_1.f2.f2 and
               (s_st_rec3_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00376.P1" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            st_rec3_select <= transport 2 ;
              -- s_st_rec3.f2.f2 <= transport
              --   c_st_rec3_2.f2.f2 after 10 ns ,
              --   c_st_rec3_1.f2.f2 after 20 ns ,
              --   c_st_rec3_2.f2.f2 after 30 ns ,
              --   c_st_rec3_1.f2.f2 after 40 ns ;
--
         when 3
         => correct :=
               s_st_rec3.f2.f2 =
                 c_st_rec3_2.f2.f2 and
               (s_st_rec3_savt + 10 ns) = Std.Standard.Now ;
            st_rec3_select <= transport 3 ;
              -- s_st_rec3.f2.f2 <= transport
              --   c_st_rec3_1.f2.f2 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_rec3.f2.f2 =
                 c_st_rec3_1.f2.f2 and
               (s_st_rec3_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00376" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00376" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00376" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      s_st_rec3_savt <= transport Std.Standard.Now ;
      chk_st_rec3 <= transport s_st_rec3_cnt
          after (1 us - Std.Standard.Now) ;
      s_st_rec3_cnt <= transport s_st_rec3_cnt + 1 ;
--
   end process CHG1 ;
--
   PGEN_CHKP_1 :
   process ( chk_st_rec3 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Transport transactions completed entirely",
           chk_st_rec3 = 4 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
--
      s_st_rec3.f2.f2 <= transport
        c_st_rec3_2.f2.f2 after 10 ns,
        c_st_rec3_1.f2.f2 after 20 ns
        when st_rec3_select = 1 else
--
        c_st_rec3_2.f2.f2 after 10 ns ,
        c_st_rec3_1.f2.f2 after 20 ns ,
        c_st_rec3_2.f2.f2 after 30 ns ,
        c_st_rec3_1.f2.f2 after 40 ns
        when st_rec3_select = 2 else
--
        c_st_rec3_1.f2.f2 after 5 ns ;
--
end ARCH00376 ;
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00376_Test_Bench is
end ENT00376_Test_Bench ;
--
--
architecture ARCH00376_Test_Bench of ENT00376_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00376 ( ARCH00376 ) ;
   begin
      CIS1 : UUT
         ;
   end block L1 ;
end ARCH00376_Test_Bench ;
