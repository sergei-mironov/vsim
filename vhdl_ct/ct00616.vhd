-- NEED RESULT: ARCH00616: Concurrent proc call 1 passed
-- NEED RESULT: ARCH00616: Concurrent proc call 1 passed
-- NEED RESULT: ARCH00616: Concurrent proc call 1 passed
-- NEED RESULT: ARCH00616: Concurrent proc call 1 passed
-- NEED RESULT: ARCH00616: Concurrent proc call 1 passed
-- NEED RESULT: ARCH00616: Concurrent proc call 1 passed
-- NEED RESULT: ARCH00616: Concurrent proc call 1 passed
-- NEED RESULT: ARCH00616: Concurrent proc call 1 passed
-- NEED RESULT: ARCH00616: Concurrent proc call 1 passed
-- NEED RESULT: ARCH00616.P1: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00616.P2: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00616.P3: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00616.P4: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00616.P5: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00616.P6: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00616.P7: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00616.P8: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00616.P9: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00616: Concurrent proc call 2 passed
-- NEED RESULT: ARCH00616: Concurrent proc call 2 passed
-- NEED RESULT: ARCH00616: Concurrent proc call 2 passed
-- NEED RESULT: ARCH00616: Concurrent proc call 2 passed
-- NEED RESULT: ARCH00616: Concurrent proc call 2 passed
-- NEED RESULT: ARCH00616: Concurrent proc call 2 passed
-- NEED RESULT: ARCH00616: Concurrent proc call 2 passed
-- NEED RESULT: ARCH00616: Concurrent proc call 2 passed
-- NEED RESULT: ARCH00616: Concurrent proc call 2 passed
-- NEED RESULT: ARCH00616: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00616: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00616: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00616: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00616: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00616: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00616: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00616: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00616: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00616: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00616: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00616: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00616: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00616: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00616: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00616: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00616: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00616: Old transactions were removed on a concurrent signal asg passed
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
--    CT00616
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
--    ENT00616(ARCH00616)
--    ENT00616_Test_Bench(ARCH00616_Test_Bench)
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
entity ENT00616 is
   port (
        s_st_boolean_vector : inout st_boolean_vector
      ; s_st_severity_level_vector : inout st_severity_level_vector
      ; s_st_string : inout st_string
      ; s_st_enum1_vector : inout st_enum1_vector
      ; s_st_integer_vector : inout st_integer_vector
      ; s_st_time_vector : inout st_time_vector
      ; s_st_real_vector : inout st_real_vector
      ; s_st_rec1_vector : inout st_rec1_vector
      ; s_st_arr2_vector : inout st_arr2_vector
        ) ;
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_st_boolean_vector : chk_sig_type := -1 ;
   signal chk_st_severity_level_vector : chk_sig_type := -1 ;
   signal chk_st_string : chk_sig_type := -1 ;
   signal chk_st_enum1_vector : chk_sig_type := -1 ;
   signal chk_st_integer_vector : chk_sig_type := -1 ;
   signal chk_st_time_vector : chk_sig_type := -1 ;
   signal chk_st_real_vector : chk_sig_type := -1 ;
   signal chk_st_rec1_vector : chk_sig_type := -1 ;
   signal chk_st_arr2_vector : chk_sig_type := -1 ;
--
end ENT00616 ;
--
--
architecture ARCH00616 of ENT00616 is
   subtype chk_time_type is Time ;
   signal s_st_boolean_vector_savt : chk_time_type := 0 ns ;
   signal s_st_severity_level_vector_savt : chk_time_type := 0 ns ;
   signal s_st_string_savt : chk_time_type := 0 ns ;
   signal s_st_enum1_vector_savt : chk_time_type := 0 ns ;
   signal s_st_integer_vector_savt : chk_time_type := 0 ns ;
   signal s_st_time_vector_savt : chk_time_type := 0 ns ;
   signal s_st_real_vector_savt : chk_time_type := 0 ns ;
   signal s_st_rec1_vector_savt : chk_time_type := 0 ns ;
   signal s_st_arr2_vector_savt : chk_time_type := 0 ns ;
--
   subtype chk_cnt_type is Integer ;
   signal s_st_boolean_vector_cnt : chk_cnt_type := 0 ;
   signal s_st_severity_level_vector_cnt : chk_cnt_type := 0 ;
   signal s_st_string_cnt : chk_cnt_type := 0 ;
   signal s_st_enum1_vector_cnt : chk_cnt_type := 0 ;
   signal s_st_integer_vector_cnt : chk_cnt_type := 0 ;
   signal s_st_time_vector_cnt : chk_cnt_type := 0 ;
   signal s_st_real_vector_cnt : chk_cnt_type := 0 ;
   signal s_st_rec1_vector_cnt : chk_cnt_type := 0 ;
   signal s_st_arr2_vector_cnt : chk_cnt_type := 0 ;
