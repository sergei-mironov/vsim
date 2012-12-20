-- NEED RESULT: ARCH00192.P17: Transaction occurred on signal asg with no  time expression -- 0 ns assumed passed
-- NEED RESULT: ARCH00192.P16: Transaction occurred on signal asg with no  time expression -- 0 ns assumed passed
-- NEED RESULT: ARCH00192.P15: Transaction occurred on signal asg with no  time expression -- 0 ns assumed passed
-- NEED RESULT: ARCH00192.P14: Transaction occurred on signal asg with no  time expression -- 0 ns assumed passed
-- NEED RESULT: ARCH00192.P13: Transaction occurred on signal asg with no  time expression -- 0 ns assumed passed
-- NEED RESULT: ARCH00192.P12: Transaction occurred on signal asg with no  time expression -- 0 ns assumed passed
-- NEED RESULT: ARCH00192.P11: Transaction occurred on signal asg with no  time expression -- 0 ns assumed passed
-- NEED RESULT: ARCH00192.P10: Transaction occurred on signal asg with no  time expression -- 0 ns assumed passed
-- NEED RESULT: ARCH00192.P9: Transaction occurred on signal asg with no  time expression -- 0 ns assumed passed
-- NEED RESULT: ARCH00192.P8: Transaction occurred on signal asg with no  time expression -- 0 ns assumed passed
-- NEED RESULT: ARCH00192.P7: Transaction occurred on signal asg with no  time expression -- 0 ns assumed passed
-- NEED RESULT: ARCH00192.P6: Transaction occurred on signal asg with no  time expression -- 0 ns assumed passed
-- NEED RESULT: ARCH00192.P5: Transaction occurred on signal asg with no  time expression -- 0 ns assumed passed
-- NEED RESULT: ARCH00192.P4: Transaction occurred on signal asg with no  time expression -- 0 ns assumed passed
-- NEED RESULT: ARCH00192.P3: Transaction occurred on signal asg with no  time expression -- 0 ns assumed passed
-- NEED RESULT: ARCH00192.P2: Transaction occurred on signal asg with no  time expression -- 0 ns assumed passed
-- NEED RESULT: ARCH00192.P1: Transaction occurred on signal asg with no  time expression -- 0 ns assumed passed
-- NEED RESULT: P17: Inertial transactions entirely completed passed
-- NEED RESULT: P16: Inertial transactions entirely completed passed
-- NEED RESULT: P15: Inertial transactions entirely completed passed
-- NEED RESULT: P14: Inertial transactions entirely completed passed
-- NEED RESULT: P13: Inertial transactions entirely completed passed
-- NEED RESULT: P12: Inertial transactions entirely completed passed
-- NEED RESULT: P11: Inertial transactions entirely completed passed
-- NEED RESULT: P10: Inertial transactions entirely completed passed
-- NEED RESULT: P9: Inertial transactions entirely completed passed
-- NEED RESULT: P8: Inertial transactions entirely completed passed
-- NEED RESULT: P7: Inertial transactions entirely completed passed
-- NEED RESULT: P6: Inertial transactions entirely completed passed
-- NEED RESULT: P5: Inertial transactions entirely completed passed
-- NEED RESULT: P4: Inertial transactions entirely completed passed
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
--    CT00192
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.3.1 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00192)
--    ENT00192_Test_Bench(ARCH00192_Test_Bench)
--
-- REVISION HISTORY:
--
--    09-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00192 of E00000 is
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
   signal s_boolean : boolean
     := c_boolean_1 ;
   signal s_bit : bit
     := c_bit_1 ;
   signal s_severity_level : severity_level
     := c_severity_level_1 ;
   signal s_character : character
     := c_character_1 ;
   signal s_st_enum1 : st_enum1
     := c_st_enum1_1 ;
   signal s_integer : integer
     := c_integer_1 ;
   signal s_st_int1 : st_int1
     := c_st_int1_1 ;
   signal s_time : time
     := c_time_1 ;
   signal s_st_phys1 : st_phys1
     := c_st_phys1_1 ;
   signal s_real : real
     := c_real_1 ;
   signal s_st_real1 : st_real1
     := c_st_real1_1 ;
   signal s_st_rec1 : st_rec1
     := c_st_rec1_1 ;
   signal s_st_rec2 : st_rec2
     := c_st_rec2_1 ;
   signal s_st_rec3 : st_rec3
     := c_st_rec3_1 ;
   signal s_st_arr1 : st_arr1
     := c_st_arr1_1 ;
   signal s_st_arr2 : st_arr2
     := c_st_arr2_1 ;
   signal s_st_arr3 : st_arr3
     := c_st_arr3_1 ;
