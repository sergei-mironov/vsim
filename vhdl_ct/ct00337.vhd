-- NEED RESULT: ARCH00337.P1: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00337.P2: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00337.P3: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00337.P4: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00337.P5: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00337.P6: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00337.P7: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00337.P8: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00337.P9: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00337.P10: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00337.P11: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00337.P12: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00337.P13: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00337.P14: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00337.P15: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00337.P16: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00337.P17: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00337: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00337: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: P17: Transport transactions completed entirely passed
-- NEED RESULT: P16: Transport transactions completed entirely passed
-- NEED RESULT: P15: Transport transactions completed entirely passed
-- NEED RESULT: P14: Transport transactions completed entirely passed
-- NEED RESULT: P13: Transport transactions completed entirely passed
-- NEED RESULT: P12: Transport transactions completed entirely passed
-- NEED RESULT: P11: Transport transactions completed entirely passed
-- NEED RESULT: P10: Transport transactions completed entirely passed
-- NEED RESULT: P9: Transport transactions completed entirely passed
-- NEED RESULT: P8: Transport transactions completed entirely passed
-- NEED RESULT: P7: Transport transactions completed entirely passed
-- NEED RESULT: P6: Transport transactions completed entirely passed
-- NEED RESULT: P5: Transport transactions completed entirely passed
-- NEED RESULT: P4: Transport transactions completed entirely passed
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
--    CT00337
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.5 (2)
--    9.5.1 (1)
--    9.5.1 (2)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00337(ARCH00337)
--    ENT00337_Test_Bench(ARCH00337_Test_Bench)
--
-- REVISION HISTORY:
--
--    30-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
entity ENT00337 is
end ENT00337 ;
--
--
architecture ARCH00337 of ENT00337 is
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
   subtype chk_time_type is Time ;
   signal s_boolean_savt : chk_time_type := 0 ns ;
   signal s_bit_savt : chk_time_type := 0 ns ;
   signal s_severity_level_savt : chk_time_type := 0 ns ;
   signal s_character_savt : chk_time_type := 0 ns ;
   signal s_st_enum1_savt : chk_time_type := 0 ns ;
   signal s_integer_savt : chk_time_type := 0 ns ;
   signal s_st_int1_savt : chk_time_type := 0 ns ;
   signal s_time_savt : chk_time_type := 0 ns ;
   signal s_st_phys1_savt : chk_time_type := 0 ns ;
   signal s_real_savt : chk_time_type := 0 ns ;
   signal s_st_real1_savt : chk_time_type := 0 ns ;
   signal s_st_rec1_savt : chk_time_type := 0 ns ;
   signal s_st_rec2_savt : chk_time_type := 0 ns ;
   signal s_st_rec3_savt : chk_time_type := 0 ns ;
   signal s_st_arr1_savt : chk_time_type := 0 ns ;
   signal s_st_arr2_savt : chk_time_type := 0 ns ;
   signal s_st_arr3_savt : chk_time_type := 0 ns ;
--
   subtype chk_cnt_type is Integer ;
   signal s_boolean_cnt : chk_cnt_type := 0 ;
   signal s_bit_cnt : chk_cnt_type := 0 ;
   signal s_severity_level_cnt : chk_cnt_type := 0 ;
   signal s_character_cnt : chk_cnt_type := 0 ;
   signal s_st_enum1_cnt : chk_cnt_type := 0 ;
   signal s_integer_cnt : chk_cnt_type := 0 ;
   signal s_st_int1_cnt : chk_cnt_type := 0 ;
   signal s_time_cnt : chk_cnt_type := 0 ;
   signal s_st_phys1_cnt : chk_cnt_type := 0 ;
   signal s_real_cnt : chk_cnt_type := 0 ;
   signal s_st_real1_cnt : chk_cnt_type := 0 ;
   signal s_st_rec1_cnt : chk_cnt_type := 0 ;
   signal s_st_rec2_cnt : chk_cnt_type := 0 ;
   signal s_st_rec3_cnt : chk_cnt_type := 0 ;
   signal s_st_arr1_cnt : chk_cnt_type := 0 ;
   signal s_st_arr2_cnt : chk_cnt_type := 0 ;
   signal s_st_arr3_cnt : chk_cnt_type := 0 ;
--
   type select_type is range 1 to 3 ;
   signal boolean_select : select_type := 1 ;
   signal bit_select : select_type := 1 ;
   signal severity_level_select : select_type := 1 ;
   signal character_select : select_type := 1 ;
   signal st_enum1_select : select_type := 1 ;
   signal integer_select : select_type := 1 ;
   signal st_int1_select : select_type := 1 ;
   signal time_select : select_type := 1 ;
   signal st_phys1_select : select_type := 1 ;
   signal real_select : select_type := 1 ;
   signal st_real1_select : select_type := 1 ;
   signal st_rec1_select : select_type := 1 ;
   signal st_rec2_select : select_type := 1 ;
   signal st_rec3_select : select_type := 1 ;
   signal st_arr1_select : select_type := 1 ;
   signal st_arr2_select : select_type := 1 ;
   signal st_arr3_select : select_type := 1 ;
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
   CHG1 :
   process ( s_boolean )
      variable correct : boolean ;
   begin
      case s_boolean_cnt is
         when 0
         => null ;
              -- s_boolean <= transport
              --   c_boolean_2 after 10 ns,
              --   c_boolean_1 after 20 ns ;
