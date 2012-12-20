-- NEED RESULT: ARCH00621: Concurrent proc call 1 passed
-- NEED RESULT: ARCH00621.P1: Multi transport transactions occurred on concurrent signal asg passed
-- NEED RESULT: ARCH00621: Concurrent proc call 2 passed
-- NEED RESULT: ARCH00621: One transport transaction occurred on a concurrent signal asg passed
-- NEED RESULT: ARCH00621: Old transactions were removed on a concurrent signal asg passed
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
--    CT00621
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
--    ENT00621(ARCH00621)
--    ENT00621_Test_Bench(ARCH00621_Test_Bench)
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
entity ENT00621 is
end ENT00621 ;
--
--
architecture ARCH00621 of ENT00621 is
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_st_arr1_vector : chk_sig_type := -1 ;
--
   subtype chk_time_type is Time ;
   signal s_st_arr1_vector_savt : chk_time_type := 0 ns ;
--
   subtype chk_cnt_type is Integer ;
   signal s_st_arr1_vector_cnt : chk_cnt_type := 0 ;
--
   type select_type is range 1 to 3 ;
   signal st_arr1_vector_select : select_type := 1 ;
--
   signal s_st_arr1_vector : st_arr1_vector
     := c_st_arr1_vector_1 ;
--
   procedure P1
      (signal s_st_arr1_vector : in st_arr1_vector ;
       signal select_sig : out Select_Type ;
       signal savtime : out Chk_Time_Type ;
       signal chk_sig : out Chk_Sig_Type ;
       signal count : out Integer)
   is
      variable correct : boolean ;
   begin
      case s_st_arr1_vector_cnt is
         when 0
         => null ;
              -- s_st_arr1_vector(highb)(lowb to highb-1) <= transport
              --   c_st_arr1_vector_2(highb)(lowb to highb-1) after 10 ns,
              --   c_st_arr1_vector_1(highb)(lowb to highb-1) after 20 ns ;
--
         when 1
         => correct :=
               s_st_arr1_vector(highb)(lowb to highb-1) =
                 c_st_arr1_vector_2(highb)(lowb to highb-1) and
               (s_st_arr1_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00621" ,
              "Concurrent proc call 1",
              correct ) ;
--
         when 2
         => correct :=
               s_st_arr1_vector(highb)(lowb to highb-1) =
                 c_st_arr1_vector_1(highb)(lowb to highb-1) and
               (s_st_arr1_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00621.P1" ,
              "Multi transport transactions occurred on " &
              "concurrent signal asg",
              correct ) ;
--
            select_sig <= transport 2 ;
              -- s_st_arr1_vector(highb)(lowb to highb-1) <= transport
              --   c_st_arr1_vector_2(highb)(lowb to highb-1) after 10 ns ,
              --   c_st_arr1_vector_1(highb)(lowb to highb-1) after 20 ns ,
              --   c_st_arr1_vector_2(highb)(lowb to highb-1) after 30 ns ,
              --   c_st_arr1_vector_1(highb)(lowb to highb-1) after 40 ns ;
--
         when 3
         => correct :=
               s_st_arr1_vector(highb)(lowb to highb-1) =
                 c_st_arr1_vector_2(highb)(lowb to highb-1) and
               (s_st_arr1_vector_savt + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00621" ,
              "Concurrent proc call 2",
              correct ) ;
            select_sig <= transport 3 ;
              -- s_st_arr1_vector(highb)(lowb to highb-1) <= transport
              --   c_st_arr1_vector_1(highb)(lowb to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               s_st_arr1_vector(highb)(lowb to highb-1) =
                 c_st_arr1_vector_1(highb)(lowb to highb-1) and
               (s_st_arr1_vector_savt + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00621" ,
              "One transport transaction occurred on a " &
              "concurrent signal asg",
              correct ) ;
            test_report ( "ARCH00621" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00621" ,
              "Old transactions were removed on a " &
              "concurrent signal asg",
              false ) ;
--
      end case ;
--
      savtime <= transport Std.Standard.Now ;
      chk_sig <= transport s_st_arr1_vector_cnt
          after (1 us - Std.Standard.Now) ;
      count <= transport s_st_arr1_vector_cnt + 1 ;
--
   end ;
--
begin
   CHG1 :
   P1(
       s_st_arr1_vector ,
       st_arr1_vector_select ,
       s_st_arr1_vector_savt ,
       chk_st_arr1_vector ,
       s_st_arr1_vector_cnt ) ;
--
   PGEN_CHKP_1 :
   process ( chk_st_arr1_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Transport transactions completed entirely",
           chk_st_arr1_vector = 4 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
--
   with st_arr1_vector_select select
      s_st_arr1_vector(highb)(lowb to highb-1) <= transport
        c_st_arr1_vector_2(highb)(lowb to highb-1) after 10 ns,
        c_st_arr1_vector_1(highb)(lowb to highb-1) after 20 ns
        when 1,
--
        c_st_arr1_vector_2(highb)(lowb to highb-1) after 10 ns ,
        c_st_arr1_vector_1(highb)(lowb to highb-1) after 20 ns ,
        c_st_arr1_vector_2(highb)(lowb to highb-1) after 30 ns ,
        c_st_arr1_vector_1(highb)(lowb to highb-1) after 40 ns
        when 2,
--
        c_st_arr1_vector_1(highb)(lowb to highb-1) after 5 ns  when 3 ;
--
end ARCH00621 ;
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00621_Test_Bench is
end ENT00621_Test_Bench ;
--
--
architecture ARCH00621_Test_Bench of ENT00621_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00621 ( ARCH00621 ) ;
   begin
      CIS1 : UUT
         ;
   end block L1 ;
end ARCH00621_Test_Bench ;
