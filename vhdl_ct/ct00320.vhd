-- NEED RESULT: ARCH00320.P2: Execution continues with first statement after last statement in process is executed passed
-- NEED RESULT: ARCH00320.P1: Execution continues with first statement after last statement in process is executed passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00320
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.2 (8)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00320)
--    ENT00320_Test_Bench(ARCH00320_Test_Bench)
--
-- REVISION HISTORY:
--
--    29-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00320 of E00000 is
   signal s1, s2 : boolean := false;
begin
   P1 :
   process ( s1 )
      variable count : Integer := 0 ;
      variable First_Time : boolean := True ;
      variable SavTime : Time := Std.Standard.Now ;
   begin
      count := count + 1;
      if First_Time then
	 First_Time := False ;
	 s1 <= transport Not s1 after 10 ns ;
      else
	 test_report ( "ARCH00320.P1" ,
		       "Execution continues with first statement after "&
                       "last statement in process is executed" ,
		       ((SavTime + 10 ns) = Std.Standard.Now) and
                       (count = 2) and s1) ;
      end if ;
   end process P1 ;

   P2 :
   process
      variable count : Integer := 0 ;
      variable First_Time : boolean := True ;
      variable SavTime : Time := Std.Standard.Now ;
      variable correct : boolean := False ;
   begin
      count := count + 1;
      if First_Time then
	 First_Time := False ;
	 s2 <= transport Not s2 after 10 ns ;
         wait on s2 ;
         correct := s2 and
                    (count = 1) and
                    ((SavTime + 10 ns) = Std.Standard.Now) ;
         SavTime := Std.Standard.Now ;
      else
	 test_report ( "ARCH00320.P2" ,
		       "Execution continues with first statement after "&
                       "last statement in process is executed" ,
		       (SavTime = Std.Standard.Now) and s2 and correct and
                       (count = 2) ) ;
         wait;
      end if ;
   end process P2 ;
end ARCH00320 ;

entity ENT00320_Test_Bench is
end ENT00320_Test_Bench ;

architecture ARCH00320_Test_Bench of ENT00320_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00320 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00320_Test_Bench ;