--
begin
   PGEN_CHKP_1 :
   process ( chk_boolean )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Inertial transactions entirely completed",
           chk_boolean = 1 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
   P1 :
   process ( s_boolean )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_boolean <=
               c_boolean_2 ;
--
         when 1
         => correct :=
               s_boolean = c_boolean_2 and
               savtime = Std.Standard.Now ;
            test_report ( "ARCH00192.P1" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00192.P1" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_boolean <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end process P1 ;
--
   PGEN_CHKP_2 :
   process ( chk_bit )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P2" ,
           "Inertial transactions entirely completed",
           chk_bit = 1 ) ;
      end if ;
   end process PGEN_CHKP_2 ;
--
   P2 :
   process ( s_bit )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_bit <=
               c_bit_2 ;
--
         when 1
         => correct :=
               s_bit = c_bit_2 and
               savtime = Std.Standard.Now ;
            test_report ( "ARCH00192.P2" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00192.P2" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_bit <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end process P2 ;
--
   PGEN_CHKP_3 :
   process ( chk_severity_level )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P3" ,
           "Inertial transactions entirely completed",
           chk_severity_level = 1 ) ;
      end if ;
   end process PGEN_CHKP_3 ;
--
   P3 :
   process ( s_severity_level )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_severity_level <=
               c_severity_level_2 ;
--
         when 1
         => correct :=
               s_severity_level = c_severity_level_2 and
               savtime = Std.Standard.Now ;
            test_report ( "ARCH00192.P3" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00192.P3" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_severity_level <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end process P3 ;
--
   PGEN_CHKP_4 :
   process ( chk_character )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P4" ,
           "Inertial transactions entirely completed",
           chk_character = 1 ) ;
      end if ;
   end process PGEN_CHKP_4 ;
--
   P4 :
   process ( s_character )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_character <=
               c_character_2 ;
