-- NEED RESULT: ARCH00143.P1: Multi inertial transactions occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143.P2: Multi inertial transactions occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143.P3: Multi inertial transactions occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143.P4: Multi inertial transactions occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143.P5: Multi inertial transactions occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143.P6: Multi inertial transactions occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143.P7: Multi inertial transactions occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143.P8: Multi inertial transactions occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143.P9: Multi inertial transactions occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143.P10: Multi inertial transactions occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143.P11: Multi inertial transactions occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143.P12: Multi inertial transactions occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143.P13: Multi inertial transactions occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143.P14: Multi inertial transactions occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143.P15: Multi inertial transactions occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143.P16: Multi inertial transactions occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143.P17: Multi inertial transactions occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143: One inertial transaction occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143: One inertial transaction occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143: One inertial transaction occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143: One inertial transaction occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143: One inertial transaction occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143: One inertial transaction occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143: One inertial transaction occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143: One inertial transaction occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143: One inertial transaction occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143: One inertial transaction occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143: One inertial transaction occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143: One inertial transaction occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143: One inertial transaction occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143: One inertial transaction occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143: One inertial transaction occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143: One inertial transaction occurred on signal asg with slice name on LHS passed
-- NEED RESULT: ARCH00143: One inertial transaction occurred on signal asg with slice name on LHS passed
-- NEED RESULT: P17: Inertial transactions entirely completed failed
-- NEED RESULT: P16: Inertial transactions entirely completed failed
-- NEED RESULT: P15: Inertial transactions entirely completed failed
-- NEED RESULT: P14: Inertial transactions entirely completed failed
-- NEED RESULT: P13: Inertial transactions entirely completed failed
-- NEED RESULT: P12: Inertial transactions entirely completed failed
-- NEED RESULT: P11: Inertial transactions entirely completed failed
-- NEED RESULT: P10: Inertial transactions entirely completed failed
-- NEED RESULT: P9: Inertial transactions entirely completed failed
-- NEED RESULT: P8: Inertial transactions entirely completed failed
-- NEED RESULT: P7: Inertial transactions entirely completed failed
-- NEED RESULT: P6: Inertial transactions entirely completed failed
-- NEED RESULT: P5: Inertial transactions entirely completed failed
-- NEED RESULT: P4: Inertial transactions entirely completed failed
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
--    CT00143
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
--    E00000(ARCH00143)
--    ENT00143_Test_Bench(ARCH00143_Test_Bench)
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
architecture ARCH00143 of E00000 is
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_st_boolean_vector : chk_sig_type := -1 ;
   signal chk_st_bit_vector : chk_sig_type := -1 ;
   signal chk_st_severity_level_vector : chk_sig_type := -1 ;
   signal chk_st_string : chk_sig_type := -1 ;
   signal chk_st_enum1_vector : chk_sig_type := -1 ;
   signal chk_st_integer_vector : chk_sig_type := -1 ;
   signal chk_st_int1_vector : chk_sig_type := -1 ;
   signal chk_st_time_vector : chk_sig_type := -1 ;
   signal chk_st_phys1_vector : chk_sig_type := -1 ;
   signal chk_st_real_vector : chk_sig_type := -1 ;
   signal chk_st_real1_vector : chk_sig_type := -1 ;
   signal chk_st_rec1_vector : chk_sig_type := -1 ;
   signal chk_st_rec2_vector : chk_sig_type := -1 ;
   signal chk_st_rec3_vector : chk_sig_type := -1 ;
   signal chk_st_arr1_vector : chk_sig_type := -1 ;
   signal chk_st_arr2_vector : chk_sig_type := -1 ;
   signal chk_st_arr3_vector : chk_sig_type := -1 ;
--
   signal s_st_boolean_vector : st_boolean_vector
     := c_st_boolean_vector_1 ;
   signal s_st_bit_vector : st_bit_vector
     := c_st_bit_vector_1 ;
   signal s_st_severity_level_vector : st_severity_level_vector
     := c_st_severity_level_vector_1 ;
   signal s_st_string : st_string
     := c_st_string_1 ;
   signal s_st_enum1_vector : st_enum1_vector
     := c_st_enum1_vector_1 ;
   signal s_st_integer_vector : st_integer_vector
     := c_st_integer_vector_1 ;
   signal s_st_int1_vector : st_int1_vector
     := c_st_int1_vector_1 ;
   signal s_st_time_vector : st_time_vector
     := c_st_time_vector_1 ;
   signal s_st_phys1_vector : st_phys1_vector
     := c_st_phys1_vector_1 ;
   signal s_st_real_vector : st_real_vector
     := c_st_real_vector_1 ;
   signal s_st_real1_vector : st_real1_vector
     := c_st_real1_vector_1 ;
   signal s_st_rec1_vector : st_rec1_vector
     := c_st_rec1_vector_1 ;
   signal s_st_rec2_vector : st_rec2_vector
     := c_st_rec2_vector_1 ;
   signal s_st_rec3_vector : st_rec3_vector
     := c_st_rec3_vector_1 ;
   signal s_st_arr1_vector : st_arr1_vector
     := c_st_arr1_vector_1 ;
   signal s_st_arr2_vector : st_arr2_vector
     := c_st_arr2_vector_1 ;
   signal s_st_arr3_vector : st_arr3_vector
     := c_st_arr3_vector_1 ;
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
         => s_st_boolean_vector (lowb+1 to lowb+3) <=
               c_st_boolean_vector_2 (lowb+1 to lowb+3) after 10 ns,
               c_st_boolean_vector_1 (lowb+1 to lowb+3) after 20 ns ;
