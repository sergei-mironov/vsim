-- NEED RESULT: ARCH00634.P1: Multi transport transactions occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634.P2: Multi transport transactions occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634.P3: Multi transport transactions occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634.P4: Multi transport transactions occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634.P5: Multi transport transactions occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634.P6: Multi transport transactions occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634.P7: Multi transport transactions occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634.P8: Multi transport transactions occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634.P9: Multi transport transactions occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634.P10: Multi transport transactions occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634.P11: Multi transport transactions occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634.P12: Multi transport transactions occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634.P13: Multi transport transactions occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634.P14: Multi transport transactions occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634.P15: Multi transport transactions occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634.P16: Multi transport transactions occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634.P17: Multi transport transactions occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: One transport transaction occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: Old transactions were removed on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: One transport transaction occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: Old transactions were removed on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: One transport transaction occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: Old transactions were removed on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: One transport transaction occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: Old transactions were removed on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: One transport transaction occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: Old transactions were removed on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: One transport transaction occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: Old transactions were removed on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: One transport transaction occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: Old transactions were removed on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: One transport transaction occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: Old transactions were removed on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: One transport transaction occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: Old transactions were removed on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: One transport transaction occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: Old transactions were removed on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: One transport transaction occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: Old transactions were removed on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: One transport transaction occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: Old transactions were removed on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: One transport transaction occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: Old transactions were removed on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: One transport transaction occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: Old transactions were removed on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: One transport transaction occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: Old transactions were removed on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: One transport transaction occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: Old transactions were removed on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: One transport transaction occurred on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: ARCH00634: Old transactions were removed on signal asg with aggregate of simple names on LHS passed
-- NEED RESULT: P17: Transport transactions entirely completed passed
-- NEED RESULT: P16: Transport transactions entirely completed passed
-- NEED RESULT: P15: Transport transactions entirely completed passed
-- NEED RESULT: P14: Transport transactions entirely completed passed
-- NEED RESULT: P13: Transport transactions entirely completed passed
-- NEED RESULT: P12: Transport transactions entirely completed passed
-- NEED RESULT: P11: Transport transactions entirely completed passed
-- NEED RESULT: P10: Transport transactions entirely completed passed
-- NEED RESULT: P9: Transport transactions entirely completed passed
-- NEED RESULT: P8: Transport transactions entirely completed passed
-- NEED RESULT: P7: Transport transactions entirely completed passed
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
--    CT00634
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.3 (2)
--    8.3 (3)
--    8.3 (6)
--    8.3.1 (3)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00634)
--    ENT00634_Test_Bench(ARCH00634_Test_Bench)
--
-- REVISION HISTORY:
--
--    25-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00634 of E00000 is
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_boolean : chk_sig_type := -1 ;
   signal chk_bit : chk_sig_type := -1 ;
   signal chk_severity_level : chk_sig_type := -1 ;
   signal chk_character : chk_sig_type := -1 ;
   signal chk_st_enum1 : chk_sig_type := -1 ;
   signal chk_integer : chk_sig_type := -1 ;
   signal chk_st_int1 : chk_sig_type := -1 ;
   signal chk_time : chk_sig_type := -1 ;
   signal chk_st_phys1 : chk_sig_type := -1 ;
   signal chk_real : chk_sig_type := -1 ;
   signal chk_st_real1 : chk_sig_type := -1 ;
   signal chk_st_rec1 : chk_sig_type := -1 ;
   signal chk_st_rec2 : chk_sig_type := -1 ;
   signal chk_st_rec3 : chk_sig_type := -1 ;
   signal chk_st_arr1 : chk_sig_type := -1 ;
   signal chk_st_arr2 : chk_sig_type := -1 ;
   signal chk_st_arr3 : chk_sig_type := -1 ;
--
   type arr_boolean is
     array (integer range -1 downto - 3 ) of
       boolean ;
   type arr_bit is
     array (integer range -1 downto - 3 ) of
       bit ;
   type arr_severity_level is
     array (integer range -1 downto - 3 ) of
       severity_level ;
   type arr_character is
     array (integer range -1 downto - 3 ) of
       character ;
   type arr_st_enum1 is
     array (integer range -1 downto - 3 ) of
       st_enum1 ;
   type arr_integer is
     array (integer range -1 downto - 3 ) of
       integer ;
   type arr_st_int1 is
     array (integer range -1 downto - 3 ) of
       st_int1 ;
   type arr_time is
     array (integer range -1 downto - 3 ) of
       time ;
   type arr_st_phys1 is
     array (integer range -1 downto - 3 ) of
       st_phys1 ;
   type arr_real is
     array (integer range -1 downto - 3 ) of
       real ;
   type arr_st_real1 is
     array (integer range -1 downto - 3 ) of
       st_real1 ;
   type arr_st_rec1 is
     array (integer range -1 downto - 3 ) of
       st_rec1 ;
   type arr_st_rec2 is
     array (integer range -1 downto - 3 ) of
       st_rec2 ;
   type arr_st_rec3 is
     array (integer range -1 downto - 3 ) of
       st_rec3 ;
   type arr_st_arr1 is
     array (integer range -1 downto - 3 ) of
       st_arr1 ;
   type arr_st_arr2 is
     array (integer range -1 downto - 3 ) of
       st_arr2 ;
   type arr_st_arr3 is
     array (integer range -1 downto - 3 ) of
       st_arr3 ;
--
   signal s_boolean_1 : boolean
     := c_boolean_1 ;
   signal s_bit_1 : bit
     := c_bit_1 ;
   signal s_severity_level_1 : severity_level
     := c_severity_level_1 ;
   signal s_character_1 : character
     := c_character_1 ;
   signal s_st_enum1_1 : st_enum1
     := c_st_enum1_1 ;
   signal s_integer_1 : integer
     := c_integer_1 ;
   signal s_st_int1_1 : st_int1
     := c_st_int1_1 ;
   signal s_time_1 : time
     := c_time_1 ;
   signal s_st_phys1_1 : st_phys1
     := c_st_phys1_1 ;
   signal s_real_1 : real
     := c_real_1 ;
   signal s_st_real1_1 : st_real1
     := c_st_real1_1 ;
   signal s_st_rec1_1 : st_rec1
     := c_st_rec1_1 ;
   signal s_st_rec2_1 : st_rec2
     := c_st_rec2_1 ;
   signal s_st_rec3_1 : st_rec3
     := c_st_rec3_1 ;
   signal s_st_arr1_1 : st_arr1
     := c_st_arr1_1 ;
   signal s_st_arr2_1 : st_arr2
     := c_st_arr2_1 ;
   signal s_st_arr3_1 : st_arr3
     := c_st_arr3_1 ;
