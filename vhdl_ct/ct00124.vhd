-- NEED RESULT: ARCH00124.P1: Multi transport transactions occurred on signal asg with slice name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00124.P2: Multi transport transactions occurred on signal asg with slice name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00124.P3: Multi transport transactions occurred on signal asg with slice name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00124.P4: Multi transport transactions occurred on signal asg with slice name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00124.P5: Multi transport transactions occurred on signal asg with slice name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00124.P6: Multi transport transactions occurred on signal asg with slice name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00124: One transport transaction occurred on signal asg with slice name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00124: Old transactions were removed on signal asg with slice name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00124: One transport transaction occurred on signal asg with slice name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00124: Old transactions were removed on signal asg with slice name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00124: One transport transaction occurred on signal asg with slice name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00124: Old transactions were removed on signal asg with slice name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00124: One transport transaction occurred on signal asg with slice name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00124: Old transactions were removed on signal asg with slice name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00124: One transport transaction occurred on signal asg with slice name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00124: Old transactions were removed on signal asg with slice name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00124: One transport transaction occurred on signal asg with slice name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00124: Old transactions were removed on signal asg with slice name prefixed by a selected name on LHS failed
-- NEED RESULT: P6: Transport transactions entirely completed passed
-- NEED RESULT: P5: Transport transactions entirely completed passed
-- NEED RESULT: P4: Transport transactions entirely completed passed
-- NEED RESULT: P3: Transport transactions entirely completed passed
-- NEED RESULT: P2: Transport transactions entirely completed passed
-- NEED RESULT: P1: Transport transactions entirely completed passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00124
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.3 (2)
--    8.3 (3)
--    8.3 (5)
--    8.3.1 (3)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00124
--    PKG00124/BODY
--    ENT00124(ARCH00124)
--    ENT00124_Test_Bench(ARCH00124_Test_Bench)
--
-- REVISION HISTORY:
--
--    07-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
package PKG00124 is
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
end PKG00124 ;
--
package body PKG00124 is
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
end PKG00124 ;
--
use WORK.STANDARD_TYPES.all ;
use WORK.PKG00124.all ;
entity ENT00124 is
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
         => s_r_st_arr1_vector.f2 (lowb+1 to highb-1) <= transport
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
            test_report ( "ARCH00124.P1" ,
              "Multi transport transactions occurred on signal " &
              "asg with slice name prefixed by a selected name on LHS",
              correct ) ;
            s_r_st_arr1_vector.f2 (lowb+1 to highb-1) <= transport
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
            s_r_st_arr1_vector.f2 (lowb+1 to highb-1) <= transport
               c_r_st_arr1_vector_1.f2
                 (lowb+1 to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_r_st_arr1_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr1_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00124" ,
              "One transport transaction occurred on signal " &
              "asg with slice name prefixed by a selected name on LHS",
              correct ) ;
            test_report ( "ARCH00124" ,
              "Old transactions were removed on signal " &
              "asg with slice name prefixed by a selected name on LHS",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00124" ,
              "Old transactions were removed on signal " &
              "asg with slice name prefixed by a selected name on LHS",
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
         => s_r_st_arr2_vector.f2 (lowb+1 to highb-1) <= transport
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
            test_report ( "ARCH00124.P2" ,
              "Multi transport transactions occurred on signal " &
              "asg with slice name prefixed by a selected name on LHS",
              correct ) ;
            s_r_st_arr2_vector.f2 (lowb+1 to highb-1) <= transport
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
            s_r_st_arr2_vector.f2 (lowb+1 to highb-1) <= transport
               c_r_st_arr2_vector_1.f2
                 (lowb+1 to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_r_st_arr2_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr2_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00124" ,
              "One transport transaction occurred on signal " &
              "asg with slice name prefixed by a selected name on LHS",
              correct ) ;
            test_report ( "ARCH00124" ,
              "Old transactions were removed on signal " &
              "asg with slice name prefixed by a selected name on LHS",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00124" ,
              "Old transactions were removed on signal " &
              "asg with slice name prefixed by a selected name on LHS",
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
         => s_r_st_arr3_vector.f2 (lowb+1 to highb-1) <= transport
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
            test_report ( "ARCH00124.P3" ,
              "Multi transport transactions occurred on signal " &
              "asg with slice name prefixed by a selected name on LHS",
              correct ) ;
            s_r_st_arr3_vector.f2 (lowb+1 to highb-1) <= transport
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
            s_r_st_arr3_vector.f2 (lowb+1 to highb-1) <= transport
               c_r_st_arr3_vector_1.f2
                 (lowb+1 to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_r_st_arr3_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_arr3_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00124" ,
              "One transport transaction occurred on signal " &
              "asg with slice name prefixed by a selected name on LHS",
              correct ) ;
            test_report ( "ARCH00124" ,
              "Old transactions were removed on signal " &
              "asg with slice name prefixed by a selected name on LHS",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00124" ,
              "Old transactions were removed on signal " &
              "asg with slice name prefixed by a selected name on LHS",
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
         => s_r_st_rec1_vector.f2 (lowb+1 to highb-1) <= transport
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
            test_report ( "ARCH00124.P4" ,
              "Multi transport transactions occurred on signal " &
              "asg with slice name prefixed by a selected name on LHS",
              correct ) ;
            s_r_st_rec1_vector.f2 (lowb+1 to highb-1) <= transport
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
            s_r_st_rec1_vector.f2 (lowb+1 to highb-1) <= transport
               c_r_st_rec1_vector_1.f2
                 (lowb+1 to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_r_st_rec1_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec1_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00124" ,
              "One transport transaction occurred on signal " &
              "asg with slice name prefixed by a selected name on LHS",
              correct ) ;
            test_report ( "ARCH00124" ,
              "Old transactions were removed on signal " &
              "asg with slice name prefixed by a selected name on LHS",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00124" ,
              "Old transactions were removed on signal " &
              "asg with slice name prefixed by a selected name on LHS",
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
         => s_r_st_rec2_vector.f2 (lowb+1 to highb-1) <= transport
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
            test_report ( "ARCH00124.P5" ,
              "Multi transport transactions occurred on signal " &
              "asg with slice name prefixed by a selected name on LHS",
              correct ) ;
            s_r_st_rec2_vector.f2 (lowb+1 to highb-1) <= transport
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
            s_r_st_rec2_vector.f2 (lowb+1 to highb-1) <= transport
               c_r_st_rec2_vector_1.f2
                 (lowb+1 to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_r_st_rec2_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec2_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00124" ,
              "One transport transaction occurred on signal " &
              "asg with slice name prefixed by a selected name on LHS",
              correct ) ;
            test_report ( "ARCH00124" ,
              "Old transactions were removed on signal " &
              "asg with slice name prefixed by a selected name on LHS",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00124" ,
              "Old transactions were removed on signal " &
              "asg with slice name prefixed by a selected name on LHS",
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
         => s_r_st_rec3_vector.f2 (lowb+1 to highb-1) <= transport
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
            test_report ( "ARCH00124.P6" ,
              "Multi transport transactions occurred on signal " &
              "asg with slice name prefixed by a selected name on LHS",
              correct ) ;
            s_r_st_rec3_vector.f2 (lowb+1 to highb-1) <= transport
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
            s_r_st_rec3_vector.f2 (lowb+1 to highb-1) <= transport
               c_r_st_rec3_vector_1.f2
                 (lowb+1 to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_r_st_rec3_vector.f2 (lowb+1 to highb-1) =
                 c_r_st_rec3_vector_1.f2 (lowb+1 to highb-1) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00124" ,
              "One transport transaction occurred on signal " &
              "asg with slice name prefixed by a selected name on LHS",
              correct ) ;
            test_report ( "ARCH00124" ,
              "Old transactions were removed on signal " &
              "asg with slice name prefixed by a selected name on LHS",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00124" ,
              "Old transactions were removed on signal " &
              "asg with slice name prefixed by a selected name on LHS",
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
end ENT00124 ;
--
architecture ARCH00124 of ENT00124 is
begin
   PGEN_CHKP_1 :
   process ( chk_r_st_arr1_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Transport transactions entirely completed",
           chk_r_st_arr1_vector = 4 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
   P1 :
   process ( s_r_st_arr1_vector )
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
   end process P1 ;
--
   PGEN_CHKP_2 :
   process ( chk_r_st_arr2_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P2" ,
           "Transport transactions entirely completed",
           chk_r_st_arr2_vector = 4 ) ;
      end if ;
   end process PGEN_CHKP_2 ;
--
   P2 :
   process ( s_r_st_arr2_vector )
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
   end process P2 ;
--
   PGEN_CHKP_3 :
   process ( chk_r_st_arr3_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P3" ,
           "Transport transactions entirely completed",
           chk_r_st_arr3_vector = 4 ) ;
      end if ;
   end process PGEN_CHKP_3 ;
--
   P3 :
   process ( s_r_st_arr3_vector )
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
   end process P3 ;
--
   PGEN_CHKP_4 :
   process ( chk_r_st_rec1_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P4" ,
           "Transport transactions entirely completed",
           chk_r_st_rec1_vector = 4 ) ;
      end if ;
   end process PGEN_CHKP_4 ;
--
   P4 :
   process ( s_r_st_rec1_vector )
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
   end process P4 ;
--
   PGEN_CHKP_5 :
   process ( chk_r_st_rec2_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P5" ,
           "Transport transactions entirely completed",
           chk_r_st_rec2_vector = 4 ) ;
      end if ;
   end process PGEN_CHKP_5 ;
--
   P5 :
   process ( s_r_st_rec2_vector )
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
   end process P5 ;
--
   PGEN_CHKP_6 :
   process ( chk_r_st_rec3_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P6" ,
           "Transport transactions entirely completed",
           chk_r_st_rec3_vector = 4 ) ;
      end if ;
   end process PGEN_CHKP_6 ;
--
   P6 :
   process ( s_r_st_rec3_vector )
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
   end process P6 ;
--
--
end ARCH00124 ;
--
use WORK.STANDARD_TYPES.all ;
use WORK.PKG00124.all ;
entity ENT00124_Test_Bench is
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
end ENT00124_Test_Bench ;
--
architecture ARCH00124_Test_Bench of ENT00124_Test_Bench is
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
      for CIS1 : UUT use entity WORK.ENT00124 ( ARCH00124 ) ;
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
end ARCH00124_Test_Bench ;