--
         when 1
         => correct :=
               s_boolean =
                 c_boolean_2 and
               (s_boolean_savt + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_boolean =
                 c_boolean_1 and
               (s_boolean_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337.P1" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            boolean_select <= transport 2 ;
              -- s_boolean <= transport
              --   c_boolean_2 after 10 ns ,
              --   c_boolean_1 after 20 ns ,
              --   c_boolean_2 after 30 ns ,
              --   c_boolean_1 after 40 ns ;
--
         when 3
         => correct :=
               s_boolean =
                 c_boolean_2 and
               (s_boolean_savt + 10 ns) = Std.Standard.Now ;
            boolean_select <= transport 3 ;
              -- s_boolean <= transport
              --   c_boolean_1 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_boolean =
                 c_boolean_1 and
               (s_boolean_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      s_boolean_savt <= transport Std.Standard.Now ;
      chk_boolean <= transport s_boolean_cnt
          after (1 us - Std.Standard.Now) ;
      s_boolean_cnt <= transport s_boolean_cnt + 1 ;
--
   end process CHG1 ;
--
   PGEN_CHKP_1 :
   process ( chk_boolean )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Transport transactions completed entirely",
           chk_boolean = 4 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
--
      s_boolean <= transport
        c_boolean_2 after 10 ns,
        c_boolean_1 after 20 ns
        when boolean_select = 1 else
--
        c_boolean_2 after 10 ns ,
        c_boolean_1 after 20 ns ,
        c_boolean_2 after 30 ns ,
        c_boolean_1 after 40 ns
        when boolean_select = 2 else
--
        c_boolean_1 after 5 ns ;
--
   CHG2 :
   process ( s_bit )
      variable correct : boolean ;
   begin
      case s_bit_cnt is
         when 0
         => null ;
              -- s_bit <= transport
              --   c_bit_2 after 10 ns,
              --   c_bit_1 after 20 ns ;
--
         when 1
         => correct :=
               s_bit =
                 c_bit_2 and
               (s_bit_savt + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_bit =
                 c_bit_1 and
               (s_bit_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337.P2" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            bit_select <= transport 2 ;
              -- s_bit <= transport
              --   c_bit_2 after 10 ns ,
              --   c_bit_1 after 20 ns ,
              --   c_bit_2 after 30 ns ,
              --   c_bit_1 after 40 ns ;
--
         when 3
         => correct :=
               s_bit =
                 c_bit_2 and
               (s_bit_savt + 10 ns) = Std.Standard.Now ;
            bit_select <= transport 3 ;
              -- s_bit <= transport
              --   c_bit_1 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_bit =
                 c_bit_1 and
               (s_bit_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      s_bit_savt <= transport Std.Standard.Now ;
      chk_bit <= transport s_bit_cnt
          after (1 us - Std.Standard.Now) ;
      s_bit_cnt <= transport s_bit_cnt + 1 ;
--
   end process CHG2 ;
--
   PGEN_CHKP_2 :
   process ( chk_bit )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P2" ,
           "Transport transactions completed entirely",
           chk_bit = 4 ) ;
      end if ;
   end process PGEN_CHKP_2 ;
--
--
      s_bit <= transport
        c_bit_2 after 10 ns,
        c_bit_1 after 20 ns
        when bit_select = 1 else
--
        c_bit_2 after 10 ns ,
        c_bit_1 after 20 ns ,
        c_bit_2 after 30 ns ,
        c_bit_1 after 40 ns
        when bit_select = 2 else
--
        c_bit_1 after 5 ns ;
--
   CHG3 :
   process ( s_severity_level )
      variable correct : boolean ;
   begin
      case s_severity_level_cnt is
         when 0
         => null ;
              -- s_severity_level <= transport
              --   c_severity_level_2 after 10 ns,
              --   c_severity_level_1 after 20 ns ;
--
         when 1
         => correct :=
               s_severity_level =
                 c_severity_level_2 and
               (s_severity_level_savt + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_severity_level =
                 c_severity_level_1 and
               (s_severity_level_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337.P3" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            severity_level_select <= transport 2 ;
              -- s_severity_level <= transport
              --   c_severity_level_2 after 10 ns ,
              --   c_severity_level_1 after 20 ns ,
              --   c_severity_level_2 after 30 ns ,
              --   c_severity_level_1 after 40 ns ;
--
         when 3
         => correct :=
               s_severity_level =
                 c_severity_level_2 and
               (s_severity_level_savt + 10 ns) = Std.Standard.Now ;
            severity_level_select <= transport 3 ;
              -- s_severity_level <= transport
              --   c_severity_level_1 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_severity_level =
                 c_severity_level_1 and
               (s_severity_level_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      s_severity_level_savt <= transport Std.Standard.Now ;
      chk_severity_level <= transport s_severity_level_cnt
          after (1 us - Std.Standard.Now) ;
      s_severity_level_cnt <= transport s_severity_level_cnt + 1 ;
--
   end process CHG3 ;
--
   PGEN_CHKP_3 :
   process ( chk_severity_level )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P3" ,
           "Transport transactions completed entirely",
           chk_severity_level = 4 ) ;
      end if ;
   end process PGEN_CHKP_3 ;
--
--
      s_severity_level <= transport
        c_severity_level_2 after 10 ns,
        c_severity_level_1 after 20 ns
        when severity_level_select = 1 else
--
        c_severity_level_2 after 10 ns ,
        c_severity_level_1 after 20 ns ,
        c_severity_level_2 after 30 ns ,
        c_severity_level_1 after 40 ns
        when severity_level_select = 2 else
--
        c_severity_level_1 after 5 ns ;
--
   CHG4 :
   process ( s_character )
      variable correct : boolean ;
   begin
      case s_character_cnt is
         when 0
         => null ;
              -- s_character <= transport
              --   c_character_2 after 10 ns,
              --   c_character_1 after 20 ns ;
--
         when 1
         => correct :=
               s_character =
                 c_character_2 and
               (s_character_savt + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_character =
                 c_character_1 and
               (s_character_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337.P4" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            character_select <= transport 2 ;
              -- s_character <= transport
              --   c_character_2 after 10 ns ,
              --   c_character_1 after 20 ns ,
              --   c_character_2 after 30 ns ,
              --   c_character_1 after 40 ns ;
--
         when 3
         => correct :=
               s_character =
                 c_character_2 and
               (s_character_savt + 10 ns) = Std.Standard.Now ;
            character_select <= transport 3 ;
              -- s_character <= transport
              --   c_character_1 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_character =
                 c_character_1 and
               (s_character_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      s_character_savt <= transport Std.Standard.Now ;
      chk_character <= transport s_character_cnt
          after (1 us - Std.Standard.Now) ;
      s_character_cnt <= transport s_character_cnt + 1 ;
--
   end process CHG4 ;
--
   PGEN_CHKP_4 :
   process ( chk_character )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P4" ,
           "Transport transactions completed entirely",
           chk_character = 4 ) ;
      end if ;
   end process PGEN_CHKP_4 ;
--
--
      s_character <= transport
        c_character_2 after 10 ns,
        c_character_1 after 20 ns
        when character_select = 1 else
--
        c_character_2 after 10 ns ,
        c_character_1 after 20 ns ,
        c_character_2 after 30 ns ,
        c_character_1 after 40 ns
        when character_select = 2 else
--
        c_character_1 after 5 ns ;
--
   CHG5 :
   process ( s_st_enum1 )
      variable correct : boolean ;
   begin
      case s_st_enum1_cnt is
         when 0
         => null ;
              -- s_st_enum1 <= transport
              --   c_st_enum1_2 after 10 ns,
              --   c_st_enum1_1 after 20 ns ;
--
         when 1
         => correct :=
               s_st_enum1 =
                 c_st_enum1_2 and
               (s_st_enum1_savt + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_enum1 =
                 c_st_enum1_1 and
               (s_st_enum1_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337.P5" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            st_enum1_select <= transport 2 ;
              -- s_st_enum1 <= transport
              --   c_st_enum1_2 after 10 ns ,
              --   c_st_enum1_1 after 20 ns ,
              --   c_st_enum1_2 after 30 ns ,
              --   c_st_enum1_1 after 40 ns ;
--
         when 3
         => correct :=
               s_st_enum1 =
                 c_st_enum1_2 and
               (s_st_enum1_savt + 10 ns) = Std.Standard.Now ;
            st_enum1_select <= transport 3 ;
              -- s_st_enum1 <= transport
              --   c_st_enum1_1 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_enum1 =
                 c_st_enum1_1 and
               (s_st_enum1_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      s_st_enum1_savt <= transport Std.Standard.Now ;
      chk_st_enum1 <= transport s_st_enum1_cnt
          after (1 us - Std.Standard.Now) ;
      s_st_enum1_cnt <= transport s_st_enum1_cnt + 1 ;
--
   end process CHG5 ;
--
   PGEN_CHKP_5 :
   process ( chk_st_enum1 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P5" ,
           "Transport transactions completed entirely",
           chk_st_enum1 = 4 ) ;
      end if ;
   end process PGEN_CHKP_5 ;
--
--
      s_st_enum1 <= transport
        c_st_enum1_2 after 10 ns,
        c_st_enum1_1 after 20 ns
        when st_enum1_select = 1 else
--
        c_st_enum1_2 after 10 ns ,
        c_st_enum1_1 after 20 ns ,
        c_st_enum1_2 after 30 ns ,
        c_st_enum1_1 after 40 ns
        when st_enum1_select = 2 else
--
        c_st_enum1_1 after 5 ns ;
--
   CHG6 :
   process ( s_integer )
      variable correct : boolean ;
   begin
      case s_integer_cnt is
         when 0
         => null ;
              -- s_integer <= transport
              --   c_integer_2 after 10 ns,
              --   c_integer_1 after 20 ns ;
--
         when 1
         => correct :=
               s_integer =
                 c_integer_2 and
               (s_integer_savt + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_integer =
                 c_integer_1 and
               (s_integer_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337.P6" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            integer_select <= transport 2 ;
              -- s_integer <= transport
              --   c_integer_2 after 10 ns ,
              --   c_integer_1 after 20 ns ,
              --   c_integer_2 after 30 ns ,
              --   c_integer_1 after 40 ns ;
--
         when 3
         => correct :=
               s_integer =
                 c_integer_2 and
               (s_integer_savt + 10 ns) = Std.Standard.Now ;
            integer_select <= transport 3 ;
              -- s_integer <= transport
              --   c_integer_1 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_integer =
                 c_integer_1 and
               (s_integer_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      s_integer_savt <= transport Std.Standard.Now ;
      chk_integer <= transport s_integer_cnt
          after (1 us - Std.Standard.Now) ;
      s_integer_cnt <= transport s_integer_cnt + 1 ;
--
   end process CHG6 ;
--
   PGEN_CHKP_6 :
   process ( chk_integer )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P6" ,
           "Transport transactions completed entirely",
           chk_integer = 4 ) ;
      end if ;
   end process PGEN_CHKP_6 ;
--
--
      s_integer <= transport
        c_integer_2 after 10 ns,
        c_integer_1 after 20 ns
        when integer_select = 1 else
--
        c_integer_2 after 10 ns ,
        c_integer_1 after 20 ns ,
        c_integer_2 after 30 ns ,
        c_integer_1 after 40 ns
        when integer_select = 2 else
--
        c_integer_1 after 5 ns ;
--
   CHG7 :
   process ( s_st_int1 )
      variable correct : boolean ;
   begin
      case s_st_int1_cnt is
         when 0
         => null ;
              -- s_st_int1 <= transport
              --   c_st_int1_2 after 10 ns,
              --   c_st_int1_1 after 20 ns ;
--
         when 1
         => correct :=
               s_st_int1 =
                 c_st_int1_2 and
               (s_st_int1_savt + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_int1 =
                 c_st_int1_1 and
               (s_st_int1_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337.P7" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            st_int1_select <= transport 2 ;
              -- s_st_int1 <= transport
              --   c_st_int1_2 after 10 ns ,
              --   c_st_int1_1 after 20 ns ,
              --   c_st_int1_2 after 30 ns ,
              --   c_st_int1_1 after 40 ns ;
--
         when 3
         => correct :=
               s_st_int1 =
                 c_st_int1_2 and
               (s_st_int1_savt + 10 ns) = Std.Standard.Now ;
            st_int1_select <= transport 3 ;
              -- s_st_int1 <= transport
              --   c_st_int1_1 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_int1 =
                 c_st_int1_1 and
               (s_st_int1_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      s_st_int1_savt <= transport Std.Standard.Now ;
      chk_st_int1 <= transport s_st_int1_cnt
          after (1 us - Std.Standard.Now) ;
      s_st_int1_cnt <= transport s_st_int1_cnt + 1 ;
--
   end process CHG7 ;
--
   PGEN_CHKP_7 :
   process ( chk_st_int1 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P7" ,
           "Transport transactions completed entirely",
           chk_st_int1 = 4 ) ;
      end if ;
   end process PGEN_CHKP_7 ;
--
--
      s_st_int1 <= transport
        c_st_int1_2 after 10 ns,
        c_st_int1_1 after 20 ns
        when st_int1_select = 1 else
--
        c_st_int1_2 after 10 ns ,
        c_st_int1_1 after 20 ns ,
        c_st_int1_2 after 30 ns ,
        c_st_int1_1 after 40 ns
        when st_int1_select = 2 else
--
        c_st_int1_1 after 5 ns ;
--
   CHG8 :
   process ( s_time )
      variable correct : boolean ;
   begin
      case s_time_cnt is
         when 0
         => null ;
              -- s_time <= transport
              --   c_time_2 after 10 ns,
              --   c_time_1 after 20 ns ;
--
         when 1
         => correct :=
               s_time =
                 c_time_2 and
               (s_time_savt + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_time =
                 c_time_1 and
               (s_time_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337.P8" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            time_select <= transport 2 ;
              -- s_time <= transport
              --   c_time_2 after 10 ns ,
              --   c_time_1 after 20 ns ,
              --   c_time_2 after 30 ns ,
              --   c_time_1 after 40 ns ;
--
         when 3
         => correct :=
               s_time =
                 c_time_2 and
               (s_time_savt + 10 ns) = Std.Standard.Now ;
            time_select <= transport 3 ;
              -- s_time <= transport
              --   c_time_1 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_time =
                 c_time_1 and
               (s_time_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      s_time_savt <= transport Std.Standard.Now ;
      chk_time <= transport s_time_cnt
          after (1 us - Std.Standard.Now) ;
      s_time_cnt <= transport s_time_cnt + 1 ;
--
   end process CHG8 ;
--
   PGEN_CHKP_8 :
   process ( chk_time )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P8" ,
           "Transport transactions completed entirely",
           chk_time = 4 ) ;
      end if ;
   end process PGEN_CHKP_8 ;
--
--
      s_time <= transport
        c_time_2 after 10 ns,
        c_time_1 after 20 ns
        when time_select = 1 else
--
        c_time_2 after 10 ns ,
        c_time_1 after 20 ns ,
        c_time_2 after 30 ns ,
        c_time_1 after 40 ns
        when time_select = 2 else
--
        c_time_1 after 5 ns ;
--
   CHG9 :
   process ( s_st_phys1 )
      variable correct : boolean ;
   begin
      case s_st_phys1_cnt is
         when 0
         => null ;
              -- s_st_phys1 <= transport
              --   c_st_phys1_2 after 10 ns,
              --   c_st_phys1_1 after 20 ns ;
--
         when 1
         => correct :=
               s_st_phys1 =
                 c_st_phys1_2 and
               (s_st_phys1_savt + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_phys1 =
                 c_st_phys1_1 and
               (s_st_phys1_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337.P9" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            st_phys1_select <= transport 2 ;
              -- s_st_phys1 <= transport
              --   c_st_phys1_2 after 10 ns ,
              --   c_st_phys1_1 after 20 ns ,
              --   c_st_phys1_2 after 30 ns ,
              --   c_st_phys1_1 after 40 ns ;
--
         when 3
         => correct :=
               s_st_phys1 =
                 c_st_phys1_2 and
               (s_st_phys1_savt + 10 ns) = Std.Standard.Now ;
            st_phys1_select <= transport 3 ;
              -- s_st_phys1 <= transport
              --   c_st_phys1_1 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_phys1 =
                 c_st_phys1_1 and
               (s_st_phys1_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      s_st_phys1_savt <= transport Std.Standard.Now ;
      chk_st_phys1 <= transport s_st_phys1_cnt
          after (1 us - Std.Standard.Now) ;
      s_st_phys1_cnt <= transport s_st_phys1_cnt + 1 ;
--
   end process CHG9 ;
--
   PGEN_CHKP_9 :
   process ( chk_st_phys1 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P9" ,
           "Transport transactions completed entirely",
           chk_st_phys1 = 4 ) ;
      end if ;
   end process PGEN_CHKP_9 ;
--
--
      s_st_phys1 <= transport
        c_st_phys1_2 after 10 ns,
        c_st_phys1_1 after 20 ns
        when st_phys1_select = 1 else
--
        c_st_phys1_2 after 10 ns ,
        c_st_phys1_1 after 20 ns ,
        c_st_phys1_2 after 30 ns ,
        c_st_phys1_1 after 40 ns
        when st_phys1_select = 2 else
--
        c_st_phys1_1 after 5 ns ;
--
   CHG10 :
   process ( s_real )
      variable correct : boolean ;
   begin
      case s_real_cnt is
         when 0
         => null ;
              -- s_real <= transport
              --   c_real_2 after 10 ns,
              --   c_real_1 after 20 ns ;
--
         when 1
         => correct :=
               s_real =
                 c_real_2 and
               (s_real_savt + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_real =
                 c_real_1 and
               (s_real_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337.P10" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            real_select <= transport 2 ;
              -- s_real <= transport
              --   c_real_2 after 10 ns ,
              --   c_real_1 after 20 ns ,
              --   c_real_2 after 30 ns ,
              --   c_real_1 after 40 ns ;
--
         when 3
         => correct :=
               s_real =
                 c_real_2 and
               (s_real_savt + 10 ns) = Std.Standard.Now ;
            real_select <= transport 3 ;
              -- s_real <= transport
              --   c_real_1 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_real =
                 c_real_1 and
               (s_real_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      s_real_savt <= transport Std.Standard.Now ;
      chk_real <= transport s_real_cnt
          after (1 us - Std.Standard.Now) ;
      s_real_cnt <= transport s_real_cnt + 1 ;
--
   end process CHG10 ;
--
   PGEN_CHKP_10 :
   process ( chk_real )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P10" ,
           "Transport transactions completed entirely",
           chk_real = 4 ) ;
      end if ;
   end process PGEN_CHKP_10 ;
--
--
      s_real <= transport
        c_real_2 after 10 ns,
        c_real_1 after 20 ns
        when real_select = 1 else
--
        c_real_2 after 10 ns ,
        c_real_1 after 20 ns ,
        c_real_2 after 30 ns ,
        c_real_1 after 40 ns
        when real_select = 2 else
--
        c_real_1 after 5 ns ;
--
   CHG11 :
   process ( s_st_real1 )
      variable correct : boolean ;
   begin
      case s_st_real1_cnt is
         when 0
         => null ;
              -- s_st_real1 <= transport
              --   c_st_real1_2 after 10 ns,
              --   c_st_real1_1 after 20 ns ;
--
         when 1
         => correct :=
               s_st_real1 =
                 c_st_real1_2 and
               (s_st_real1_savt + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_real1 =
                 c_st_real1_1 and
               (s_st_real1_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337.P11" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            st_real1_select <= transport 2 ;
              -- s_st_real1 <= transport
              --   c_st_real1_2 after 10 ns ,
              --   c_st_real1_1 after 20 ns ,
              --   c_st_real1_2 after 30 ns ,
              --   c_st_real1_1 after 40 ns ;
--
         when 3
         => correct :=
               s_st_real1 =
                 c_st_real1_2 and
               (s_st_real1_savt + 10 ns) = Std.Standard.Now ;
            st_real1_select <= transport 3 ;
              -- s_st_real1 <= transport
              --   c_st_real1_1 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_real1 =
                 c_st_real1_1 and
               (s_st_real1_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      s_st_real1_savt <= transport Std.Standard.Now ;
      chk_st_real1 <= transport s_st_real1_cnt
          after (1 us - Std.Standard.Now) ;
      s_st_real1_cnt <= transport s_st_real1_cnt + 1 ;
--
   end process CHG11 ;
--
   PGEN_CHKP_11 :
   process ( chk_st_real1 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P11" ,
           "Transport transactions completed entirely",
           chk_st_real1 = 4 ) ;
      end if ;
   end process PGEN_CHKP_11 ;
--
--
      s_st_real1 <= transport
        c_st_real1_2 after 10 ns,
        c_st_real1_1 after 20 ns
        when st_real1_select = 1 else
--
        c_st_real1_2 after 10 ns ,
        c_st_real1_1 after 20 ns ,
        c_st_real1_2 after 30 ns ,
        c_st_real1_1 after 40 ns
        when st_real1_select = 2 else
--
        c_st_real1_1 after 5 ns ;
--
   CHG12 :
   process ( s_st_rec1 )
      variable correct : boolean ;
   begin
      case s_st_rec1_cnt is
         when 0
         => null ;
              -- s_st_rec1 <= transport
              --   c_st_rec1_2 after 10 ns,
              --   c_st_rec1_1 after 20 ns ;
--
         when 1
         => correct :=
               s_st_rec1 =
                 c_st_rec1_2 and
               (s_st_rec1_savt + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_rec1 =
                 c_st_rec1_1 and
               (s_st_rec1_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337.P12" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            st_rec1_select <= transport 2 ;
              -- s_st_rec1 <= transport
              --   c_st_rec1_2 after 10 ns ,
              --   c_st_rec1_1 after 20 ns ,
              --   c_st_rec1_2 after 30 ns ,
              --   c_st_rec1_1 after 40 ns ;
--
         when 3
         => correct :=
               s_st_rec1 =
                 c_st_rec1_2 and
               (s_st_rec1_savt + 10 ns) = Std.Standard.Now ;
            st_rec1_select <= transport 3 ;
              -- s_st_rec1 <= transport
              --   c_st_rec1_1 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_rec1 =
                 c_st_rec1_1 and
               (s_st_rec1_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      s_st_rec1_savt <= transport Std.Standard.Now ;
      chk_st_rec1 <= transport s_st_rec1_cnt
          after (1 us - Std.Standard.Now) ;
      s_st_rec1_cnt <= transport s_st_rec1_cnt + 1 ;
--
   end process CHG12 ;
--
   PGEN_CHKP_12 :
   process ( chk_st_rec1 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P12" ,
           "Transport transactions completed entirely",
           chk_st_rec1 = 4 ) ;
      end if ;
   end process PGEN_CHKP_12 ;
--
--
      s_st_rec1 <= transport
        c_st_rec1_2 after 10 ns,
        c_st_rec1_1 after 20 ns
        when st_rec1_select = 1 else
--
        c_st_rec1_2 after 10 ns ,
        c_st_rec1_1 after 20 ns ,
        c_st_rec1_2 after 30 ns ,
        c_st_rec1_1 after 40 ns
        when st_rec1_select = 2 else
--
        c_st_rec1_1 after 5 ns ;
--
   CHG13 :
   process ( s_st_rec2 )
      variable correct : boolean ;
   begin
      case s_st_rec2_cnt is
         when 0
         => null ;
              -- s_st_rec2 <= transport
              --   c_st_rec2_2 after 10 ns,
              --   c_st_rec2_1 after 20 ns ;
--
         when 1
         => correct :=
               s_st_rec2 =
                 c_st_rec2_2 and
               (s_st_rec2_savt + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_rec2 =
                 c_st_rec2_1 and
               (s_st_rec2_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337.P13" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            st_rec2_select <= transport 2 ;
              -- s_st_rec2 <= transport
              --   c_st_rec2_2 after 10 ns ,
              --   c_st_rec2_1 after 20 ns ,
              --   c_st_rec2_2 after 30 ns ,
              --   c_st_rec2_1 after 40 ns ;
--
         when 3
         => correct :=
               s_st_rec2 =
                 c_st_rec2_2 and
               (s_st_rec2_savt + 10 ns) = Std.Standard.Now ;
            st_rec2_select <= transport 3 ;
              -- s_st_rec2 <= transport
              --   c_st_rec2_1 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_rec2 =
                 c_st_rec2_1 and
               (s_st_rec2_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      s_st_rec2_savt <= transport Std.Standard.Now ;
      chk_st_rec2 <= transport s_st_rec2_cnt
          after (1 us - Std.Standard.Now) ;
      s_st_rec2_cnt <= transport s_st_rec2_cnt + 1 ;
--
   end process CHG13 ;
--
   PGEN_CHKP_13 :
   process ( chk_st_rec2 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P13" ,
           "Transport transactions completed entirely",
           chk_st_rec2 = 4 ) ;
      end if ;
   end process PGEN_CHKP_13 ;
--
--
      s_st_rec2 <= transport
        c_st_rec2_2 after 10 ns,
        c_st_rec2_1 after 20 ns
        when st_rec2_select = 1 else
--
        c_st_rec2_2 after 10 ns ,
        c_st_rec2_1 after 20 ns ,
        c_st_rec2_2 after 30 ns ,
        c_st_rec2_1 after 40 ns
        when st_rec2_select = 2 else
--
        c_st_rec2_1 after 5 ns ;
--
   CHG14 :
   process ( s_st_rec3 )
      variable correct : boolean ;
   begin
      case s_st_rec3_cnt is
         when 0
         => null ;
              -- s_st_rec3 <= transport
              --   c_st_rec3_2 after 10 ns,
              --   c_st_rec3_1 after 20 ns ;
--
         when 1
         => correct :=
               s_st_rec3 =
                 c_st_rec3_2 and
               (s_st_rec3_savt + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_rec3 =
                 c_st_rec3_1 and
               (s_st_rec3_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337.P14" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            st_rec3_select <= transport 2 ;
              -- s_st_rec3 <= transport
              --   c_st_rec3_2 after 10 ns ,
              --   c_st_rec3_1 after 20 ns ,
              --   c_st_rec3_2 after 30 ns ,
              --   c_st_rec3_1 after 40 ns ;
--
         when 3
         => correct :=
               s_st_rec3 =
                 c_st_rec3_2 and
               (s_st_rec3_savt + 10 ns) = Std.Standard.Now ;
            st_rec3_select <= transport 3 ;
              -- s_st_rec3 <= transport
              --   c_st_rec3_1 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_rec3 =
                 c_st_rec3_1 and
               (s_st_rec3_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      s_st_rec3_savt <= transport Std.Standard.Now ;
      chk_st_rec3 <= transport s_st_rec3_cnt
          after (1 us - Std.Standard.Now) ;
      s_st_rec3_cnt <= transport s_st_rec3_cnt + 1 ;
--
   end process CHG14 ;
--
   PGEN_CHKP_14 :
   process ( chk_st_rec3 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P14" ,
           "Transport transactions completed entirely",
           chk_st_rec3 = 4 ) ;
      end if ;
   end process PGEN_CHKP_14 ;
--
--
      s_st_rec3 <= transport
        c_st_rec3_2 after 10 ns,
        c_st_rec3_1 after 20 ns
        when st_rec3_select = 1 else
--
        c_st_rec3_2 after 10 ns ,
        c_st_rec3_1 after 20 ns ,
        c_st_rec3_2 after 30 ns ,
        c_st_rec3_1 after 40 ns
        when st_rec3_select = 2 else
--
        c_st_rec3_1 after 5 ns ;
--
   CHG15 :
   process ( s_st_arr1 )
      variable correct : boolean ;
   begin
      case s_st_arr1_cnt is
         when 0
         => null ;
              -- s_st_arr1 <= transport
              --   c_st_arr1_2 after 10 ns,
              --   c_st_arr1_1 after 20 ns ;
--
         when 1
         => correct :=
               s_st_arr1 =
                 c_st_arr1_2 and
               (s_st_arr1_savt + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_arr1 =
                 c_st_arr1_1 and
               (s_st_arr1_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337.P15" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            st_arr1_select <= transport 2 ;
              -- s_st_arr1 <= transport
              --   c_st_arr1_2 after 10 ns ,
              --   c_st_arr1_1 after 20 ns ,
              --   c_st_arr1_2 after 30 ns ,
              --   c_st_arr1_1 after 40 ns ;
--
         when 3
         => correct :=
               s_st_arr1 =
                 c_st_arr1_2 and
               (s_st_arr1_savt + 10 ns) = Std.Standard.Now ;
            st_arr1_select <= transport 3 ;
              -- s_st_arr1 <= transport
              --   c_st_arr1_1 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_arr1 =
                 c_st_arr1_1 and
               (s_st_arr1_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      s_st_arr1_savt <= transport Std.Standard.Now ;
      chk_st_arr1 <= transport s_st_arr1_cnt
          after (1 us - Std.Standard.Now) ;
      s_st_arr1_cnt <= transport s_st_arr1_cnt + 1 ;
--
   end process CHG15 ;
--
   PGEN_CHKP_15 :
   process ( chk_st_arr1 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P15" ,
           "Transport transactions completed entirely",
           chk_st_arr1 = 4 ) ;
      end if ;
   end process PGEN_CHKP_15 ;
--
--
      s_st_arr1 <= transport
        c_st_arr1_2 after 10 ns,
        c_st_arr1_1 after 20 ns
        when st_arr1_select = 1 else
--
        c_st_arr1_2 after 10 ns ,
        c_st_arr1_1 after 20 ns ,
        c_st_arr1_2 after 30 ns ,
        c_st_arr1_1 after 40 ns
        when st_arr1_select = 2 else
--
        c_st_arr1_1 after 5 ns ;
--
   CHG16 :
   process ( s_st_arr2 )
      variable correct : boolean ;
   begin
      case s_st_arr2_cnt is
         when 0
         => null ;
              -- s_st_arr2 <= transport
              --   c_st_arr2_2 after 10 ns,
              --   c_st_arr2_1 after 20 ns ;
--
         when 1
         => correct :=
               s_st_arr2 =
                 c_st_arr2_2 and
               (s_st_arr2_savt + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_arr2 =
                 c_st_arr2_1 and
               (s_st_arr2_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337.P16" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            st_arr2_select <= transport 2 ;
              -- s_st_arr2 <= transport
              --   c_st_arr2_2 after 10 ns ,
              --   c_st_arr2_1 after 20 ns ,
              --   c_st_arr2_2 after 30 ns ,
              --   c_st_arr2_1 after 40 ns ;
--
         when 3
         => correct :=
               s_st_arr2 =
                 c_st_arr2_2 and
               (s_st_arr2_savt + 10 ns) = Std.Standard.Now ;
            st_arr2_select <= transport 3 ;
              -- s_st_arr2 <= transport
              --   c_st_arr2_1 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_arr2 =
                 c_st_arr2_1 and
               (s_st_arr2_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      s_st_arr2_savt <= transport Std.Standard.Now ;
      chk_st_arr2 <= transport s_st_arr2_cnt
          after (1 us - Std.Standard.Now) ;
      s_st_arr2_cnt <= transport s_st_arr2_cnt + 1 ;
--
   end process CHG16 ;
--
   PGEN_CHKP_16 :
   process ( chk_st_arr2 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P16" ,
           "Transport transactions completed entirely",
           chk_st_arr2 = 4 ) ;
      end if ;
   end process PGEN_CHKP_16 ;
--
--
      s_st_arr2 <= transport
        c_st_arr2_2 after 10 ns,
        c_st_arr2_1 after 20 ns
        when st_arr2_select = 1 else
--
        c_st_arr2_2 after 10 ns ,
        c_st_arr2_1 after 20 ns ,
        c_st_arr2_2 after 30 ns ,
        c_st_arr2_1 after 40 ns
        when st_arr2_select = 2 else
--
        c_st_arr2_1 after 5 ns ;
--
   CHG17 :
   process ( s_st_arr3 )
      variable correct : boolean ;
   begin
      case s_st_arr3_cnt is
         when 0
         => null ;
              -- s_st_arr3 <= transport
              --   c_st_arr3_2 after 10 ns,
              --   c_st_arr3_1 after 20 ns ;
--
         when 1
         => correct :=
               s_st_arr3 =
                 c_st_arr3_2 and
               (s_st_arr3_savt + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_arr3 =
                 c_st_arr3_1 and
               (s_st_arr3_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337.P17" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            st_arr3_select <= transport 2 ;
              -- s_st_arr3 <= transport
              --   c_st_arr3_2 after 10 ns ,
              --   c_st_arr3_1 after 20 ns ,
              --   c_st_arr3_2 after 30 ns ,
              --   c_st_arr3_1 after 40 ns ;
--
         when 3
         => correct :=
               s_st_arr3 =
                 c_st_arr3_2 and
               (s_st_arr3_savt + 10 ns) = Std.Standard.Now ;
            st_arr3_select <= transport 3 ;
              -- s_st_arr3 <= transport
              --   c_st_arr3_1 after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_arr3 =
                 c_st_arr3_1 and
               (s_st_arr3_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00337" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00337" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      s_st_arr3_savt <= transport Std.Standard.Now ;
      chk_st_arr3 <= transport s_st_arr3_cnt
          after (1 us - Std.Standard.Now) ;
      s_st_arr3_cnt <= transport s_st_arr3_cnt + 1 ;
--
   end process CHG17 ;
--
   PGEN_CHKP_17 :
   process ( chk_st_arr3 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P17" ,
           "Transport transactions completed entirely",
           chk_st_arr3 = 4 ) ;
      end if ;
   end process PGEN_CHKP_17 ;
--
--
      s_st_arr3 <= transport
        c_st_arr3_2 after 10 ns,
        c_st_arr3_1 after 20 ns
        when st_arr3_select = 1 else
--
        c_st_arr3_2 after 10 ns ,
        c_st_arr3_1 after 20 ns ,
        c_st_arr3_2 after 30 ns ,
        c_st_arr3_1 after 40 ns
        when st_arr3_select = 2 else
--
        c_st_arr3_1 after 5 ns ;
--
end ARCH00337 ;
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00337_Test_Bench is
end ENT00337_Test_Bench ;
--
--
architecture ARCH00337_Test_Bench of ENT00337_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00337 ( ARCH00337 ) ;
   begin
      CIS1 : UUT
         ;
   end block L1 ;
end ARCH00337_Test_Bench ;
