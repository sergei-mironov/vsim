-- NEED RESULT: ARCH00618: Concurrent proc call 1 passed
-- NEED RESULT: ARCH00618: Concurrent proc call 1 passed
-- NEED RESULT: ARCH00618: Concurrent proc call 1 passed
-- NEED RESULT: ARCH00618.P1: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00618.P2: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00618.P3: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00618: Concurrent proc call 2 passed
-- NEED RESULT: ARCH00618: Concurrent proc call 2 passed
-- NEED RESULT: ARCH00618: Concurrent proc call 2 passed
-- NEED RESULT: ARCH00618: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00618: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00618: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00618: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00618: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00618: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: P3: Transport transactions completed entirely passed
-- NEED RESULT: P2: Transport transactions completed entirely passed
-- NEED RESULT: P1: Transport transactions completed entirely passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00618
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.3 (3)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00618(ARCH00618)
--    ENT00618_Test_Bench(ARCH00618_Test_Bench)
--
-- REVISION HISTORY:
--
--    24-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
entity ENT00618 is
   port (
        s_st_rec1 : inout st_rec1
      ; s_st_rec2 : inout st_rec2
      ; s_st_rec3 : inout st_rec3
        ) ;
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_st_rec1 : chk_sig_type := -1 ;
   signal chk_st_rec2 : chk_sig_type := -1 ;
   signal chk_st_rec3 : chk_sig_type := -1 ;
--
end ENT00618 ;
--
--
architecture ARCH00618 of ENT00618 is
   subtype chk_time_type is Time ;
   signal s_st_rec1_savt : chk_time_type := 0 ns ;
   signal s_st_rec2_savt : chk_time_type := 0 ns ;
   signal s_st_rec3_savt : chk_time_type := 0 ns ;
--
   subtype chk_cnt_type is Integer ;
   signal s_st_rec1_cnt : chk_cnt_type := 0 ;
   signal s_st_rec2_cnt : chk_cnt_type := 0 ;
   signal s_st_rec3_cnt : chk_cnt_type := 0 ;
--
   type select_type is range 1 to 3 ;
   signal st_rec1_select : select_type := 1 ;
   signal st_rec2_select : select_type := 1 ;
   signal st_rec3_select : select_type := 1 ;
--
   procedure P1
      (signal s_st_rec1 : in st_rec1 ;
       signal select_sig : out Select_Type ;
       signal savtime : out Chk_Time_Type ;
       signal chk_sig : out Chk_Sig_Type ;
       signal count : out Integer)
   is
      variable correct : boolean ;
   begin
      case s_st_rec1_cnt is
         when 0
         => null ;
              -- s_st_rec1.f2 <= transport
              --   c_st_rec1_2.f2 after 10 ns,
              --   c_st_rec1_1.f2 after 20 ns ;
--
         when 1
         => correct :=
               s_st_rec1.f2 =
                 c_st_rec1_2.f2 and
               (s_st_rec1_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00618" ,
              "Concurrent proc call 1",
              correct ) ;
