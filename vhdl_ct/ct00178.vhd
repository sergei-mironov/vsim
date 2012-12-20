-- NEED RESULT: ARCH00178.P1: Multi inertial transactions occurred on signal asg with indexed name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00178: One inertial transaction occurred on signal asg with indexed name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00178: Old transactions were removed on signal asg with indexed name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00178: One inertial transaction occurred on signal asg with indexed name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00178: Inertial semantics check on a signal asg with indexed name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00178: Inertial semantics check on a signal asg with indexed name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00178: Inertial semantics check on a signal asg with indexed name prefixed by a selected name on LHS failed
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
--    CT00178
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
--    ENT00178(ARCH00178)
--    ENT00178_Test_Bench(ARCH00178_Test_Bench)
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
entity ENT00178 is
   port (
        s_st_rec3 : inout st_rec3
        ) ;
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_st_rec3 : chk_sig_type := -1 ;
--
--
   procedure Proc1 (
      signal   s_st_rec3 : inout st_rec3 ;
      variable counter : inout integer ;
      variable correct : inout boolean ;
      variable savtime : inout time ;
      signal   chk_st_rec3 : out chk_sig_type
                   )
   is
   begin
      case counter is
         when 0 =>
            s_st_rec3.f3 (
              s_st_rec3.f3'Left(1),s_st_rec3.f3'Left(2)) <=
               c_st_rec3_2.f3 (
                 s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) after 10 ns,
               c_st_rec3_1.f3 (
                 s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) after 20 ns ;
--
         when 1 =>
            correct :=
               s_st_rec3.f3 (
                 s_st_rec3.f3'Left(1),s_st_rec3.f3'Left(2)) =
                  c_st_rec3_2.f3 (
                    s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2 =>
            correct :=
               correct and
               s_st_rec3.f3 (
                 s_st_rec3.f3'Left(1),s_st_rec3.f3'Left(2)) =
                  c_st_rec3_1.f3 (
                    s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00178.P1" ,
              "Multi inertial transactions occurred on signal " &
              "asg with indexed name prefixed by a selected name on LHS",
              correct ) ;
            s_st_rec3.f3 (
              s_st_rec3.f3'Left(1),s_st_rec3.f3'Left(2)) <=
               c_st_rec3_2.f3 (
                 s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) after 10 ns,
               c_st_rec3_1.f3 (
                 s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) after 20 ns,
               c_st_rec3_2.f3 (
                 s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) after 30 ns,
               c_st_rec3_1.f3 (
                 s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) after 40 ns ;
--
         when 3 =>
            correct :=
               s_st_rec3.f3 (
                 s_st_rec3.f3'Left(1),s_st_rec3.f3'Left(2)) =
                  c_st_rec3_2.f3 (
                    s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_rec3.f3 (
              s_st_rec3.f3'Left(1),s_st_rec3.f3'Left(2)) <=
               c_st_rec3_1.f3 (
                 s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) after 5 ns;
--
         when 4 =>
            correct :=
               correct and
               s_st_rec3.f3 (
                 s_st_rec3.f3'Left(1),s_st_rec3.f3'Left(2)) =
                  c_st_rec3_1.f3 (
                    s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00178" ,
              "One inertial transaction occurred on signal " &
              "asg with indexed name prefixed by a selected name on LHS",
              correct ) ;
            s_st_rec3.f3 (
              s_st_rec3.f3'Left(1),s_st_rec3.f3'Left(2)) <= transport
               c_st_rec3_1.f3 (
                 s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) after 100 ns;
--
         when 5 =>
            correct :=
               s_st_rec3.f3 (
                 s_st_rec3.f3'Left(1),s_st_rec3.f3'Left(2)) =
                  c_st_rec3_1.f3 (
                    s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00178" ,
              "Old transactions were removed on signal " &
              "asg with indexed name prefixed by a selected name on LHS",
              correct ) ;
            s_st_rec3.f3 (
              s_st_rec3.f3'Left(1),s_st_rec3.f3'Left(2)) <=
               c_st_rec3_2.f3 (
                 s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) after 10 ns,
               c_st_rec3_1.f3 (
                 s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) after 20 ns,
               c_st_rec3_2.f3 (
                 s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) after 30 ns,
               c_st_rec3_1.f3 (
                 s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) after 40 ns ;
--
         when 6 =>
            correct :=
               s_st_rec3.f3 (
                 s_st_rec3.f3'Left(1),s_st_rec3.f3'Left(2)) =
                  c_st_rec3_2.f3 (
                    s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00178" ,
              "One inertial transaction occurred on signal " &
              "asg with indexed name prefixed by a selected name on LHS",
              correct ) ;
            -- The following will mark last transaction above
            s_st_rec3.f3 (
              s_st_rec3.f3'Left(1),s_st_rec3.f3'Left(2)) <=
               c_st_rec3_1.f3 (
                 s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) after 40 ns;
--
         when 7 =>
            correct :=
               s_st_rec3.f3 (
                 s_st_rec3.f3'Left(1),s_st_rec3.f3'Left(2)) =
                  c_st_rec3_1.f3 (
                    s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8 =>
            correct :=
               correct and
               s_st_rec3.f3 (
                 s_st_rec3.f3'Left(1),s_st_rec3.f3'Left(2)) =
                  c_st_rec3_1.f3 (
                    s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00178" ,
              "Inertial semantics check on a signal " &
              "asg with indexed name prefixed by a selected name on LHS",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00178" ,
              "Inertial semantics check on a signal " &
              "asg with indexed name prefixed by a selected name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_rec3 <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end Proc1 ;
--
--
end ENT00178 ;
--
architecture ARCH00178 of ENT00178 is
begin
   P1 :
   process
      variable counter : integer := 0 ;
      variable correct : boolean ;
      variable savtime : time ;
   begin
      Proc1 (
          s_st_rec3,
          counter,
          correct,
          savtime,
          chk_st_rec3
         ) ;
      wait until (not s_st_rec3'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P1 ;
--
   PGEN_CHKP_1 :
   process ( chk_st_rec3 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Inertial transactions entirely completed",
           chk_st_rec3 = 8 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
--
--
end ARCH00178 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00178_Test_Bench is
   signal s_st_rec3 : st_rec3
     := c_st_rec3_1 ;
--
end ENT00178_Test_Bench ;
--
architecture ARCH00178_Test_Bench of ENT00178_Test_Bench is
begin
   L1:
   block
      component UUT
         port (
              s_st_rec3 : inout st_rec3
              ) ;
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00178 ( ARCH00178 ) ;
   begin
      CIS1 : UUT
         port map (
              s_st_rec3
                  ) ;
   end block L1 ;
end ARCH00178_Test_Bench ;
