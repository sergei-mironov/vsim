-- NEED RESULT: ARCH00115.P1: Multi transport transactions occurred on signal asg with indexed name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00115: One transport transaction occurred on signal asg with indexed name prefixed by a selected name on LHS failed
-- NEED RESULT: ARCH00115: Old transactions were removed on signal asg with indexed name prefixed by a selected name on LHS failed
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
--    CT00115
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
--    ENT00115(ARCH00115)
--    ENT00115_Test_Bench(ARCH00115_Test_Bench)
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
entity ENT00115 is
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_st_rec3 : chk_sig_type := -1 ;
--
   procedure Proc1 (
      signal   s_st_rec3 : inout st_rec3 ;
      variable counter : inout integer ;
      variable correct : inout boolean ;
      variable savtime : inout time ;
      signal   chk_st_rec3 : out chk_sig_type
                   )
   is
   begin
      case counter is
         when 0 =>
            s_st_rec3.f3 (
              s_st_rec3.f3'Left(1),s_st_rec3.f3'Left(2)) <= transport
               c_st_rec3_2.f3 (
                 s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) after 10 ns,
               c_st_rec3_1.f3 (
                 s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) after 20 ns ;
--
         when 1 =>
            correct :=
               s_st_rec3.f3 (
                 s_st_rec3.f3'Left(1),s_st_rec3.f3'Left(2)) =
                  c_st_rec3_2.f3 (
                    s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) and
               (savtime + 10 ns) = Std.Standard.Now ;
--
         when 2 =>
            correct :=
               correct and
               s_st_rec3.f3 (
                 s_st_rec3.f3'Left(1),s_st_rec3.f3'Left(2)) =
                  c_st_rec3_1.f3 (
                    s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) and
               (savtime + 10 ns) = Std.Standard.Now ;
            test_report ( "ARCH00115.P1" ,
              "Multi transport transactions occurred on signal " &
              "asg with indexed name prefixed by a selected name on LHS",
              correct ) ;
            s_st_rec3.f3 (
              s_st_rec3.f3'Left(1),s_st_rec3.f3'Left(2)) <= transport
               c_st_rec3_2.f3 (
                 s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) after 10 ns,
               c_st_rec3_1.f3 (
                 s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) after 20 ns,
               c_st_rec3_2.f3 (
                 s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) after 30 ns,
               c_st_rec3_1.f3 (
                 s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) after 40 ns ;
--
         when 3 =>
            correct :=
               s_st_rec3.f3 (
                 s_st_rec3.f3'Left(1),s_st_rec3.f3'Left(2)) =
                  c_st_rec3_2.f3 (
                    s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) and
               (savtime + 10 ns) = Std.Standard.Now ;
            s_st_rec3.f3 (
              s_st_rec3.f3'Left(1),s_st_rec3.f3'Left(2)) <= transport
               c_st_rec3_1.f3 (
                 s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) after 5 ns;
--
         when 4 =>
            correct :=
               correct and
               s_st_rec3.f3 (
                 s_st_rec3.f3'Left(1),s_st_rec3.f3'Left(2)) =
                  c_st_rec3_1.f3 (
                    s_st_rec3.f3'Right(1),s_st_rec3.f3'Right(2)) and
               (savtime + 5 ns) = Std.Standard.Now ;
            test_report ( "ARCH00115" ,
              "One transport transaction occurred on signal " &
              "asg with indexed name prefixed by a selected name on LHS",
              correct ) ;
            test_report ( "ARCH00115" ,
              "Old transactions were removed on signal " &
              "asg with indexed name prefixed by a selected name on LHS",
              correct ) ;
--
         when others
         => -- No more transactions should have occurred
            test_report ( "ARCH00115" ,
              "Old transactions were removed on signal " &
              "asg with indexed name prefixed by a selected name on LHS",
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
--
end ENT00115 ;
--
architecture ARCH00115 of ENT00115 is
   signal s_st_rec3 : st_rec3
     := c_st_rec3_1 ;
--
begin
   PGEN_CHKP_1 :
   process ( chk_st_rec3 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Transport transactions entirely completed",
           chk_st_rec3 = 4 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
   P1 :
   process ( s_st_rec3 )
      variable counter : integer := 0 ;
      variable correct : boolean ;
      variable savtime : time ;
   begin
      Proc1 (
          s_st_rec3,
          counter,
          correct,
          savtime,
          chk_st_rec3
         ) ;
   end process P1 ;
--
--
end ARCH00115 ;
--
entity ENT00115_Test_Bench is
end ENT00115_Test_Bench ;
--
architecture ARCH00115_Test_Bench of ENT00115_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.ENT00115 ( ARCH00115 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00115_Test_Bench ;