--
         when 1
         => correct :=
               s_st_boolean_vector (lowb+1 to lowb+3) =
                 c_st_boolean_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_boolean_vector (lowb+1 to lowb+3) =
                 c_st_boolean_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143.P1" ,
              "Multi inertial transactions occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_boolean_vector (lowb+1 to lowb+3) <=
               c_st_boolean_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_boolean_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_boolean_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_boolean_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 3
         => correct :=
               s_st_boolean_vector (lowb+1 to lowb+3) =
                 c_st_boolean_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_boolean_vector (lowb+1 to lowb+3) <=
               c_st_boolean_vector_1 (lowb+1 to lowb+3) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_boolean_vector (lowb+1 to lowb+3) =
                 c_st_boolean_vector_1 (lowb+1 to lowb+3) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_boolean_vector (lowb+1 to lowb+3) <= transport
               c_st_boolean_vector_1 (lowb+1 to lowb+3) after 100 ns ;
--
         when 5
         => correct :=
               s_st_boolean_vector (lowb+1 to lowb+3) =
                 c_st_boolean_vector_1 (lowb+1 to lowb+3) and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Old transactions were removed on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_boolean_vector (lowb+1 to lowb+3) <=
               c_st_boolean_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_boolean_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_boolean_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_boolean_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 6
         => correct :=
               s_st_boolean_vector (lowb+1 to lowb+3) =
                 c_st_boolean_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            -- Last transaction above is marked by following
            s_st_boolean_vector (lowb+1 to lowb+3) <=
               c_st_boolean_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 7
         => correct :=
               s_st_boolean_vector (lowb+1 to lowb+3) =
                 c_st_boolean_vector_1 (lowb+1 to lowb+3) and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_st_boolean_vector (lowb+1 to lowb+3) =
                 c_st_boolean_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_boolean_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_st_boolean_vector'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P1 ;
--
   PGEN_CHKP_1 :
   process ( chk_st_boolean_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Inertial transactions entirely completed",
           chk_st_boolean_vector = 8 ) ;
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
         => s_st_bit_vector (lowb+1 to lowb+3) <=
               c_st_bit_vector_2 (lowb+1 to lowb+3) after 10 ns,
               c_st_bit_vector_1 (lowb+1 to lowb+3) after 20 ns ;
--
         when 1
         => correct :=
               s_st_bit_vector (lowb+1 to lowb+3) =
                 c_st_bit_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_bit_vector (lowb+1 to lowb+3) =
                 c_st_bit_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143.P2" ,
              "Multi inertial transactions occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_bit_vector (lowb+1 to lowb+3) <=
               c_st_bit_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_bit_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_bit_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_bit_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 3
         => correct :=
               s_st_bit_vector (lowb+1 to lowb+3) =
                 c_st_bit_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_bit_vector (lowb+1 to lowb+3) <=
               c_st_bit_vector_1 (lowb+1 to lowb+3) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_bit_vector (lowb+1 to lowb+3) =
                 c_st_bit_vector_1 (lowb+1 to lowb+3) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_bit_vector (lowb+1 to lowb+3) <= transport
               c_st_bit_vector_1 (lowb+1 to lowb+3) after 100 ns ;
--
         when 5
         => correct :=
               s_st_bit_vector (lowb+1 to lowb+3) =
                 c_st_bit_vector_1 (lowb+1 to lowb+3) and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Old transactions were removed on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_bit_vector (lowb+1 to lowb+3) <=
               c_st_bit_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_bit_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_bit_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_bit_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 6
         => correct :=
               s_st_bit_vector (lowb+1 to lowb+3) =
                 c_st_bit_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            -- Last transaction above is marked by following
            s_st_bit_vector (lowb+1 to lowb+3) <=
               c_st_bit_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 7
         => correct :=
               s_st_bit_vector (lowb+1 to lowb+3) =
                 c_st_bit_vector_1 (lowb+1 to lowb+3) and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_st_bit_vector (lowb+1 to lowb+3) =
                 c_st_bit_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_bit_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_st_bit_vector'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P2 ;
--
   PGEN_CHKP_2 :
   process ( chk_st_bit_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P2" ,
           "Inertial transactions entirely completed",
           chk_st_bit_vector = 8 ) ;
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
         => s_st_severity_level_vector (lowb+1 to lowb+3) <=
               c_st_severity_level_vector_2 (lowb+1 to lowb+3) after 10 ns,
               c_st_severity_level_vector_1 (lowb+1 to lowb+3) after 20 ns ;
--
         when 1
         => correct :=
               s_st_severity_level_vector (lowb+1 to lowb+3) =
                 c_st_severity_level_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_severity_level_vector (lowb+1 to lowb+3) =
                 c_st_severity_level_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143.P3" ,
              "Multi inertial transactions occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_severity_level_vector (lowb+1 to lowb+3) <=
               c_st_severity_level_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_severity_level_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_severity_level_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_severity_level_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 3
         => correct :=
               s_st_severity_level_vector (lowb+1 to lowb+3) =
                 c_st_severity_level_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_severity_level_vector (lowb+1 to lowb+3) <=
               c_st_severity_level_vector_1 (lowb+1 to lowb+3) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_severity_level_vector (lowb+1 to lowb+3) =
                 c_st_severity_level_vector_1 (lowb+1 to lowb+3) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_severity_level_vector (lowb+1 to lowb+3) <= transport
               c_st_severity_level_vector_1 (lowb+1 to lowb+3) after 100 ns ;
