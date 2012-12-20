-- NEED RESULT: ARCH00182.P1: Multi inertial transactions occurred on signal asg with slice name prefixed by a selected name on LHS passed
-- NEED RESULT: ARCH00182.P2: Multi inertial transactions occurred on signal asg with slice name prefixed by a selected name on LHS passed
-- NEED RESULT: ARCH00182.P3: Multi inertial transactions occurred on signal asg with slice name prefixed by a selected name on LHS passed
-- NEED RESULT: ARCH00182.P4: Multi inertial transactions occurred on signal asg with slice name prefixed by a selected name on LHS passed
-- NEED RESULT: ARCH00182.P5: Multi inertial transactions occurred on signal asg with slice name prefixed by a selected name on LHS passed
-- NEED RESULT: ARCH00182.P6: Multi inertial transactions occurred on signal asg with slice name prefixed by a selected name on LHS passed
-- NEED RESULT: ARCH00182: One inertial transaction occurred on signal asg with slice name prefixed by an selected name on LHS passed
-- NEED RESULT: ARCH00182: One inertial transaction occurred on signal asg with slice name prefixed by an selected name on LHS passed
-- NEED RESULT: ARCH00182: One inertial transaction occurred on signal asg with slice name prefixed by an selected name on LHS passed
-- NEED RESULT: ARCH00182: One inertial transaction occurred on signal asg with slice name prefixed by an selected name on LHS passed
-- NEED RESULT: ARCH00182: One inertial transaction occurred on signal asg with slice name prefixed by an selected name on LHS passed
-- NEED RESULT: ARCH00182: One inertial transaction occurred on signal asg with slice name prefixed by an selected name on LHS passed
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
--    CT00182
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
--    PKG00182
--    PKG00182/BODY
--    ENT00182(ARCH00182)
--    ENT00182_Test_Bench(ARCH00182_Test_Bench)
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
package PKG00182 is
   type r_st_arr1_vector is record
     f1 : integer ;
     f2 : st_arr1_vector ;
   end record ;
   function c_r_st_arr1_vector_1 return r_st_arr1_vector ;
       -- (c_integer_1, c_st_arr1_vector_1) ;
   function c_r_st_arr1_vector_2 return r_st_arr1_vector ;
       -- (c_integer_2, c_st_arr1_vector_2) ;
--
   type r_st_arr2_vector is record
     f1 : integer ;
     f2 : st_arr2_vector ;
   end record ;
   function c_r_st_arr2_vector_1 return r_st_arr2_vector ;
       -- (c_integer_1, c_st_arr2_vector_1) ;
   function c_r_st_arr2_vector_2 return r_st_arr2_vector ;
       -- (c_integer_2, c_st_arr2_vector_2) ;
--
   type r_st_arr3_vector is record
     f1 : integer ;
     f2 : st_arr3_vector ;
   end record ;
   function c_r_st_arr3_vector_1 return r_st_arr3_vector ;
       -- (c_integer_1, c_st_arr3_vector_1) ;
   function c_r_st_arr3_vector_2 return r_st_arr3_vector ;
       -- (c_integer_2, c_st_arr3_vector_2) ;
--
   type r_st_rec1_vector is record
     f1 : integer ;
     f2 : st_rec1_vector ;
   end record ;
   function c_r_st_rec1_vector_1 return r_st_rec1_vector ;
       -- (c_integer_1, c_st_rec1_vector_1) ;
   function c_r_st_rec1_vector_2 return r_st_rec1_vector ;
       -- (c_integer_2, c_st_rec1_vector_2) ;
--
   type r_st_rec2_vector is record
     f1 : integer ;
     f2 : st_rec2_vector ;
   end record ;
   function c_r_st_rec2_vector_1 return r_st_rec2_vector ;
       -- (c_integer_1, c_st_rec2_vector_1) ;
   function c_r_st_rec2_vector_2 return r_st_rec2_vector ;
       -- (c_integer_2, c_st_rec2_vector_2) ;
--
   type r_st_rec3_vector is record
     f1 : integer ;
     f2 : st_rec3_vector ;
   end record ;
   function c_r_st_rec3_vector_1 return r_st_rec3_vector ;
       -- (c_integer_1, c_st_rec3_vector_1) ;
   function c_r_st_rec3_vector_2 return r_st_rec3_vector ;
       -- (c_integer_2, c_st_rec3_vector_2) ;
