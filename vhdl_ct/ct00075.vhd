-- NEED RESULT: ARCH00075.P1: Multi transport transactions occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075.P2: Multi transport transactions occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075.P3: Multi transport transactions occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075.P4: Multi transport transactions occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075.P5: Multi transport transactions occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075.P6: Multi transport transactions occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075.P7: Multi transport transactions occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075.P8: Multi transport transactions occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075.P9: Multi transport transactions occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075.P10: Multi transport transactions occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075.P11: Multi transport transactions occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075.P12: Multi transport transactions occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075.P13: Multi transport transactions occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075.P14: Multi transport transactions occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075.P15: Multi transport transactions occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075.P16: Multi transport transactions occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075.P17: Multi transport transactions occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: One transport transaction occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: Old transactions were removed on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: One transport transaction occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: Old transactions were removed on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: One transport transaction occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: Old transactions were removed on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: One transport transaction occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: Old transactions were removed on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: One transport transaction occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: Old transactions were removed on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: One transport transaction occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: Old transactions were removed on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: One transport transaction occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: Old transactions were removed on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: One transport transaction occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: Old transactions were removed on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: One transport transaction occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: Old transactions were removed on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: One transport transaction occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: Old transactions were removed on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: One transport transaction occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: Old transactions were removed on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: One transport transaction occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: Old transactions were removed on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: One transport transaction occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: Old transactions were removed on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: One transport transaction occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: Old transactions were removed on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: One transport transaction occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: Old transactions were removed on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: One transport transaction occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: Old transactions were removed on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: One transport transaction occurred on signal asg with simple name on LHS passed
-- NEED RESULT: ARCH00075: Old transactions were removed on signal asg with simple name on LHS passed
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
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00075
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
--    ENT00075(ARCH00075)
--    ENT00075_Test_Bench(ARCH00075_Test_Bench)
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
entity ENT00075 is
   port (
        s_boolean : inout boolean
      ; s_bit : inout bit
      ; s_severity_level : inout severity_level
      ; s_character : inout character
      ; s_st_enum1 : inout st_enum1
      ; s_integer : inout integer
      ; s_st_int1 : inout st_int1
      ; s_time : inout time
      ; s_st_phys1 : inout st_phys1
      ; s_real : inout real
      ; s_st_real1 : inout st_real1
      ; s_st_rec1 : inout st_rec1
      ; s_st_rec2 : inout st_rec2
      ; s_st_rec3 : inout st_rec3
      ; s_st_arr1 : inout st_arr1
      ; s_st_arr2 : inout st_arr2
      ; s_st_arr3 : inout st_arr3
        ) ;
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
end ENT00075 ;
--
architecture ARCH00075 of ENT00075 is
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
   process ( s_boolean )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => s_boolean <= transport
                  c_boolean_2 after 10 ns,
                  c_boolean_1 after 20 ns ;
--
            when 1
            => correct :=
                  s_boolean = c_boolean_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_boolean = c_boolean_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075.P1" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               s_boolean <= transport
                  c_boolean_2 after 10 ns ,
                  c_boolean_1 after 20 ns ,
                  c_boolean_2 after 30 ns ,
                  c_boolean_1 after 40 ns ;
--
            when 3
            => correct :=
                  s_boolean = c_boolean_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               s_boolean <= transport c_boolean_1 after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_boolean = c_boolean_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075" ,
                 "One transport transaction occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
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
   process ( s_bit )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => s_bit <= transport
                  c_bit_2 after 10 ns,
                  c_bit_1 after 20 ns ;
--
            when 1
            => correct :=
                  s_bit = c_bit_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_bit = c_bit_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075.P2" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               s_bit <= transport
                  c_bit_2 after 10 ns ,
                  c_bit_1 after 20 ns ,
                  c_bit_2 after 30 ns ,
                  c_bit_1 after 40 ns ;
--
            when 3
            => correct :=
                  s_bit = c_bit_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               s_bit <= transport c_bit_1 after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_bit = c_bit_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075" ,
                 "One transport transaction occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
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
   process ( s_severity_level )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => s_severity_level <= transport
                  c_severity_level_2 after 10 ns,
                  c_severity_level_1 after 20 ns ;
