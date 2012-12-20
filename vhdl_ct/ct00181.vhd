-- NEED RESULT: ARCH00181.P1: Multi inertial transactions occurred on signal asg with slice name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00181.P2: Multi inertial transactions occurred on signal asg with slice name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00181.P3: Multi inertial transactions occurred on signal asg with slice name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00181.P4: Multi inertial transactions occurred on signal asg with slice name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00181.P5: Multi inertial transactions occurred on signal asg with slice name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00181.P6: Multi inertial transactions occurred on signal asg with slice name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00181: One inertial transaction occurred on signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: One inertial transaction occurred on signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: One inertial transaction occurred on signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: One inertial transaction occurred on signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: One inertial transaction occurred on signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: One inertial transaction occurred on signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: Old transactions were removed on signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: Old transactions were removed on signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: Old transactions were removed on signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: Old transactions were removed on signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: Old transactions were removed on signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: Old transactions were removed on signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: One inertial transaction occurred on signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: One inertial transaction occurred on signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: One inertial transaction occurred on signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: One inertial transaction occurred on signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: One inertial transaction occurred on signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: One inertial transaction occurred on signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: Inertial semantics check on a signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: Inertial semantics check on a signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: Inertial semantics check on a signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: Inertial semantics check on a signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: Inertial semantics check on a signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: Inertial semantics check on a signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: Inertial semantics check on a signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: Inertial semantics check on a signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: Inertial semantics check on a signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: Inertial semantics check on a signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: Inertial semantics check on a signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: Inertial semantics check on a signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: Inertial semantics check on a signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: Inertial semantics check on a signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: Inertial semantics check on a signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: Inertial semantics check on a signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: Inertial semantics check on a signal asg with slice name prefixed by an selected name on LHS failed
-- NEED RESULT: ARCH00181: Inertial semantics check on a signal asg with slice name prefixed by an selected name on LHS failed
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
--    CT00181
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
--    PKG00181
--    PKG00181/BODY
--    ENT00181(ARCH00181)
--    ENT00181_Test_Bench(ARCH00181_Test_Bench)
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
package PKG00181 is
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
end PKG00181 ;
--
package body PKG00181 is
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
end PKG00181 ;
--
use WORK.STANDARD_TYPES.all ;
use WORK.PKG00181.all ;
entity ENT00181 is
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_r_st_arr1_vector : chk_sig_type := -1 ;
   signal chk_r_st_arr2_vector : chk_sig_type := -1 ;
   signal chk_r_st_arr3_vector : chk_sig_type := -1 ;
   signal chk_r_st_rec1_vector : chk_sig_type := -1 ;
   signal chk_r_st_rec2_vector : chk_sig_type := -1 ;
   signal chk_r_st_rec3_vector : chk_sig_type := -1 ;