--
         when 5
         => correct :=
               s_st_severity_level_vector (lowb+1 to lowb+3) =
                 c_st_severity_level_vector_1 (lowb+1 to lowb+3) and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Old transactions were removed on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_severity_level_vector (lowb+1 to lowb+3) <=
               c_st_severity_level_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_severity_level_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_severity_level_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_severity_level_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 6
         => correct :=
               s_st_severity_level_vector (lowb+1 to lowb+3) =
                 c_st_severity_level_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            -- Last transaction above is marked by following
            s_st_severity_level_vector (lowb+1 to lowb+3) <=
               c_st_severity_level_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 7
         => correct :=
               s_st_severity_level_vector (lowb+1 to lowb+3) =
                 c_st_severity_level_vector_1 (lowb+1 to lowb+3) and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_st_severity_level_vector (lowb+1 to lowb+3) =
                 c_st_severity_level_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_severity_level_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_st_severity_level_vector'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P3 ;
--
   PGEN_CHKP_3 :
   process ( chk_st_severity_level_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P3" ,
           "Inertial transactions entirely completed",
           chk_st_severity_level_vector = 8 ) ;
      end if ;
   end process PGEN_CHKP_3 ;
--
   P4 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_string (lowb+1 to lowb+3) <=
               c_st_string_2 (lowb+1 to lowb+3) after 10 ns,
               c_st_string_1 (lowb+1 to lowb+3) after 20 ns ;
--
         when 1
         => correct :=
               s_st_string (lowb+1 to lowb+3) =
                 c_st_string_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_string (lowb+1 to lowb+3) =
                 c_st_string_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143.P4" ,
              "Multi inertial transactions occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_string (lowb+1 to lowb+3) <=
               c_st_string_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_string_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_string_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_string_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 3
         => correct :=
               s_st_string (lowb+1 to lowb+3) =
                 c_st_string_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_string (lowb+1 to lowb+3) <=
               c_st_string_1 (lowb+1 to lowb+3) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_string (lowb+1 to lowb+3) =
                 c_st_string_1 (lowb+1 to lowb+3) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_string (lowb+1 to lowb+3) <= transport
               c_st_string_1 (lowb+1 to lowb+3) after 100 ns ;
--
         when 5
         => correct :=
               s_st_string (lowb+1 to lowb+3) =
                 c_st_string_1 (lowb+1 to lowb+3) and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Old transactions were removed on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_string (lowb+1 to lowb+3) <=
               c_st_string_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_string_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_string_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_string_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 6
         => correct :=
               s_st_string (lowb+1 to lowb+3) =
                 c_st_string_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            -- Last transaction above is marked by following
            s_st_string (lowb+1 to lowb+3) <=
               c_st_string_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 7
         => correct :=
               s_st_string (lowb+1 to lowb+3) =
                 c_st_string_1 (lowb+1 to lowb+3) and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_st_string (lowb+1 to lowb+3) =
                 c_st_string_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_string <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_st_string'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P4 ;
--
   PGEN_CHKP_4 :
   process ( chk_st_string )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P4" ,
           "Inertial transactions entirely completed",
           chk_st_string = 8 ) ;
      end if ;
   end process PGEN_CHKP_4 ;
--
   P5 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_enum1_vector (lowb+1 to lowb+3) <=
               c_st_enum1_vector_2 (lowb+1 to lowb+3) after 10 ns,
               c_st_enum1_vector_1 (lowb+1 to lowb+3) after 20 ns ;
--
         when 1
         => correct :=
               s_st_enum1_vector (lowb+1 to lowb+3) =
                 c_st_enum1_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_enum1_vector (lowb+1 to lowb+3) =
                 c_st_enum1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143.P5" ,
              "Multi inertial transactions occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_enum1_vector (lowb+1 to lowb+3) <=
               c_st_enum1_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_enum1_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_enum1_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_enum1_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 3
         => correct :=
               s_st_enum1_vector (lowb+1 to lowb+3) =
                 c_st_enum1_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_enum1_vector (lowb+1 to lowb+3) <=
               c_st_enum1_vector_1 (lowb+1 to lowb+3) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_enum1_vector (lowb+1 to lowb+3) =
                 c_st_enum1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_enum1_vector (lowb+1 to lowb+3) <= transport
               c_st_enum1_vector_1 (lowb+1 to lowb+3) after 100 ns ;
--
         when 5
         => correct :=
               s_st_enum1_vector (lowb+1 to lowb+3) =
                 c_st_enum1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Old transactions were removed on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_enum1_vector (lowb+1 to lowb+3) <=
               c_st_enum1_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_enum1_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_enum1_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_enum1_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 6
         => correct :=
               s_st_enum1_vector (lowb+1 to lowb+3) =
                 c_st_enum1_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            -- Last transaction above is marked by following
            s_st_enum1_vector (lowb+1 to lowb+3) <=
               c_st_enum1_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 7
         => correct :=
               s_st_enum1_vector (lowb+1 to lowb+3) =
                 c_st_enum1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_st_enum1_vector (lowb+1 to lowb+3) =
                 c_st_enum1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_enum1_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_st_enum1_vector'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P5 ;
--
   PGEN_CHKP_5 :
   process ( chk_st_enum1_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P5" ,
           "Inertial transactions entirely completed",
           chk_st_enum1_vector = 8 ) ;
      end if ;
   end process PGEN_CHKP_5 ;