--
            when 1
            => correct :=
                  s_severity_level = c_severity_level_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_severity_level = c_severity_level_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075.P3" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               s_severity_level <= transport
                  c_severity_level_2 after 10 ns ,
                  c_severity_level_1 after 20 ns ,
                  c_severity_level_2 after 30 ns ,
                  c_severity_level_1 after 40 ns ;
--
            when 3
            => correct :=
                  s_severity_level = c_severity_level_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               s_severity_level <= transport c_severity_level_1 after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_severity_level = c_severity_level_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075" ,
                 "One transport transaction occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
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
   process ( s_character )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => s_character <= transport
                  c_character_2 after 10 ns,
                  c_character_1 after 20 ns ;
--
            when 1
            => correct :=
                  s_character = c_character_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_character = c_character_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075.P4" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               s_character <= transport
                  c_character_2 after 10 ns ,
                  c_character_1 after 20 ns ,
                  c_character_2 after 30 ns ,
                  c_character_1 after 40 ns ;
--
            when 3
            => correct :=
                  s_character = c_character_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               s_character <= transport c_character_1 after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_character = c_character_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075" ,
                 "One transport transaction occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
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
   process ( s_st_enum1 )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => s_st_enum1 <= transport
                  c_st_enum1_2 after 10 ns,
                  c_st_enum1_1 after 20 ns ;
--
            when 1
            => correct :=
                  s_st_enum1 = c_st_enum1_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_st_enum1 = c_st_enum1_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075.P5" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               s_st_enum1 <= transport
                  c_st_enum1_2 after 10 ns ,
                  c_st_enum1_1 after 20 ns ,
                  c_st_enum1_2 after 30 ns ,
                  c_st_enum1_1 after 40 ns ;
--
            when 3
            => correct :=
                  s_st_enum1 = c_st_enum1_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               s_st_enum1 <= transport c_st_enum1_1 after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_st_enum1 = c_st_enum1_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075" ,
                 "One transport transaction occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
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
   process ( s_integer )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => s_integer <= transport
                  c_integer_2 after 10 ns,
                  c_integer_1 after 20 ns ;
--
            when 1
            => correct :=
                  s_integer = c_integer_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_integer = c_integer_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075.P6" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               s_integer <= transport
                  c_integer_2 after 10 ns ,
                  c_integer_1 after 20 ns ,
                  c_integer_2 after 30 ns ,
                  c_integer_1 after 40 ns ;
--
            when 3
            => correct :=
                  s_integer = c_integer_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               s_integer <= transport c_integer_1 after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_integer = c_integer_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075" ,
                 "One transport transaction occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
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
   process ( s_st_int1 )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => s_st_int1 <= transport
                  c_st_int1_2 after 10 ns,
                  c_st_int1_1 after 20 ns ;
--
            when 1
            => correct :=
                  s_st_int1 = c_st_int1_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_st_int1 = c_st_int1_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075.P7" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               s_st_int1 <= transport
                  c_st_int1_2 after 10 ns ,
                  c_st_int1_1 after 20 ns ,
                  c_st_int1_2 after 30 ns ,
                  c_st_int1_1 after 40 ns ;
--
            when 3
            => correct :=
                  s_st_int1 = c_st_int1_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               s_st_int1 <= transport c_st_int1_1 after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_st_int1 = c_st_int1_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075" ,
                 "One transport transaction occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
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
   process ( s_time )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => s_time <= transport
                  c_time_2 after 10 ns,
                  c_time_1 after 20 ns ;
--
            when 1
            => correct :=
                  s_time = c_time_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_time = c_time_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075.P8" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               s_time <= transport
                  c_time_2 after 10 ns ,
                  c_time_1 after 20 ns ,
                  c_time_2 after 30 ns ,
                  c_time_1 after 40 ns ;
--
            when 3
            => correct :=
                  s_time = c_time_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               s_time <= transport c_time_1 after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_time = c_time_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075" ,
                 "One transport transaction occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
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
   process ( s_st_phys1 )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => s_st_phys1 <= transport
                  c_st_phys1_2 after 10 ns,
                  c_st_phys1_1 after 20 ns ;
--
            when 1
            => correct :=
                  s_st_phys1 = c_st_phys1_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_st_phys1 = c_st_phys1_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075.P9" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               s_st_phys1 <= transport
                  c_st_phys1_2 after 10 ns ,
                  c_st_phys1_1 after 20 ns ,
                  c_st_phys1_2 after 30 ns ,
                  c_st_phys1_1 after 40 ns ;