--
   signal s_boolean_2 : boolean
     := c_boolean_1 ;
   signal s_bit_2 : bit
     := c_bit_1 ;
   signal s_severity_level_2 : severity_level
     := c_severity_level_1 ;
   signal s_character_2 : character
     := c_character_1 ;
   signal s_st_enum1_2 : st_enum1
     := c_st_enum1_1 ;
   signal s_integer_2 : integer
     := c_integer_1 ;
   signal s_st_int1_2 : st_int1
     := c_st_int1_1 ;
   signal s_time_2 : time
     := c_time_1 ;
   signal s_st_phys1_2 : st_phys1
     := c_st_phys1_1 ;
   signal s_real_2 : real
     := c_real_1 ;
   signal s_st_real1_2 : st_real1
     := c_st_real1_1 ;
   signal s_st_rec1_2 : st_rec1
     := c_st_rec1_1 ;
   signal s_st_rec2_2 : st_rec2
     := c_st_rec2_1 ;
   signal s_st_rec3_2 : st_rec3
     := c_st_rec3_1 ;
   signal s_st_arr1_2 : st_arr1
     := c_st_arr1_1 ;
   signal s_st_arr2_2 : st_arr2
     := c_st_arr2_1 ;
   signal s_st_arr3_2 : st_arr3
     := c_st_arr3_1 ;
--
   signal s_boolean_3 : boolean
     := c_boolean_1 ;
   signal s_bit_3 : bit
     := c_bit_1 ;
   signal s_severity_level_3 : severity_level
     := c_severity_level_1 ;
   signal s_character_3 : character
     := c_character_1 ;
   signal s_st_enum1_3 : st_enum1
     := c_st_enum1_1 ;
   signal s_integer_3 : integer
     := c_integer_1 ;
   signal s_st_int1_3 : st_int1
     := c_st_int1_1 ;
   signal s_time_3 : time
     := c_time_1 ;
   signal s_st_phys1_3 : st_phys1
     := c_st_phys1_1 ;
   signal s_real_3 : real
     := c_real_1 ;
   signal s_st_real1_3 : st_real1
     := c_st_real1_1 ;
   signal s_st_rec1_3 : st_rec1
     := c_st_rec1_1 ;
   signal s_st_rec2_3 : st_rec2
     := c_st_rec2_1 ;
   signal s_st_rec3_3 : st_rec3
     := c_st_rec3_1 ;
   signal s_st_arr1_3 : st_arr1
     := c_st_arr1_1 ;
   signal s_st_arr2_3 : st_arr2
     := c_st_arr2_1 ;
   signal s_st_arr3_3 : st_arr3
     := c_st_arr3_1 ;
--
begin
   PGEN_CHKP_1 :
   process ( chk_boolean )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Transport transactions entirely completed",
           chk_boolean = 4 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
   P1 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => (s_boolean_1,
                s_boolean_2,
                s_boolean_3) <= transport
                  arr_boolean ' (
                  (c_boolean_2,
                   c_boolean_2,
                   c_boolean_2) ) after 10 ns,
                  arr_boolean ' (
                  (c_boolean_1,
                   c_boolean_1,
                   c_boolean_1) ) after 20 ns ;
--
            when 1
            => correct :=
                  s_boolean_1 = c_boolean_2 and
                  s_boolean_2 = c_boolean_2 and
                  s_boolean_3 = c_boolean_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_boolean_1 = c_boolean_1 and
                  s_boolean_2 = c_boolean_1 and
                  s_boolean_3 = c_boolean_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634.P1" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               (s_boolean_1,
                s_boolean_2,
                s_boolean_3) <= transport
               arr_boolean ' (
                  (c_boolean_2,
                   c_boolean_2,
                   c_boolean_2) ) after 10 ns,
               arr_boolean ' (
                  (c_boolean_1,
                   c_boolean_1,
                   c_boolean_1) ) after 20 ns,
               arr_boolean ' (
                  (c_boolean_2,
                   c_boolean_2,
                   c_boolean_2) ) after 30 ns,
               arr_boolean ' (
                  (c_boolean_1,
                   c_boolean_1,
                   c_boolean_1) ) after 40 ns ;
--
            when 3
            => correct :=
                  s_boolean_1 = c_boolean_2 and
                  s_boolean_2 = c_boolean_2 and
                  s_boolean_3 = c_boolean_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               (s_boolean_1,
                s_boolean_2,
                s_boolean_3) <= transport
               arr_boolean ' (
                 (c_boolean_1,
                  c_boolean_1,
                  c_boolean_1) ) after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_boolean_1 = c_boolean_1 and
                  s_boolean_2 = c_boolean_1 and
                  s_boolean_3 = c_boolean_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634" ,
                 "One transport transaction occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 false ) ;
--
         end case ;
--
         savtime := Std.Standard.Now ;
         chk_boolean <= transport counter after (1 us - savtime) ;
         counter := counter + 1;
--
      end Proc1 ;
--
   begin
      Proc1 ;
      wait until s_boolean_1'EVENT and
                 s_boolean_2'EVENT and
                 s_boolean_3'EVENT ;
   end process P1 ;
--
   PGEN_CHKP_2 :
   process ( chk_bit )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P2" ,
           "Transport transactions entirely completed",
           chk_bit = 4 ) ;
      end if ;
   end process PGEN_CHKP_2 ;
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
            when 0
            => (s_bit_1,
                s_bit_2,
                s_bit_3) <= transport
                  arr_bit ' (
                  (c_bit_2,
                   c_bit_2,
                   c_bit_2) ) after 10 ns,
                  arr_bit ' (
                  (c_bit_1,
                   c_bit_1,
                   c_bit_1) ) after 20 ns ;
--
            when 1
            => correct :=
                  s_bit_1 = c_bit_2 and
                  s_bit_2 = c_bit_2 and
                  s_bit_3 = c_bit_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_bit_1 = c_bit_1 and
                  s_bit_2 = c_bit_1 and
                  s_bit_3 = c_bit_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634.P2" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               (s_bit_1,
                s_bit_2,
                s_bit_3) <= transport
               arr_bit ' (
                  (c_bit_2,
                   c_bit_2,
                   c_bit_2) ) after 10 ns,
               arr_bit ' (
                  (c_bit_1,
                   c_bit_1,
                   c_bit_1) ) after 20 ns,
               arr_bit ' (
                  (c_bit_2,
                   c_bit_2,
                   c_bit_2) ) after 30 ns,
               arr_bit ' (
                  (c_bit_1,
                   c_bit_1,
                   c_bit_1) ) after 40 ns ;