--
   P6 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_integer_vector (lowb+1 to lowb+3) <=
               c_st_integer_vector_2 (lowb+1 to lowb+3) after 10 ns,
               c_st_integer_vector_1 (lowb+1 to lowb+3) after 20 ns ;
--
         when 1
         => correct :=
               s_st_integer_vector (lowb+1 to lowb+3) =
                 c_st_integer_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_integer_vector (lowb+1 to lowb+3) =
                 c_st_integer_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143.P6" ,
              "Multi inertial transactions occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_integer_vector (lowb+1 to lowb+3) <=
               c_st_integer_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_integer_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_integer_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_integer_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 3
         => correct :=
               s_st_integer_vector (lowb+1 to lowb+3) =
                 c_st_integer_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_integer_vector (lowb+1 to lowb+3) <=
               c_st_integer_vector_1 (lowb+1 to lowb+3) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_integer_vector (lowb+1 to lowb+3) =
                 c_st_integer_vector_1 (lowb+1 to lowb+3) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_integer_vector (lowb+1 to lowb+3) <= transport
               c_st_integer_vector_1 (lowb+1 to lowb+3) after 100 ns ;
--
         when 5
         => correct :=
               s_st_integer_vector (lowb+1 to lowb+3) =
                 c_st_integer_vector_1 (lowb+1 to lowb+3) and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Old transactions were removed on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_integer_vector (lowb+1 to lowb+3) <=
               c_st_integer_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_integer_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_integer_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_integer_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 6
         => correct :=
               s_st_integer_vector (lowb+1 to lowb+3) =
                 c_st_integer_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            -- Last transaction above is marked by following
            s_st_integer_vector (lowb+1 to lowb+3) <=
               c_st_integer_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 7
         => correct :=
               s_st_integer_vector (lowb+1 to lowb+3) =
                 c_st_integer_vector_1 (lowb+1 to lowb+3) and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_st_integer_vector (lowb+1 to lowb+3) =
                 c_st_integer_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_integer_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_st_integer_vector'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P6 ;
--
   PGEN_CHKP_6 :
   process ( chk_st_integer_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P6" ,
           "Inertial transactions entirely completed",
           chk_st_integer_vector = 8 ) ;
      end if ;
   end process PGEN_CHKP_6 ;
--
   P7 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_int1_vector (lowb+1 to lowb+3) <=
               c_st_int1_vector_2 (lowb+1 to lowb+3) after 10 ns,
               c_st_int1_vector_1 (lowb+1 to lowb+3) after 20 ns ;
--
         when 1
         => correct :=
               s_st_int1_vector (lowb+1 to lowb+3) =
                 c_st_int1_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_int1_vector (lowb+1 to lowb+3) =
                 c_st_int1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143.P7" ,
              "Multi inertial transactions occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_int1_vector (lowb+1 to lowb+3) <=
               c_st_int1_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_int1_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_int1_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_int1_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 3
         => correct :=
               s_st_int1_vector (lowb+1 to lowb+3) =
                 c_st_int1_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_int1_vector (lowb+1 to lowb+3) <=
               c_st_int1_vector_1 (lowb+1 to lowb+3) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_int1_vector (lowb+1 to lowb+3) =
                 c_st_int1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_int1_vector (lowb+1 to lowb+3) <= transport
               c_st_int1_vector_1 (lowb+1 to lowb+3) after 100 ns ;
--
         when 5
         => correct :=
               s_st_int1_vector (lowb+1 to lowb+3) =
                 c_st_int1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Old transactions were removed on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_int1_vector (lowb+1 to lowb+3) <=
               c_st_int1_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_int1_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_int1_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_int1_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 6
         => correct :=
               s_st_int1_vector (lowb+1 to lowb+3) =
                 c_st_int1_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            -- Last transaction above is marked by following
            s_st_int1_vector (lowb+1 to lowb+3) <=
               c_st_int1_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 7
         => correct :=
               s_st_int1_vector (lowb+1 to lowb+3) =
                 c_st_int1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_st_int1_vector (lowb+1 to lowb+3) =
                 c_st_int1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_int1_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_st_int1_vector'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P7 ;
--
   PGEN_CHKP_7 :
   process ( chk_st_int1_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P7" ,
           "Inertial transactions entirely completed",
           chk_st_int1_vector = 8 ) ;
      end if ;
   end process PGEN_CHKP_7 ;
--
   P8 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_time_vector (lowb+1 to lowb+3) <=
               c_st_time_vector_2 (lowb+1 to lowb+3) after 10 ns,
               c_st_time_vector_1 (lowb+1 to lowb+3) after 20 ns ;
--
         when 1
         => correct :=
               s_st_time_vector (lowb+1 to lowb+3) =
                 c_st_time_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_time_vector (lowb+1 to lowb+3) =
                 c_st_time_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143.P8" ,
              "Multi inertial transactions occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_time_vector (lowb+1 to lowb+3) <=
               c_st_time_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_time_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_time_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_time_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 3
         => correct :=
               s_st_time_vector (lowb+1 to lowb+3) =
                 c_st_time_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_time_vector (lowb+1 to lowb+3) <=
               c_st_time_vector_1 (lowb+1 to lowb+3) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_time_vector (lowb+1 to lowb+3) =
                 c_st_time_vector_1 (lowb+1 to lowb+3) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_time_vector (lowb+1 to lowb+3) <= transport
               c_st_time_vector_1 (lowb+1 to lowb+3) after 100 ns ;