--
--
end PKG00182 ;
--
package body PKG00182 is
   function c_r_st_arr1_vector_1 return r_st_arr1_vector
   is begin
       return (c_integer_1, c_st_arr1_vector_1) ;
   end c_r_st_arr1_vector_1 ;
--
   function c_r_st_arr1_vector_2 return r_st_arr1_vector
   is begin
       return (c_integer_2, c_st_arr1_vector_2) ;
   end c_r_st_arr1_vector_2 ;
--
--
   function c_r_st_arr2_vector_1 return r_st_arr2_vector
   is begin
       return (c_integer_1, c_st_arr2_vector_1) ;
   end c_r_st_arr2_vector_1 ;
--
   function c_r_st_arr2_vector_2 return r_st_arr2_vector
   is begin
       return (c_integer_2, c_st_arr2_vector_2) ;
   end c_r_st_arr2_vector_2 ;
--
--
   function c_r_st_arr3_vector_1 return r_st_arr3_vector
   is begin
       return (c_integer_1, c_st_arr3_vector_1) ;
   end c_r_st_arr3_vector_1 ;
--
   function c_r_st_arr3_vector_2 return r_st_arr3_vector
   is begin
       return (c_integer_2, c_st_arr3_vector_2) ;
   end c_r_st_arr3_vector_2 ;
--
--
   function c_r_st_rec1_vector_1 return r_st_rec1_vector
   is begin
       return (c_integer_1, c_st_rec1_vector_1) ;
   end c_r_st_rec1_vector_1 ;
--
   function c_r_st_rec1_vector_2 return r_st_rec1_vector
   is begin
       return (c_integer_2, c_st_rec1_vector_2) ;
   end c_r_st_rec1_vector_2 ;
--
--
   function c_r_st_rec2_vector_1 return r_st_rec2_vector
   is begin
       return (c_integer_1, c_st_rec2_vector_1) ;
   end c_r_st_rec2_vector_1 ;
--
   function c_r_st_rec2_vector_2 return r_st_rec2_vector
   is begin
       return (c_integer_2, c_st_rec2_vector_2) ;
   end c_r_st_rec2_vector_2 ;
--
--
   function c_r_st_rec3_vector_1 return r_st_rec3_vector
   is begin
       return (c_integer_1, c_st_rec3_vector_1) ;
   end c_r_st_rec3_vector_1 ;
--
   function c_r_st_rec3_vector_2 return r_st_rec3_vector
   is begin
       return (c_integer_2, c_st_rec3_vector_2) ;
   end c_r_st_rec3_vector_2 ;
--
--
--
end PKG00182 ;
--
use WORK.STANDARD_TYPES.all ;
use WORK.PKG00182.all ;
entity ENT00182 is
   port (
        s_r_st_arr1_vector : inout r_st_arr1_vector
      ; s_r_st_arr2_vector : inout r_st_arr2_vector
      ; s_r_st_arr3_vector : inout r_st_arr3_vector
      ; s_r_st_rec1_vector : inout r_st_rec1_vector
      ; s_r_st_rec2_vector : inout r_st_rec2_vector
      ; s_r_st_rec3_vector : inout r_st_rec3_vector
        ) ;
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_r_st_arr1_vector : chk_sig_type := -1 ;
   signal chk_r_st_arr2_vector : chk_sig_type := -1 ;
   signal chk_r_st_arr3_vector : chk_sig_type := -1 ;
   signal chk_r_st_rec1_vector : chk_sig_type := -1 ;
   signal chk_r_st_rec2_vector : chk_sig_type := -1 ;
   signal chk_r_st_rec3_vector : chk_sig_type := -1 ;
--
end ENT00182 ;
--
architecture ARCH00182 of ENT00182 is
begin
   P1 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_r_st_arr1_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_arr1_vector_2.f2
                 (lowb+1 to highb-1) after 10 ns,
               c_r_st_arr1_vector_1.f2
                 (lowb+1 to highb-1) after 20 ns ;
--
         when 1
         => correct :=
               s_r_st_arr1_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr1_vector_2.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_r_st_arr1_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr1_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182.P1" ,
              "Multi inertial transactions occurred on signal " &
              "asg with slice name prefixed by a selected name on LHS",
              correct ) ;
            s_r_st_arr1_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_arr1_vector_2.f2
                 (lowb+1 to highb-1) after 10 ns ,
               c_r_st_arr1_vector_1.f2
                 (lowb+1 to highb-1) after 20 ns ,
               c_r_st_arr1_vector_2.f2
                 (lowb+1 to highb-1) after 30 ns ,
               c_r_st_arr1_vector_1.f2
                 (lowb+1 to highb-1) after 40 ns ;