--
            when 3
            => correct :=
                  s_bit_1 = c_bit_2 and
                  s_bit_2 = c_bit_2 and
                  s_bit_3 = c_bit_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               (s_bit_1,
                s_bit_2,
                s_bit_3) <= transport
               arr_bit ' (
                 (c_bit_1,
                  c_bit_1,
                  c_bit_1) ) after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_bit_1 = c_bit_1 and
                  s_bit_2 = c_bit_1 and
                  s_bit_3 = c_bit_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634" ,
                 "One transport transaction occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 false ) ;
--
         end case ;
--
         savtime := Std.Standard.Now ;
         chk_bit <= transport counter after (1 us - savtime) ;
         counter := counter + 1;
--
      end Proc1 ;
--
   begin
      Proc1 ;
      wait until s_bit_1'EVENT and
                 s_bit_2'EVENT and
                 s_bit_3'EVENT ;
   end process P2 ;
--
   PGEN_CHKP_3 :
   process ( chk_severity_level )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P3" ,
           "Transport transactions entirely completed",
           chk_severity_level = 4 ) ;
      end if ;
   end process PGEN_CHKP_3 ;
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
            when 0
            => (s_severity_level_1,
                s_severity_level_2,
                s_severity_level_3) <= transport
                  arr_severity_level ' (
                  (c_severity_level_2,
                   c_severity_level_2,
                   c_severity_level_2) ) after 10 ns,
                  arr_severity_level ' (
                  (c_severity_level_1,
                   c_severity_level_1,
                   c_severity_level_1) ) after 20 ns ;
--
            when 1
            => correct :=
                  s_severity_level_1 = c_severity_level_2 and
                  s_severity_level_2 = c_severity_level_2 and
                  s_severity_level_3 = c_severity_level_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_severity_level_1 = c_severity_level_1 and
                  s_severity_level_2 = c_severity_level_1 and
                  s_severity_level_3 = c_severity_level_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634.P3" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               (s_severity_level_1,
                s_severity_level_2,
                s_severity_level_3) <= transport
               arr_severity_level ' (
                  (c_severity_level_2,
                   c_severity_level_2,
                   c_severity_level_2) ) after 10 ns,
               arr_severity_level ' (
                  (c_severity_level_1,
                   c_severity_level_1,
                   c_severity_level_1) ) after 20 ns,
               arr_severity_level ' (
                  (c_severity_level_2,
                   c_severity_level_2,
                   c_severity_level_2) ) after 30 ns,
               arr_severity_level ' (
                  (c_severity_level_1,
                   c_severity_level_1,
                   c_severity_level_1) ) after 40 ns ;
--
            when 3
            => correct :=
                  s_severity_level_1 = c_severity_level_2 and
                  s_severity_level_2 = c_severity_level_2 and
                  s_severity_level_3 = c_severity_level_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               (s_severity_level_1,
                s_severity_level_2,
                s_severity_level_3) <= transport
               arr_severity_level ' (
                 (c_severity_level_1,
                  c_severity_level_1,
                  c_severity_level_1) ) after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_severity_level_1 = c_severity_level_1 and
                  s_severity_level_2 = c_severity_level_1 and
                  s_severity_level_3 = c_severity_level_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634" ,
                 "One transport transaction occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 false ) ;
--
         end case ;
--
         savtime := Std.Standard.Now ;
         chk_severity_level <= transport counter after (1 us - savtime) ;
         counter := counter + 1;
--
      end Proc1 ;
--
   begin
      Proc1 ;
      wait until s_severity_level_1'EVENT and
                 s_severity_level_2'EVENT and
                 s_severity_level_3'EVENT ;
   end process P3 ;
--
   PGEN_CHKP_4 :
   process ( chk_character )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P4" ,
           "Transport transactions entirely completed",
           chk_character = 4 ) ;
      end if ;
   end process PGEN_CHKP_4 ;
--
   P4 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => (s_character_1,
                s_character_2,
                s_character_3) <= transport
                  arr_character ' (
                  (c_character_2,
                   c_character_2,
                   c_character_2) ) after 10 ns,
                  arr_character ' (
                  (c_character_1,
                   c_character_1,
                   c_character_1) ) after 20 ns ;
--
            when 1
            => correct :=
                  s_character_1 = c_character_2 and
                  s_character_2 = c_character_2 and
                  s_character_3 = c_character_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_character_1 = c_character_1 and
                  s_character_2 = c_character_1 and
                  s_character_3 = c_character_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634.P4" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               (s_character_1,
                s_character_2,
                s_character_3) <= transport
               arr_character ' (
                  (c_character_2,
                   c_character_2,
                   c_character_2) ) after 10 ns,
               arr_character ' (
                  (c_character_1,
                   c_character_1,
                   c_character_1) ) after 20 ns,
               arr_character ' (
                  (c_character_2,
                   c_character_2,
                   c_character_2) ) after 30 ns,
               arr_character ' (
                  (c_character_1,
                   c_character_1,
                   c_character_1) ) after 40 ns ;
--
            when 3
            => correct :=
                  s_character_1 = c_character_2 and
                  s_character_2 = c_character_2 and
                  s_character_3 = c_character_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               (s_character_1,
                s_character_2,
                s_character_3) <= transport
               arr_character ' (
                 (c_character_1,
                  c_character_1,
                  c_character_1) ) after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_character_1 = c_character_1 and
                  s_character_2 = c_character_1 and
                  s_character_3 = c_character_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634" ,
                 "One transport transaction occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 false ) ;
--
         end case ;
--
         savtime := Std.Standard.Now ;
         chk_character <= transport counter after (1 us - savtime) ;
         counter := counter + 1;
--
      end Proc1 ;
--
   begin
      Proc1 ;
      wait until s_character_1'EVENT and
                 s_character_2'EVENT and
                 s_character_3'EVENT ;
   end process P4 ;
--
   PGEN_CHKP_5 :
   process ( chk_st_enum1 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P5" ,
           "Transport transactions entirely completed",
           chk_st_enum1 = 4 ) ;
      end if ;
   end process PGEN_CHKP_5 ;
--
   P5 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => (s_st_enum1_1,
                s_st_enum1_2,
                s_st_enum1_3) <= transport
                  arr_st_enum1 ' (
                  (c_st_enum1_2,
                   c_st_enum1_2,
                   c_st_enum1_2) ) after 10 ns,
                  arr_st_enum1 ' (
                  (c_st_enum1_1,
                   c_st_enum1_1,
                   c_st_enum1_1) ) after 20 ns ;
