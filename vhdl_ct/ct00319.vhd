-- NEED RESULT: ARCH00319: Test completed successfully passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00319
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.2 (7)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00319)
--    ENT00319_Test_Bench(ARCH00319_Test_Bench)
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
architecture ARCH00319 of E00000 is
   signal s1, complete : boolean := false;
begin
   P1 :
   process ( s1 )
      variable First_Time : boolean := True ;
   begin
      if First_Time then
	 First_Time := False ;
      else
         -- This should never execute if last statement is an implicit Wait
	 test_report ( "ARCH00319" ,
		       "Last statement in a Process with a Sens List "&
                       "is an implicit Wait" ,
		       False ) ;
      end if ;

      complete <= transport Not complete ;

      -- Should sit here forever since no events are scheduled on s1

   end process P1 ;

   Check_Completion :
   process
   begin
      wait on complete ;
      test_report ( "ARCH00319" ,
		    "Test completed successfully" ,
		    complete ) ;
   end process Check_Completion ;
end ARCH00319 ;

entity ENT00319_Test_Bench is
end ENT00319_Test_Bench ;

architecture ARCH00319_Test_Bench of ENT00319_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00319 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00319_Test_Bench ;