--
            when 3
            => correct :=
                  s_st_phys1 = c_st_phys1_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               s_st_phys1 <= transport c_st_phys1_1 after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_st_phys1 = c_st_phys1_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075" ,
                 "One transport transaction occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
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
   process ( s_real )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => s_real <= transport
                  c_real_2 after 10 ns,
                  c_real_1 after 20 ns ;
--
            when 1
            => correct :=
                  s_real = c_real_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_real = c_real_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075.P10" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               s_real <= transport
                  c_real_2 after 10 ns ,
                  c_real_1 after 20 ns ,
                  c_real_2 after 30 ns ,
                  c_real_1 after 40 ns ;
--
            when 3
            => correct :=
                  s_real = c_real_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               s_real <= transport c_real_1 after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_real = c_real_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075" ,
                 "One transport transaction occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
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
   process ( s_st_real1 )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => s_st_real1 <= transport
                  c_st_real1_2 after 10 ns,
                  c_st_real1_1 after 20 ns ;
--
            when 1
            => correct :=
                  s_st_real1 = c_st_real1_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_st_real1 = c_st_real1_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075.P11" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               s_st_real1 <= transport
                  c_st_real1_2 after 10 ns ,
                  c_st_real1_1 after 20 ns ,
                  c_st_real1_2 after 30 ns ,
                  c_st_real1_1 after 40 ns ;
--
            when 3
            => correct :=
                  s_st_real1 = c_st_real1_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               s_st_real1 <= transport c_st_real1_1 after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_st_real1 = c_st_real1_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075" ,
                 "One transport transaction occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
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
   process ( s_st_rec1 )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => s_st_rec1 <= transport
                  c_st_rec1_2 after 10 ns,
                  c_st_rec1_1 after 20 ns ;
--
            when 1
            => correct :=
                  s_st_rec1 = c_st_rec1_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_st_rec1 = c_st_rec1_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075.P12" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               s_st_rec1 <= transport
                  c_st_rec1_2 after 10 ns ,
                  c_st_rec1_1 after 20 ns ,
                  c_st_rec1_2 after 30 ns ,
                  c_st_rec1_1 after 40 ns ;
--
            when 3
            => correct :=
                  s_st_rec1 = c_st_rec1_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               s_st_rec1 <= transport c_st_rec1_1 after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_st_rec1 = c_st_rec1_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075" ,
                 "One transport transaction occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
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
   process ( s_st_rec2 )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => s_st_rec2 <= transport
                  c_st_rec2_2 after 10 ns,
                  c_st_rec2_1 after 20 ns ;
--
            when 1
            => correct :=
                  s_st_rec2 = c_st_rec2_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_st_rec2 = c_st_rec2_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075.P13" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               s_st_rec2 <= transport
                  c_st_rec2_2 after 10 ns ,
                  c_st_rec2_1 after 20 ns ,
                  c_st_rec2_2 after 30 ns ,
                  c_st_rec2_1 after 40 ns ;
--
            when 3
            => correct :=
                  s_st_rec2 = c_st_rec2_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               s_st_rec2 <= transport c_st_rec2_1 after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_st_rec2 = c_st_rec2_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075" ,
                 "One transport transaction occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
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
   process ( s_st_rec3 )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => s_st_rec3 <= transport
                  c_st_rec3_2 after 10 ns,
                  c_st_rec3_1 after 20 ns ;
--
            when 1
            => correct :=
                  s_st_rec3 = c_st_rec3_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_st_rec3 = c_st_rec3_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075.P14" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               s_st_rec3 <= transport
                  c_st_rec3_2 after 10 ns ,
                  c_st_rec3_1 after 20 ns ,
                  c_st_rec3_2 after 30 ns ,
                  c_st_rec3_1 after 40 ns ;
--
            when 3
            => correct :=
                  s_st_rec3 = c_st_rec3_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               s_st_rec3 <= transport c_st_rec3_1 after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_st_rec3 = c_st_rec3_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075" ,
                 "One transport transaction occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
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
   process ( s_st_arr1 )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => s_st_arr1 <= transport
                  c_st_arr1_2 after 10 ns,
                  c_st_arr1_1 after 20 ns ;