--
            when 1
            => correct :=
                  s_st_enum1_1 = c_st_enum1_2 and
                  s_st_enum1_2 = c_st_enum1_2 and
                  s_st_enum1_3 = c_st_enum1_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_st_enum1_1 = c_st_enum1_1 and
                  s_st_enum1_2 = c_st_enum1_1 and
                  s_st_enum1_3 = c_st_enum1_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634.P5" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               (s_st_enum1_1,
                s_st_enum1_2,
                s_st_enum1_3) <= transport
               arr_st_enum1 ' (
                  (c_st_enum1_2,
                   c_st_enum1_2,
                   c_st_enum1_2) ) after 10 ns,
               arr_st_enum1 ' (
                  (c_st_enum1_1,
                   c_st_enum1_1,
                   c_st_enum1_1) ) after 20 ns,
               arr_st_enum1 ' (
                  (c_st_enum1_2,
                   c_st_enum1_2,
                   c_st_enum1_2) ) after 30 ns,
               arr_st_enum1 ' (
                  (c_st_enum1_1,
                   c_st_enum1_1,
                   c_st_enum1_1) ) after 40 ns ;
--
            when 3
            => correct :=
                  s_st_enum1_1 = c_st_enum1_2 and
                  s_st_enum1_2 = c_st_enum1_2 and
                  s_st_enum1_3 = c_st_enum1_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               (s_st_enum1_1,
                s_st_enum1_2,
                s_st_enum1_3) <= transport
               arr_st_enum1 ' (
                 (c_st_enum1_1,
                  c_st_enum1_1,
                  c_st_enum1_1) ) after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_st_enum1_1 = c_st_enum1_1 and
                  s_st_enum1_2 = c_st_enum1_1 and
                  s_st_enum1_3 = c_st_enum1_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634" ,
                 "One transport transaction occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 false ) ;
--
         end case ;
--
         savtime := Std.Standard.Now ;
         chk_st_enum1 <= transport counter after (1 us - savtime) ;
         counter := counter + 1;
--
      end Proc1 ;
--
   begin
      Proc1 ;
      wait until s_st_enum1_1'EVENT and
                 s_st_enum1_2'EVENT and
                 s_st_enum1_3'EVENT ;
   end process P5 ;
--
   PGEN_CHKP_6 :
   process ( chk_integer )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P6" ,
           "Transport transactions entirely completed",
           chk_integer = 4 ) ;
      end if ;
   end process PGEN_CHKP_6 ;
--
   P6 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => (s_integer_1,
                s_integer_2,
                s_integer_3) <= transport
                  arr_integer ' (
                  (c_integer_2,
                   c_integer_2,
                   c_integer_2) ) after 10 ns,
                  arr_integer ' (
                  (c_integer_1,
                   c_integer_1,
                   c_integer_1) ) after 20 ns ;
--
            when 1
            => correct :=
                  s_integer_1 = c_integer_2 and
                  s_integer_2 = c_integer_2 and
                  s_integer_3 = c_integer_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_integer_1 = c_integer_1 and
                  s_integer_2 = c_integer_1 and
                  s_integer_3 = c_integer_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634.P6" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               (s_integer_1,
                s_integer_2,
                s_integer_3) <= transport
               arr_integer ' (
                  (c_integer_2,
                   c_integer_2,
                   c_integer_2) ) after 10 ns,
               arr_integer ' (
                  (c_integer_1,
                   c_integer_1,
                   c_integer_1) ) after 20 ns,
               arr_integer ' (
                  (c_integer_2,
                   c_integer_2,
                   c_integer_2) ) after 30 ns,
               arr_integer ' (
                  (c_integer_1,
                   c_integer_1,
                   c_integer_1) ) after 40 ns ;
--
            when 3
            => correct :=
                  s_integer_1 = c_integer_2 and
                  s_integer_2 = c_integer_2 and
                  s_integer_3 = c_integer_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               (s_integer_1,
                s_integer_2,
                s_integer_3) <= transport
               arr_integer ' (
                 (c_integer_1,
                  c_integer_1,
                  c_integer_1) ) after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_integer_1 = c_integer_1 and
                  s_integer_2 = c_integer_1 and
                  s_integer_3 = c_integer_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634" ,
                 "One transport transaction occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 false ) ;
--
         end case ;
--
         savtime := Std.Standard.Now ;
         chk_integer <= transport counter after (1 us - savtime) ;
         counter := counter + 1;
--
      end Proc1 ;
--
   begin
      Proc1 ;
      wait until s_integer_1'EVENT and
                 s_integer_2'EVENT and
                 s_integer_3'EVENT ;
   end process P6 ;
--
   PGEN_CHKP_7 :
   process ( chk_st_int1 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P7" ,
           "Transport transactions entirely completed",
           chk_st_int1 = 4 ) ;
      end if ;
   end process PGEN_CHKP_7 ;
--
   P7 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => (s_st_int1_1,
                s_st_int1_2,
                s_st_int1_3) <= transport
                  arr_st_int1 ' (
                  (c_st_int1_2,
                   c_st_int1_2,
                   c_st_int1_2) ) after 10 ns,
                  arr_st_int1 ' (
                  (c_st_int1_1,
                   c_st_int1_1,
                   c_st_int1_1) ) after 20 ns ;
--
            when 1
            => correct :=
                  s_st_int1_1 = c_st_int1_2 and
                  s_st_int1_2 = c_st_int1_2 and
                  s_st_int1_3 = c_st_int1_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_st_int1_1 = c_st_int1_1 and
                  s_st_int1_2 = c_st_int1_1 and
                  s_st_int1_3 = c_st_int1_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634.P7" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               (s_st_int1_1,
                s_st_int1_2,
                s_st_int1_3) <= transport
               arr_st_int1 ' (
                  (c_st_int1_2,
                   c_st_int1_2,
                   c_st_int1_2) ) after 10 ns,
               arr_st_int1 ' (
                  (c_st_int1_1,
                   c_st_int1_1,
                   c_st_int1_1) ) after 20 ns,
               arr_st_int1 ' (
                  (c_st_int1_2,
                   c_st_int1_2,
                   c_st_int1_2) ) after 30 ns,
               arr_st_int1 ' (
                  (c_st_int1_1,
                   c_st_int1_1,
                   c_st_int1_1) ) after 40 ns ;
--
            when 3
            => correct :=
                  s_st_int1_1 = c_st_int1_2 and
                  s_st_int1_2 = c_st_int1_2 and
                  s_st_int1_3 = c_st_int1_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               (s_st_int1_1,
                s_st_int1_2,
                s_st_int1_3) <= transport
               arr_st_int1 ' (
                 (c_st_int1_1,
                  c_st_int1_1,
                  c_st_int1_1) ) after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_st_int1_1 = c_st_int1_1 and
                  s_st_int1_2 = c_st_int1_1 and
                  s_st_int1_3 = c_st_int1_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634" ,
                 "One transport transaction occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 false ) ;
--
         end case ;
--
         savtime := Std.Standard.Now ;
         chk_st_int1 <= transport counter after (1 us - savtime) ;
         counter := counter + 1;
--
      end Proc1 ;