--
   type select_type is range 1 to 3 ;
   signal st_boolean_vector_select : select_type := 1 ;
   signal st_severity_level_vector_select : select_type := 1 ;
   signal st_string_select : select_type := 1 ;
   signal st_enum1_vector_select : select_type := 1 ;
   signal st_integer_vector_select : select_type := 1 ;
   signal st_time_vector_select : select_type := 1 ;
   signal st_real_vector_select : select_type := 1 ;
   signal st_rec1_vector_select : select_type := 1 ;
   signal st_arr2_vector_select : select_type := 1 ;
--
   procedure P1
      (signal s_st_boolean_vector : in st_boolean_vector ;
       signal select_sig : out Select_Type ;
       signal savtime : out Chk_Time_Type ;
       signal chk_sig : out Chk_Sig_Type ;
       signal count : out Integer)
   is
      variable correct : boolean ;
   begin
      case s_st_boolean_vector_cnt is
         when 0
         => null ;
              -- s_st_boolean_vector(lowb to highb-1) <= transport
              --   c_st_boolean_vector_2(lowb to highb-1) after 10 ns,
              --   c_st_boolean_vector_1(lowb to highb-1) after 20 ns ;
--
         when 1
         => correct :=
               s_st_boolean_vector(lowb to highb-1) =
                 c_st_boolean_vector_2(lowb to highb-1) and
               (s_st_boolean_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "Concurrent proc call 1",
              correct ) ;
