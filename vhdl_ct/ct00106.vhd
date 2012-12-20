-- NEED RESULT: ARCH00106.P1: Multi transport transactions occurred on signal asg with slice name prefixed by an indexed name on LHS failed
-- NEED RESULT: ARCH00106: One transport transaction occurred on signal asg with slice name prefixed by an indexed name on LHS failed
-- NEED RESULT: ARCH00106: Old transactions were removed on signal asg with slice name prefixed by an indexed name on LHS failed
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
--    CT00106
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
--    ENT00106(ARCH00106)
--    ENT00106_Test_Bench(ARCH00106_Test_Bench)
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
entity ENT00106 is
   port (
        s_st_arr1_vector : inout st_arr1_vector
        ) ;
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_st_arr1_vector : chk_sig_type := -1 ;
--
--
   procedure Proc1 (
      signal   s_st_arr1_vector : inout st_arr1_vector ;
      variable counter : inout integer ;
      variable correct : inout boolean ;
      variable savtime : inout time ;
      signal   chk_st_arr1_vector : out chk_sig_type
                   )
   is
   begin
      case counter is
         when 0
         => s_st_arr1_vector(lowb) (lowb+1 to highb-1) <= transport
               c_st_arr1_vector_2(highb)
                 (lowb+1 to highb-1) after 10 ns,
               c_st_arr1_vector_1(highb)
                 (lowb+1 to highb-1) after 20 ns ;
--
         when 1
         => correct :=
               s_st_arr1_vector(lowb) (lowb+1 to highb-1) =
                 c_st_arr1_vector_2(highb) (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2
         => correct :=
               correct and
               s_st_arr1_vector(lowb) (lowb+1 to highb-1) =
                 c_st_arr1_vector_1(highb) (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00106.P1" ,
              "Multi transport transactions occurred on signal " &
              "asg with slice name prefixed by an indexed name on LHS",
              correct ) ;
            s_st_arr1_vector(lowb) (lowb+1 to highb-1) <= transport
               c_st_arr1_vector_2(highb)
                 (lowb+1 to highb-1) after 10 ns ,
               c_st_arr1_vector_1(highb)
                 (lowb+1 to highb-1) after 20 ns ,
               c_st_arr1_vector_2(highb)
                 (lowb+1 to highb-1) after 30 ns ,
               c_st_arr1_vector_1(highb)
                 (lowb+1 to highb-1) after 40 ns ;
--
         when 3
         => correct :=
               s_st_arr1_vector(lowb) (lowb+1 to highb-1) =
                 c_st_arr1_vector_2(highb) (lowb+1 to highb-1) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_arr1_vector(lowb) (lowb+1 to highb-1) <= transport
               c_st_arr1_vector_1(highb)
                 (lowb+1 to highb-1) after 5 ns ;
--
         when 4
         => correct :=
               correct and
               s_st_arr1_vector(lowb) (lowb+1 to highb-1) =
                 c_st_arr1_vector_1(highb) (lowb+1 to highb-1) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00106" ,
              "One transport transaction occurred on signal " &
              "asg with slice name prefixed by an indexed name on LHS",
              correct ) ;
            test_report ( "ARCH00106" ,
              "Old transactions were removed on signal " &
              "asg with slice name prefixed by an indexed name on LHS",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00106" ,
              "Old transactions were removed on signal " &
              "asg with slice name prefixed by an indexed name on LHS",
              false ) ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_arr1_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end Proc1 ;
--
--
end ENT00106 ;
--
architecture ARCH00106 of ENT00106 is
begin
   PGEN_CHKP_1 :
   process ( chk_st_arr1_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Transport transactions entirely completed",
           chk_st_arr1_vector = 4 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
   P1 :
   process ( s_st_arr1_vector )
      variable counter : integer := 0 ;
      variable correct : boolean ;
      variable savtime : time ;
   begin
      Proc1 (
          s_st_arr1_vector,
          counter,
          correct,
          savtime,
          chk_st_arr1_vector
         ) ;
   end process P1 ;
--
--
end ARCH00106 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00106_Test_Bench is
   signal s_st_arr1_vector : st_arr1_vector
     := c_st_arr1_vector_1 ;
--
end ENT00106_Test_Bench ;
--
architecture ARCH00106_Test_Bench of ENT00106_Test_Bench is
begin
   L1:
   block
      component UUT
         port (
              s_st_arr1_vector : inout st_arr1_vector
              ) ;
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00106 ( ARCH00106 ) ;
   begin
      CIS1 : UUT
         port map (
              s_st_arr1_vector
                  ) ;
   end block L1 ;
end ARCH00106_Test_Bench ;
