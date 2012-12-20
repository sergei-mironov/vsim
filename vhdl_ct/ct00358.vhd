-- NEED RESULT: ARCH00358.P1: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00358.P2: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00358: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00358: Old transactions were removed on a concurrent signal asg passed
-- NEED RESULT: ARCH00358: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00358: Old transactions were removed on a concurrent signal asg passed
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
--    CT00358
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
--    ENT00358(ARCH00358)
--    ENT00358_Test_Bench(ARCH00358_Test_Bench)
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
entity ENT00358 is
   port (
        s_st_arr2_vector : inout st_arr2_vector
      ; s_st_arr3_vector : inout st_arr3_vector
        ) ;
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_st_arr2_vector : chk_sig_type := -1 ;
   signal chk_st_arr3_vector : chk_sig_type := -1 ;
--
end ENT00358 ;
--
--
architecture ARCH00358 of ENT00358 is
   subtype chk_time_type is Time ;
   signal s_st_arr2_vector_savt : chk_time_type := 0 ns ;
   signal s_st_arr3_vector_savt : chk_time_type := 0 ns ;
--
   subtype chk_cnt_type is Integer ;
   signal s_st_arr2_vector_cnt : chk_cnt_type := 0 ;
   signal s_st_arr3_vector_cnt : chk_cnt_type := 0 ;
--
   type select_type is range 1 to 3 ;
   signal st_arr2_vector_select : select_type := 1 ;
   signal st_arr3_vector_select : select_type := 1 ;
--
begin
   CHG1 :
   process ( s_st_arr2_vector )
      variable correct : boolean ;
   begin
      case s_st_arr2_vector_cnt is
         when 0
         => null ;
              -- s_st_arr2_vector(lowb)(highb,false) <= transport
              --   c_st_arr2_vector_2(lowb)(highb,false) after 10 ns,
              --   c_st_arr2_vector_1(lowb)(highb,false) after 20 ns ;