--
         when 5
         => correct :=
               s_st_time_vector (lowb+1 to lowb+3) =
                 c_st_time_vector_1 (lowb+1 to lowb+3) and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Old transactions were removed on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_time_vector (lowb+1 to lowb+3) <=
               c_st_time_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_time_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_time_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_time_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 6
         => correct :=
               s_st_time_vector (lowb+1 to lowb+3) =
                 c_st_time_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            -- Last transaction above is marked by following
            s_st_time_vector (lowb+1 to lowb+3) <=
               c_st_time_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 7
         => correct :=
               s_st_time_vector (lowb+1 to lowb+3) =
                 c_st_time_vector_1 (lowb+1 to lowb+3) and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_st_time_vector (lowb+1 to lowb+3) =
                 c_st_time_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_time_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_st_time_vector'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P8 ;
--
   PGEN_CHKP_8 :
   process ( chk_st_time_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P8" ,
           "Inertial transactions entirely completed",
           chk_st_time_vector = 8 ) ;
      end if ;
   end process PGEN_CHKP_8 ;
--
   P9 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_phys1_vector (lowb+1 to lowb+3) <=
               c_st_phys1_vector_2 (lowb+1 to lowb+3) after 10 ns,
               c_st_phys1_vector_1 (lowb+1 to lowb+3) after 20 ns ;
--
         when 1
         => correct :=
               s_st_phys1_vector (lowb+1 to lowb+3) =
                 c_st_phys1_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_phys1_vector (lowb+1 to lowb+3) =
                 c_st_phys1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143.P9" ,
              "Multi inertial transactions occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_phys1_vector (lowb+1 to lowb+3) <=
               c_st_phys1_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_phys1_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_phys1_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_phys1_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 3
         => correct :=
               s_st_phys1_vector (lowb+1 to lowb+3) =
                 c_st_phys1_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_phys1_vector (lowb+1 to lowb+3) <=
               c_st_phys1_vector_1 (lowb+1 to lowb+3) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_phys1_vector (lowb+1 to lowb+3) =
                 c_st_phys1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_phys1_vector (lowb+1 to lowb+3) <= transport
               c_st_phys1_vector_1 (lowb+1 to lowb+3) after 100 ns ;
--
         when 5
         => correct :=
               s_st_phys1_vector (lowb+1 to lowb+3) =
                 c_st_phys1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Old transactions were removed on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_phys1_vector (lowb+1 to lowb+3) <=
               c_st_phys1_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_phys1_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_phys1_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_phys1_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 6
         => correct :=
               s_st_phys1_vector (lowb+1 to lowb+3) =
                 c_st_phys1_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            -- Last transaction above is marked by following
            s_st_phys1_vector (lowb+1 to lowb+3) <=
               c_st_phys1_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 7
         => correct :=
               s_st_phys1_vector (lowb+1 to lowb+3) =
                 c_st_phys1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_st_phys1_vector (lowb+1 to lowb+3) =
                 c_st_phys1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_phys1_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_st_phys1_vector'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P9 ;
--
   PGEN_CHKP_9 :
   process ( chk_st_phys1_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P9" ,
           "Inertial transactions entirely completed",
           chk_st_phys1_vector = 8 ) ;
      end if ;
   end process PGEN_CHKP_9 ;
--
   P10 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_real_vector (lowb+1 to lowb+3) <=
               c_st_real_vector_2 (lowb+1 to lowb+3) after 10 ns,
               c_st_real_vector_1 (lowb+1 to lowb+3) after 20 ns ;
--
         when 1
         => correct :=
               s_st_real_vector (lowb+1 to lowb+3) =
                 c_st_real_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_real_vector (lowb+1 to lowb+3) =
                 c_st_real_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143.P10" ,
              "Multi inertial transactions occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_real_vector (lowb+1 to lowb+3) <=
               c_st_real_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_real_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_real_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_real_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 3
         => correct :=
               s_st_real_vector (lowb+1 to lowb+3) =
                 c_st_real_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_real_vector (lowb+1 to lowb+3) <=
               c_st_real_vector_1 (lowb+1 to lowb+3) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_real_vector (lowb+1 to lowb+3) =
                 c_st_real_vector_1 (lowb+1 to lowb+3) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_real_vector (lowb+1 to lowb+3) <= transport
               c_st_real_vector_1 (lowb+1 to lowb+3) after 100 ns ;
--
         when 5
         => correct :=
               s_st_real_vector (lowb+1 to lowb+3) =
                 c_st_real_vector_1 (lowb+1 to lowb+3) and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Old transactions were removed on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_real_vector (lowb+1 to lowb+3) <=
               c_st_real_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_real_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_real_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_real_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 6
         => correct :=
               s_st_real_vector (lowb+1 to lowb+3) =
                 c_st_real_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            -- Last transaction above is marked by following
            s_st_real_vector (lowb+1 to lowb+3) <=
               c_st_real_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 7
         => correct :=
               s_st_real_vector (lowb+1 to lowb+3) =
                 c_st_real_vector_1 (lowb+1 to lowb+3) and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_st_real_vector (lowb+1 to lowb+3) =
                 c_st_real_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_real_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_st_real_vector'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P10 ;
--
   PGEN_CHKP_10 :
   process ( chk_st_real_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P10" ,
           "Inertial transactions entirely completed",
           chk_st_real_vector = 8 ) ;
      end if ;
   end process PGEN_CHKP_10 ;