--
         when 1
         => correct :=
               s_character = c_character_2 and
               savtime = Std.Standard.Now ;
            test_report ( "ARCH00192.P4" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00192.P4" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_character <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end process P4 ;
--
   PGEN_CHKP_5 :
   process ( chk_st_enum1 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P5" ,
           "Inertial transactions entirely completed",
           chk_st_enum1 = 1 ) ;
      end if ;
   end process PGEN_CHKP_5 ;
--
   P5 :
   process ( s_st_enum1 )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_enum1 <=
               c_st_enum1_2 ;
--
         when 1
         => correct :=
               s_st_enum1 = c_st_enum1_2 and
               savtime = Std.Standard.Now ;
            test_report ( "ARCH00192.P5" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00192.P5" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_enum1 <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end process P5 ;
--
   PGEN_CHKP_6 :
   process ( chk_integer )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P6" ,
           "Inertial transactions entirely completed",
           chk_integer = 1 ) ;
      end if ;
   end process PGEN_CHKP_6 ;
--
   P6 :
   process ( s_integer )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_integer <=
               c_integer_2 ;
--
         when 1
         => correct :=
               s_integer = c_integer_2 and
               savtime = Std.Standard.Now ;
            test_report ( "ARCH00192.P6" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00192.P6" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_integer <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end process P6 ;
--
   PGEN_CHKP_7 :
   process ( chk_st_int1 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P7" ,
           "Inertial transactions entirely completed",
           chk_st_int1 = 1 ) ;
      end if ;
   end process PGEN_CHKP_7 ;
--
   P7 :
   process ( s_st_int1 )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_int1 <=
               c_st_int1_2 ;
--
         when 1
         => correct :=
               s_st_int1 = c_st_int1_2 and
               savtime = Std.Standard.Now ;
            test_report ( "ARCH00192.P7" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00192.P7" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_int1 <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end process P7 ;
--
   PGEN_CHKP_8 :
   process ( chk_time )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P8" ,
           "Inertial transactions entirely completed",
           chk_time = 1 ) ;
      end if ;
   end process PGEN_CHKP_8 ;
--
   P8 :
   process ( s_time )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_time <=
               c_time_2 ;
--
         when 1
         => correct :=
               s_time = c_time_2 and
               savtime = Std.Standard.Now ;
            test_report ( "ARCH00192.P8" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00192.P8" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_time <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end process P8 ;
--
   PGEN_CHKP_9 :
   process ( chk_st_phys1 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P9" ,
           "Inertial transactions entirely completed",
           chk_st_phys1 = 1 ) ;
      end if ;
   end process PGEN_CHKP_9 ;
--
   P9 :
   process ( s_st_phys1 )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_phys1 <=
               c_st_phys1_2 ;
--
         when 1
         => correct :=
               s_st_phys1 = c_st_phys1_2 and
               savtime = Std.Standard.Now ;
            test_report ( "ARCH00192.P9" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00192.P9" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_phys1 <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end process P9 ;
--
   PGEN_CHKP_10 :
   process ( chk_real )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P10" ,
           "Inertial transactions entirely completed",
           chk_real = 1 ) ;
      end if ;
   end process PGEN_CHKP_10 ;
--
   P10 :
   process ( s_real )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_real <=
               c_real_2 ;
--
         when 1
         => correct :=
               s_real = c_real_2 and
               savtime = Std.Standard.Now ;
            test_report ( "ARCH00192.P10" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00192.P10" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_real <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end process P10 ;
--
   PGEN_CHKP_11 :
   process ( chk_st_real1 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P11" ,
           "Inertial transactions entirely completed",
           chk_st_real1 = 1 ) ;
      end if ;
   end process PGEN_CHKP_11 ;
--
   P11 :
   process ( s_st_real1 )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_real1 <=
               c_st_real1_2 ;
--
         when 1
         => correct :=
               s_st_real1 = c_st_real1_2 and
               savtime = Std.Standard.Now ;
            test_report ( "ARCH00192.P11" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00192.P11" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_real1 <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end process P11 ;
--
   PGEN_CHKP_12 :
   process ( chk_st_rec1 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P12" ,
           "Inertial transactions entirely completed",
           chk_st_rec1 = 1 ) ;
      end if ;
   end process PGEN_CHKP_12 ;
--
   P12 :
   process ( s_st_rec1 )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_rec1 <=
               c_st_rec1_2 ;
--
         when 1
         => correct :=
               s_st_rec1 = c_st_rec1_2 and
               savtime = Std.Standard.Now ;
            test_report ( "ARCH00192.P12" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00192.P12" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_rec1 <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end process P12 ;
--
   PGEN_CHKP_13 :
   process ( chk_st_rec2 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P13" ,
           "Inertial transactions entirely completed",
           chk_st_rec2 = 1 ) ;
      end if ;
   end process PGEN_CHKP_13 ;
--
   P13 :
   process ( s_st_rec2 )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_rec2 <=
               c_st_rec2_2 ;
--
         when 1
         => correct :=
               s_st_rec2 = c_st_rec2_2 and
               savtime = Std.Standard.Now ;
            test_report ( "ARCH00192.P13" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00192.P13" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_rec2 <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end process P13 ;
--
   PGEN_CHKP_14 :
   process ( chk_st_rec3 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P14" ,
           "Inertial transactions entirely completed",
           chk_st_rec3 = 1 ) ;
      end if ;
   end process PGEN_CHKP_14 ;
--
   P14 :
   process ( s_st_rec3 )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_rec3 <=
               c_st_rec3_2 ;
--
         when 1
         => correct :=
               s_st_rec3 = c_st_rec3_2 and
               savtime = Std.Standard.Now ;
            test_report ( "ARCH00192.P14" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00192.P14" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_rec3 <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end process P14 ;
--
   PGEN_CHKP_15 :
   process ( chk_st_arr1 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P15" ,
           "Inertial transactions entirely completed",
           chk_st_arr1 = 1 ) ;
      end if ;
   end process PGEN_CHKP_15 ;
--
   P15 :
   process ( s_st_arr1 )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_arr1 <=
               c_st_arr1_2 ;
--
         when 1
         => correct :=
               s_st_arr1 = c_st_arr1_2 and
               savtime = Std.Standard.Now ;
            test_report ( "ARCH00192.P15" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00192.P15" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_arr1 <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end process P15 ;
--
   PGEN_CHKP_16 :
   process ( chk_st_arr2 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P16" ,
           "Inertial transactions entirely completed",
           chk_st_arr2 = 1 ) ;
      end if ;
   end process PGEN_CHKP_16 ;
--
   P16 :
   process ( s_st_arr2 )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_arr2 <=
               c_st_arr2_2 ;
--
         when 1
         => correct :=
               s_st_arr2 = c_st_arr2_2 and
               savtime = Std.Standard.Now ;
            test_report ( "ARCH00192.P16" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00192.P16" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_arr2 <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end process P16 ;
--
   PGEN_CHKP_17 :
   process ( chk_st_arr3 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P17" ,
           "Inertial transactions entirely completed",
           chk_st_arr3 = 1 ) ;
      end if ;
   end process PGEN_CHKP_17 ;
--
   P17 :
   process ( s_st_arr3 )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_arr3 <=
               c_st_arr3_2 ;
--
         when 1
         => correct :=
               s_st_arr3 = c_st_arr3_2 and
               savtime = Std.Standard.Now ;
            test_report ( "ARCH00192.P17" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00192.P17" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_arr3 <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end process P17 ;
--
--
end ARCH00192 ;
--
entity ENT00192_Test_Bench is
end ENT00192_Test_Bench ;
--
architecture ARCH00192_Test_Bench of ENT00192_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00192 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00192_Test_Bench ;
