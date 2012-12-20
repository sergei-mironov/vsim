-- NEED RESULT: ARCH00138.P1: Multi inertial transactions occurred on signal asg with indexed name on LHS passed
-- NEED RESULT: ARCH00138.P2: Multi inertial transactions occurred on signal asg with indexed name on LHS passed
-- NEED RESULT: ARCH00138.P3: Multi inertial transactions occurred on signal asg with indexed name on LHS passed
-- NEED RESULT: ARCH00138: One inertial transaction occurred on signal asg with indexed name on LHS passed
-- NEED RESULT: ARCH00138: One inertial transaction occurred on signal asg with indexed name on LHS passed
-- NEED RESULT: ARCH00138: One inertial transaction occurred on signal asg with indexed name on LHS passed
-- NEED RESULT: ARCH00138: Old transactions were removed on signal asg with indexed name on LHS passed
-- NEED RESULT: ARCH00138: Old transactions were removed on signal asg with indexed name on LHS passed
-- NEED RESULT: ARCH00138: Old transactions were removed on signal asg with indexed name on LHS passed
-- NEED RESULT: ARCH00138: One inertial transaction occurred on signal asg with indexed name on LHS passed
-- NEED RESULT: ARCH00138: One inertial transaction occurred on signal asg with indexed name on LHS passed
-- NEED RESULT: ARCH00138: One inertial transaction occurred on signal asg with indexed name on LHS passed
-- NEED RESULT: ARCH00138: Inertial semantics check on a signal asg with indexed name on LHS passed
-- NEED RESULT: ARCH00138: Inertial semantics check on a signal asg with indexed name on LHS passed
-- NEED RESULT: ARCH00138: Inertial semantics check on a signal asg with indexed name on LHS passed
-- NEED RESULT: P3: Inertial transactions entirely completed passed
-- NEED RESULT: P2: Inertial transactions entirely completed passed
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
--    CT00138
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
--    E00000(ARCH00138)
--    ENT00138_Test_Bench(ARCH00138_Test_Bench)
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
architecture ARCH00138 of E00000 is
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_st_arr1 : chk_sig_type := -1 ;
   signal chk_st_arr2 : chk_sig_type := -1 ;
   signal chk_st_arr3 : chk_sig_type := -1 ;
--
   signal s_st_arr1 : st_arr1
     := c_st_arr1_1 ;
   signal s_st_arr2 : st_arr2
     := c_st_arr2_1 ;
   signal s_st_arr3 : st_arr3
     := c_st_arr3_1 ;