--
   begin
      Proc1 ;
      wait until s_st_int1_1'EVENT and
                 s_st_int1_2'EVENT and
                 s_st_int1_3'EVENT ;
   end process P7 ;
--
   PGEN_CHKP_8 :
   process ( chk_time )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P8" ,
           "Transport transactions entirely completed",
           chk_time = 4 ) ;
      end if ;
   end process PGEN_CHKP_8 ;
--
   P8 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => (s_time_1,
                s_time_2,
                s_time_3) <= transport
                  arr_time ' (
                  (c_time_2,
                   c_time_2,
                   c_time_2) ) after 10 ns,
                  arr_time ' (
                  (c_time_1,
                   c_time_1,
                   c_time_1) ) after 20 ns ;
--
            when 1
            => correct :=
                  s_time_1 = c_time_2 and
                  s_time_2 = c_time_2 and
                  s_time_3 = c_time_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_time_1 = c_time_1 and
                  s_time_2 = c_time_1 and
                  s_time_3 = c_time_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634.P8" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               (s_time_1,
                s_time_2,
                s_time_3) <= transport
               arr_time ' (
                  (c_time_2,
                   c_time_2,
                   c_time_2) ) after 10 ns,
               arr_time ' (
                  (c_time_1,
                   c_time_1,
                   c_time_1) ) after 20 ns,
               arr_time ' (
                  (c_time_2,
                   c_time_2,
                   c_time_2) ) after 30 ns,
               arr_time ' (
                  (c_time_1,
                   c_time_1,
                   c_time_1) ) after 40 ns ;
--
            when 3
            => correct :=
                  s_time_1 = c_time_2 and
                  s_time_2 = c_time_2 and
                  s_time_3 = c_time_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               (s_time_1,
                s_time_2,
                s_time_3) <= transport
               arr_time ' (
                 (c_time_1,
                  c_time_1,
                  c_time_1) ) after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_time_1 = c_time_1 and
                  s_time_2 = c_time_1 and
                  s_time_3 = c_time_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634" ,
                 "One transport transaction occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 false ) ;
--
         end case ;
--
         savtime := Std.Standard.Now ;
         chk_time <= transport counter after (1 us - savtime) ;
         counter := counter + 1;
--
      end Proc1 ;
--
   begin
      Proc1 ;
      wait until s_time_1'EVENT and
                 s_time_2'EVENT and
                 s_time_3'EVENT ;
   end process P8 ;
--
   PGEN_CHKP_9 :
   process ( chk_st_phys1 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P9" ,
           "Transport transactions entirely completed",
           chk_st_phys1 = 4 ) ;
      end if ;
   end process PGEN_CHKP_9 ;
--
   P9 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => (s_st_phys1_1,
                s_st_phys1_2,
                s_st_phys1_3) <= transport
                  arr_st_phys1 ' (
                  (c_st_phys1_2,
                   c_st_phys1_2,
                   c_st_phys1_2) ) after 10 ns,
                  arr_st_phys1 ' (
                  (c_st_phys1_1,
                   c_st_phys1_1,
                   c_st_phys1_1) ) after 20 ns ;
--
            when 1
            => correct :=
                  s_st_phys1_1 = c_st_phys1_2 and
                  s_st_phys1_2 = c_st_phys1_2 and
                  s_st_phys1_3 = c_st_phys1_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_st_phys1_1 = c_st_phys1_1 and
                  s_st_phys1_2 = c_st_phys1_1 and
                  s_st_phys1_3 = c_st_phys1_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634.P9" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               (s_st_phys1_1,
                s_st_phys1_2,
                s_st_phys1_3) <= transport
               arr_st_phys1 ' (
                  (c_st_phys1_2,
                   c_st_phys1_2,
                   c_st_phys1_2) ) after 10 ns,
               arr_st_phys1 ' (
                  (c_st_phys1_1,
                   c_st_phys1_1,
                   c_st_phys1_1) ) after 20 ns,
               arr_st_phys1 ' (
                  (c_st_phys1_2,
                   c_st_phys1_2,
                   c_st_phys1_2) ) after 30 ns,
               arr_st_phys1 ' (
                  (c_st_phys1_1,
                   c_st_phys1_1,
                   c_st_phys1_1) ) after 40 ns ;
--
            when 3
            => correct :=
                  s_st_phys1_1 = c_st_phys1_2 and
                  s_st_phys1_2 = c_st_phys1_2 and
                  s_st_phys1_3 = c_st_phys1_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               (s_st_phys1_1,
                s_st_phys1_2,
                s_st_phys1_3) <= transport
               arr_st_phys1 ' (
                 (c_st_phys1_1,
                  c_st_phys1_1,
                  c_st_phys1_1) ) after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_st_phys1_1 = c_st_phys1_1 and
                  s_st_phys1_2 = c_st_phys1_1 and
                  s_st_phys1_3 = c_st_phys1_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634" ,
                 "One transport transaction occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 false ) ;
--
         end case ;
--
         savtime := Std.Standard.Now ;
         chk_st_phys1 <= transport counter after (1 us - savtime) ;
         counter := counter + 1;
--
      end Proc1 ;
--
   begin
      Proc1 ;
      wait until s_st_phys1_1'EVENT and
                 s_st_phys1_2'EVENT and
                 s_st_phys1_3'EVENT ;
   end process P9 ;
--
   PGEN_CHKP_10 :
   process ( chk_real )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P10" ,
           "Transport transactions entirely completed",
           chk_real = 4 ) ;
      end if ;
   end process PGEN_CHKP_10 ;
--
   P10 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => (s_real_1,
                s_real_2,
                s_real_3) <= transport
                  arr_real ' (
                  (c_real_2,
                   c_real_2,
                   c_real_2) ) after 10 ns,
                  arr_real ' (
                  (c_real_1,
                   c_real_1,
                   c_real_1) ) after 20 ns ;
--
            when 1
            => correct :=
                  s_real_1 = c_real_2 and
                  s_real_2 = c_real_2 and
                  s_real_3 = c_real_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_real_1 = c_real_1 and
                  s_real_2 = c_real_1 and
                  s_real_3 = c_real_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634.P10" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               (s_real_1,
                s_real_2,
                s_real_3) <= transport
               arr_real ' (
                  (c_real_2,
                   c_real_2,
                   c_real_2) ) after 10 ns,
               arr_real ' (
                  (c_real_1,
                   c_real_1,
                   c_real_1) ) after 20 ns,
               arr_real ' (
                  (c_real_2,
                   c_real_2,
                   c_real_2) ) after 30 ns,
               arr_real ' (
                  (c_real_1,
                   c_real_1,
                   c_real_1) ) after 40 ns ;