--
   P11 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_real1_vector (lowb+1 to lowb+3) <=
               c_st_real1_vector_2 (lowb+1 to lowb+3) after 10 ns,
               c_st_real1_vector_1 (lowb+1 to lowb+3) after 20 ns ;
--
         when 1
         => correct :=
               s_st_real1_vector (lowb+1 to lowb+3) =
                 c_st_real1_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_real1_vector (lowb+1 to lowb+3) =
                 c_st_real1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143.P11" ,
              "Multi inertial transactions occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_real1_vector (lowb+1 to lowb+3) <=
               c_st_real1_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_real1_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_real1_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_real1_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 3
         => correct :=
               s_st_real1_vector (lowb+1 to lowb+3) =
                 c_st_real1_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_real1_vector (lowb+1 to lowb+3) <=
               c_st_real1_vector_1 (lowb+1 to lowb+3) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_real1_vector (lowb+1 to lowb+3) =
                 c_st_real1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_real1_vector (lowb+1 to lowb+3) <= transport
               c_st_real1_vector_1 (lowb+1 to lowb+3) after 100 ns ;
--
         when 5
         => correct :=
               s_st_real1_vector (lowb+1 to lowb+3) =
                 c_st_real1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Old transactions were removed on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_real1_vector (lowb+1 to lowb+3) <=
               c_st_real1_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_real1_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_real1_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_real1_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 6
         => correct :=
               s_st_real1_vector (lowb+1 to lowb+3) =
                 c_st_real1_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            -- Last transaction above is marked by following
            s_st_real1_vector (lowb+1 to lowb+3) <=
               c_st_real1_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 7
         => correct :=
               s_st_real1_vector (lowb+1 to lowb+3) =
                 c_st_real1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_st_real1_vector (lowb+1 to lowb+3) =
                 c_st_real1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_real1_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_st_real1_vector'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P11 ;
--
   PGEN_CHKP_11 :
   process ( chk_st_real1_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P11" ,
           "Inertial transactions entirely completed",
           chk_st_real1_vector = 8 ) ;
      end if ;
   end process PGEN_CHKP_11 ;
--
   P12 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_rec1_vector (lowb+1 to lowb+3) <=
               c_st_rec1_vector_2 (lowb+1 to lowb+3) after 10 ns,
               c_st_rec1_vector_1 (lowb+1 to lowb+3) after 20 ns ;
--
         when 1
         => correct :=
               s_st_rec1_vector (lowb+1 to lowb+3) =
                 c_st_rec1_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_rec1_vector (lowb+1 to lowb+3) =
                 c_st_rec1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143.P12" ,
              "Multi inertial transactions occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_rec1_vector (lowb+1 to lowb+3) <=
               c_st_rec1_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_rec1_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_rec1_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_rec1_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 3
         => correct :=
               s_st_rec1_vector (lowb+1 to lowb+3) =
                 c_st_rec1_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_rec1_vector (lowb+1 to lowb+3) <=
               c_st_rec1_vector_1 (lowb+1 to lowb+3) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_rec1_vector (lowb+1 to lowb+3) =
                 c_st_rec1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_rec1_vector (lowb+1 to lowb+3) <= transport
               c_st_rec1_vector_1 (lowb+1 to lowb+3) after 100 ns ;
--
         when 5
         => correct :=
               s_st_rec1_vector (lowb+1 to lowb+3) =
                 c_st_rec1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Old transactions were removed on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_rec1_vector (lowb+1 to lowb+3) <=
               c_st_rec1_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_rec1_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_rec1_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_rec1_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 6
         => correct :=
               s_st_rec1_vector (lowb+1 to lowb+3) =
                 c_st_rec1_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            -- Last transaction above is marked by following
            s_st_rec1_vector (lowb+1 to lowb+3) <=
               c_st_rec1_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 7
         => correct :=
               s_st_rec1_vector (lowb+1 to lowb+3) =
                 c_st_rec1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_st_rec1_vector (lowb+1 to lowb+3) =
                 c_st_rec1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
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
   end process P12 ;
--
   PGEN_CHKP_12 :
   process ( chk_st_rec1_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P12" ,
           "Inertial transactions entirely completed",
           chk_st_rec1_vector = 8 ) ;
      end if ;
   end process PGEN_CHKP_12 ;
--
   P13 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_rec2_vector (lowb+1 to lowb+3) <=
               c_st_rec2_vector_2 (lowb+1 to lowb+3) after 10 ns,
               c_st_rec2_vector_1 (lowb+1 to lowb+3) after 20 ns ;
--
         when 1
         => correct :=
               s_st_rec2_vector (lowb+1 to lowb+3) =
                 c_st_rec2_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_rec2_vector (lowb+1 to lowb+3) =
                 c_st_rec2_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143.P13" ,
              "Multi inertial transactions occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_rec2_vector (lowb+1 to lowb+3) <=
               c_st_rec2_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_rec2_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_rec2_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_rec2_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 3
         => correct :=
               s_st_rec2_vector (lowb+1 to lowb+3) =
                 c_st_rec2_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_rec2_vector (lowb+1 to lowb+3) <=
               c_st_rec2_vector_1 (lowb+1 to lowb+3) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_rec2_vector (lowb+1 to lowb+3) =
                 c_st_rec2_vector_1 (lowb+1 to lowb+3) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_rec2_vector (lowb+1 to lowb+3) <= transport
               c_st_rec2_vector_1 (lowb+1 to lowb+3) after 100 ns ;
