-- NEED RESULT: ARCH00149.P1: Multi inertial transactions occurred on signal asg with selected name on LHS passed
-- NEED RESULT: ARCH00149.P2: Multi inertial transactions occurred on signal asg with selected name on LHS passed
-- NEED RESULT: ARCH00149.P3: Multi inertial transactions occurred on signal asg with selected name on LHS passed
-- NEED RESULT: ARCH00149: One inertial transaction occurred on signal asg with selected name on LHS passed
-- NEED RESULT: ARCH00149: One inertial transaction occurred on signal asg with selected name on LHS passed
-- NEED RESULT: ARCH00149: One inertial transaction occurred on signal asg with selected name on LHS passed
-- NEED RESULT: P3: Inertial transactions entirely completed failed
-- NEED RESULT: P2: Inertial transactions entirely completed failed
-- NEED RESULT: P1: Inertial transactions entirely completed failed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00149
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.3 (1)
--    8.3 (2)
--    8.3 (4)
--    8.3 (5)
--    8.3.1 (4)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00149)
--    ENT00149_Test_Bench(ARCH00149_Test_Bench)
--
-- REVISION HISTORY:
--
--    08-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00149 of E00000 is
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_st_rec1 : chk_sig_type := -1 ;
   signal chk_st_rec2 : chk_sig_type := -1 ;
   signal chk_st_rec3 : chk_sig_type := -1 ;
--
   signal s_st_rec1 : st_rec1
     := c_st_rec1_1 ;
   signal s_st_rec2 : st_rec2
     := c_st_rec2_1 ;
   signal s_st_rec3 : st_rec3
     := c_st_rec3_1 ;
--
begin
   P1 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_rec1.f2 <=
               c_st_rec1_2.f2 after 10 ns,
               c_st_rec1_1.f2 after 20 ns ;
--
         when 1
         => correct :=
               s_st_rec1.f2 = c_st_rec1_2.f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_rec1.f2 = c_st_rec1_1.f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00149.P1" ,
              "Multi inertial transactions occurred on signal " &
              "asg with selected name on LHS",
              correct ) ;
            s_st_rec1.f2 <=
               c_st_rec1_2.f2 after 10 ns ,
               c_st_rec1_1.f2 after 20 ns ,
               c_st_rec1_2.f2 after 30 ns ,
               c_st_rec1_1.f2 after 40 ns ;
--
         when 3
         => correct :=
               s_st_rec1.f2 = c_st_rec1_2.f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_rec1.f2 <= c_st_rec1_1.f2 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_rec1.f2 = c_st_rec1_1.f2 and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00149" ,
              "One inertial transaction occurred on signal " &
              "asg with selected name on LHS",
              correct ) ;
            s_st_rec1.f2 <= transport
               c_st_rec1_1.f2 after 100 ns ;
--
         when 5
         => correct :=
               s_st_rec1.f2 = c_st_rec1_1.f2 and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00149" ,
              "Old transactions were removed on signal " &
              "asg with selected name on LHS",
              correct ) ;
            s_st_rec1.f2 <=
               c_st_rec1_2.f2 after 10 ns ,
               c_st_rec1_1.f2 after 20 ns ,
               c_st_rec1_2.f2 after 30 ns ,
               c_st_rec1_1.f2 after 40 ns ;
--
         when 6
         => correct :=
               s_st_rec1.f2 = c_st_rec1_2.f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00149" ,
              "One inertial transaction occurred on signal " &
              "asg with selected name on LHS",
              correct ) ;
            s_st_rec1.f2 <=    -- Last transaction above is marked
               c_st_rec1_1.f2 after 40 ns ;
--
         when 7
         => correct :=
               s_st_rec1.f2 = c_st_rec1_1.f2 and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_st_rec1.f2 = c_st_rec1_1.f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00149" ,
              "Inertial semantics check on a signal " &
              "asg with selected name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00149" ,
              "Inertial semantics check on a signal " &
              "asg with selected name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_rec1 <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_st_rec1'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P1 ;
--
   PGEN_CHKP_1 :
   process ( chk_st_rec1 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Inertial transactions entirely completed",
           chk_st_rec1 = 8 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
   P2 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_rec2.f2 <=
               c_st_rec2_2.f2 after 10 ns,
               c_st_rec2_1.f2 after 20 ns ;
--
         when 1
         => correct :=
               s_st_rec2.f2 = c_st_rec2_2.f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_rec2.f2 = c_st_rec2_1.f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00149.P2" ,
              "Multi inertial transactions occurred on signal " &
              "asg with selected name on LHS",
              correct ) ;
            s_st_rec2.f2 <=
               c_st_rec2_2.f2 after 10 ns ,
               c_st_rec2_1.f2 after 20 ns ,
               c_st_rec2_2.f2 after 30 ns ,
               c_st_rec2_1.f2 after 40 ns ;