--
            when 3
            => correct :=
                  s_real_1 = c_real_2 and
                  s_real_2 = c_real_2 and
                  s_real_3 = c_real_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               (s_real_1,
                s_real_2,
                s_real_3) <= transport
               arr_real ' (
                 (c_real_1,
                  c_real_1,
                  c_real_1) ) after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_real_1 = c_real_1 and
                  s_real_2 = c_real_1 and
                  s_real_3 = c_real_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634" ,
                 "One transport transaction occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 false ) ;
--
         end case ;
--
         savtime := Std.Standard.Now ;
         chk_real <= transport counter after (1 us - savtime) ;
         counter := counter + 1;
--
      end Proc1 ;
--
   begin
      Proc1 ;
      wait until s_real_1'EVENT and
                 s_real_2'EVENT and
                 s_real_3'EVENT ;
   end process P10 ;
--
   PGEN_CHKP_11 :
   process ( chk_st_real1 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P11" ,
           "Transport transactions entirely completed",
           chk_st_real1 = 4 ) ;
      end if ;
   end process PGEN_CHKP_11 ;
--
   P11 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => (s_st_real1_1,
                s_st_real1_2,
                s_st_real1_3) <= transport
                  arr_st_real1 ' (
                  (c_st_real1_2,
                   c_st_real1_2,
                   c_st_real1_2) ) after 10 ns,
                  arr_st_real1 ' (
                  (c_st_real1_1,
                   c_st_real1_1,
                   c_st_real1_1) ) after 20 ns ;
--
            when 1
            => correct :=
                  s_st_real1_1 = c_st_real1_2 and
                  s_st_real1_2 = c_st_real1_2 and
                  s_st_real1_3 = c_st_real1_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_st_real1_1 = c_st_real1_1 and
                  s_st_real1_2 = c_st_real1_1 and
                  s_st_real1_3 = c_st_real1_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634.P11" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               (s_st_real1_1,
                s_st_real1_2,
                s_st_real1_3) <= transport
               arr_st_real1 ' (
                  (c_st_real1_2,
                   c_st_real1_2,
                   c_st_real1_2) ) after 10 ns,
               arr_st_real1 ' (
                  (c_st_real1_1,
                   c_st_real1_1,
                   c_st_real1_1) ) after 20 ns,
               arr_st_real1 ' (
                  (c_st_real1_2,
                   c_st_real1_2,
                   c_st_real1_2) ) after 30 ns,
               arr_st_real1 ' (
                  (c_st_real1_1,
                   c_st_real1_1,
                   c_st_real1_1) ) after 40 ns ;
--
            when 3
            => correct :=
                  s_st_real1_1 = c_st_real1_2 and
                  s_st_real1_2 = c_st_real1_2 and
                  s_st_real1_3 = c_st_real1_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               (s_st_real1_1,
                s_st_real1_2,
                s_st_real1_3) <= transport
               arr_st_real1 ' (
                 (c_st_real1_1,
                  c_st_real1_1,
                  c_st_real1_1) ) after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_st_real1_1 = c_st_real1_1 and
                  s_st_real1_2 = c_st_real1_1 and
                  s_st_real1_3 = c_st_real1_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634" ,
                 "One transport transaction occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 false ) ;
--
         end case ;
--
         savtime := Std.Standard.Now ;
         chk_st_real1 <= transport counter after (1 us - savtime) ;
         counter := counter + 1;
--
      end Proc1 ;
--
   begin
      Proc1 ;
      wait until s_st_real1_1'EVENT and
                 s_st_real1_2'EVENT and
                 s_st_real1_3'EVENT ;
   end process P11 ;
--
   PGEN_CHKP_12 :
   process ( chk_st_rec1 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P12" ,
           "Transport transactions entirely completed",
           chk_st_rec1 = 4 ) ;
      end if ;
   end process PGEN_CHKP_12 ;
--
   P12 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => (s_st_rec1_1,
                s_st_rec1_2,
                s_st_rec1_3) <= transport
                  arr_st_rec1 ' (
                  (c_st_rec1_2,
                   c_st_rec1_2,
                   c_st_rec1_2) ) after 10 ns,
                  arr_st_rec1 ' (
                  (c_st_rec1_1,
                   c_st_rec1_1,
                   c_st_rec1_1) ) after 20 ns ;
--
            when 1
            => correct :=
                  s_st_rec1_1 = c_st_rec1_2 and
                  s_st_rec1_2 = c_st_rec1_2 and
                  s_st_rec1_3 = c_st_rec1_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_st_rec1_1 = c_st_rec1_1 and
                  s_st_rec1_2 = c_st_rec1_1 and
                  s_st_rec1_3 = c_st_rec1_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634.P12" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               (s_st_rec1_1,
                s_st_rec1_2,
                s_st_rec1_3) <= transport
               arr_st_rec1 ' (
                  (c_st_rec1_2,
                   c_st_rec1_2,
                   c_st_rec1_2) ) after 10 ns,
               arr_st_rec1 ' (
                  (c_st_rec1_1,
                   c_st_rec1_1,
                   c_st_rec1_1) ) after 20 ns,
               arr_st_rec1 ' (
                  (c_st_rec1_2,
                   c_st_rec1_2,
                   c_st_rec1_2) ) after 30 ns,
               arr_st_rec1 ' (
                  (c_st_rec1_1,
                   c_st_rec1_1,
                   c_st_rec1_1) ) after 40 ns ;
--
            when 3
            => correct :=
                  s_st_rec1_1 = c_st_rec1_2 and
                  s_st_rec1_2 = c_st_rec1_2 and
                  s_st_rec1_3 = c_st_rec1_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               (s_st_rec1_1,
                s_st_rec1_2,
                s_st_rec1_3) <= transport
               arr_st_rec1 ' (
                 (c_st_rec1_1,
                  c_st_rec1_1,
                  c_st_rec1_1) ) after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_st_rec1_1 = c_st_rec1_1 and
                  s_st_rec1_2 = c_st_rec1_1 and
                  s_st_rec1_3 = c_st_rec1_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634" ,
                 "One transport transaction occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 false ) ;
--
         end case ;
--
         savtime := Std.Standard.Now ;
         chk_st_rec1 <= transport counter after (1 us - savtime) ;
         counter := counter + 1;
--
      end Proc1 ;
--
   begin
      Proc1 ;
      wait until s_st_rec1_1'EVENT and
                 s_st_rec1_2'EVENT and
                 s_st_rec1_3'EVENT ;
   end process P12 ;
--
   PGEN_CHKP_13 :
   process ( chk_st_rec2 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P13" ,
           "Transport transactions entirely completed",
           chk_st_rec2 = 4 ) ;
      end if ;
   end process PGEN_CHKP_13 ;
