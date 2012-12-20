-- NEED RESULT: ARCH00170.P1: Multi inertial transactions occurred on signal asg with selected name prefixed by an indexed name on LHS passed
-- NEED RESULT: ARCH00170.P2: Multi inertial transactions occurred on signal asg with selected name prefixed by an indexed name on LHS passed
-- NEED RESULT: ARCH00170.P3: Multi inertial transactions occurred on signal asg with selected name prefixed by an indexed name on LHS passed
-- NEED RESULT: ARCH00170: One inertial transaction occurred on signal asg with selected name prefixed by an indexed name on LHS passed
-- NEED RESULT: ARCH00170: One inertial transaction occurred on signal asg with selected name prefixed by an indexed name on LHS passed
-- NEED RESULT: ARCH00170: One inertial transaction occurred on signal asg with selected name prefixed by an indexed name on LHS passed
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
--    CT00170
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
--    ENT00170(ARCH00170)
--    ENT00170_Test_Bench(ARCH00170_Test_Bench)
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
entity ENT00170 is
   port (
        s_st_rec1_vector : inout st_rec1_vector
      ; s_st_rec2_vector : inout st_rec2_vector
      ; s_st_rec3_vector : inout st_rec3_vector
        ) ;
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_st_rec1_vector : chk_sig_type := -1 ;
   signal chk_st_rec2_vector : chk_sig_type := -1 ;
   signal chk_st_rec3_vector : chk_sig_type := -1 ;
--
end ENT00170 ;
--
architecture ARCH00170 of ENT00170 is
begin
   P1 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_rec1_vector(lowb).f2 <=
               c_st_rec1_vector_2(highb).f2 after 10 ns,
               c_st_rec1_vector_1(highb).f2 after 20 ns ;
--
         when 1
         => correct :=
               s_st_rec1_vector(lowb).f2 =
                 c_st_rec1_vector_2(highb).f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_rec1_vector(lowb).f2 =
                 c_st_rec1_vector_1(highb).f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00170.P1" ,
              "Multi inertial transactions occurred on signal " &
              "asg with selected name prefixed by an indexed name on LHS",
              correct ) ;
            s_st_rec1_vector(lowb).f2 <=
               c_st_rec1_vector_2(highb).f2 after 10 ns ,
               c_st_rec1_vector_1(highb).f2 after 20 ns ,
               c_st_rec1_vector_2(highb).f2 after 30 ns ,
               c_st_rec1_vector_1(highb).f2 after 40 ns ;
--
         when 3
         => correct :=
               s_st_rec1_vector(lowb).f2 =
                 c_st_rec1_vector_2(highb).f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_rec1_vector(lowb).f2 <=
               c_st_rec1_vector_1(highb).f2 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_rec1_vector(lowb).f2 =
                 c_st_rec1_vector_1(highb).f2 and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00170" ,
              "One inertial transaction occurred on signal " &
              "asg with selected name prefixed by an indexed name on LHS",
              correct ) ;
            s_st_rec1_vector(lowb).f2 <= transport
               c_st_rec1_vector_1(highb).f2 after 100 ns ;
--
         when 5
         => correct :=
               s_st_rec1_vector(lowb).f2 =
                 c_st_rec1_vector_1(highb).f2 and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00170" ,
              "Old transactions were removed on signal " &
              "asg with selected name prefixed by an indexed name on LHS",
              correct ) ;
            s_st_rec1_vector(lowb).f2 <=
               c_st_rec1_vector_2(highb).f2 after 10 ns ,
               c_st_rec1_vector_1(highb).f2 after 20 ns ,
               c_st_rec1_vector_2(highb).f2 after 30 ns ,
               c_st_rec1_vector_1(highb).f2 after 40 ns ;
--
         when 6
         => correct :=
               s_st_rec1_vector(lowb).f2 =
                 c_st_rec1_vector_2(highb).f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00170" ,
              "One inertial transaction occurred on signal " &
              "asg with selected name prefixed by an indexed name on LHS",
              correct ) ;
            -- Last transaction above is marked
            s_st_rec1_vector(lowb).f2 <=
               c_st_rec1_vector_1(highb).f2 after 40 ns ;