--
         when 3
         => correct :=
               s_r_st_arr1_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr1_vector_2.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_r_st_arr1_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_arr1_vector_1.f2
                 (lowb+1 to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_r_st_arr1_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr1_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
            s_r_st_arr1_vector.f2 (lowb+1 to highb-1) <= transport
               c_r_st_arr1_vector_1.f2
                 (lowb+1 to highb-1) after 100 ns ;
--
         when 5
         => correct :=
               s_r_st_arr1_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr1_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182" ,
              "Old transactions were removed on signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
            s_r_st_arr1_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_arr1_vector_2.f2
                 (lowb+1 to highb-1) after 10 ns ,
               c_r_st_arr1_vector_1.f2
                 (lowb+1 to highb-1) after 20 ns ,
               c_r_st_arr1_vector_2.f2
                 (lowb+1 to highb-1) after 30 ns ,
               c_r_st_arr1_vector_1.f2
                 (lowb+1 to highb-1) after 40 ns ;
--
         when 6
         => correct :=
               s_r_st_arr1_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr1_vector_2.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
            -- Last transaction above is marked
            s_r_st_arr1_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_arr1_vector_1.f2
                 (lowb+1 to highb-1) after 40 ns ;
--
         when 7
         => correct :=
               s_r_st_arr1_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr1_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_r_st_arr1_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr1_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182" ,
              "Inertial semantics check on a signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00182" ,
              "Inertial semantics check on a signal " &
              "asg with slice name prefixed by an selected name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_r_st_arr1_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_r_st_arr1_vector'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P1 ;
--
   PGEN_CHKP_1 :
   process ( chk_r_st_arr1_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Inertial transactions entirely completed",
           chk_r_st_arr1_vector = 8 ) ;
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
         => s_r_st_arr2_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_arr2_vector_2.f2
                 (lowb+1 to highb-1) after 10 ns,
               c_r_st_arr2_vector_1.f2
                 (lowb+1 to highb-1) after 20 ns ;
--
         when 1
         => correct :=
               s_r_st_arr2_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr2_vector_2.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_r_st_arr2_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr2_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182.P2" ,
              "Multi inertial transactions occurred on signal " &
              "asg with slice name prefixed by a selected name on LHS",
              correct ) ;
            s_r_st_arr2_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_arr2_vector_2.f2
                 (lowb+1 to highb-1) after 10 ns ,
               c_r_st_arr2_vector_1.f2
                 (lowb+1 to highb-1) after 20 ns ,
               c_r_st_arr2_vector_2.f2
                 (lowb+1 to highb-1) after 30 ns ,
               c_r_st_arr2_vector_1.f2
                 (lowb+1 to highb-1) after 40 ns ;
--
         when 3
         => correct :=
               s_r_st_arr2_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr2_vector_2.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_r_st_arr2_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_arr2_vector_1.f2
                 (lowb+1 to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_r_st_arr2_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr2_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
            s_r_st_arr2_vector.f2 (lowb+1 to highb-1) <= transport
               c_r_st_arr2_vector_1.f2
                 (lowb+1 to highb-1) after 100 ns ;
--
         when 5
         => correct :=
               s_r_st_arr2_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr2_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182" ,
              "Old transactions were removed on signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
            s_r_st_arr2_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_arr2_vector_2.f2
                 (lowb+1 to highb-1) after 10 ns ,
               c_r_st_arr2_vector_1.f2
                 (lowb+1 to highb-1) after 20 ns ,
               c_r_st_arr2_vector_2.f2
                 (lowb+1 to highb-1) after 30 ns ,
               c_r_st_arr2_vector_1.f2
                 (lowb+1 to highb-1) after 40 ns ;
--
         when 6
         => correct :=
               s_r_st_arr2_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr2_vector_2.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
            -- Last transaction above is marked
            s_r_st_arr2_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_arr2_vector_1.f2
                 (lowb+1 to highb-1) after 40 ns ;
--
         when 7
         => correct :=
               s_r_st_arr2_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr2_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_r_st_arr2_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr2_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182" ,
              "Inertial semantics check on a signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00182" ,
              "Inertial semantics check on a signal " &
              "asg with slice name prefixed by an selected name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_r_st_arr2_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_r_st_arr2_vector'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P2 ;
--
   PGEN_CHKP_2 :
   process ( chk_r_st_arr2_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P2" ,
           "Inertial transactions entirely completed",
           chk_r_st_arr2_vector = 8 ) ;
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
         => s_r_st_arr3_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_arr3_vector_2.f2
                 (lowb+1 to highb-1) after 10 ns,
               c_r_st_arr3_vector_1.f2
                 (lowb+1 to highb-1) after 20 ns ;
--
         when 1
         => correct :=
               s_r_st_arr3_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr3_vector_2.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_r_st_arr3_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr3_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182.P3" ,
              "Multi inertial transactions occurred on signal " &
              "asg with slice name prefixed by a selected name on LHS",
              correct ) ;
            s_r_st_arr3_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_arr3_vector_2.f2
                 (lowb+1 to highb-1) after 10 ns ,
               c_r_st_arr3_vector_1.f2
                 (lowb+1 to highb-1) after 20 ns ,
               c_r_st_arr3_vector_2.f2
                 (lowb+1 to highb-1) after 30 ns ,
               c_r_st_arr3_vector_1.f2
                 (lowb+1 to highb-1) after 40 ns ;