--
   P13 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => (s_st_rec2_1,
                s_st_rec2_2,
                s_st_rec2_3) <= transport
                  arr_st_rec2 ' (
                  (c_st_rec2_2,
                   c_st_rec2_2,
                   c_st_rec2_2) ) after 10 ns,
                  arr_st_rec2 ' (
                  (c_st_rec2_1,
                   c_st_rec2_1,
                   c_st_rec2_1) ) after 20 ns ;
--
            when 1
            => correct :=
                  s_st_rec2_1 = c_st_rec2_2 and
                  s_st_rec2_2 = c_st_rec2_2 and
                  s_st_rec2_3 = c_st_rec2_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_st_rec2_1 = c_st_rec2_1 and
                  s_st_rec2_2 = c_st_rec2_1 and
                  s_st_rec2_3 = c_st_rec2_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634.P13" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               (s_st_rec2_1,
                s_st_rec2_2,
                s_st_rec2_3) <= transport
               arr_st_rec2 ' (
                  (c_st_rec2_2,
                   c_st_rec2_2,
                   c_st_rec2_2) ) after 10 ns,
               arr_st_rec2 ' (
                  (c_st_rec2_1,
                   c_st_rec2_1,
                   c_st_rec2_1) ) after 20 ns,
               arr_st_rec2 ' (
                  (c_st_rec2_2,
                   c_st_rec2_2,
                   c_st_rec2_2) ) after 30 ns,
               arr_st_rec2 ' (
                  (c_st_rec2_1,
                   c_st_rec2_1,
                   c_st_rec2_1) ) after 40 ns ;
--
            when 3
            => correct :=
                  s_st_rec2_1 = c_st_rec2_2 and
                  s_st_rec2_2 = c_st_rec2_2 and
                  s_st_rec2_3 = c_st_rec2_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               (s_st_rec2_1,
                s_st_rec2_2,
                s_st_rec2_3) <= transport
               arr_st_rec2 ' (
                 (c_st_rec2_1,
                  c_st_rec2_1,
                  c_st_rec2_1) ) after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_st_rec2_1 = c_st_rec2_1 and
                  s_st_rec2_2 = c_st_rec2_1 and
                  s_st_rec2_3 = c_st_rec2_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634" ,
                 "One transport transaction occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 false ) ;
--
         end case ;
--
         savtime := Std.Standard.Now ;
         chk_st_rec2 <= transport counter after (1 us - savtime) ;
         counter := counter + 1;
--
      end Proc1 ;
--
   begin
      Proc1 ;
      wait until s_st_rec2_1'EVENT and
                 s_st_rec2_2'EVENT and
                 s_st_rec2_3'EVENT ;
   end process P13 ;
--
   PGEN_CHKP_14 :
   process ( chk_st_rec3 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P14" ,
           "Transport transactions entirely completed",
           chk_st_rec3 = 4 ) ;
      end if ;
   end process PGEN_CHKP_14 ;
--
   P14 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => (s_st_rec3_1,
                s_st_rec3_2,
                s_st_rec3_3) <= transport
                  arr_st_rec3 ' (
                  (c_st_rec3_2,
                   c_st_rec3_2,
                   c_st_rec3_2) ) after 10 ns,
                  arr_st_rec3 ' (
                  (c_st_rec3_1,
                   c_st_rec3_1,
                   c_st_rec3_1) ) after 20 ns ;
--
            when 1
            => correct :=
                  s_st_rec3_1 = c_st_rec3_2 and
                  s_st_rec3_2 = c_st_rec3_2 and
                  s_st_rec3_3 = c_st_rec3_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_st_rec3_1 = c_st_rec3_1 and
                  s_st_rec3_2 = c_st_rec3_1 and
                  s_st_rec3_3 = c_st_rec3_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634.P14" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               (s_st_rec3_1,
                s_st_rec3_2,
                s_st_rec3_3) <= transport
               arr_st_rec3 ' (
                  (c_st_rec3_2,
                   c_st_rec3_2,
                   c_st_rec3_2) ) after 10 ns,
               arr_st_rec3 ' (
                  (c_st_rec3_1,
                   c_st_rec3_1,
                   c_st_rec3_1) ) after 20 ns,
               arr_st_rec3 ' (
                  (c_st_rec3_2,
                   c_st_rec3_2,
                   c_st_rec3_2) ) after 30 ns,
               arr_st_rec3 ' (
                  (c_st_rec3_1,
                   c_st_rec3_1,
                   c_st_rec3_1) ) after 40 ns ;
--
            when 3
            => correct :=
                  s_st_rec3_1 = c_st_rec3_2 and
                  s_st_rec3_2 = c_st_rec3_2 and
                  s_st_rec3_3 = c_st_rec3_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               (s_st_rec3_1,
                s_st_rec3_2,
                s_st_rec3_3) <= transport
               arr_st_rec3 ' (
                 (c_st_rec3_1,
                  c_st_rec3_1,
                  c_st_rec3_1) ) after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_st_rec3_1 = c_st_rec3_1 and
                  s_st_rec3_2 = c_st_rec3_1 and
                  s_st_rec3_3 = c_st_rec3_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634" ,
                 "One transport transaction occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
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
   begin
      Proc1 ;
      wait until s_st_rec3_1'EVENT and
                 s_st_rec3_2'EVENT and
                 s_st_rec3_3'EVENT ;
   end process P14 ;
--
   PGEN_CHKP_15 :
   process ( chk_st_arr1 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P15" ,
           "Transport transactions entirely completed",
           chk_st_arr1 = 4 ) ;
      end if ;
   end process PGEN_CHKP_15 ;
--
   P15 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => (s_st_arr1_1,
                s_st_arr1_2,
                s_st_arr1_3) <= transport
                  arr_st_arr1 ' (
                  (c_st_arr1_2,
                   c_st_arr1_2,
                   c_st_arr1_2) ) after 10 ns,
                  arr_st_arr1 ' (
                  (c_st_arr1_1,
                   c_st_arr1_1,
                   c_st_arr1_1) ) after 20 ns ;
--
            when 1
            => correct :=
                  s_st_arr1_1 = c_st_arr1_2 and
                  s_st_arr1_2 = c_st_arr1_2 and
                  s_st_arr1_3 = c_st_arr1_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_st_arr1_1 = c_st_arr1_1 and
                  s_st_arr1_2 = c_st_arr1_1 and
                  s_st_arr1_3 = c_st_arr1_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634.P15" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               (s_st_arr1_1,
                s_st_arr1_2,
                s_st_arr1_3) <= transport
               arr_st_arr1 ' (
                  (c_st_arr1_2,
                   c_st_arr1_2,
                   c_st_arr1_2) ) after 10 ns,
               arr_st_arr1 ' (
                  (c_st_arr1_1,
                   c_st_arr1_1,
                   c_st_arr1_1) ) after 20 ns,
               arr_st_arr1 ' (
                  (c_st_arr1_2,
                   c_st_arr1_2,
                   c_st_arr1_2) ) after 30 ns,
               arr_st_arr1 ' (
                  (c_st_arr1_1,
                   c_st_arr1_1,
                   c_st_arr1_1) ) after 40 ns ;
