-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00127
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
--    PKG00127
--    PKG00127/BODY
--    ENT00127(ARCH00127)
--    ENT00127_Test_Bench(ARCH00127_Test_Bench)
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
package PKG00127 is
   type r_st_rec1 is record
     f1 : integer ;
     f2 : st_rec1 ;
   end record ;
   function c_r_st_rec1_1 return r_st_rec1 ;
       -- (c_integer_1, c_st_rec1_1) ;
   function c_r_st_rec1_2 return r_st_rec1 ;
       -- (c_integer_2, c_st_rec1_2) ;
--
   type r_st_rec2 is record
     f1 : integer ;
     f2 : st_rec2 ;
   end record ;
   function c_r_st_rec2_1 return r_st_rec2 ;
       -- (c_integer_1, c_st_rec2_1) ;
   function c_r_st_rec2_2 return r_st_rec2 ;
       -- (c_integer_2, c_st_rec2_2) ;
--
   type r_st_rec3 is record
     f1 : integer ;
     f2 : st_rec3 ;
   end record ;
   function c_r_st_rec3_1 return r_st_rec3 ;
       -- (c_integer_1, c_st_rec3_1) ;
   function c_r_st_rec3_2 return r_st_rec3 ;
       -- (c_integer_2, c_st_rec3_2) ;
--
--
end PKG00127 ;
--
package body PKG00127 is
   function c_r_st_rec1_1 return r_st_rec1
   is begin
       return (c_integer_1, c_st_rec1_1) ;
   end c_r_st_rec1_1 ;
--
   function c_r_st_rec1_2 return r_st_rec1
   is begin
       return (c_integer_2, c_st_rec1_2) ;
   end c_r_st_rec1_2 ;
--
--
   function c_r_st_rec2_1 return r_st_rec2
   is begin
       return (c_integer_1, c_st_rec2_1) ;
   end c_r_st_rec2_1 ;
--
   function c_r_st_rec2_2 return r_st_rec2
   is begin
       return (c_integer_2, c_st_rec2_2) ;
   end c_r_st_rec2_2 ;
--
--
   function c_r_st_rec3_1 return r_st_rec3
   is begin
       return (c_integer_1, c_st_rec3_1) ;
   end c_r_st_rec3_1 ;
--
   function c_r_st_rec3_2 return r_st_rec3
   is begin
       return (c_integer_2, c_st_rec3_2) ;
   end c_r_st_rec3_2 ;
--
--
--
end PKG00127 ;
--
use WORK.STANDARD_TYPES.all ;
use WORK.PKG00127.all ;
entity ENT00127 is
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_r_st_rec1 : chk_sig_type := -1 ;
   signal chk_r_st_rec2 : chk_sig_type := -1 ;
   signal chk_r_st_rec3 : chk_sig_type := -1 ;
--
   procedure Proc1 (
      signal   s_r_st_rec1 : inout r_st_rec1 ;
      variable counter : inout integer ;
      variable correct : inout boolean ;
      variable savtime : inout time ;
      signal   chk_r_st_rec1 : out chk_sig_type
                   )
   is
   begin
      case counter is
         when 0
         => s_r_st_rec1.f2.f2 <= transport
               c_r_st_rec1_2.f2.f2 after 10 ns,
               c_r_st_rec1_1.f2.f2 after 20 ns ;
--
         when 1
         => correct :=
               s_r_st_rec1.f2.f2 =
                 c_r_st_rec1_2.f2.f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_r_st_rec1.f2.f2 =
                 c_r_st_rec1_1.f2.f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00127.P1" ,
              "Multi transport transactions occurred on signal " &
              "asg with selected name prefixed by a selected name on LHS",
              correct ) ;
            s_r_st_rec1.f2.f2 <= transport
               c_r_st_rec1_2.f2.f2 after 10 ns ,
               c_r_st_rec1_1.f2.f2 after 20 ns ,
               c_r_st_rec1_2.f2.f2 after 30 ns ,
               c_r_st_rec1_1.f2.f2 after 40 ns ;
--
         when 3
         => correct :=
               s_r_st_rec1.f2.f2 =
                 c_r_st_rec1_2.f2.f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_r_st_rec1.f2.f2 <= transport
               c_r_st_rec1_1.f2.f2 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_r_st_rec1.f2.f2 =
                 c_r_st_rec1_1.f2.f2 and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00127" ,
              "One transport transaction occurred on signal " &
              "asg with selected name prefixed by a selected name on LHS",
              correct ) ;
            test_report ( "ARCH00127" ,
              "Old transactions were removed on signal " &
              "asg with selected name prefixed by a selected name on LHS",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00127" ,
              "Old transactions were removed on signal " &
              "asg with selected name prefixed by a selected name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_r_st_rec1 <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end Proc1 ;
--
   procedure Proc2 (
      signal   s_r_st_rec2 : inout r_st_rec2 ;
      variable counter : inout integer ;
      variable correct : inout boolean ;
      variable savtime : inout time ;
      signal   chk_r_st_rec2 : out chk_sig_type
                   )
   is
   begin
      case counter is
         when 0
         => s_r_st_rec2.f2.f2 <= transport
               c_r_st_rec2_2.f2.f2 after 10 ns,
               c_r_st_rec2_1.f2.f2 after 20 ns ;
--
         when 1
         => correct :=
               s_r_st_rec2.f2.f2 =
                 c_r_st_rec2_2.f2.f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_r_st_rec2.f2.f2 =
                 c_r_st_rec2_1.f2.f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00127.P2" ,
              "Multi transport transactions occurred on signal " &
              "asg with selected name prefixed by a selected name on LHS",
              correct ) ;
            s_r_st_rec2.f2.f2 <= transport
               c_r_st_rec2_2.f2.f2 after 10 ns ,
               c_r_st_rec2_1.f2.f2 after 20 ns ,
               c_r_st_rec2_2.f2.f2 after 30 ns ,
               c_r_st_rec2_1.f2.f2 after 40 ns ;