--
         when 1
         => correct :=
               s_st_arr2_vector(lowb)(highb,false) =
                 c_st_arr2_vector_2(lowb)(highb,false) and
               (s_st_arr2_vector_savt + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_arr2_vector(lowb)(highb,false) =
                 c_st_arr2_vector_1(lowb)(highb,false) and
               (s_st_arr2_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00358.P1" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            st_arr2_vector_select <= transport 2 ;
              -- s_st_arr2_vector(lowb)(highb,false) <= transport
              --   c_st_arr2_vector_2(lowb)(highb,false) after 10 ns ,
              --   c_st_arr2_vector_1(lowb)(highb,false) after 20 ns ,
              --   c_st_arr2_vector_2(lowb)(highb,false) after 30 ns ,
              --   c_st_arr2_vector_1(lowb)(highb,false) after 40 ns ;
--
         when 3
         => correct :=
               s_st_arr2_vector(lowb)(highb,false) =
                 c_st_arr2_vector_2(lowb)(highb,false) and
               (s_st_arr2_vector_savt + 10 ns) = Std.Standard.Now ;
            st_arr2_vector_select <= transport 3 ;
              -- s_st_arr2_vector(lowb)(highb,false) <= transport
              --   c_st_arr2_vector_1(lowb)(highb,false) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_arr2_vector(lowb)(highb,false) =
                 c_st_arr2_vector_1(lowb)(highb,false) and
               (s_st_arr2_vector_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00358" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00358" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00358" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      s_st_arr2_vector_savt <= transport Std.Standard.Now ;
      chk_st_arr2_vector <= transport s_st_arr2_vector_cnt
          after (1 us - Std.Standard.Now) ;
      s_st_arr2_vector_cnt <= transport s_st_arr2_vector_cnt + 1 ;
--
   end process CHG1 ;
--
   PGEN_CHKP_1 :
   process ( chk_st_arr2_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Transport transactions completed entirely",
           chk_st_arr2_vector = 4 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
--
      s_st_arr2_vector(lowb)(highb,false) <= transport
        c_st_arr2_vector_2(lowb)(highb,false) after 10 ns,
        c_st_arr2_vector_1(lowb)(highb,false) after 20 ns
        when st_arr2_vector_select = 1 else
--
        c_st_arr2_vector_2(lowb)(highb,false) after 10 ns ,
        c_st_arr2_vector_1(lowb)(highb,false) after 20 ns ,
        c_st_arr2_vector_2(lowb)(highb,false) after 30 ns ,
        c_st_arr2_vector_1(lowb)(highb,false) after 40 ns
        when st_arr2_vector_select = 2 else
--
        c_st_arr2_vector_1(lowb)(highb,false) after 5 ns ;
--
   CHG2 :
   process ( s_st_arr3_vector )
      variable correct : boolean ;
   begin
      case s_st_arr3_vector_cnt is
         when 0
         => null ;
              -- s_st_arr3_vector(highb)(lowb,true) <= transport
              --   c_st_arr3_vector_2(highb)(lowb,true) after 10 ns,
              --   c_st_arr3_vector_1(highb)(lowb,true) after 20 ns ;
--
         when 1
         => correct :=
               s_st_arr3_vector(highb)(lowb,true) =
                 c_st_arr3_vector_2(highb)(lowb,true) and
               (s_st_arr3_vector_savt + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_arr3_vector(highb)(lowb,true) =
                 c_st_arr3_vector_1(highb)(lowb,true) and
               (s_st_arr3_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00358.P2" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            st_arr3_vector_select <= transport 2 ;
              -- s_st_arr3_vector(highb)(lowb,true) <= transport
              --   c_st_arr3_vector_2(highb)(lowb,true) after 10 ns ,
              --   c_st_arr3_vector_1(highb)(lowb,true) after 20 ns ,
              --   c_st_arr3_vector_2(highb)(lowb,true) after 30 ns ,
              --   c_st_arr3_vector_1(highb)(lowb,true) after 40 ns ;
--
         when 3
         => correct :=
               s_st_arr3_vector(highb)(lowb,true) =
                 c_st_arr3_vector_2(highb)(lowb,true) and
               (s_st_arr3_vector_savt + 10 ns) = Std.Standard.Now ;
            st_arr3_vector_select <= transport 3 ;
              -- s_st_arr3_vector(highb)(lowb,true) <= transport
              --   c_st_arr3_vector_1(highb)(lowb,true) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_arr3_vector(highb)(lowb,true) =
                 c_st_arr3_vector_1(highb)(lowb,true) and
               (s_st_arr3_vector_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00358" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00358" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00358" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      s_st_arr3_vector_savt <= transport Std.Standard.Now ;
      chk_st_arr3_vector <= transport s_st_arr3_vector_cnt
          after (1 us - Std.Standard.Now) ;
      s_st_arr3_vector_cnt <= transport s_st_arr3_vector_cnt + 1 ;
--
   end process CHG2 ;
--
   PGEN_CHKP_2 :
   process ( chk_st_arr3_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P2" ,
           "Transport transactions completed entirely",
           chk_st_arr3_vector = 4 ) ;
      end if ;
   end process PGEN_CHKP_2 ;
--
--
      s_st_arr3_vector(highb)(lowb,true) <= transport
        c_st_arr3_vector_2(highb)(lowb,true) after 10 ns,
        c_st_arr3_vector_1(highb)(lowb,true) after 20 ns
        when st_arr3_vector_select = 1 else
--
        c_st_arr3_vector_2(highb)(lowb,true) after 10 ns ,
        c_st_arr3_vector_1(highb)(lowb,true) after 20 ns ,
        c_st_arr3_vector_2(highb)(lowb,true) after 30 ns ,
        c_st_arr3_vector_1(highb)(lowb,true) after 40 ns
        when st_arr3_vector_select = 2 else
--
        c_st_arr3_vector_1(highb)(lowb,true) after 5 ns ;
--
end ARCH00358 ;
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00358_Test_Bench is
   signal s_st_arr2_vector : st_arr2_vector
     := c_st_arr2_vector_1 ;
   signal s_st_arr3_vector : st_arr3_vector
     := c_st_arr3_vector_1 ;
--
end ENT00358_Test_Bench ;
--
--
architecture ARCH00358_Test_Bench of ENT00358_Test_Bench is
begin
   L1:
   block
      component UUT
         port (
              s_st_arr2_vector : inout st_arr2_vector
            ; s_st_arr3_vector : inout st_arr3_vector
              ) ;
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00358 ( ARCH00358 ) ;
   begin
      CIS1 : UUT
         port map (
              s_st_arr2_vector
            , s_st_arr3_vector
                  )
         ;
   end block L1 ;
end ARCH00358_Test_Bench ;