--
            when 3
            => correct :=
                  s_st_arr1_1 = c_st_arr1_2 and
                  s_st_arr1_2 = c_st_arr1_2 and
                  s_st_arr1_3 = c_st_arr1_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               (s_st_arr1_1,
                s_st_arr1_2,
                s_st_arr1_3) <= transport
               arr_st_arr1 ' (
                 (c_st_arr1_1,
                  c_st_arr1_1,
                  c_st_arr1_1) ) after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_st_arr1_1 = c_st_arr1_1 and
                  s_st_arr1_2 = c_st_arr1_1 and
                  s_st_arr1_3 = c_st_arr1_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634" ,
                 "One transport transaction occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
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
      wait until s_st_arr1_1'EVENT and
                 s_st_arr1_2'EVENT and
                 s_st_arr1_3'EVENT ;
   end process P15 ;
--
   PGEN_CHKP_16 :
   process ( chk_st_arr2 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P16" ,
           "Transport transactions entirely completed",
           chk_st_arr2 = 4 ) ;
      end if ;
   end process PGEN_CHKP_16 ;
--
   P16 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => (s_st_arr2_1,
                s_st_arr2_2,
                s_st_arr2_3) <= transport
                  arr_st_arr2 ' (
                  (c_st_arr2_2,
                   c_st_arr2_2,
                   c_st_arr2_2) ) after 10 ns,
                  arr_st_arr2 ' (
                  (c_st_arr2_1,
                   c_st_arr2_1,
                   c_st_arr2_1) ) after 20 ns ;
--
            when 1
            => correct :=
                  s_st_arr2_1 = c_st_arr2_2 and
                  s_st_arr2_2 = c_st_arr2_2 and
                  s_st_arr2_3 = c_st_arr2_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_st_arr2_1 = c_st_arr2_1 and
                  s_st_arr2_2 = c_st_arr2_1 and
                  s_st_arr2_3 = c_st_arr2_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634.P16" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               (s_st_arr2_1,
                s_st_arr2_2,
                s_st_arr2_3) <= transport
               arr_st_arr2 ' (
                  (c_st_arr2_2,
                   c_st_arr2_2,
                   c_st_arr2_2) ) after 10 ns,
               arr_st_arr2 ' (
                  (c_st_arr2_1,
                   c_st_arr2_1,
                   c_st_arr2_1) ) after 20 ns,
               arr_st_arr2 ' (
                  (c_st_arr2_2,
                   c_st_arr2_2,
                   c_st_arr2_2) ) after 30 ns,
               arr_st_arr2 ' (
                  (c_st_arr2_1,
                   c_st_arr2_1,
                   c_st_arr2_1) ) after 40 ns ;
--
            when 3
            => correct :=
                  s_st_arr2_1 = c_st_arr2_2 and
                  s_st_arr2_2 = c_st_arr2_2 and
                  s_st_arr2_3 = c_st_arr2_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               (s_st_arr2_1,
                s_st_arr2_2,
                s_st_arr2_3) <= transport
               arr_st_arr2 ' (
                 (c_st_arr2_1,
                  c_st_arr2_1,
                  c_st_arr2_1) ) after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_st_arr2_1 = c_st_arr2_1 and
                  s_st_arr2_2 = c_st_arr2_1 and
                  s_st_arr2_3 = c_st_arr2_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634" ,
                 "One transport transaction occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
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
      wait until s_st_arr2_1'EVENT and
                 s_st_arr2_2'EVENT and
                 s_st_arr2_3'EVENT ;
   end process P16 ;
--
   PGEN_CHKP_17 :
   process ( chk_st_arr3 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P17" ,
           "Transport transactions entirely completed",
           chk_st_arr3 = 4 ) ;
      end if ;
   end process PGEN_CHKP_17 ;
--
   P17 :
   process
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => (s_st_arr3_1,
                s_st_arr3_2,
                s_st_arr3_3) <= transport
                  arr_st_arr3 ' (
                  (c_st_arr3_2,
                   c_st_arr3_2,
                   c_st_arr3_2) ) after 10 ns,
                  arr_st_arr3 ' (
                  (c_st_arr3_1,
                   c_st_arr3_1,
                   c_st_arr3_1) ) after 20 ns ;
--
            when 1
            => correct :=
                  s_st_arr3_1 = c_st_arr3_2 and
                  s_st_arr3_2 = c_st_arr3_2 and
                  s_st_arr3_3 = c_st_arr3_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_st_arr3_1 = c_st_arr3_1 and
                  s_st_arr3_2 = c_st_arr3_1 and
                  s_st_arr3_3 = c_st_arr3_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634.P17" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               (s_st_arr3_1,
                s_st_arr3_2,
                s_st_arr3_3) <= transport
               arr_st_arr3 ' (
                  (c_st_arr3_2,
                   c_st_arr3_2,
                   c_st_arr3_2) ) after 10 ns,
               arr_st_arr3 ' (
                  (c_st_arr3_1,
                   c_st_arr3_1,
                   c_st_arr3_1) ) after 20 ns,
               arr_st_arr3 ' (
                  (c_st_arr3_2,
                   c_st_arr3_2,
                   c_st_arr3_2) ) after 30 ns,
               arr_st_arr3 ' (
                  (c_st_arr3_1,
                   c_st_arr3_1,
                   c_st_arr3_1) ) after 40 ns ;
--
            when 3
            => correct :=
                  s_st_arr3_1 = c_st_arr3_2 and
                  s_st_arr3_2 = c_st_arr3_2 and
                  s_st_arr3_3 = c_st_arr3_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               (s_st_arr3_1,
                s_st_arr3_2,
                s_st_arr3_3) <= transport
               arr_st_arr3 ' (
                 (c_st_arr3_1,
                  c_st_arr3_1,
                  c_st_arr3_1) ) after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_st_arr3_1 = c_st_arr3_1 and
                  s_st_arr3_2 = c_st_arr3_1 and
                  s_st_arr3_3 = c_st_arr3_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00634" ,
                 "One transport transaction occurred on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00634" ,
                 "Old transactions were removed on signal " &
                 "asg with aggregate of simple names on LHS",
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
      wait until s_st_arr3_1'EVENT and
                 s_st_arr3_2'EVENT and
                 s_st_arr3_3'EVENT ;
   end process P17 ;
--
--
end ARCH00634 ;
--
entity ENT00634_Test_Bench is
end ENT00634_Test_Bench ;
--
architecture ARCH00634_Test_Bench of ENT00634_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00634 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00634_Test_Bench ;