--
begin
   P1 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0 =>
               s_st_arr1 (st_arr1'Left) <=
                  c_st_arr1_2 (st_arr1'Right) after 10 ns,
                  c_st_arr1_1 (st_arr1'Right) after 20 ns ;
--
            when 1 =>
               correct :=
                  s_st_arr1 (st_arr1'Left) =
                     c_st_arr1_2 (st_arr1'Right) and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2 =>
               correct :=
                  correct and
                  s_st_arr1 (st_arr1'Left) =
                     c_st_arr1_1 (st_arr1'Right) and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00138.P1" ,
                 "Multi inertial transactions occurred on signal " &
                 "asg with indexed name on LHS",
                 correct ) ;
               s_st_arr1 (st_arr1'Left) <=
                  c_st_arr1_2 (st_arr1'Right) after 10 ns,
                  c_st_arr1_1 (st_arr1'Right) after 20 ns,
                  c_st_arr1_2 (st_arr1'Right) after 30 ns,
                  c_st_arr1_1 (st_arr1'Right) after 40 ns ;
--
            when 3 =>
               correct :=
                  s_st_arr1 (st_arr1'Left) =
                     c_st_arr1_2 (st_arr1'Right) and
                  (savtime + 10 ns) = Std.Standard.Now ;
               s_st_arr1 (st_arr1'Left) <=
                  c_st_arr1_1 (st_arr1'Right) after 5 ns;
--
            when 4 =>
               correct :=
                  correct and
                  s_st_arr1 (st_arr1'Left) =
                     c_st_arr1_1 (st_arr1'Right) and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00138" ,
                 "One inertial transaction occurred on signal " &
                 "asg with indexed name on LHS",
                 correct ) ;
               s_st_arr1 (st_arr1'Left) <= transport
                  c_st_arr1_1 (st_arr1'Right) after 100 ns;
--
            when 5 =>
               correct :=
                  s_st_arr1 (st_arr1'Left) =
                     c_st_arr1_1 (st_arr1'Right) and
                  (savtime + 100 ns) = Std.Standard.Now ;
               test_report ( "ARCH00138" ,
                 "Old transactions were removed on signal " &
                 "asg with indexed name on LHS",
                 correct ) ;
               s_st_arr1 (st_arr1'Left) <=
                  c_st_arr1_2 (st_arr1'Right) after 10 ns,
                  c_st_arr1_1 (st_arr1'Right) after 20 ns,
                  c_st_arr1_2 (st_arr1'Right) after 30 ns,
                  c_st_arr1_1 (st_arr1'Right) after 40 ns ;
--
            when 6 =>
               correct :=
                  s_st_arr1 (st_arr1'Left) =
                     c_st_arr1_2 (st_arr1'Right) and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00138" ,
                 "One inertial transaction occurred on signal " &
                 "asg with indexed name on LHS",
                 correct ) ;
               -- The following will mark last transaction above
               s_st_arr1 (st_arr1'Left) <=
                  c_st_arr1_1 (st_arr1'Right) after 40 ns;
--
            when 7 =>
               correct :=
                  s_st_arr1 (st_arr1'Left) =
                     c_st_arr1_1 (st_arr1'Right) and
                  (savtime + 30 ns) = Std.Standard.Now ;
--
            when 8 =>
               correct :=
                  correct and
                  s_st_arr1 (st_arr1'Left) =
                     c_st_arr1_1 (st_arr1'Right) and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00138" ,
                 "Inertial semantics check on a signal " &
                 "asg with indexed name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00138" ,
                 "Inertial semantics check on a signal " &
                 "asg with indexed name on LHS",
                 false ) ;
--
         end case ;
--
         savtime := Std.Standard.Now ;
         chk_st_arr1 <= transport counter after (1 us - savtime) ;
         counter := counter + 1;
--
      end Proc1 ;
--
   begin
      Proc1 ;
      wait until (not s_st_arr1'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P1 ;
--
   PGEN_CHKP_1 :
   process ( chk_st_arr1 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Inertial transactions entirely completed",
           chk_st_arr1 = 8 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
   P2 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0 =>
               s_st_arr2 (
                 st_arr2'Left(1),st_arr2'Left(2)) <=
                  c_st_arr2_2 (
                    st_arr2'Right(1),st_arr2'Right(2)) after 10 ns,
                  c_st_arr2_1 (
                    st_arr2'Right(1),st_arr2'Right(2)) after 20 ns ;
--
            when 1 =>
               correct :=
                  s_st_arr2 (
                    st_arr2'Left(1),st_arr2'Left(2)) =
                     c_st_arr2_2 (
                       st_arr2'Right(1),st_arr2'Right(2)) and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2 =>
               correct :=
                  correct and
                  s_st_arr2 (
                    st_arr2'Left(1),st_arr2'Left(2)) =
                     c_st_arr2_1 (
                       st_arr2'Right(1),st_arr2'Right(2)) and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00138.P2" ,
                 "Multi inertial transactions occurred on signal " &
                 "asg with indexed name on LHS",
                 correct ) ;
               s_st_arr2 (
                 st_arr2'Left(1),st_arr2'Left(2)) <=
                  c_st_arr2_2 (
                    st_arr2'Right(1),st_arr2'Right(2)) after 10 ns,
                  c_st_arr2_1 (
                    st_arr2'Right(1),st_arr2'Right(2)) after 20 ns,
                  c_st_arr2_2 (
                    st_arr2'Right(1),st_arr2'Right(2)) after 30 ns,
                  c_st_arr2_1 (
                    st_arr2'Right(1),st_arr2'Right(2)) after 40 ns ;
--
            when 3 =>
               correct :=
                  s_st_arr2 (
                    st_arr2'Left(1),st_arr2'Left(2)) =
                     c_st_arr2_2 (
                       st_arr2'Right(1),st_arr2'Right(2)) and
                  (savtime + 10 ns) = Std.Standard.Now ;
               s_st_arr2 (
                 st_arr2'Left(1),st_arr2'Left(2)) <=
                  c_st_arr2_1 (
                    st_arr2'Right(1),st_arr2'Right(2)) after 5 ns;
--
            when 4 =>
               correct :=
                  correct and
                  s_st_arr2 (
                    st_arr2'Left(1),st_arr2'Left(2)) =
                     c_st_arr2_1 (
                       st_arr2'Right(1),st_arr2'Right(2)) and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00138" ,
                 "One inertial transaction occurred on signal " &
                 "asg with indexed name on LHS",
                 correct ) ;
               s_st_arr2 (
                 st_arr2'Left(1),st_arr2'Left(2)) <= transport
                  c_st_arr2_1 (
                    st_arr2'Right(1),st_arr2'Right(2)) after 100 ns;
--
            when 5 =>
               correct :=
                  s_st_arr2 (
                    st_arr2'Left(1),st_arr2'Left(2)) =
                     c_st_arr2_1 (
                       st_arr2'Right(1),st_arr2'Right(2)) and
                  (savtime + 100 ns) = Std.Standard.Now ;
               test_report ( "ARCH00138" ,
                 "Old transactions were removed on signal " &
                 "asg with indexed name on LHS",
                 correct ) ;
               s_st_arr2 (
                 st_arr2'Left(1),st_arr2'Left(2)) <=
                  c_st_arr2_2 (
                    st_arr2'Right(1),st_arr2'Right(2)) after 10 ns,
                  c_st_arr2_1 (
                    st_arr2'Right(1),st_arr2'Right(2)) after 20 ns,
                  c_st_arr2_2 (
                    st_arr2'Right(1),st_arr2'Right(2)) after 30 ns,
                  c_st_arr2_1 (
                    st_arr2'Right(1),st_arr2'Right(2)) after 40 ns ;
--
            when 6 =>
               correct :=
                  s_st_arr2 (
                    st_arr2'Left(1),st_arr2'Left(2)) =
                     c_st_arr2_2 (
                       st_arr2'Right(1),st_arr2'Right(2)) and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00138" ,
                 "One inertial transaction occurred on signal " &
                 "asg with indexed name on LHS",
                 correct ) ;
               -- The following will mark last transaction above
               s_st_arr2 (
                 st_arr2'Left(1),st_arr2'Left(2)) <=
                  c_st_arr2_1 (
                    st_arr2'Right(1),st_arr2'Right(2)) after 40 ns;
--
            when 7 =>
               correct :=
                  s_st_arr2 (
                    st_arr2'Left(1),st_arr2'Left(2)) =
                     c_st_arr2_1 (
                       st_arr2'Right(1),st_arr2'Right(2)) and
                  (savtime + 30 ns) = Std.Standard.Now ;
--
            when 8 =>
               correct :=
                  correct and
                  s_st_arr2 (
                    st_arr2'Left(1),st_arr2'Left(2)) =
                     c_st_arr2_1 (
                       st_arr2'Right(1),st_arr2'Right(2)) and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00138" ,
                 "Inertial semantics check on a signal " &
                 "asg with indexed name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00138" ,
                 "Inertial semantics check on a signal " &
                 "asg with indexed name on LHS",
                 false ) ;
--
         end case ;
--
         savtime := Std.Standard.Now ;
         chk_st_arr2 <= transport counter after (1 us - savtime) ;
         counter := counter + 1;
--
      end Proc1 ;
--
   begin
      Proc1 ;
      wait until (not s_st_arr2'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P2 ;
--
   PGEN_CHKP_2 :
   process ( chk_st_arr2 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P2" ,
           "Inertial transactions entirely completed",
           chk_st_arr2 = 8 ) ;
      end if ;
   end process PGEN_CHKP_2 ;
--
   P3 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0 =>
               s_st_arr3 (
                 st_arr3'Left(1),st_arr3'Left(2)) <=
                  c_st_arr3_2 (
                    st_arr3'Right(1),st_arr3'Right(2)) after 10 ns,
                  c_st_arr3_1 (
                    st_arr3'Right(1),st_arr3'Right(2)) after 20 ns ;
--
            when 1 =>
               correct :=
                  s_st_arr3 (
                    st_arr3'Left(1),st_arr3'Left(2)) =
                     c_st_arr3_2 (
                       st_arr3'Right(1),st_arr3'Right(2)) and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2 =>
               correct :=
                  correct and
                  s_st_arr3 (
                    st_arr3'Left(1),st_arr3'Left(2)) =
                     c_st_arr3_1 (
                       st_arr3'Right(1),st_arr3'Right(2)) and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00138.P3" ,
                 "Multi inertial transactions occurred on signal " &
                 "asg with indexed name on LHS",
                 correct ) ;
               s_st_arr3 (
                 st_arr3'Left(1),st_arr3'Left(2)) <=
                  c_st_arr3_2 (
                    st_arr3'Right(1),st_arr3'Right(2)) after 10 ns,
                  c_st_arr3_1 (
                    st_arr3'Right(1),st_arr3'Right(2)) after 20 ns,
                  c_st_arr3_2 (
                    st_arr3'Right(1),st_arr3'Right(2)) after 30 ns,
                  c_st_arr3_1 (
                    st_arr3'Right(1),st_arr3'Right(2)) after 40 ns ;
--
            when 3 =>
               correct :=
                  s_st_arr3 (
                    st_arr3'Left(1),st_arr3'Left(2)) =
                     c_st_arr3_2 (
                       st_arr3'Right(1),st_arr3'Right(2)) and
                  (savtime + 10 ns) = Std.Standard.Now ;
               s_st_arr3 (
                 st_arr3'Left(1),st_arr3'Left(2)) <=
                  c_st_arr3_1 (
                    st_arr3'Right(1),st_arr3'Right(2)) after 5 ns;
--
            when 4 =>
               correct :=
                  correct and
                  s_st_arr3 (
                    st_arr3'Left(1),st_arr3'Left(2)) =
                     c_st_arr3_1 (
                       st_arr3'Right(1),st_arr3'Right(2)) and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00138" ,
                 "One inertial transaction occurred on signal " &
                 "asg with indexed name on LHS",
                 correct ) ;
               s_st_arr3 (
                 st_arr3'Left(1),st_arr3'Left(2)) <= transport
                  c_st_arr3_1 (
                    st_arr3'Right(1),st_arr3'Right(2)) after 100 ns;
--
            when 5 =>
               correct :=
                  s_st_arr3 (
                    st_arr3'Left(1),st_arr3'Left(2)) =
                     c_st_arr3_1 (
                       st_arr3'Right(1),st_arr3'Right(2)) and
                  (savtime + 100 ns) = Std.Standard.Now ;
               test_report ( "ARCH00138" ,
                 "Old transactions were removed on signal " &
                 "asg with indexed name on LHS",
                 correct ) ;
               s_st_arr3 (
                 st_arr3'Left(1),st_arr3'Left(2)) <=
                  c_st_arr3_2 (
                    st_arr3'Right(1),st_arr3'Right(2)) after 10 ns,
                  c_st_arr3_1 (
                    st_arr3'Right(1),st_arr3'Right(2)) after 20 ns,
                  c_st_arr3_2 (
                    st_arr3'Right(1),st_arr3'Right(2)) after 30 ns,
                  c_st_arr3_1 (
                    st_arr3'Right(1),st_arr3'Right(2)) after 40 ns ;
--
            when 6 =>
               correct :=
                  s_st_arr3 (
                    st_arr3'Left(1),st_arr3'Left(2)) =
                     c_st_arr3_2 (
                       st_arr3'Right(1),st_arr3'Right(2)) and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00138" ,
                 "One inertial transaction occurred on signal " &
                 "asg with indexed name on LHS",
                 correct ) ;
               -- The following will mark last transaction above
               s_st_arr3 (
                 st_arr3'Left(1),st_arr3'Left(2)) <=
                  c_st_arr3_1 (
                    st_arr3'Right(1),st_arr3'Right(2)) after 40 ns;
--
            when 7 =>
               correct :=
                  s_st_arr3 (
                    st_arr3'Left(1),st_arr3'Left(2)) =
                     c_st_arr3_1 (
                       st_arr3'Right(1),st_arr3'Right(2)) and
                  (savtime + 30 ns) = Std.Standard.Now ;
--
            when 8 =>
               correct :=
                  correct and
                  s_st_arr3 (
                    st_arr3'Left(1),st_arr3'Left(2)) =
                     c_st_arr3_1 (
                       st_arr3'Right(1),st_arr3'Right(2)) and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00138" ,
                 "Inertial semantics check on a signal " &
                 "asg with indexed name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00138" ,
                 "Inertial semantics check on a signal " &
                 "asg with indexed name on LHS",
                 false ) ;
--
         end case ;
--
         savtime := Std.Standard.Now ;
         chk_st_arr3 <= transport counter after (1 us - savtime) ;
         counter := counter + 1;
--
      end Proc1 ;
--
   begin
      Proc1 ;
      wait until (not s_st_arr3'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P3 ;
--
   PGEN_CHKP_3 :
   process ( chk_st_arr3 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P3" ,
           "Inertial transactions entirely completed",
           chk_st_arr3 = 8 ) ;
      end if ;
   end process PGEN_CHKP_3 ;
--
--
end ARCH00138 ;
--
entity ENT00138_Test_Bench is
end ENT00138_Test_Bench ;
--
architecture ARCH00138_Test_Bench of ENT00138_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00138 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00138_Test_Bench ;