--
   procedure Proc1 (
      signal   s_r_st_arr1_vector : inout r_st_arr1_vector ;
      variable counter : inout integer ;
      variable correct : inout boolean ;
      variable savtime : inout time ;
      signal   chk_r_st_arr1_vector : out chk_sig_type
                   )
   is
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
            test_report ( "ARCH00181.P1" ,
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
            test_report ( "ARCH00181" ,
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
            test_report ( "ARCH00181" ,
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
            test_report ( "ARCH00181" ,
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
            test_report ( "ARCH00181" ,
              "Inertial semantics check on a signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00181" ,
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
   end Proc1 ;
--
   procedure Proc2 (
      signal   s_r_st_arr2_vector : inout r_st_arr2_vector ;
      variable counter : inout integer ;
      variable correct : inout boolean ;
      variable savtime : inout time ;
      signal   chk_r_st_arr2_vector : out chk_sig_type
                   )
   is
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
            test_report ( "ARCH00181.P2" ,
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
            test_report ( "ARCH00181" ,
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
            test_report ( "ARCH00181" ,
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
            test_report ( "ARCH00181" ,
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
            test_report ( "ARCH00181" ,
              "Inertial semantics check on a signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00181" ,
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
   end Proc2 ;
--
   procedure Proc3 (
      signal   s_r_st_arr3_vector : inout r_st_arr3_vector ;
      variable counter : inout integer ;
      variable correct : inout boolean ;
      variable savtime : inout time ;
      signal   chk_r_st_arr3_vector : out chk_sig_type
                   )
   is
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
            test_report ( "ARCH00181.P3" ,
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
            test_report ( "ARCH00181" ,
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
            test_report ( "ARCH00181" ,
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
            test_report ( "ARCH00181" ,
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
            test_report ( "ARCH00181" ,
              "Inertial semantics check on a signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00181" ,
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
   end Proc3 ;
--
   procedure Proc4 (
      signal   s_r_st_rec1_vector : inout r_st_rec1_vector ;
      variable counter : inout integer ;
      variable correct : inout boolean ;
      variable savtime : inout time ;
      signal   chk_r_st_rec1_vector : out chk_sig_type
                   )
   is
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
            test_report ( "ARCH00181.P4" ,
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
            test_report ( "ARCH00181" ,
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
            test_report ( "ARCH00181" ,
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
            test_report ( "ARCH00181" ,
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
            test_report ( "ARCH00181" ,
              "Inertial semantics check on a signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00181" ,
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
   end Proc4 ;
--
   procedure Proc5 (
      signal   s_r_st_rec2_vector : inout r_st_rec2_vector ;
      variable counter : inout integer ;
      variable correct : inout boolean ;
      variable savtime : inout time ;
      signal   chk_r_st_rec2_vector : out chk_sig_type
                   )
   is
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
            test_report ( "ARCH00181.P5" ,
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
            test_report ( "ARCH00181" ,
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
            test_report ( "ARCH00181" ,
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
            test_report ( "ARCH00181" ,
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
            test_report ( "ARCH00181" ,
              "Inertial semantics check on a signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00181" ,
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
   end Proc5 ;
--
   procedure Proc6 (
      signal   s_r_st_rec3_vector : inout r_st_rec3_vector ;
      variable counter : inout integer ;
      variable correct : inout boolean ;
      variable savtime : inout time ;
      signal   chk_r_st_rec3_vector : out chk_sig_type
                   )
   is
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
            test_report ( "ARCH00181.P6" ,
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
            test_report ( "ARCH00181" ,
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
            test_report ( "ARCH00181" ,
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
            test_report ( "ARCH00181" ,
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
            test_report ( "ARCH00181" ,
              "Inertial semantics check on a signal " &
              "asg with slice name prefixed by an selected name on LHS",
              correct ) ;
--
         when others
         =>
            test_report ( "ARCH00181" ,
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
   end Proc6 ;
--
--
end ENT00181 ;
--
architecture ARCH00181 of ENT00181 is
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
begin
   P1 :
   process
      variable counter : integer := 0 ;
      variable correct : boolean ;
      variable savtime : time ;
   begin
      Proc1 (
          s_r_st_arr1_vector,
          counter,
          correct,
          savtime,
          chk_r_st_arr1_vector
         ) ;
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
      variable counter : integer := 0 ;
      variable correct : boolean ;
      variable savtime : time ;
   begin
      Proc2 (
          s_r_st_arr2_vector,
          counter,
          correct,
          savtime,
          chk_r_st_arr2_vector
         ) ;
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
      variable counter : integer := 0 ;
      variable correct : boolean ;
      variable savtime : time ;
   begin
      Proc3 (
          s_r_st_arr3_vector,
          counter,
          correct,
          savtime,
          chk_r_st_arr3_vector
         ) ;
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
      variable counter : integer := 0 ;
      variable correct : boolean ;
      variable savtime : time ;
   begin
      Proc4 (
          s_r_st_rec1_vector,
          counter,
          correct,
          savtime,
          chk_r_st_rec1_vector
         ) ;
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
      variable counter : integer := 0 ;
      variable correct : boolean ;
      variable savtime : time ;
   begin
      Proc5 (
          s_r_st_rec2_vector,
          counter,
          correct,
          savtime,
          chk_r_st_rec2_vector
         ) ;
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
      variable counter : integer := 0 ;
      variable correct : boolean ;
      variable savtime : time ;
   begin
      Proc6 (
          s_r_st_rec3_vector,
          counter,
          correct,
          savtime,
          chk_r_st_rec3_vector
         ) ;
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
end ARCH00181 ;
--
entity ENT00181_Test_Bench is
end ENT00181_Test_Bench ;
--
architecture ARCH00181_Test_Bench of ENT00181_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.ENT00181 ( ARCH00181 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00181_Test_Bench ;
