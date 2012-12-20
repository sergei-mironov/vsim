-- NEED RESULT: ARCH00196.P2: Transaction occurred on signal asg with no  time expression -- 0 ns assumed passed
-- NEED RESULT: ARCH00196.P1: Transaction occurred on signal asg with no  time expression -- 0 ns assumed passed
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
--    CT00196
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.3.1 (1)
--    8.3.1 (6)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00196)
--    ENT00196_Test_Bench(ARCH00196_Test_Bench)
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
architecture ARCH00196 of E00000 is
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_real : chk_sig_type := -1 ;
   signal chk_st_real1 : chk_sig_type := -1 ;
--
   signal s_real : real
     := c_real_1 ;
   signal s_st_real1 : st_real1
     := c_st_real1_1 ;
--
begin
   PGEN_CHKP_1 :
   process ( chk_real )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Inertial transactions entirely completed",
           chk_real = 1 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
   P1 :
   process ( s_real )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_real <=
               50.0 ;
--
         when 1
         => correct :=
               s_real = 50.0 and
               savtime = Std.Standard.Now ;
            test_report ( "ARCH00196.P1" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00196.P1" ,
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
   end process P1 ;
--
   PGEN_CHKP_2 :
   process ( chk_st_real1 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P2" ,
           "Inertial transactions entirely completed",
           chk_st_real1 = 1 ) ;
      end if ;
   end process PGEN_CHKP_2 ;
--
   P2 :
   process ( s_st_real1 )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_real1 <=
               50.0 ;
--
         when 1
         => correct :=
               s_st_real1 = 50.0 and
               savtime = Std.Standard.Now ;
            test_report ( "ARCH00196.P2" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00196.P2" ,
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
   end process P2 ;
--
--
end ARCH00196 ;
--
entity ENT00196_Test_Bench is
end ENT00196_Test_Bench ;
--
architecture ARCH00196_Test_Bench of ENT00196_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00196 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00196_Test_Bench ;