--
            when 1
            => correct :=
                  s_st_arr1 = c_st_arr1_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_st_arr1 = c_st_arr1_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075.P15" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               s_st_arr1 <= transport
                  c_st_arr1_2 after 10 ns ,
                  c_st_arr1_1 after 20 ns ,
                  c_st_arr1_2 after 30 ns ,
                  c_st_arr1_1 after 40 ns ;
--
            when 3
            => correct :=
                  s_st_arr1 = c_st_arr1_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               s_st_arr1 <= transport c_st_arr1_1 after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_st_arr1 = c_st_arr1_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075" ,
                 "One transport transaction occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
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
   process ( s_st_arr2 )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => s_st_arr2 <= transport
                  c_st_arr2_2 after 10 ns,
                  c_st_arr2_1 after 20 ns ;
--
            when 1
            => correct :=
                  s_st_arr2 = c_st_arr2_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_st_arr2 = c_st_arr2_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075.P16" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               s_st_arr2 <= transport
                  c_st_arr2_2 after 10 ns ,
                  c_st_arr2_1 after 20 ns ,
                  c_st_arr2_2 after 30 ns ,
                  c_st_arr2_1 after 40 ns ;
--
            when 3
            => correct :=
                  s_st_arr2 = c_st_arr2_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               s_st_arr2 <= transport c_st_arr2_1 after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_st_arr2 = c_st_arr2_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075" ,
                 "One transport transaction occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
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
   process ( s_st_arr3 )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
--
      procedure Proc1 is
      begin
         case counter is
            when 0
            => s_st_arr3 <= transport
                  c_st_arr3_2 after 10 ns,
                  c_st_arr3_1 after 20 ns ;
--
            when 1
            => correct :=
                  s_st_arr3 = c_st_arr3_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
--
            when 2
            => correct :=
                  correct and
                  s_st_arr3 = c_st_arr3_1 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075.P17" ,
                 "Multi transport transactions occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               s_st_arr3 <= transport
                  c_st_arr3_2 after 10 ns ,
                  c_st_arr3_1 after 20 ns ,
                  c_st_arr3_2 after 30 ns ,
                  c_st_arr3_1 after 40 ns ;
--
            when 3
            => correct :=
                  s_st_arr3 = c_st_arr3_2 and
                  (savtime + 10 ns) = Std.Standard.Now ;
               s_st_arr3 <= transport c_st_arr3_1 after 5 ns ;
--
            when 4
            => correct :=
                  correct and
                  s_st_arr3 = c_st_arr3_1 and
                  (savtime + 5 ns) = Std.Standard.Now ;
               test_report ( "ARCH00075" ,
                 "One transport transaction occurred on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
                 correct ) ;
--
            when others
            => -- No more transactions should have occurred
               test_report ( "ARCH00075" ,
                 "Old transactions were removed on signal " &
                 "asg with simple name on LHS",
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
   end process P17 ;
--
--
end ARCH00075 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00075_Test_Bench is
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
end ENT00075_Test_Bench ;
--
architecture ARCH00075_Test_Bench of ENT00075_Test_Bench is
begin
   L1:
   block
      component UUT
         port (
              s_boolean : inout boolean
            ; s_bit : inout bit
            ; s_severity_level : inout severity_level
            ; s_character : inout character
            ; s_st_enum1 : inout st_enum1
            ; s_integer : inout integer
            ; s_st_int1 : inout st_int1
            ; s_time : inout time
            ; s_st_phys1 : inout st_phys1
            ; s_real : inout real
            ; s_st_real1 : inout st_real1
            ; s_st_rec1 : inout st_rec1
            ; s_st_rec2 : inout st_rec2
            ; s_st_rec3 : inout st_rec3
            ; s_st_arr1 : inout st_arr1
            ; s_st_arr2 : inout st_arr2
            ; s_st_arr3 : inout st_arr3
              ) ;
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00075 ( ARCH00075 ) ;
   begin
      CIS1 : UUT
         port map (
              s_boolean
            , s_bit
            , s_severity_level
            , s_character
            , s_st_enum1
            , s_integer
            , s_st_int1
            , s_time
            , s_st_phys1
            , s_real
            , s_st_real1
            , s_st_rec1
            , s_st_rec2
            , s_st_rec3
            , s_st_arr1
            , s_st_arr2
            , s_st_arr3
                  ) ;
   end block L1 ;
end ARCH00075_Test_Bench ;