--
         when 3
         => correct :=
               s_r_st_arr3_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr3_vector_2.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_r_st_arr3_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_arr3_vector_1.f2
                 (lowb+1 to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_r_st_arr3_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr3_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
            s_r_st_arr3_vector.f2 (lowb+1 to highb-1) <= transport
               c_r_st_arr3_vector_1.f2
                 (lowb+1 to highb-1) after 100 ns ;
--
         when 5
         => correct :=
               s_r_st_arr3_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr3_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182" ,
              "Old transactions were removed on signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
            s_r_st_arr3_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_arr3_vector_2.f2
                 (lowb+1 to highb-1) after 10 ns ,
               c_r_st_arr3_vector_1.f2
                 (lowb+1 to highb-1) after 20 ns ,
               c_r_st_arr3_vector_2.f2
                 (lowb+1 to highb-1) after 30 ns ,
               c_r_st_arr3_vector_1.f2
                 (lowb+1 to highb-1) after 40 ns ;
--
         when 6
         => correct :=
               s_r_st_arr3_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr3_vector_2.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
            -- Last transaction above is marked
            s_r_st_arr3_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_arr3_vector_1.f2
                 (lowb+1 to highb-1) after 40 ns ;
--
         when 7
         => correct :=
               s_r_st_arr3_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr3_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_r_st_arr3_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr3_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182" ,
              "Inertial semantics check on a signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00182" ,
              "Inertial semantics check on a signal " &
              "asg with slice name prefixed by an selected name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_r_st_arr3_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_r_st_arr3_vector'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P3 ;
--
   PGEN_CHKP_3 :
   process ( chk_r_st_arr3_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P3" ,
           "Inertial transactions entirely completed",
           chk_r_st_arr3_vector = 8 ) ;
      end if ;
   end process PGEN_CHKP_3 ;
--
--
   P4 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_r_st_rec1_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_rec1_vector_2.f2
                 (lowb+1 to highb-1) after 10 ns,
               c_r_st_rec1_vector_1.f2
                 (lowb+1 to highb-1) after 20 ns ;
--
         when 1
         => correct :=
               s_r_st_rec1_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec1_vector_2.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_r_st_rec1_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec1_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182.P4" ,
              "Multi inertial transactions occurred on signal " &
              "asg with slice name prefixed by a selected name on LHS",
              correct ) ;
            s_r_st_rec1_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_rec1_vector_2.f2
                 (lowb+1 to highb-1) after 10 ns ,
               c_r_st_rec1_vector_1.f2
                 (lowb+1 to highb-1) after 20 ns ,
               c_r_st_rec1_vector_2.f2
                 (lowb+1 to highb-1) after 30 ns ,
               c_r_st_rec1_vector_1.f2
                 (lowb+1 to highb-1) after 40 ns ;