--
         when 3
         => correct :=
               s_st_rec2.f2 = c_st_rec2_2.f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_rec2.f2 <= c_st_rec2_1.f2 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_rec2.f2 = c_st_rec2_1.f2 and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00149" ,
              "One inertial transaction occurred on signal " &
              "asg with selected name on LHS",
              correct ) ;
            s_st_rec2.f2 <= transport
               c_st_rec2_1.f2 after 100 ns ;
--
         when 5
         => correct :=
               s_st_rec2.f2 = c_st_rec2_1.f2 and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00149" ,
              "Old transactions were removed on signal " &
              "asg with selected name on LHS",
              correct ) ;
            s_st_rec2.f2 <=
               c_st_rec2_2.f2 after 10 ns ,
               c_st_rec2_1.f2 after 20 ns ,
               c_st_rec2_2.f2 after 30 ns ,
               c_st_rec2_1.f2 after 40 ns ;
--
         when 6
         => correct :=
               s_st_rec2.f2 = c_st_rec2_2.f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00149" ,
              "One inertial transaction occurred on signal " &
              "asg with selected name on LHS",
              correct ) ;
            s_st_rec2.f2 <=    -- Last transaction above is marked
               c_st_rec2_1.f2 after 40 ns ;
--
         when 7
         => correct :=
               s_st_rec2.f2 = c_st_rec2_1.f2 and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_st_rec2.f2 = c_st_rec2_1.f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00149" ,
              "Inertial semantics check on a signal " &
              "asg with selected name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00149" ,
              "Inertial semantics check on a signal " &
              "asg with selected name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_rec2 <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_st_rec2'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P2 ;
--
   PGEN_CHKP_2 :
   process ( chk_st_rec2 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P2" ,
           "Inertial transactions entirely completed",
           chk_st_rec2 = 8 ) ;
      end if ;
   end process PGEN_CHKP_2 ;
--
   P3 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_rec3.f2 <=
               c_st_rec3_2.f2 after 10 ns,
               c_st_rec3_1.f2 after 20 ns ;
--
         when 1
         => correct :=
               s_st_rec3.f2 = c_st_rec3_2.f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_rec3.f2 = c_st_rec3_1.f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00149.P3" ,
              "Multi inertial transactions occurred on signal " &
              "asg with selected name on LHS",
              correct ) ;
            s_st_rec3.f2 <=
               c_st_rec3_2.f2 after 10 ns ,
               c_st_rec3_1.f2 after 20 ns ,
               c_st_rec3_2.f2 after 30 ns ,
               c_st_rec3_1.f2 after 40 ns ;
--
         when 3
         => correct :=
               s_st_rec3.f2 = c_st_rec3_2.f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_rec3.f2 <= c_st_rec3_1.f2 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_rec3.f2 = c_st_rec3_1.f2 and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00149" ,
              "One inertial transaction occurred on signal " &
              "asg with selected name on LHS",
              correct ) ;
            s_st_rec3.f2 <= transport
               c_st_rec3_1.f2 after 100 ns ;
--
         when 5
         => correct :=
               s_st_rec3.f2 = c_st_rec3_1.f2 and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00149" ,
              "Old transactions were removed on signal " &
              "asg with selected name on LHS",
              correct ) ;
            s_st_rec3.f2 <=
               c_st_rec3_2.f2 after 10 ns ,
               c_st_rec3_1.f2 after 20 ns ,
               c_st_rec3_2.f2 after 30 ns ,
               c_st_rec3_1.f2 after 40 ns ;
--
         when 6
         => correct :=
               s_st_rec3.f2 = c_st_rec3_2.f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00149" ,
              "One inertial transaction occurred on signal " &
              "asg with selected name on LHS",
              correct ) ;
            s_st_rec3.f2 <=    -- Last transaction above is marked
               c_st_rec3_1.f2 after 40 ns ;
--
         when 7
         => correct :=
               s_st_rec3.f2 = c_st_rec3_1.f2 and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_st_rec3.f2 = c_st_rec3_1.f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00149" ,
              "Inertial semantics check on a signal " &
              "asg with selected name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00149" ,
              "Inertial semantics check on a signal " &
              "asg with selected name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_rec3 <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_st_rec3'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P3 ;
--
   PGEN_CHKP_3 :
   process ( chk_st_rec3 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P3" ,
           "Inertial transactions entirely completed",
           chk_st_rec3 = 8 ) ;
      end if ;
   end process PGEN_CHKP_3 ;
--
--
end ARCH00149 ;
--
entity ENT00149_Test_Bench is
end ENT00149_Test_Bench ;
--
architecture ARCH00149_Test_Bench of ENT00149_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00149 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00149_Test_Bench ;