--
         when 7
         => correct :=
               s_st_rec1_vector(lowb).f2 =
                 c_st_rec1_vector_1(highb).f2 and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_st_rec1_vector(lowb).f2 =
                 c_st_rec1_vector_1(highb).f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00170" ,
              "Inertial semantics check on a signal " &
              "asg with selected name prefixed by an indexed name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00170" ,
              "Inertial semantics check on a signal " &
              "asg with selected name prefixed by an indexed name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_rec1_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_st_rec1_vector'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P1 ;
--
   PGEN_CHKP_1 :
   process ( chk_st_rec1_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Inertial transactions entirely completed",
           chk_st_rec1_vector = 8 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
--
   P2 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_rec2_vector(lowb).f2 <=
               c_st_rec2_vector_2(highb).f2 after 10 ns,
               c_st_rec2_vector_1(highb).f2 after 20 ns ;
--
         when 1
         => correct :=
               s_st_rec2_vector(lowb).f2 =
                 c_st_rec2_vector_2(highb).f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_rec2_vector(lowb).f2 =
                 c_st_rec2_vector_1(highb).f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00170.P2" ,
              "Multi inertial transactions occurred on signal " &
              "asg with selected name prefixed by an indexed name on LHS",
              correct ) ;
            s_st_rec2_vector(lowb).f2 <=
               c_st_rec2_vector_2(highb).f2 after 10 ns ,
               c_st_rec2_vector_1(highb).f2 after 20 ns ,
               c_st_rec2_vector_2(highb).f2 after 30 ns ,
               c_st_rec2_vector_1(highb).f2 after 40 ns ;
--
         when 3
         => correct :=
               s_st_rec2_vector(lowb).f2 =
                 c_st_rec2_vector_2(highb).f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_rec2_vector(lowb).f2 <=
               c_st_rec2_vector_1(highb).f2 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_rec2_vector(lowb).f2 =
                 c_st_rec2_vector_1(highb).f2 and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00170" ,
              "One inertial transaction occurred on signal " &
              "asg with selected name prefixed by an indexed name on LHS",
              correct ) ;
            s_st_rec2_vector(lowb).f2 <= transport
               c_st_rec2_vector_1(highb).f2 after 100 ns ;
--
         when 5
         => correct :=
               s_st_rec2_vector(lowb).f2 =
                 c_st_rec2_vector_1(highb).f2 and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00170" ,
              "Old transactions were removed on signal " &
              "asg with selected name prefixed by an indexed name on LHS",
              correct ) ;
            s_st_rec2_vector(lowb).f2 <=
               c_st_rec2_vector_2(highb).f2 after 10 ns ,
               c_st_rec2_vector_1(highb).f2 after 20 ns ,
               c_st_rec2_vector_2(highb).f2 after 30 ns ,
               c_st_rec2_vector_1(highb).f2 after 40 ns ;
--
         when 6
         => correct :=
               s_st_rec2_vector(lowb).f2 =
                 c_st_rec2_vector_2(highb).f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00170" ,
              "One inertial transaction occurred on signal " &
              "asg with selected name prefixed by an indexed name on LHS",
              correct ) ;
            -- Last transaction above is marked
            s_st_rec2_vector(lowb).f2 <=
               c_st_rec2_vector_1(highb).f2 after 40 ns ;
--
         when 7
         => correct :=
               s_st_rec2_vector(lowb).f2 =
                 c_st_rec2_vector_1(highb).f2 and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_st_rec2_vector(lowb).f2 =
                 c_st_rec2_vector_1(highb).f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00170" ,
              "Inertial semantics check on a signal " &
              "asg with selected name prefixed by an indexed name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00170" ,
              "Inertial semantics check on a signal " &
              "asg with selected name prefixed by an indexed name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_rec2_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_st_rec2_vector'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P2 ;
--
   PGEN_CHKP_2 :
   process ( chk_st_rec2_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P2" ,
           "Inertial transactions entirely completed",
           chk_st_rec2_vector = 8 ) ;
      end if ;
   end process PGEN_CHKP_2 ;
--
--
   P3 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_rec3_vector(lowb).f2 <=
               c_st_rec3_vector_2(highb).f2 after 10 ns,
               c_st_rec3_vector_1(highb).f2 after 20 ns ;