--
         when 5
         => correct :=
               s_st_rec2_vector (lowb+1 to lowb+3) =
                 c_st_rec2_vector_1 (lowb+1 to lowb+3) and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Old transactions were removed on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_rec2_vector (lowb+1 to lowb+3) <=
               c_st_rec2_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_rec2_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_rec2_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_rec2_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 6
         => correct :=
               s_st_rec2_vector (lowb+1 to lowb+3) =
                 c_st_rec2_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            -- Last transaction above is marked by following
            s_st_rec2_vector (lowb+1 to lowb+3) <=
               c_st_rec2_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 7
         => correct :=
               s_st_rec2_vector (lowb+1 to lowb+3) =
                 c_st_rec2_vector_1 (lowb+1 to lowb+3) and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_st_rec2_vector (lowb+1 to lowb+3) =
                 c_st_rec2_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
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
   end process P13 ;
--
   PGEN_CHKP_13 :
   process ( chk_st_rec2_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P13" ,
           "Inertial transactions entirely completed",
           chk_st_rec2_vector = 8 ) ;
      end if ;
   end process PGEN_CHKP_13 ;
--
   P14 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_rec3_vector (lowb+1 to lowb+3) <=
               c_st_rec3_vector_2 (lowb+1 to lowb+3) after 10 ns,
               c_st_rec3_vector_1 (lowb+1 to lowb+3) after 20 ns ;
--
         when 1
         => correct :=
               s_st_rec3_vector (lowb+1 to lowb+3) =
                 c_st_rec3_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_rec3_vector (lowb+1 to lowb+3) =
                 c_st_rec3_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143.P14" ,
              "Multi inertial transactions occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_rec3_vector (lowb+1 to lowb+3) <=
               c_st_rec3_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_rec3_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_rec3_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_rec3_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 3
         => correct :=
               s_st_rec3_vector (lowb+1 to lowb+3) =
                 c_st_rec3_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_rec3_vector (lowb+1 to lowb+3) <=
               c_st_rec3_vector_1 (lowb+1 to lowb+3) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_rec3_vector (lowb+1 to lowb+3) =
                 c_st_rec3_vector_1 (lowb+1 to lowb+3) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_rec3_vector (lowb+1 to lowb+3) <= transport
               c_st_rec3_vector_1 (lowb+1 to lowb+3) after 100 ns ;
--
         when 5
         => correct :=
               s_st_rec3_vector (lowb+1 to lowb+3) =
                 c_st_rec3_vector_1 (lowb+1 to lowb+3) and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Old transactions were removed on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_rec3_vector (lowb+1 to lowb+3) <=
               c_st_rec3_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_rec3_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_rec3_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_rec3_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 6
         => correct :=
               s_st_rec3_vector (lowb+1 to lowb+3) =
                 c_st_rec3_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            -- Last transaction above is marked by following
            s_st_rec3_vector (lowb+1 to lowb+3) <=
               c_st_rec3_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 7
         => correct :=
               s_st_rec3_vector (lowb+1 to lowb+3) =
                 c_st_rec3_vector_1 (lowb+1 to lowb+3) and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_st_rec3_vector (lowb+1 to lowb+3) =
                 c_st_rec3_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
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
   end process P14 ;
--
   PGEN_CHKP_14 :
   process ( chk_st_rec3_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P14" ,
           "Inertial transactions entirely completed",
           chk_st_rec3_vector = 8 ) ;
      end if ;
   end process PGEN_CHKP_14 ;
--
   P15 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_arr1_vector (lowb+1 to lowb+3) <=
               c_st_arr1_vector_2 (lowb+1 to lowb+3) after 10 ns,
               c_st_arr1_vector_1 (lowb+1 to lowb+3) after 20 ns ;
--
         when 1
         => correct :=
               s_st_arr1_vector (lowb+1 to lowb+3) =
                 c_st_arr1_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_arr1_vector (lowb+1 to lowb+3) =
                 c_st_arr1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143.P15" ,
              "Multi inertial transactions occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_arr1_vector (lowb+1 to lowb+3) <=
               c_st_arr1_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_arr1_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_arr1_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_arr1_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 3
         => correct :=
               s_st_arr1_vector (lowb+1 to lowb+3) =
                 c_st_arr1_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_arr1_vector (lowb+1 to lowb+3) <=
               c_st_arr1_vector_1 (lowb+1 to lowb+3) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_arr1_vector (lowb+1 to lowb+3) =
                 c_st_arr1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_arr1_vector (lowb+1 to lowb+3) <= transport
               c_st_arr1_vector_1 (lowb+1 to lowb+3) after 100 ns ;
--
         when 5
         => correct :=
               s_st_arr1_vector (lowb+1 to lowb+3) =
                 c_st_arr1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Old transactions were removed on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_arr1_vector (lowb+1 to lowb+3) <=
               c_st_arr1_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_arr1_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_arr1_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_arr1_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 6
         => correct :=
               s_st_arr1_vector (lowb+1 to lowb+3) =
                 c_st_arr1_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            -- Last transaction above is marked by following
            s_st_arr1_vector (lowb+1 to lowb+3) <=
               c_st_arr1_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 7
         => correct :=
               s_st_arr1_vector (lowb+1 to lowb+3) =
                 c_st_arr1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_st_arr1_vector (lowb+1 to lowb+3) =
                 c_st_arr1_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_arr1_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_st_arr1_vector'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P15 ;
--
   PGEN_CHKP_15 :
   process ( chk_st_arr1_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P15" ,
           "Inertial transactions entirely completed",
           chk_st_arr1_vector = 8 ) ;
      end if ;
   end process PGEN_CHKP_15 ;
