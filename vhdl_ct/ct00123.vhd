-- NEED RESULT: ARCH00123.P1: Multi transport transactions occurred on signal asg with slice name prefixed by a selected name on LHS passed
-- NEED RESULT: ARCH00123.P2: Multi transport transactions occurred on signal asg with slice name prefixed by a selected name on LHS passed
-- NEED RESULT: ARCH00123.P3: Multi transport transactions occurred on signal asg with slice name prefixed by a selected name on LHS passed
-- NEED RESULT: ARCH00123.P4: Multi transport transactions occurred on signal asg with slice name prefixed by a selected name on LHS passed
-- NEED RESULT: ARCH00123.P5: Multi transport transactions occurred on signal asg with slice name prefixed by a selected name on LHS passed
-- NEED RESULT: ARCH00123.P6: Multi transport transactions occurred on signal asg with slice name prefixed by a selected name on LHS passed
-- NEED RESULT: ARCH00123: One transport transaction occurred on signal asg with slice name prefixed by a selected name on LHS passed
-- NEED RESULT: ARCH00123: Old transactions were removed on signal asg with slice name prefixed by a selected name on LHS passed
-- NEED RESULT: ARCH00123: One transport transaction occurred on signal asg with slice name prefixed by a selected name on LHS passed
-- NEED RESULT: ARCH00123: Old transactions were removed on signal asg with slice name prefixed by a selected name on LHS passed
-- NEED RESULT: ARCH00123: One transport transaction occurred on signal asg with slice name prefixed by a selected name on LHS passed
-- NEED RESULT: ARCH00123: Old transactions were removed on signal asg with slice name prefixed by a selected name on LHS passed
-- NEED RESULT: ARCH00123: One transport transaction occurred on signal asg with slice name prefixed by a selected name on LHS passed
-- NEED RESULT: ARCH00123: Old transactions were removed on signal asg with slice name prefixed by a selected name on LHS passed
-- NEED RESULT: ARCH00123: One transport transaction occurred on signal asg with slice name prefixed by a selected name on LHS passed
-- NEED RESULT: ARCH00123: Old transactions were removed on signal asg with slice name prefixed by a selected name on LHS passed
-- NEED RESULT: ARCH00123: One transport transaction occurred on signal asg with slice name prefixed by a selected name on LHS passed
-- NEED RESULT: ARCH00123: Old transactions were removed on signal asg with slice name prefixed by a selected name on LHS passed
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
--    CT00123
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
--    PKG00123
--    PKG00123/BODY
--    ENT00123(ARCH00123)
--    ENT00123_Test_Bench(ARCH00123_Test_Bench)
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
package PKG00123 is
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
end PKG00123 ;
--
package body PKG00123 is
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
end PKG00123 ;
--
use WORK.STANDARD_TYPES.all ;
use WORK.PKG00123.all ;
entity ENT00123 is
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
end ENT00123 ;
--
architecture ARCH00123 of ENT00123 is
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
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
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
               test_report ( "ARCH00123.P1" ,
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
               test_report ( "ARCH00123" ,
                 "One transport transaction occurred on signal " &
                 "asg with slice name prefixed by a selected name on LHS",
                 correct ) ;
               test_report ( "ARCH00123" ,
                 "Old transactions were removed on signal " &
                 "asg with slice name prefixed by a selected name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00123" ,
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
   begin
      Proc1 ;
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
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
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
               test_report ( "ARCH00123.P2" ,
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
               test_report ( "ARCH00123" ,
                 "One transport transaction occurred on signal " &
                 "asg with slice name prefixed by a selected name on LHS",
                 correct ) ;
               test_report ( "ARCH00123" ,
                 "Old transactions were removed on signal " &
                 "asg with slice name prefixed by a selected name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00123" ,
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
      end Proc1 ;
--
   begin
      Proc1 ;
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
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
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
               test_report ( "ARCH00123.P3" ,
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
               test_report ( "ARCH00123" ,
                 "One transport transaction occurred on signal " &
                 "asg with slice name prefixed by a selected name on LHS",
                 correct ) ;
               test_report ( "ARCH00123" ,
                 "Old transactions were removed on signal " &
                 "asg with slice name prefixed by a selected name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00123" ,
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
      end Proc1 ;
--
   begin
      Proc1 ;
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
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
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
               test_report ( "ARCH00123.P4" ,
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
               test_report ( "ARCH00123" ,
                 "One transport transaction occurred on signal " &
                 "asg with slice name prefixed by a selected name on LHS",
                 correct ) ;
               test_report ( "ARCH00123" ,
                 "Old transactions were removed on signal " &
                 "asg with slice name prefixed by a selected name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00123" ,
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
      end Proc1 ;
--
   begin
      Proc1 ;
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
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
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
               test_report ( "ARCH00123.P5" ,
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
               test_report ( "ARCH00123" ,
                 "One transport transaction occurred on signal " &
                 "asg with slice name prefixed by a selected name on LHS",
                 correct ) ;
               test_report ( "ARCH00123" ,
                 "Old transactions were removed on signal " &
                 "asg with slice name prefixed by a selected name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00123" ,
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
      end Proc1 ;
--
   begin
      Proc1 ;
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
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
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
               test_report ( "ARCH00123.P6" ,
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
               test_report ( "ARCH00123" ,
                 "One transport transaction occurred on signal " &
                 "asg with slice name prefixed by a selected name on LHS",
                 correct ) ;
               test_report ( "ARCH00123" ,
                 "Old transactions were removed on signal " &
                 "asg with slice name prefixed by a selected name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00123" ,
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
      end Proc1 ;
--
   begin
      Proc1 ;
   end process P6 ;
--
--
end ARCH00123 ;
--
use WORK.STANDARD_TYPES.all ;
use WORK.PKG00123.all ;
entity ENT00123_Test_Bench is
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
end ENT00123_Test_Bench ;
--
architecture ARCH00123_Test_Bench of ENT00123_Test_Bench is
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
      for CIS1 : UUT use entity WORK.ENT00123 ( ARCH00123 ) ;
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
end ARCH00123_Test_Bench ;