--
         when 3
         => correct :=
               s_r_st_rec2.f2.f2 =
                 c_r_st_rec2_2.f2.f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_r_st_rec2.f2.f2 <= transport
               c_r_st_rec2_1.f2.f2 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_r_st_rec2.f2.f2 =
                 c_r_st_rec2_1.f2.f2 and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00127" ,
              "One transport transaction occurred on signal " &
              "asg with selected name prefixed by a selected name on LHS",
              correct ) ;
            test_report ( "ARCH00127" ,
              "Old transactions were removed on signal " &
              "asg with selected name prefixed by a selected name on LHS",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00127" ,
              "Old transactions were removed on signal " &
              "asg with selected name prefixed by a selected name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_r_st_rec2 <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end Proc2 ;
--
   procedure Proc3 (
      signal   s_r_st_rec3 : inout r_st_rec3 ;
      variable counter : inout integer ;
      variable correct : inout boolean ;
      variable savtime : inout time ;
      signal   chk_r_st_rec3 : out chk_sig_type
                   )
   is
   begin
      case counter is
         when 0
         => s_r_st_rec3.f2.f2 <= transport
               c_r_st_rec3_2.f2.f2 after 10 ns,
               c_r_st_rec3_1.f2.f2 after 20 ns ;
--
         when 1
         => correct :=
               s_r_st_rec3.f2.f2 =
                 c_r_st_rec3_2.f2.f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_r_st_rec3.f2.f2 =
                 c_r_st_rec3_1.f2.f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00127.P3" ,
              "Multi transport transactions occurred on signal " &
              "asg with selected name prefixed by a selected name on LHS",
              correct ) ;
            s_r_st_rec3.f2.f2 <= transport
               c_r_st_rec3_2.f2.f2 after 10 ns ,
               c_r_st_rec3_1.f2.f2 after 20 ns ,
               c_r_st_rec3_2.f2.f2 after 30 ns ,
               c_r_st_rec3_1.f2.f2 after 40 ns ;
--
         when 3
         => correct :=
               s_r_st_rec3.f2.f2 =
                 c_r_st_rec3_2.f2.f2 and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_r_st_rec3.f2.f2 <= transport
               c_r_st_rec3_1.f2.f2 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_r_st_rec3.f2.f2 =
                 c_r_st_rec3_1.f2.f2 and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00127" ,
              "One transport transaction occurred on signal " &
              "asg with selected name prefixed by a selected name on LHS",
              correct ) ;
            test_report ( "ARCH00127" ,
              "Old transactions were removed on signal " &
              "asg with selected name prefixed by a selected name on LHS",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00127" ,
              "Old transactions were removed on signal " &
              "asg with selected name prefixed by a selected name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_r_st_rec3 <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end Proc3 ;
--
--
end ENT00127 ;
--
architecture ARCH00127 of ENT00127 is
   signal s_r_st_rec1 : r_st_rec1
     := c_r_st_rec1_1 ;
   signal s_r_st_rec2 : r_st_rec2
     := c_r_st_rec2_1 ;
   signal s_r_st_rec3 : r_st_rec3
     := c_r_st_rec3_1 ;
--
begin
   PGEN_CHKP_1 :
   process ( chk_r_st_rec1 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Transport transactions entirely completed",
           chk_r_st_rec1 = 4 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
   P1 :
   process ( s_r_st_rec1 )
      variable counter : integer := 0 ;
      variable correct : boolean ;
      variable savtime : time ;
   begin
      Proc1 (
          s_r_st_rec1,
          counter,
          correct,
          savtime,
          chk_r_st_rec1
         ) ;
   end process P1 ;
--
   PGEN_CHKP_2 :
   process ( chk_r_st_rec2 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P2" ,
           "Transport transactions entirely completed",
           chk_r_st_rec2 = 4 ) ;
      end if ;
   end process PGEN_CHKP_2 ;
--
   P2 :
   process ( s_r_st_rec2 )
      variable counter : integer := 0 ;
      variable correct : boolean ;
      variable savtime : time ;
   begin
      Proc2 (
          s_r_st_rec2,
          counter,
          correct,
          savtime,
          chk_r_st_rec2
         ) ;
   end process P2 ;
--
   PGEN_CHKP_3 :
   process ( chk_r_st_rec3 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P3" ,
           "Transport transactions entirely completed",
           chk_r_st_rec3 = 4 ) ;
      end if ;
   end process PGEN_CHKP_3 ;
--
   P3 :
   process ( s_r_st_rec3 )
      variable counter : integer := 0 ;
      variable correct : boolean ;
      variable savtime : time ;
   begin
      Proc3 (
          s_r_st_rec3,
          counter,
          correct,
          savtime,
          chk_r_st_rec3
         ) ;
   end process P3 ;
--
--
end ARCH00127 ;
--
entity ENT00127_Test_Bench is
end ENT00127_Test_Bench ;
--
architecture ARCH00127_Test_Bench of ENT00127_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.ENT00127 ( ARCH00127 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00127_Test_Bench ;