--
   P16 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_arr2_vector (lowb+1 to lowb+3) <=
               c_st_arr2_vector_2 (lowb+1 to lowb+3) after 10 ns,
               c_st_arr2_vector_1 (lowb+1 to lowb+3) after 20 ns ;
--
         when 1
         => correct :=
               s_st_arr2_vector (lowb+1 to lowb+3) =
                 c_st_arr2_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_arr2_vector (lowb+1 to lowb+3) =
                 c_st_arr2_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143.P16" ,
              "Multi inertial transactions occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_arr2_vector (lowb+1 to lowb+3) <=
               c_st_arr2_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_arr2_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_arr2_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_arr2_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 3
         => correct :=
               s_st_arr2_vector (lowb+1 to lowb+3) =
                 c_st_arr2_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_arr2_vector (lowb+1 to lowb+3) <=
               c_st_arr2_vector_1 (lowb+1 to lowb+3) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_arr2_vector (lowb+1 to lowb+3) =
                 c_st_arr2_vector_1 (lowb+1 to lowb+3) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_arr2_vector (lowb+1 to lowb+3) <= transport
               c_st_arr2_vector_1 (lowb+1 to lowb+3) after 100 ns ;
--
         when 5
         => correct :=
               s_st_arr2_vector (lowb+1 to lowb+3) =
                 c_st_arr2_vector_1 (lowb+1 to lowb+3) and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Old transactions were removed on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_arr2_vector (lowb+1 to lowb+3) <=
               c_st_arr2_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_arr2_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_arr2_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_arr2_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 6
         => correct :=
               s_st_arr2_vector (lowb+1 to lowb+3) =
                 c_st_arr2_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            -- Last transaction above is marked by following
            s_st_arr2_vector (lowb+1 to lowb+3) <=
               c_st_arr2_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 7
         => correct :=
               s_st_arr2_vector (lowb+1 to lowb+3) =
                 c_st_arr2_vector_1 (lowb+1 to lowb+3) and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_st_arr2_vector (lowb+1 to lowb+3) =
                 c_st_arr2_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_arr2_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_st_arr2_vector'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P16 ;
--
   PGEN_CHKP_16 :
   process ( chk_st_arr2_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P16" ,
           "Inertial transactions entirely completed",
           chk_st_arr2_vector = 8 ) ;
      end if ;
   end process PGEN_CHKP_16 ;
--
   P17 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_arr3_vector (lowb+1 to lowb+3) <=
               c_st_arr3_vector_2 (lowb+1 to lowb+3) after 10 ns,
               c_st_arr3_vector_1 (lowb+1 to lowb+3) after 20 ns ;
--
         when 1
         => correct :=
               s_st_arr3_vector (lowb+1 to lowb+3) =
                 c_st_arr3_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_arr3_vector (lowb+1 to lowb+3) =
                 c_st_arr3_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143.P17" ,
              "Multi inertial transactions occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_arr3_vector (lowb+1 to lowb+3) <=
               c_st_arr3_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_arr3_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_arr3_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_arr3_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 3
         => correct :=
               s_st_arr3_vector (lowb+1 to lowb+3) =
                 c_st_arr3_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_arr3_vector (lowb+1 to lowb+3) <=
               c_st_arr3_vector_1 (lowb+1 to lowb+3) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_arr3_vector (lowb+1 to lowb+3) =
                 c_st_arr3_vector_1 (lowb+1 to lowb+3) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_arr3_vector (lowb+1 to lowb+3) <= transport
               c_st_arr3_vector_1 (lowb+1 to lowb+3) after 100 ns ;
--
         when 5
         => correct :=
               s_st_arr3_vector (lowb+1 to lowb+3) =
                 c_st_arr3_vector_1 (lowb+1 to lowb+3) and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Old transactions were removed on signal " &
              "asg with slice name on LHS",
              correct ) ;
            s_st_arr3_vector (lowb+1 to lowb+3) <=
               c_st_arr3_vector_2 (lowb+1 to lowb+3) after 10 ns ,
               c_st_arr3_vector_1 (lowb+1 to lowb+3) after 20 ns ,
               c_st_arr3_vector_2 (lowb+1 to lowb+3) after 30 ns ,
               c_st_arr3_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 6
         => correct :=
               s_st_arr3_vector (lowb+1 to lowb+3) =
                 c_st_arr3_vector_2 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name on LHS",
              correct ) ;
            -- Last transaction above is marked by following
            s_st_arr3_vector (lowb+1 to lowb+3) <=
               c_st_arr3_vector_1 (lowb+1 to lowb+3) after 40 ns ;
--
         when 7
         => correct :=
               s_st_arr3_vector (lowb+1 to lowb+3) =
                 c_st_arr3_vector_1 (lowb+1 to lowb+3) and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_st_arr3_vector (lowb+1 to lowb+3) =
                 c_st_arr3_vector_1 (lowb+1 to lowb+3) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00143" ,
              "Inertial semantics check on a signal " &
              "asg with slice name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_arr3_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_st_arr3_vector'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P17 ;
--
   PGEN_CHKP_17 :
   process ( chk_st_arr3_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P17" ,
           "Inertial transactions entirely completed",
           chk_st_arr3_vector = 8 ) ;
      end if ;
   end process PGEN_CHKP_17 ;
--
--
end ARCH00143 ;
--
entity ENT00143_Test_Bench is
end ENT00143_Test_Bench ;
--
architecture ARCH00143_Test_Bench of ENT00143_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00143 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00143_Test_Bench ;