--
         when 2
         => correct :=
               s_st_rec1.f2 =
                 c_st_rec1_1.f2 and
               (s_st_rec1_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00618.P1" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            select_sig <= transport 2 ;
              -- s_st_rec1.f2 <= transport
              --   c_st_rec1_2.f2 after 10 ns ,
              --   c_st_rec1_1.f2 after 20 ns ,
              --   c_st_rec1_2.f2 after 30 ns ,
              --   c_st_rec1_1.f2 after 40 ns ;
--
         when 3
         => correct :=
               s_st_rec1.f2 =
                 c_st_rec1_2.f2 and
               (s_st_rec1_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00618" ,
              "Concurrent proc call 2",
              correct ) ;
            select_sig <= transport 3 ;
              -- s_st_rec1.f2 <= transport
              --   c_st_rec1_1.f2 after 5 ns ;
--
         when 4
         => correct :=
               s_st_rec1.f2 =
                 c_st_rec1_1.f2 and
               (s_st_rec1_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00618" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00618" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00618" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      savtime <= transport Std.Standard.Now ;
      chk_sig <= transport s_st_rec1_cnt
          after (1 us - Std.Standard.Now) ;
      count <= transport s_st_rec1_cnt + 1 ;
--
   end ;
--
   procedure P2
      (signal s_st_rec2 : in st_rec2 ;
       signal select_sig : out Select_Type ;
       signal savtime : out Chk_Time_Type ;
       signal chk_sig : out Chk_Sig_Type ;
       signal count : out Integer)
   is
      variable correct : boolean ;
   begin
      case s_st_rec2_cnt is
         when 0
         => null ;
              -- s_st_rec2.f2 <= transport
              --   c_st_rec2_2.f2 after 10 ns,
              --   c_st_rec2_1.f2 after 20 ns ;
--
         when 1
         => correct :=
               s_st_rec2.f2 =
                 c_st_rec2_2.f2 and
               (s_st_rec2_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00618" ,
              "Concurrent proc call 1",
              correct ) ;
--
         when 2
         => correct :=
               s_st_rec2.f2 =
                 c_st_rec2_1.f2 and
               (s_st_rec2_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00618.P2" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            select_sig <= transport 2 ;
              -- s_st_rec2.f2 <= transport
              --   c_st_rec2_2.f2 after 10 ns ,
              --   c_st_rec2_1.f2 after 20 ns ,
              --   c_st_rec2_2.f2 after 30 ns ,
              --   c_st_rec2_1.f2 after 40 ns ;
--
         when 3
         => correct :=
               s_st_rec2.f2 =
                 c_st_rec2_2.f2 and
               (s_st_rec2_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00618" ,
              "Concurrent proc call 2",
              correct ) ;
            select_sig <= transport 3 ;
              -- s_st_rec2.f2 <= transport
              --   c_st_rec2_1.f2 after 5 ns ;
--
         when 4
         => correct :=
               s_st_rec2.f2 =
                 c_st_rec2_1.f2 and
               (s_st_rec2_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00618" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00618" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00618" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      savtime <= transport Std.Standard.Now ;
      chk_sig <= transport s_st_rec2_cnt
          after (1 us - Std.Standard.Now) ;
      count <= transport s_st_rec2_cnt + 1 ;
--
   end ;
--
   procedure P3
      (signal s_st_rec3 : in st_rec3 ;
       signal select_sig : out Select_Type ;
       signal savtime : out Chk_Time_Type ;
       signal chk_sig : out Chk_Sig_Type ;
       signal count : out Integer)
   is
      variable correct : boolean ;
   begin
      case s_st_rec3_cnt is
         when 0
         => null ;
              -- s_st_rec3.f2 <= transport
              --   c_st_rec3_2.f2 after 10 ns,
              --   c_st_rec3_1.f2 after 20 ns ;
--
         when 1
         => correct :=
               s_st_rec3.f2 =
                 c_st_rec3_2.f2 and
               (s_st_rec3_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00618" ,
              "Concurrent proc call 1",
              correct ) ;
--
         when 2
         => correct :=
               s_st_rec3.f2 =
                 c_st_rec3_1.f2 and
               (s_st_rec3_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00618.P3" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            select_sig <= transport 2 ;
              -- s_st_rec3.f2 <= transport
              --   c_st_rec3_2.f2 after 10 ns ,
              --   c_st_rec3_1.f2 after 20 ns ,
              --   c_st_rec3_2.f2 after 30 ns ,
              --   c_st_rec3_1.f2 after 40 ns ;
--
         when 3
         => correct :=
               s_st_rec3.f2 =
                 c_st_rec3_2.f2 and
               (s_st_rec3_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00618" ,
              "Concurrent proc call 2",
              correct ) ;
            select_sig <= transport 3 ;
              -- s_st_rec3.f2 <= transport
              --   c_st_rec3_1.f2 after 5 ns ;
--
         when 4
         => correct :=
               s_st_rec3.f2 =
                 c_st_rec3_1.f2 and
               (s_st_rec3_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00618" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00618" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00618" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      savtime <= transport Std.Standard.Now ;
      chk_sig <= transport s_st_rec3_cnt
          after (1 us - Std.Standard.Now) ;
      count <= transport s_st_rec3_cnt + 1 ;
--
   end ;
--
begin
   CHG1 :
   P1(
       s_st_rec1 ,
       st_rec1_select ,
       s_st_rec1_savt ,
       chk_st_rec1 ,
       s_st_rec1_cnt ) ;
--
   PGEN_CHKP_1 :
   process ( chk_st_rec1 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Transport transactions completed entirely",
           chk_st_rec1 = 4 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
--
   with st_rec1_select select
      s_st_rec1.f2 <= transport
        c_st_rec1_2.f2 after 10 ns,
        c_st_rec1_1.f2 after 20 ns
        when 1,
--
        c_st_rec1_2.f2 after 10 ns ,
        c_st_rec1_1.f2 after 20 ns ,
        c_st_rec1_2.f2 after 30 ns ,
        c_st_rec1_1.f2 after 40 ns
        when 2,
--
        c_st_rec1_1.f2 after 5 ns  when 3 ;
--
   CHG2 :
   P2(
       s_st_rec2 ,
       st_rec2_select ,
       s_st_rec2_savt ,
       chk_st_rec2 ,
       s_st_rec2_cnt ) ;
--
   PGEN_CHKP_2 :
   process ( chk_st_rec2 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P2" ,
           "Transport transactions completed entirely",
           chk_st_rec2 = 4 ) ;
      end if ;
   end process PGEN_CHKP_2 ;
--
--
   with st_rec2_select select
      s_st_rec2.f2 <= transport
        c_st_rec2_2.f2 after 10 ns,
        c_st_rec2_1.f2 after 20 ns
        when 1,
--
        c_st_rec2_2.f2 after 10 ns ,
        c_st_rec2_1.f2 after 20 ns ,
        c_st_rec2_2.f2 after 30 ns ,
        c_st_rec2_1.f2 after 40 ns
        when 2,
--
        c_st_rec2_1.f2 after 5 ns  when 3 ;
--
   CHG3 :
   P3(
       s_st_rec3 ,
       st_rec3_select ,
       s_st_rec3_savt ,
       chk_st_rec3 ,
       s_st_rec3_cnt ) ;
--
   PGEN_CHKP_3 :
   process ( chk_st_rec3 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P3" ,
           "Transport transactions completed entirely",
           chk_st_rec3 = 4 ) ;
      end if ;
   end process PGEN_CHKP_3 ;
--
--
   with st_rec3_select select
      s_st_rec3.f2 <= transport
        c_st_rec3_2.f2 after 10 ns,
        c_st_rec3_1.f2 after 20 ns
        when 1,
--
        c_st_rec3_2.f2 after 10 ns ,
        c_st_rec3_1.f2 after 20 ns ,
        c_st_rec3_2.f2 after 30 ns ,
        c_st_rec3_1.f2 after 40 ns
        when 2,
--
        c_st_rec3_1.f2 after 5 ns  when 3 ;
--
end ARCH00618 ;
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00618_Test_Bench is
   signal s_st_rec1 : st_rec1
     := c_st_rec1_1 ;
   signal s_st_rec2 : st_rec2
     := c_st_rec2_1 ;
   signal s_st_rec3 : st_rec3
     := c_st_rec3_1 ;
--
end ENT00618_Test_Bench ;
--
--
architecture ARCH00618_Test_Bench of ENT00618_Test_Bench is
begin
   L1:
   block
      component UUT
         port (
              s_st_rec1 : inout st_rec1
            ; s_st_rec2 : inout st_rec2
            ; s_st_rec3 : inout st_rec3
              ) ;
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00618 ( ARCH00618 ) ;
   begin
      CIS1 : UUT
         port map (
              s_st_rec1
            , s_st_rec2
            , s_st_rec3
                  )
         ;
   end block L1 ;
end ARCH00618_Test_Bench ;
