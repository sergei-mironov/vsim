-- NEED RESULT: ARCH00194.P2: Transaction occurred on signal asg with no  time expression -- 0 ns assumed passed
-- NEED RESULT: ARCH00194.P1: Transaction occurred on signal asg with no  time expression -- 0 ns assumed passed
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
--    CT00194
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
--    E00000(ARCH00194)
--    ENT00194_Test_Bench(ARCH00194_Test_Bench)
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
architecture ARCH00194 of E00000 is
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_integer : chk_sig_type := -1 ;
   signal chk_st_int1 : chk_sig_type := -1 ;
--
   signal s_integer : integer
     := c_integer_1 ;
   signal s_st_int1 : st_int1
     := c_st_int1_1 ;
--
begin
   PGEN_CHKP_1 :
   process ( chk_integer )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Inertial transactions entirely completed",
           chk_integer = 1 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
   P1 :
   process ( s_integer )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_integer <=
               50 ;
--
         when 1
         => correct :=
               s_integer = 50 and
               savtime = Std.Standard.Now ;
            test_report ( "ARCH00194.P1" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00194.P1" ,
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
   end process P1 ;
--
   PGEN_CHKP_2 :
   process ( chk_st_int1 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P2" ,
           "Inertial transactions entirely completed",
           chk_st_int1 = 1 ) ;
      end if ;
   end process PGEN_CHKP_2 ;
--
   P2 :
   process ( s_st_int1 )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable savtime : time ;
   begin
      case counter is
         when 0
         => s_st_int1 <=
               50 ;
--
         when 1
         => correct :=
               s_st_int1 = 50 and
               savtime = Std.Standard.Now ;
            test_report ( "ARCH00194.P2" ,
              "Transaction occurred on signal asg with no " &
              " time expression -- 0 ns assumed",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00194.P2" ,
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
   end process P2 ;
--
--
end ARCH00194 ;
--
entity ENT00194_Test_Bench is
end ENT00194_Test_Bench ;
--
architecture ARCH00194_Test_Bench of ENT00194_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00194 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00194_Test_Bench ;
