-- NEED RESULT: ARCH00151.P1: Multi inertial transactions occurred on signal asg with selected name on LHS passed
-- NEED RESULT: ARCH00151.P2: Multi inertial transactions occurred on signal asg with selected name on LHS failed
-- NEED RESULT: ARCH00151.P3: Multi inertial transactions occurred on signal asg with selected name on LHS failed
-- NEED RESULT: ARCH00151: One inertial transaction occurred on signal asg with selected name on LHS passed
-- NEED RESULT: ARCH00151: One inertial transaction occurred on signal asg with selected name on LHS failed
-- NEED RESULT: ARCH00151: One inertial transaction occurred on signal asg with selected name on LHS failed
-- NEED RESULT: ARCH00151: Old transactions were removed on signal asg with selected name on LHS failed
-- NEED RESULT: ARCH00151: Old transactions were removed on signal asg with selected name on LHS failed
-- NEED RESULT: ARCH00151: One inertial transaction occurred on signal asg with selected name on LHS failed
-- NEED RESULT: ARCH00151: One inertial transaction occurred on signal asg with selected name on LHS failed
-- NEED RESULT: ARCH00151: Inertial semantics check on a signal asg with selected name on LHS failed
-- NEED RESULT: ARCH00151: Inertial semantics check on a signal asg with selected name on LHS failed
-- NEED RESULT: ARCH00151: Inertial semantics check on a signal asg with selected name on LHS failed
-- NEED RESULT: ARCH00151: Inertial semantics check on a signal asg with selected name on LHS failed
-- NEED RESULT: ARCH00151: Inertial semantics check on a signal asg with selected name on LHS failed
-- NEED RESULT: ARCH00151: Inertial semantics check on a signal asg with selected name on LHS failed
-- NEED RESULT: ARCH00151: Old transactions were removed on signal asg with selected name on LHS passed
-- NEED RESULT: ARCH00151: One inertial transaction occurred on signal asg with selected name on LHS passed
-- NEED RESULT: ARCH00151: Inertial semantics check on a signal asg with selected name on LHS passed
-- NEED RESULT: P3: Inertial transactions entirely completed failed
-- NEED RESULT: P2: Inertial transactions entirely completed failed
-- NEED RESULT: P1: Inertial transactions entirely completed passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00151
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
--    ENT00151(ARCH00151)
--    ENT00151_Test_Bench(ARCH00151_Test_Bench)
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
entity ENT00151 is
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_st_rec1 : chk_sig_type := -1 ;
   signal chk_st_rec2 : chk_sig_type := -1 ;
   signal chk_st_rec3 : chk_sig_type := -1 ;
--
   procedure Proc1 (
      signal   s_st_rec1 : inout st_rec1 ;
      variable counter : inout integer ;
      variable correct : inout boolean ;
      variable savtime : inout time ;
      signal   chk_st_rec1 : out chk_sig_type
                   )
   is
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
            test_report ( "ARCH00151.P1" ,
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
            test_report ( "ARCH00151" ,
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
            test_report ( "ARCH00151" ,
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
            test_report ( "ARCH00151" ,
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
            test_report ( "ARCH00151" ,
              "Inertial semantics check on a signal " &
              "asg with selected name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00151" ,
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
   end Proc1 ;
--
   procedure Proc2 (
      signal   s_st_rec2 : inout st_rec2 ;
      variable counter : inout integer ;
      variable correct : inout boolean ;
      variable savtime : inout time ;
      signal   chk_st_rec2 : out chk_sig_type
                   )
   is
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
            test_report ( "ARCH00151.P2" ,
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
            test_report ( "ARCH00151" ,
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
            test_report ( "ARCH00151" ,
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
            test_report ( "ARCH00151" ,
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
            test_report ( "ARCH00151" ,
              "Inertial semantics check on a signal " &
              "asg with selected name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00151" ,
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
   end Proc2 ;
--
   procedure Proc3 (
      signal   s_st_rec3 : inout st_rec3 ;
      variable counter : inout integer ;
      variable correct : inout boolean ;
      variable savtime : inout time ;
      signal   chk_st_rec3 : out chk_sig_type
                   )
   is
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
            test_report ( "ARCH00151.P3" ,
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
            test_report ( "ARCH00151" ,
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
            test_report ( "ARCH00151" ,
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
            test_report ( "ARCH00151" ,
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
            test_report ( "ARCH00151" ,
              "Inertial semantics check on a signal " &
              "asg with selected name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00151" ,
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
   end Proc3 ;
--
--
end ENT00151 ;
--
architecture ARCH00151 of ENT00151 is
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
      variable counter : integer := 0 ;
      variable correct : boolean ;
      variable savtime : time ;
   begin
      Proc1 (
          s_st_rec1,
          counter,
          correct,
          savtime,
          chk_st_rec1
         ) ;
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
      variable counter : integer := 0 ;
      variable correct : boolean ;
      variable savtime : time ;
   begin
      Proc2 (
          s_st_rec2,
          counter,
          correct,
          savtime,
          chk_st_rec2
         ) ;
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
      variable counter : integer := 0 ;
      variable correct : boolean ;
      variable savtime : time ;
   begin
      Proc3 (
          s_st_rec3,
          counter,
          correct,
          savtime,
          chk_st_rec3
         ) ;
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
end ARCH00151 ;
--
entity ENT00151_Test_Bench is
end ENT00151_Test_Bench ;
--
architecture ARCH00151_Test_Bench of ENT00151_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.ENT00151 ( ARCH00151 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00151_Test_Bench ;