--
         when 1
         => correct :=
               s_st_rec3_vector(lowb).f2 =
                 c_st_rec3_vector_2(highb).f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_rec3_vector(lowb).f2 =
                 c_st_rec3_vector_1(highb).f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00170.P3" ,
              "Multi inertial transactions occurred on signal " &
              "asg with selected name prefixed by an indexed name on LHS",
              correct ) ;
            s_st_rec3_vector(lowb).f2 <=
               c_st_rec3_vector_2(highb).f2 after 10 ns ,
               c_st_rec3_vector_1(highb).f2 after 20 ns ,
               c_st_rec3_vector_2(highb).f2 after 30 ns ,
               c_st_rec3_vector_1(highb).f2 after 40 ns ;
--
         when 3
         => correct :=
               s_st_rec3_vector(lowb).f2 =
                 c_st_rec3_vector_2(highb).f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_rec3_vector(lowb).f2 <=
               c_st_rec3_vector_1(highb).f2 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_rec3_vector(lowb).f2 =
                 c_st_rec3_vector_1(highb).f2 and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00170" ,
              "One inertial transaction occurred on signal " &
              "asg with selected name prefixed by an indexed name on LHS",
              correct ) ;
            s_st_rec3_vector(lowb).f2 <= transport
               c_st_rec3_vector_1(highb).f2 after 100 ns ;
--
         when 5
         => correct :=
               s_st_rec3_vector(lowb).f2 =
                 c_st_rec3_vector_1(highb).f2 and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00170" ,
              "Old transactions were removed on signal " &
              "asg with selected name prefixed by an indexed name on LHS",
              correct ) ;
            s_st_rec3_vector(lowb).f2 <=
               c_st_rec3_vector_2(highb).f2 after 10 ns ,
               c_st_rec3_vector_1(highb).f2 after 20 ns ,
               c_st_rec3_vector_2(highb).f2 after 30 ns ,
               c_st_rec3_vector_1(highb).f2 after 40 ns ;
--
         when 6
         => correct :=
               s_st_rec3_vector(lowb).f2 =
                 c_st_rec3_vector_2(highb).f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00170" ,
              "One inertial transaction occurred on signal " &
              "asg with selected name prefixed by an indexed name on LHS",
              correct ) ;
            -- Last transaction above is marked
            s_st_rec3_vector(lowb).f2 <=
               c_st_rec3_vector_1(highb).f2 after 40 ns ;
--
         when 7
         => correct :=
               s_st_rec3_vector(lowb).f2 =
                 c_st_rec3_vector_1(highb).f2 and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_st_rec3_vector(lowb).f2 =
                 c_st_rec3_vector_1(highb).f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00170" ,
              "Inertial semantics check on a signal " &
              "asg with selected name prefixed by an indexed name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00170" ,
              "Inertial semantics check on a signal " &
              "asg with selected name prefixed by an indexed name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_rec3_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_st_rec3_vector'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P3 ;
--
   PGEN_CHKP_3 :
   process ( chk_st_rec3_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P3" ,
           "Inertial transactions entirely completed",
           chk_st_rec3_vector = 8 ) ;
      end if ;
   end process PGEN_CHKP_3 ;
--
--
--
end ARCH00170 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00170_Test_Bench is
   signal s_st_rec1_vector : st_rec1_vector
     := c_st_rec1_vector_1 ;
   signal s_st_rec2_vector : st_rec2_vector
     := c_st_rec2_vector_1 ;
   signal s_st_rec3_vector : st_rec3_vector
     := c_st_rec3_vector_1 ;
--
end ENT00170_Test_Bench ;
--
architecture ARCH00170_Test_Bench of ENT00170_Test_Bench is
begin
   L1:
   block
      component UUT
         port (
              s_st_rec1_vector : inout st_rec1_vector
            ; s_st_rec2_vector : inout st_rec2_vector
            ; s_st_rec3_vector : inout st_rec3_vector
              ) ;
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00170 ( ARCH00170 ) ;
   begin
      CIS1 : UUT
         port map (
              s_st_rec1_vector
            , s_st_rec2_vector
            , s_st_rec3_vector
                  ) ;
   end block L1 ;
end ARCH00170_Test_Bench ;
