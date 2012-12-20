-- NEED RESULT: ARCH00315: Process with Sens List and End Label passed
-- NEED RESULT: ARCH00315: Process has no process declarative items in itsdeclarative part passed
-- NEED RESULT: ARCH00315: Process with Sens List and No End Label passed
-- NEED RESULT: ARCH00315: Process has no process declarative items in itsdeclarative part passed
-- NEED RESULT: ARCH00315: Process with No Sens List and End Label passed
-- NEED RESULT: ARCH00315: Process has no process declarative items in itsdeclarative part passed
-- NEED RESULT: ARCH00315: Process with No Sens List and No End Label passed
-- NEED RESULT: ARCH00315: Process has no process declarative items in itsdeclarative part passed
-- NEED RESULT: ARCH00315: Test completed successfully passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00315
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.2 (1)
--    9.2 (2)
--    9.2 (4)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00315)
--    ENT00315_Test_Bench(ARCH00315_Test_Bench)
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
architecture ARCH00315 of E00000 is
   signal s1, s2 : boolean := True ;
   signal chk1, chk2, chk3, chk4, Complete : boolean := False ;
begin
   P1 :  -- Sensitivity List and End Label
   process ( s1 )
   begin
      test_report ( "ARCH00315" ,
		    "Process with Sens List and End Label" ,
		    True ) ;
      test_report ( "ARCH00315" ,
		    "Process has no process declarative items in its" &
                    "declarative part" ,
		    True ) ;
      chk1 <= transport True ;
   end process P1 ;

   P2 :  -- Sensitivity List and No End Label
   process ( s2 )
   begin
      test_report ( "ARCH00315" ,
		    "Process with Sens List and No End Label" ,
		    True ) ;
      test_report ( "ARCH00315" ,
		    "Process has no process declarative items in its" &
                    "declarative part" ,
		    True ) ;
      chk2 <= transport True ;
   end process ;

   P3 :  -- No Sensitivity List and End Label
   process
   begin
      test_report ( "ARCH00315" ,
		    "Process with No Sens List and End Label" ,
		    True ) ;
      test_report ( "ARCH00315" ,
		    "Process has no process declarative items in its" &
                    "declarative part" ,
		    True ) ;
      chk3 <= transport True ;
      wait ;
   end process P3 ;

   P4 :  -- No Sensitivity List and No End Label
   process
   begin
      test_report ( "ARCH00315" ,
		    "Process with No Sens List and No End Label" ,
		    True ) ;
      test_report ( "ARCH00315" ,
		    "Process has no process declarative items in its" &
                    "declarative part" ,
		    True ) ;
      chk4 <= transport True ;
      wait ;
   end process ;

   complete <= transport True after 100 ns ;

   Completion_Test :
   process ( complete )
      variable First_Time : boolean := True ;
   begin
      if First_Time then
	 First_Time := False ;
      else
	 test_report ( "ARCH00315" ,
		       "Test completed successfully" ,
		       (chk1 and chk2 and chk3 and chk4) ) ;
      end if ;
   end process Completion_Test ;

end ARCH00315 ;

entity ENT00315_Test_Bench is
end ENT00315_Test_Bench ;

architecture ARCH00315_Test_Bench of ENT00315_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00315 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00315_Test_Bench ;