--
         when 2
         => correct :=
               s_st_boolean_vector(lowb to highb-1) =
                 c_st_boolean_vector_1(lowb to highb-1) and
               (s_st_boolean_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616.P1" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            select_sig <= transport 2 ;
              -- s_st_boolean_vector(lowb to highb-1) <= transport
              --   c_st_boolean_vector_2(lowb to highb-1) after 10 ns ,
              --   c_st_boolean_vector_1(lowb to highb-1) after 20 ns ,
              --   c_st_boolean_vector_2(lowb to highb-1) after 30 ns ,
              --   c_st_boolean_vector_1(lowb to highb-1) after 40 ns ;
--
         when 3
         => correct :=
               s_st_boolean_vector(lowb to highb-1) =
                 c_st_boolean_vector_2(lowb to highb-1) and
               (s_st_boolean_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "Concurrent proc call 2",
              correct ) ;
            select_sig <= transport 3 ;
              -- s_st_boolean_vector(lowb to highb-1) <= transport
              --   c_st_boolean_vector_1(lowb to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               s_st_boolean_vector(lowb to highb-1) =
                 c_st_boolean_vector_1(lowb to highb-1) and
               (s_st_boolean_vector_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00616" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00616" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      savtime <= transport Std.Standard.Now ;
      chk_sig <= transport s_st_boolean_vector_cnt
          after (1 us - Std.Standard.Now) ;
      count <= transport s_st_boolean_vector_cnt + 1 ;
--
   end ;
--
   procedure P2
      (signal s_st_severity_level_vector : in st_severity_level_vector ;
       signal select_sig : out Select_Type ;
       signal savtime : out Chk_Time_Type ;
       signal chk_sig : out Chk_Sig_Type ;
       signal count : out Integer)
   is
      variable correct : boolean ;
   begin
      case s_st_severity_level_vector_cnt is
         when 0
         => null ;
              -- s_st_severity_level_vector(lowb to highb-1) <= transport
              --   c_st_severity_level_vector_2(lowb to highb-1) after 10 ns,
              --   c_st_severity_level_vector_1(lowb to highb-1) after 20 ns ;
--
         when 1
         => correct :=
               s_st_severity_level_vector(lowb to highb-1) =
                 c_st_severity_level_vector_2(lowb to highb-1) and
               (s_st_severity_level_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "Concurrent proc call 1",
              correct ) ;
--
         when 2
         => correct :=
               s_st_severity_level_vector(lowb to highb-1) =
                 c_st_severity_level_vector_1(lowb to highb-1) and
               (s_st_severity_level_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616.P2" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            select_sig <= transport 2 ;
              -- s_st_severity_level_vector(lowb to highb-1) <= transport
              --   c_st_severity_level_vector_2(lowb to highb-1) after 10 ns ,
              --   c_st_severity_level_vector_1(lowb to highb-1) after 20 ns ,
              --   c_st_severity_level_vector_2(lowb to highb-1) after 30 ns ,
              --   c_st_severity_level_vector_1(lowb to highb-1) after 40 ns ;
--
         when 3
         => correct :=
               s_st_severity_level_vector(lowb to highb-1) =
                 c_st_severity_level_vector_2(lowb to highb-1) and
               (s_st_severity_level_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "Concurrent proc call 2",
              correct ) ;
            select_sig <= transport 3 ;
              -- s_st_severity_level_vector(lowb to highb-1) <= transport
              --   c_st_severity_level_vector_1(lowb to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               s_st_severity_level_vector(lowb to highb-1) =
                 c_st_severity_level_vector_1(lowb to highb-1) and
               (s_st_severity_level_vector_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00616" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00616" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      savtime <= transport Std.Standard.Now ;
      chk_sig <= transport s_st_severity_level_vector_cnt
          after (1 us - Std.Standard.Now) ;
      count <= transport s_st_severity_level_vector_cnt + 1 ;
--
   end ;
--
   procedure P3
      (signal s_st_string : in st_string ;
       signal select_sig : out Select_Type ;
       signal savtime : out Chk_Time_Type ;
       signal chk_sig : out Chk_Sig_Type ;
       signal count : out Integer)
   is
      variable correct : boolean ;
   begin
      case s_st_string_cnt is
         when 0
         => null ;
              -- s_st_string(highb-1 to highb-1) <= transport
              --   c_st_string_2(highb-1 to highb-1) after 10 ns,
              --   c_st_string_1(highb-1 to highb-1) after 20 ns ;
--
         when 1
         => correct :=
               s_st_string(highb-1 to highb-1) =
                 c_st_string_2(highb-1 to highb-1) and
               (s_st_string_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "Concurrent proc call 1",
              correct ) ;
--
         when 2
         => correct :=
               s_st_string(highb-1 to highb-1) =
                 c_st_string_1(highb-1 to highb-1) and
               (s_st_string_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616.P3" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            select_sig <= transport 2 ;
              -- s_st_string(highb-1 to highb-1) <= transport
              --   c_st_string_2(highb-1 to highb-1) after 10 ns ,
              --   c_st_string_1(highb-1 to highb-1) after 20 ns ,
              --   c_st_string_2(highb-1 to highb-1) after 30 ns ,
              --   c_st_string_1(highb-1 to highb-1) after 40 ns ;
--
         when 3
         => correct :=
               s_st_string(highb-1 to highb-1) =
                 c_st_string_2(highb-1 to highb-1) and
               (s_st_string_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "Concurrent proc call 2",
              correct ) ;
            select_sig <= transport 3 ;
              -- s_st_string(highb-1 to highb-1) <= transport
              --   c_st_string_1(highb-1 to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               s_st_string(highb-1 to highb-1) =
                 c_st_string_1(highb-1 to highb-1) and
               (s_st_string_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00616" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00616" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      savtime <= transport Std.Standard.Now ;
      chk_sig <= transport s_st_string_cnt
          after (1 us - Std.Standard.Now) ;
      count <= transport s_st_string_cnt + 1 ;
--
   end ;
--
   procedure P4
      (signal s_st_enum1_vector : in st_enum1_vector ;
       signal select_sig : out Select_Type ;
       signal savtime : out Chk_Time_Type ;
       signal chk_sig : out Chk_Sig_Type ;
       signal count : out Integer)
   is
      variable correct : boolean ;
   begin
      case s_st_enum1_vector_cnt is
         when 0
         => null ;
              -- s_st_enum1_vector(highb-1 to highb-1) <= transport
              --   c_st_enum1_vector_2(highb-1 to highb-1) after 10 ns,
              --   c_st_enum1_vector_1(highb-1 to highb-1) after 20 ns ;
--
         when 1
         => correct :=
               s_st_enum1_vector(highb-1 to highb-1) =
                 c_st_enum1_vector_2(highb-1 to highb-1) and
               (s_st_enum1_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "Concurrent proc call 1",
              correct ) ;
--
         when 2
         => correct :=
               s_st_enum1_vector(highb-1 to highb-1) =
                 c_st_enum1_vector_1(highb-1 to highb-1) and
               (s_st_enum1_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616.P4" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            select_sig <= transport 2 ;
              -- s_st_enum1_vector(highb-1 to highb-1) <= transport
              --   c_st_enum1_vector_2(highb-1 to highb-1) after 10 ns ,
              --   c_st_enum1_vector_1(highb-1 to highb-1) after 20 ns ,
              --   c_st_enum1_vector_2(highb-1 to highb-1) after 30 ns ,
              --   c_st_enum1_vector_1(highb-1 to highb-1) after 40 ns ;
--
         when 3
         => correct :=
               s_st_enum1_vector(highb-1 to highb-1) =
                 c_st_enum1_vector_2(highb-1 to highb-1) and
               (s_st_enum1_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "Concurrent proc call 2",
              correct ) ;
            select_sig <= transport 3 ;
              -- s_st_enum1_vector(highb-1 to highb-1) <= transport
              --   c_st_enum1_vector_1(highb-1 to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               s_st_enum1_vector(highb-1 to highb-1) =
                 c_st_enum1_vector_1(highb-1 to highb-1) and
               (s_st_enum1_vector_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00616" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00616" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      savtime <= transport Std.Standard.Now ;
      chk_sig <= transport s_st_enum1_vector_cnt
          after (1 us - Std.Standard.Now) ;
      count <= transport s_st_enum1_vector_cnt + 1 ;
--
   end ;
--
   procedure P5
      (signal s_st_integer_vector : in st_integer_vector ;
       signal select_sig : out Select_Type ;
       signal savtime : out Chk_Time_Type ;
       signal chk_sig : out Chk_Sig_Type ;
       signal count : out Integer)
   is
      variable correct : boolean ;
   begin
      case s_st_integer_vector_cnt is
         when 0
         => null ;
              -- s_st_integer_vector(lowb to highb-1) <= transport
              --   c_st_integer_vector_2(lowb to highb-1) after 10 ns,
              --   c_st_integer_vector_1(lowb to highb-1) after 20 ns ;
--
         when 1
         => correct :=
               s_st_integer_vector(lowb to highb-1) =
                 c_st_integer_vector_2(lowb to highb-1) and
               (s_st_integer_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "Concurrent proc call 1",
              correct ) ;
--
         when 2
         => correct :=
               s_st_integer_vector(lowb to highb-1) =
                 c_st_integer_vector_1(lowb to highb-1) and
               (s_st_integer_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616.P5" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            select_sig <= transport 2 ;
              -- s_st_integer_vector(lowb to highb-1) <= transport
              --   c_st_integer_vector_2(lowb to highb-1) after 10 ns ,
              --   c_st_integer_vector_1(lowb to highb-1) after 20 ns ,
              --   c_st_integer_vector_2(lowb to highb-1) after 30 ns ,
              --   c_st_integer_vector_1(lowb to highb-1) after 40 ns ;
--
         when 3
         => correct :=
               s_st_integer_vector(lowb to highb-1) =
                 c_st_integer_vector_2(lowb to highb-1) and
               (s_st_integer_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "Concurrent proc call 2",
              correct ) ;
            select_sig <= transport 3 ;
              -- s_st_integer_vector(lowb to highb-1) <= transport
              --   c_st_integer_vector_1(lowb to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               s_st_integer_vector(lowb to highb-1) =
                 c_st_integer_vector_1(lowb to highb-1) and
               (s_st_integer_vector_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00616" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00616" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      savtime <= transport Std.Standard.Now ;
      chk_sig <= transport s_st_integer_vector_cnt
          after (1 us - Std.Standard.Now) ;
      count <= transport s_st_integer_vector_cnt + 1 ;
--
   end ;
--
   procedure P6
      (signal s_st_time_vector : in st_time_vector ;
       signal select_sig : out Select_Type ;
       signal savtime : out Chk_Time_Type ;
       signal chk_sig : out Chk_Sig_Type ;
       signal count : out Integer)
   is
      variable correct : boolean ;
   begin
      case s_st_time_vector_cnt is
         when 0
         => null ;
              -- s_st_time_vector(lowb to highb-1) <= transport
              --   c_st_time_vector_2(lowb to highb-1) after 10 ns,
              --   c_st_time_vector_1(lowb to highb-1) after 20 ns ;
--
         when 1
         => correct :=
               s_st_time_vector(lowb to highb-1) =
                 c_st_time_vector_2(lowb to highb-1) and
               (s_st_time_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "Concurrent proc call 1",
              correct ) ;
--
         when 2
         => correct :=
               s_st_time_vector(lowb to highb-1) =
                 c_st_time_vector_1(lowb to highb-1) and
               (s_st_time_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616.P6" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            select_sig <= transport 2 ;
              -- s_st_time_vector(lowb to highb-1) <= transport
              --   c_st_time_vector_2(lowb to highb-1) after 10 ns ,
              --   c_st_time_vector_1(lowb to highb-1) after 20 ns ,
              --   c_st_time_vector_2(lowb to highb-1) after 30 ns ,
              --   c_st_time_vector_1(lowb to highb-1) after 40 ns ;
--
         when 3
         => correct :=
               s_st_time_vector(lowb to highb-1) =
                 c_st_time_vector_2(lowb to highb-1) and
               (s_st_time_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "Concurrent proc call 2",
              correct ) ;
            select_sig <= transport 3 ;
              -- s_st_time_vector(lowb to highb-1) <= transport
              --   c_st_time_vector_1(lowb to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               s_st_time_vector(lowb to highb-1) =
                 c_st_time_vector_1(lowb to highb-1) and
               (s_st_time_vector_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00616" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00616" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      savtime <= transport Std.Standard.Now ;
      chk_sig <= transport s_st_time_vector_cnt
          after (1 us - Std.Standard.Now) ;
      count <= transport s_st_time_vector_cnt + 1 ;
--
   end ;
--
   procedure P7
      (signal s_st_real_vector : in st_real_vector ;
       signal select_sig : out Select_Type ;
       signal savtime : out Chk_Time_Type ;
       signal chk_sig : out Chk_Sig_Type ;
       signal count : out Integer)
   is
      variable correct : boolean ;
   begin
      case s_st_real_vector_cnt is
         when 0
         => null ;
              -- s_st_real_vector(highb-1 to highb-1) <= transport
              --   c_st_real_vector_2(highb-1 to highb-1) after 10 ns,
              --   c_st_real_vector_1(highb-1 to highb-1) after 20 ns ;
--
         when 1
         => correct :=
               s_st_real_vector(highb-1 to highb-1) =
                 c_st_real_vector_2(highb-1 to highb-1) and
               (s_st_real_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "Concurrent proc call 1",
              correct ) ;
--
         when 2
         => correct :=
               s_st_real_vector(highb-1 to highb-1) =
                 c_st_real_vector_1(highb-1 to highb-1) and
               (s_st_real_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616.P7" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            select_sig <= transport 2 ;
              -- s_st_real_vector(highb-1 to highb-1) <= transport
              --   c_st_real_vector_2(highb-1 to highb-1) after 10 ns ,
              --   c_st_real_vector_1(highb-1 to highb-1) after 20 ns ,
              --   c_st_real_vector_2(highb-1 to highb-1) after 30 ns ,
              --   c_st_real_vector_1(highb-1 to highb-1) after 40 ns ;
--
         when 3
         => correct :=
               s_st_real_vector(highb-1 to highb-1) =
                 c_st_real_vector_2(highb-1 to highb-1) and
               (s_st_real_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "Concurrent proc call 2",
              correct ) ;
            select_sig <= transport 3 ;
              -- s_st_real_vector(highb-1 to highb-1) <= transport
              --   c_st_real_vector_1(highb-1 to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               s_st_real_vector(highb-1 to highb-1) =
                 c_st_real_vector_1(highb-1 to highb-1) and
               (s_st_real_vector_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00616" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00616" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      savtime <= transport Std.Standard.Now ;
      chk_sig <= transport s_st_real_vector_cnt
          after (1 us - Std.Standard.Now) ;
      count <= transport s_st_real_vector_cnt + 1 ;
--
   end ;
--
   procedure P8
      (signal s_st_rec1_vector : in st_rec1_vector ;
       signal select_sig : out Select_Type ;
       signal savtime : out Chk_Time_Type ;
       signal chk_sig : out Chk_Sig_Type ;
       signal count : out Integer)
   is
      variable correct : boolean ;
   begin
      case s_st_rec1_vector_cnt is
         when 0
         => null ;
              -- s_st_rec1_vector(highb-1 to highb-1) <= transport
              --   c_st_rec1_vector_2(highb-1 to highb-1) after 10 ns,
              --   c_st_rec1_vector_1(highb-1 to highb-1) after 20 ns ;
--
         when 1
         => correct :=
               s_st_rec1_vector(highb-1 to highb-1) =
                 c_st_rec1_vector_2(highb-1 to highb-1) and
               (s_st_rec1_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "Concurrent proc call 1",
              correct ) ;
--
         when 2
         => correct :=
               s_st_rec1_vector(highb-1 to highb-1) =
                 c_st_rec1_vector_1(highb-1 to highb-1) and
               (s_st_rec1_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616.P8" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            select_sig <= transport 2 ;
              -- s_st_rec1_vector(highb-1 to highb-1) <= transport
              --   c_st_rec1_vector_2(highb-1 to highb-1) after 10 ns ,
              --   c_st_rec1_vector_1(highb-1 to highb-1) after 20 ns ,
              --   c_st_rec1_vector_2(highb-1 to highb-1) after 30 ns ,
              --   c_st_rec1_vector_1(highb-1 to highb-1) after 40 ns ;
--
         when 3
         => correct :=
               s_st_rec1_vector(highb-1 to highb-1) =
                 c_st_rec1_vector_2(highb-1 to highb-1) and
               (s_st_rec1_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "Concurrent proc call 2",
              correct ) ;
            select_sig <= transport 3 ;
              -- s_st_rec1_vector(highb-1 to highb-1) <= transport
              --   c_st_rec1_vector_1(highb-1 to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               s_st_rec1_vector(highb-1 to highb-1) =
                 c_st_rec1_vector_1(highb-1 to highb-1) and
               (s_st_rec1_vector_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00616" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00616" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      savtime <= transport Std.Standard.Now ;
      chk_sig <= transport s_st_rec1_vector_cnt
          after (1 us - Std.Standard.Now) ;
      count <= transport s_st_rec1_vector_cnt + 1 ;
--
   end ;
--
   procedure P9
      (signal s_st_arr2_vector : in st_arr2_vector ;
       signal select_sig : out Select_Type ;
       signal savtime : out Chk_Time_Type ;
       signal chk_sig : out Chk_Sig_Type ;
       signal count : out Integer)
   is
      variable correct : boolean ;
   begin
      case s_st_arr2_vector_cnt is
         when 0
         => null ;
              -- s_st_arr2_vector(lowb to highb-1) <= transport
              --   c_st_arr2_vector_2(lowb to highb-1) after 10 ns,
              --   c_st_arr2_vector_1(lowb to highb-1) after 20 ns ;
--
         when 1
         => correct :=
               s_st_arr2_vector(lowb to highb-1) =
                 c_st_arr2_vector_2(lowb to highb-1) and
               (s_st_arr2_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "Concurrent proc call 1",
              correct ) ;
--
         when 2
         => correct :=
               s_st_arr2_vector(lowb to highb-1) =
                 c_st_arr2_vector_1(lowb to highb-1) and
               (s_st_arr2_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616.P9" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            select_sig <= transport 2 ;
              -- s_st_arr2_vector(lowb to highb-1) <= transport
              --   c_st_arr2_vector_2(lowb to highb-1) after 10 ns ,
              --   c_st_arr2_vector_1(lowb to highb-1) after 20 ns ,
              --   c_st_arr2_vector_2(lowb to highb-1) after 30 ns ,
              --   c_st_arr2_vector_1(lowb to highb-1) after 40 ns ;
--
         when 3
         => correct :=
               s_st_arr2_vector(lowb to highb-1) =
                 c_st_arr2_vector_2(lowb to highb-1) and
               (s_st_arr2_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "Concurrent proc call 2",
              correct ) ;
            select_sig <= transport 3 ;
              -- s_st_arr2_vector(lowb to highb-1) <= transport
              --   c_st_arr2_vector_1(lowb to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               s_st_arr2_vector(lowb to highb-1) =
                 c_st_arr2_vector_1(lowb to highb-1) and
               (s_st_arr2_vector_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00616" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00616" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00616" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      savtime <= transport Std.Standard.Now ;
      chk_sig <= transport s_st_arr2_vector_cnt
          after (1 us - Std.Standard.Now) ;
      count <= transport s_st_arr2_vector_cnt + 1 ;
--
   end ;
--
begin
   CHG1 :
   P1(
       s_st_boolean_vector ,
       st_boolean_vector_select ,
       s_st_boolean_vector_savt ,
       chk_st_boolean_vector ,
       s_st_boolean_vector_cnt ) ;
--
   PGEN_CHKP_1 :
   process ( chk_st_boolean_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Transport transactions completed entirely",
           chk_st_boolean_vector = 4 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
--
   with st_boolean_vector_select select
      s_st_boolean_vector(lowb to highb-1) <= transport
        c_st_boolean_vector_2(lowb to highb-1) after 10 ns,
        c_st_boolean_vector_1(lowb to highb-1) after 20 ns
        when 1,
--
        c_st_boolean_vector_2(lowb to highb-1) after 10 ns ,
        c_st_boolean_vector_1(lowb to highb-1) after 20 ns ,
        c_st_boolean_vector_2(lowb to highb-1) after 30 ns ,
        c_st_boolean_vector_1(lowb to highb-1) after 40 ns
        when 2,
--
        c_st_boolean_vector_1(lowb to highb-1) after 5 ns  when 3 ;
--
   CHG2 :
   P2(
       s_st_severity_level_vector ,
       st_severity_level_vector_select ,
       s_st_severity_level_vector_savt ,
       chk_st_severity_level_vector ,
       s_st_severity_level_vector_cnt ) ;
--
   PGEN_CHKP_2 :
   process ( chk_st_severity_level_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P2" ,
           "Transport transactions completed entirely",
           chk_st_severity_level_vector = 4 ) ;
      end if ;
   end process PGEN_CHKP_2 ;
--
--
   with st_severity_level_vector_select select
      s_st_severity_level_vector(lowb to highb-1) <= transport
        c_st_severity_level_vector_2(lowb to highb-1) after 10 ns,
        c_st_severity_level_vector_1(lowb to highb-1) after 20 ns
        when 1,
--
        c_st_severity_level_vector_2(lowb to highb-1) after 10 ns ,
        c_st_severity_level_vector_1(lowb to highb-1) after 20 ns ,
        c_st_severity_level_vector_2(lowb to highb-1) after 30 ns ,
        c_st_severity_level_vector_1(lowb to highb-1) after 40 ns
        when 2,
--
        c_st_severity_level_vector_1(lowb to highb-1) after 5 ns  when 3 ;
--
   CHG3 :
   P3(
       s_st_string ,
       st_string_select ,
       s_st_string_savt ,
       chk_st_string ,
       s_st_string_cnt ) ;
--
   PGEN_CHKP_3 :
   process ( chk_st_string )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P3" ,
           "Transport transactions completed entirely",
           chk_st_string = 4 ) ;
      end if ;
   end process PGEN_CHKP_3 ;
--
--
   with st_string_select select
      s_st_string(highb-1 to highb-1) <= transport
        c_st_string_2(highb-1 to highb-1) after 10 ns,
        c_st_string_1(highb-1 to highb-1) after 20 ns
        when 1,
--
        c_st_string_2(highb-1 to highb-1) after 10 ns ,
        c_st_string_1(highb-1 to highb-1) after 20 ns ,
        c_st_string_2(highb-1 to highb-1) after 30 ns ,
        c_st_string_1(highb-1 to highb-1) after 40 ns
        when 2,
--
        c_st_string_1(highb-1 to highb-1) after 5 ns  when 3 ;
--
   CHG4 :
   P4(
       s_st_enum1_vector ,
       st_enum1_vector_select ,
       s_st_enum1_vector_savt ,
       chk_st_enum1_vector ,
       s_st_enum1_vector_cnt ) ;
--
   PGEN_CHKP_4 :
   process ( chk_st_enum1_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P4" ,
           "Transport transactions completed entirely",
           chk_st_enum1_vector = 4 ) ;
      end if ;
   end process PGEN_CHKP_4 ;
--
--
   with st_enum1_vector_select select
      s_st_enum1_vector(highb-1 to highb-1) <= transport
        c_st_enum1_vector_2(highb-1 to highb-1) after 10 ns,
        c_st_enum1_vector_1(highb-1 to highb-1) after 20 ns
        when 1,
--
        c_st_enum1_vector_2(highb-1 to highb-1) after 10 ns ,
        c_st_enum1_vector_1(highb-1 to highb-1) after 20 ns ,
        c_st_enum1_vector_2(highb-1 to highb-1) after 30 ns ,
        c_st_enum1_vector_1(highb-1 to highb-1) after 40 ns
        when 2,
--
        c_st_enum1_vector_1(highb-1 to highb-1) after 5 ns  when 3 ;
--
   CHG5 :
   P5(
       s_st_integer_vector ,
       st_integer_vector_select ,
       s_st_integer_vector_savt ,
       chk_st_integer_vector ,
       s_st_integer_vector_cnt ) ;
--
   PGEN_CHKP_5 :
   process ( chk_st_integer_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P5" ,
           "Transport transactions completed entirely",
           chk_st_integer_vector = 4 ) ;
      end if ;
   end process PGEN_CHKP_5 ;
--
--
   with st_integer_vector_select select
      s_st_integer_vector(lowb to highb-1) <= transport
        c_st_integer_vector_2(lowb to highb-1) after 10 ns,
        c_st_integer_vector_1(lowb to highb-1) after 20 ns
        when 1,
--
        c_st_integer_vector_2(lowb to highb-1) after 10 ns ,
        c_st_integer_vector_1(lowb to highb-1) after 20 ns ,
        c_st_integer_vector_2(lowb to highb-1) after 30 ns ,
        c_st_integer_vector_1(lowb to highb-1) after 40 ns
        when 2,
--
        c_st_integer_vector_1(lowb to highb-1) after 5 ns  when 3 ;
--
   CHG6 :
   P6(
       s_st_time_vector ,
       st_time_vector_select ,
       s_st_time_vector_savt ,
       chk_st_time_vector ,
       s_st_time_vector_cnt ) ;
--
   PGEN_CHKP_6 :
   process ( chk_st_time_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P6" ,
           "Transport transactions completed entirely",
           chk_st_time_vector = 4 ) ;
      end if ;
   end process PGEN_CHKP_6 ;
--
--
   with st_time_vector_select select
      s_st_time_vector(lowb to highb-1) <= transport
        c_st_time_vector_2(lowb to highb-1) after 10 ns,
        c_st_time_vector_1(lowb to highb-1) after 20 ns
        when 1,
--
        c_st_time_vector_2(lowb to highb-1) after 10 ns ,
        c_st_time_vector_1(lowb to highb-1) after 20 ns ,
        c_st_time_vector_2(lowb to highb-1) after 30 ns ,
        c_st_time_vector_1(lowb to highb-1) after 40 ns
        when 2,
--
        c_st_time_vector_1(lowb to highb-1) after 5 ns  when 3 ;
--
   CHG7 :
   P7(
       s_st_real_vector ,
       st_real_vector_select ,
       s_st_real_vector_savt ,
       chk_st_real_vector ,
       s_st_real_vector_cnt ) ;
--
   PGEN_CHKP_7 :
   process ( chk_st_real_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P7" ,
           "Transport transactions completed entirely",
           chk_st_real_vector = 4 ) ;
      end if ;
   end process PGEN_CHKP_7 ;
--
--
   with st_real_vector_select select
      s_st_real_vector(highb-1 to highb-1) <= transport
        c_st_real_vector_2(highb-1 to highb-1) after 10 ns,
        c_st_real_vector_1(highb-1 to highb-1) after 20 ns
        when 1,
--
        c_st_real_vector_2(highb-1 to highb-1) after 10 ns ,
        c_st_real_vector_1(highb-1 to highb-1) after 20 ns ,
        c_st_real_vector_2(highb-1 to highb-1) after 30 ns ,
        c_st_real_vector_1(highb-1 to highb-1) after 40 ns
        when 2,
--
        c_st_real_vector_1(highb-1 to highb-1) after 5 ns  when 3 ;
--
   CHG8 :
   P8(
       s_st_rec1_vector ,
       st_rec1_vector_select ,
       s_st_rec1_vector_savt ,
       chk_st_rec1_vector ,
       s_st_rec1_vector_cnt ) ;
--
   PGEN_CHKP_8 :
   process ( chk_st_rec1_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P8" ,
           "Transport transactions completed entirely",
           chk_st_rec1_vector = 4 ) ;
      end if ;
   end process PGEN_CHKP_8 ;
--
--
   with st_rec1_vector_select select
      s_st_rec1_vector(highb-1 to highb-1) <= transport
        c_st_rec1_vector_2(highb-1 to highb-1) after 10 ns,
        c_st_rec1_vector_1(highb-1 to highb-1) after 20 ns
        when 1,
--
        c_st_rec1_vector_2(highb-1 to highb-1) after 10 ns ,
        c_st_rec1_vector_1(highb-1 to highb-1) after 20 ns ,
        c_st_rec1_vector_2(highb-1 to highb-1) after 30 ns ,
        c_st_rec1_vector_1(highb-1 to highb-1) after 40 ns
        when 2,
--
        c_st_rec1_vector_1(highb-1 to highb-1) after 5 ns  when 3 ;
--
   CHG9 :
   P9(
       s_st_arr2_vector ,
       st_arr2_vector_select ,
       s_st_arr2_vector_savt ,
       chk_st_arr2_vector ,
       s_st_arr2_vector_cnt ) ;
--
   PGEN_CHKP_9 :
   process ( chk_st_arr2_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P9" ,
           "Transport transactions completed entirely",
           chk_st_arr2_vector = 4 ) ;
      end if ;
   end process PGEN_CHKP_9 ;
--
--
   with st_arr2_vector_select select
      s_st_arr2_vector(lowb to highb-1) <= transport
        c_st_arr2_vector_2(lowb to highb-1) after 10 ns,
        c_st_arr2_vector_1(lowb to highb-1) after 20 ns
        when 1,
--
        c_st_arr2_vector_2(lowb to highb-1) after 10 ns ,
        c_st_arr2_vector_1(lowb to highb-1) after 20 ns ,
        c_st_arr2_vector_2(lowb to highb-1) after 30 ns ,
        c_st_arr2_vector_1(lowb to highb-1) after 40 ns
        when 2,
--
        c_st_arr2_vector_1(lowb to highb-1) after 5 ns  when 3 ;
--
end ARCH00616 ;
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00616_Test_Bench is
   signal s_st_boolean_vector : st_boolean_vector
     := c_st_boolean_vector_1 ;
   signal s_st_severity_level_vector : st_severity_level_vector
     := c_st_severity_level_vector_1 ;
   signal s_st_string : st_string
     := c_st_string_1 ;
   signal s_st_enum1_vector : st_enum1_vector
     := c_st_enum1_vector_1 ;
   signal s_st_integer_vector : st_integer_vector
     := c_st_integer_vector_1 ;
   signal s_st_time_vector : st_time_vector
     := c_st_time_vector_1 ;
   signal s_st_real_vector : st_real_vector
     := c_st_real_vector_1 ;
   signal s_st_rec1_vector : st_rec1_vector
     := c_st_rec1_vector_1 ;
   signal s_st_arr2_vector : st_arr2_vector
     := c_st_arr2_vector_1 ;
--
end ENT00616_Test_Bench ;
--
--
architecture ARCH00616_Test_Bench of ENT00616_Test_Bench is
begin
   L1:
   block
      component UUT
         port (
              s_st_boolean_vector : inout st_boolean_vector
            ; s_st_severity_level_vector : inout st_severity_level_vector
            ; s_st_string : inout st_string
            ; s_st_enum1_vector : inout st_enum1_vector
            ; s_st_integer_vector : inout st_integer_vector
            ; s_st_time_vector : inout st_time_vector
            ; s_st_real_vector : inout st_real_vector
            ; s_st_rec1_vector : inout st_rec1_vector
            ; s_st_arr2_vector : inout st_arr2_vector
              ) ;
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00616 ( ARCH00616 ) ;
   begin
      CIS1 : UUT
         port map (
              s_st_boolean_vector
            , s_st_severity_level_vector
            , s_st_string
            , s_st_enum1_vector
            , s_st_integer_vector
            , s_st_time_vector
            , s_st_real_vector
            , s_st_rec1_vector
            , s_st_arr2_vector
                  )
         ;
   end block L1 ;
end ARCH00616_Test_Bench ;