--
         when 3
         => correct :=
               s_r_st_rec1_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec1_vector_2.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_r_st_rec1_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_rec1_vector_1.f2
                 (lowb+1 to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_r_st_rec1_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec1_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
            s_r_st_rec1_vector.f2 (lowb+1 to highb-1) <= transport
               c_r_st_rec1_vector_1.f2
                 (lowb+1 to highb-1) after 100 ns ;
--
         when 5
         => correct :=
               s_r_st_rec1_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec1_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182" ,
              "Old transactions were removed on signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
            s_r_st_rec1_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_rec1_vector_2.f2
                 (lowb+1 to highb-1) after 10 ns ,
               c_r_st_rec1_vector_1.f2
                 (lowb+1 to highb-1) after 20 ns ,
               c_r_st_rec1_vector_2.f2
                 (lowb+1 to highb-1) after 30 ns ,
               c_r_st_rec1_vector_1.f2
                 (lowb+1 to highb-1) after 40 ns ;
--
         when 6
         => correct :=
               s_r_st_rec1_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec1_vector_2.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
            -- Last transaction above is marked
            s_r_st_rec1_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_rec1_vector_1.f2
                 (lowb+1 to highb-1) after 40 ns ;
--
         when 7
         => correct :=
               s_r_st_rec1_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec1_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_r_st_rec1_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec1_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182" ,
              "Inertial semantics check on a signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00182" ,
              "Inertial semantics check on a signal " &
              "asg with slice name prefixed by an selected name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_r_st_rec1_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_r_st_rec1_vector'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P4 ;
--
   PGEN_CHKP_4 :
   process ( chk_r_st_rec1_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P4" ,
           "Inertial transactions entirely completed",
           chk_r_st_rec1_vector = 8 ) ;
      end if ;
   end process PGEN_CHKP_4 ;
--
--
   P5 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_r_st_rec2_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_rec2_vector_2.f2
                 (lowb+1 to highb-1) after 10 ns,
               c_r_st_rec2_vector_1.f2
                 (lowb+1 to highb-1) after 20 ns ;
--
         when 1
         => correct :=
               s_r_st_rec2_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec2_vector_2.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_r_st_rec2_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec2_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182.P5" ,
              "Multi inertial transactions occurred on signal " &
              "asg with slice name prefixed by a selected name on LHS",
              correct ) ;
            s_r_st_rec2_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_rec2_vector_2.f2
                 (lowb+1 to highb-1) after 10 ns ,
               c_r_st_rec2_vector_1.f2
                 (lowb+1 to highb-1) after 20 ns ,
               c_r_st_rec2_vector_2.f2
                 (lowb+1 to highb-1) after 30 ns ,
               c_r_st_rec2_vector_1.f2
                 (lowb+1 to highb-1) after 40 ns ;
--
         when 3
         => correct :=
               s_r_st_rec2_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec2_vector_2.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_r_st_rec2_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_rec2_vector_1.f2
                 (lowb+1 to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_r_st_rec2_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec2_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
            s_r_st_rec2_vector.f2 (lowb+1 to highb-1) <= transport
               c_r_st_rec2_vector_1.f2
                 (lowb+1 to highb-1) after 100 ns ;
--
         when 5
         => correct :=
               s_r_st_rec2_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec2_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182" ,
              "Old transactions were removed on signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
            s_r_st_rec2_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_rec2_vector_2.f2
                 (lowb+1 to highb-1) after 10 ns ,
               c_r_st_rec2_vector_1.f2
                 (lowb+1 to highb-1) after 20 ns ,
               c_r_st_rec2_vector_2.f2
                 (lowb+1 to highb-1) after 30 ns ,
               c_r_st_rec2_vector_1.f2
                 (lowb+1 to highb-1) after 40 ns ;
--
         when 6
         => correct :=
               s_r_st_rec2_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec2_vector_2.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
            -- Last transaction above is marked
            s_r_st_rec2_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_rec2_vector_1.f2
                 (lowb+1 to highb-1) after 40 ns ;
--
         when 7
         => correct :=
               s_r_st_rec2_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec2_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_r_st_rec2_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec2_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182" ,
              "Inertial semantics check on a signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00182" ,
              "Inertial semantics check on a signal " &
              "asg with slice name prefixed by an selected name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_r_st_rec2_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_r_st_rec2_vector'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P5 ;
--
   PGEN_CHKP_5 :
   process ( chk_r_st_rec2_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P5" ,
           "Inertial transactions entirely completed",
           chk_r_st_rec2_vector = 8 ) ;
      end if ;
   end process PGEN_CHKP_5 ;
--
--
   P6 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_r_st_rec3_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_rec3_vector_2.f2
                 (lowb+1 to highb-1) after 10 ns,
               c_r_st_rec3_vector_1.f2
                 (lowb+1 to highb-1) after 20 ns ;
--
         when 1
         => correct :=
               s_r_st_rec3_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec3_vector_2.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_r_st_rec3_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec3_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182.P6" ,
              "Multi inertial transactions occurred on signal " &
              "asg with slice name prefixed by a selected name on LHS",
              correct ) ;
            s_r_st_rec3_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_rec3_vector_2.f2
                 (lowb+1 to highb-1) after 10 ns ,
               c_r_st_rec3_vector_1.f2
                 (lowb+1 to highb-1) after 20 ns ,
               c_r_st_rec3_vector_2.f2
                 (lowb+1 to highb-1) after 30 ns ,
               c_r_st_rec3_vector_1.f2
                 (lowb+1 to highb-1) after 40 ns ;
