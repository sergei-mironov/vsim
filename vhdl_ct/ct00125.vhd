-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00125
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
--    PKG00125
--    PKG00125/BODY
--    E00000(ARCH00125)
--    ENT00125_Test_Bench(ARCH00125_Test_Bench)
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
package PKG00125 is
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
end PKG00125 ;
--
package body PKG00125 is
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
end PKG00125 ;
--
use WORK.STANDARD_TYPES.all ;
use WORK.PKG00125.all ;
architecture ARCH00125 of E00000 is
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_r_st_rec1 : chk_sig_type := -1 ;
   signal chk_r_st_rec2 : chk_sig_type := -1 ;
   signal chk_r_st_rec3 : chk_sig_type := -1 ;
--
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
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
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
            test_report ( "ARCH00125.P1" ,
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
            test_report ( "ARCH00125" ,
              "One transport transaction occurred on signal " &
              "asg with selected name prefixed by a selected name on LHS",
              correct ) ;
            test_report ( "ARCH00125" ,
              "Old transactions were removed on signal " &
              "asg with selected name prefixed by a selected name on LHS",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00125" ,
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
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
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
            test_report ( "ARCH00125.P2" ,
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
            test_report ( "ARCH00125" ,
              "One transport transaction occurred on signal " &
              "asg with selected name prefixed by a selected name on LHS",
              correct ) ;
            test_report ( "ARCH00125" ,
              "Old transactions were removed on signal " &
              "asg with selected name prefixed by a selected name on LHS",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00125" ,
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
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
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
            test_report ( "ARCH00125.P3" ,
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
            test_report ( "ARCH00125" ,
              "One transport transaction occurred on signal " &
              "asg with selected name prefixed by a selected name on LHS",
              correct ) ;
            test_report ( "ARCH00125" ,
              "Old transactions were removed on signal " &
              "asg with selected name prefixed by a selected name on LHS",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00125" ,
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
   end process P3 ;
--
--
end ARCH00125 ;
--
entity ENT00125_Test_Bench is
end ENT00125_Test_Bench ;
--
architecture ARCH00125_Test_Bench of ENT00125_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00125 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00125_Test_Bench ;