--
         when 3
         => correct :=
               s_r_st_rec3_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec3_vector_2.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_r_st_rec3_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_rec3_vector_1.f2
                 (lowb+1 to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_r_st_rec3_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec3_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
            s_r_st_rec3_vector.f2 (lowb+1 to highb-1) <= transport
               c_r_st_rec3_vector_1.f2
                 (lowb+1 to highb-1) after 100 ns ;
--
         when 5
         => correct :=
               s_r_st_rec3_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec3_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 100 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182" ,
              "Old transactions were removed on signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
            s_r_st_rec3_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_rec3_vector_2.f2
                 (lowb+1 to highb-1) after 10 ns ,
               c_r_st_rec3_vector_1.f2
                 (lowb+1 to highb-1) after 20 ns ,
               c_r_st_rec3_vector_2.f2
                 (lowb+1 to highb-1) after 30 ns ,
               c_r_st_rec3_vector_1.f2
                 (lowb+1 to highb-1) after 40 ns ;
--
         when 6
         => correct :=
               s_r_st_rec3_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec3_vector_2.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182" ,
              "One inertial transaction occurred on signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
            -- Last transaction above is marked
            s_r_st_rec3_vector.f2 (lowb+1 to highb-1) <=
               c_r_st_rec3_vector_1.f2
                 (lowb+1 to highb-1) after 40 ns ;
--
         when 7
         => correct :=
               s_r_st_rec3_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec3_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 30 ns) = Std.Standard.Now ;
--
         when 8
         => correct := correct and
               s_r_st_rec3_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec3_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00182" ,
              "Inertial semantics check on a signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00182" ,
              "Inertial semantics check on a signal " &
              "asg with slice name prefixed by an selected name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_r_st_rec3_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
      wait until (not s_r_st_rec3_vector'Quiet) and
                 (savtime /= Std.Standard.Now) ;
--
   end process P6 ;
--
   PGEN_CHKP_6 :
   process ( chk_r_st_rec3_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P6" ,
           "Inertial transactions entirely completed",
           chk_r_st_rec3_vector = 8 ) ;
      end if ;
   end process PGEN_CHKP_6 ;
--
--
--
end ARCH00182 ;
--
use WORK.STANDARD_TYPES.all ;
use WORK.PKG00182.all ;
entity ENT00182_Test_Bench is
   signal s_r_st_arr1_vector : r_st_arr1_vector
     := c_r_st_arr1_vector_1 ;
   signal s_r_st_arr2_vector : r_st_arr2_vector
     := c_r_st_arr2_vector_1 ;
   signal s_r_st_arr3_vector : r_st_arr3_vector
     := c_r_st_arr3_vector_1 ;
   signal s_r_st_rec1_vector : r_st_rec1_vector
     := c_r_st_rec1_vector_1 ;
   signal s_r_st_rec2_vector : r_st_rec2_vector
     := c_r_st_rec2_vector_1 ;
   signal s_r_st_rec3_vector : r_st_rec3_vector
     := c_r_st_rec3_vector_1 ;
--
end ENT00182_Test_Bench ;
--
architecture ARCH00182_Test_Bench of ENT00182_Test_Bench is
begin
   L1:
   block
      component UUT
         port (
              s_r_st_arr1_vector : inout r_st_arr1_vector
            ; s_r_st_arr2_vector : inout r_st_arr2_vector
            ; s_r_st_arr3_vector : inout r_st_arr3_vector
            ; s_r_st_rec1_vector : inout r_st_rec1_vector
            ; s_r_st_rec2_vector : inout r_st_rec2_vector
            ; s_r_st_rec3_vector : inout r_st_rec3_vector
              ) ;
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00182 ( ARCH00182 ) ;
   begin
      CIS1 : UUT
         port map (
              s_r_st_arr1_vector
            , s_r_st_arr2_vector
            , s_r_st_arr3_vector
            , s_r_st_rec1_vector
            , s_r_st_rec2_vector
            , s_r_st_rec3_vector
                  ) ;
   end block L1 ;
end ARCH00182_Test_Bench ;
