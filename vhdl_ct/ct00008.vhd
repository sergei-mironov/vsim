-- NEED RESULT: ARCH00008.P1: Wait has sens_list, condition, time passed
-- NEED RESULT: ARCH00008.GLB_PROC1: Wait has sens_list, condition, time passed
-- NEED RESULT: ARCH00008.P1: Wait has sens_list, condition passed
-- NEED RESULT: ARCH00008.GLB_PROC1: Wait has sens_list, condition passed
-- NEED RESULT: ARCH00008.P1: Wait has sens_list, time passed
-- NEED RESULT: ARCH00008.GLB_PROC1: Wait has sens_list, time passed
-- NEED RESULT: ARCH00008.P1: Wait has sens_list passed
-- NEED RESULT: ARCH00008.GLB_PROC1: Wait has sens_list passed
-- NEED RESULT: ARCH00008.P1: Wait has condition, time passed
-- NEED RESULT: ARCH00008.GLB_PROC1: Wait has condition, time passed
-- NEED RESULT: ARCH00008.P1: Wait has condition passed
-- NEED RESULT: ARCH00008.GLB_PROC1: Wait has condition passed
-- NEED RESULT: ARCH00008.GLB_PROC1: Wait has time passed
-- NEED RESULT: ARCH00008.P1: Wait has time passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00008
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.1 (2)
--    8.1 (3)
--    8.1 (4)
--    8.1 (6)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00008)
--    ENT00008_Test_Bench(ARCH00008_Test_Bench)
--
-- REVISION HISTORY:
--
--    25-JUN-1987   - initial revision
--    11-DEC-1989   - GDT: in case 7, changed time clause from 0ns to 10ns and
--                         modified test_report pass/fail condition
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00008 of E00000 is  -- Check with simple names
   signal Test_Case : Integer := 0 ;
   constant Max_Test_Cases : Integer := 8 ;

   procedure Glb_Proc1 is
      variable Save : Integer;
   begin
      Save := Test_Case;
      case Test_Case is
	 when 1 =>
	    wait on Test_Case until True for (Time'High - Std.Standard.Now) ;
	    test_report ( "ARCH00008.GLB_PROC1" ,
			  "Wait has sens_list, condition, time" ,
			  Save /= Test_Case ) ;
	 when 2 =>
	    wait on Test_Case until True ;
	    test_report ( "ARCH00008.GLB_PROC1" ,
			  "Wait has sens_list, condition" ,
			  Save /= Test_Case ) ;
	 when 3 =>
	    wait on Test_Case for (Time'High - Std.Standard.Now) ;
	    test_report ( "ARCH00008.GLB_PROC1" ,
			  "Wait has sens_list, time" ,
			  Save /= Test_Case ) ;
	 when 4 =>
	    wait on Test_Case ;
	    test_report ( "ARCH00008.GLB_PROC1" ,
			  "Wait has sens_list" ,
			  Save /= Test_Case ) ;
	 when 5 =>
	    wait until (Test_Case = Test_Case) for (Time'High - Std.Standard.Now) ;
	    test_report ( "ARCH00008.GLB_PROC1" ,
			  "Wait has condition, time" ,
			  Save /= Test_Case ) ;
	 when 6 =>
	    wait until (Test_Case = Test_Case) ;
	    test_report ( "ARCH00008.GLB_PROC1" ,
			  "Wait has condition" ,
			  Save /= Test_Case ) ;
	 when 7 =>
	    -- GDT 12-7-89: wait for 0 ns ;
	    wait for 10 ns ;
	    test_report ( "ARCH00008.GLB_PROC1" ,
			  "Wait has time" ,
			  -- GDT 12-7-89: Save = Test_Case ) ;
			  Save /= Test_Case ) ;
	 when 8 =>
	    wait ;
	    test_report ( "ARCH00008.GLB_PROC1" ,
			  "Wait with no clauses" ,
			  False ) ;
	 when others =>
	    wait on Test_Case ;

      end case ;
   end Glb_Proc1 ;

begin
   Change_Test_Case :
   process (Test_Case)
   begin
      if Test_Case < Max_Test_Cases then
         Test_Case <= transport (Test_Case + 1) after 10 ns;
      end if ;
   end process Change_Test_Case ;

   P1 :
   process
      variable Save : Integer;
   begin
      Save := Test_Case;
      case Test_Case is
	 when 1 =>
	    wait on Test_Case until True for (Time'High - Std.Standard.Now) ;
	    test_report ( "ARCH00008.P1" ,
			  "Wait has sens_list, condition, time" ,
			  Save /= Test_Case ) ;
	 when 2 =>
	    wait on Test_Case until True ;
	    test_report ( "ARCH00008.P1" ,
			  "Wait has sens_list, condition" ,
			  Save /= Test_Case ) ;
	 when 3 =>
	    wait on Test_Case for (Time'High - Std.Standard.Now) ;
	    test_report ( "ARCH00008.P1" ,
			  "Wait has sens_list, time" ,
			  Save /= Test_Case ) ;
	 when 4 =>
	    wait on Test_Case ;
	    test_report ( "ARCH00008.P1" ,
			  "Wait has sens_list" ,
			  Save /= Test_Case ) ;
	 when 5 =>
	    wait until (Test_Case = Test_Case) for (Time'High - Std.Standard.Now) ;
	    test_report ( "ARCH00008.P1" ,
			  "Wait has condition, time" ,
			  Save /= Test_Case ) ;
	 when 6 =>
	    wait until (Test_Case = Test_Case) ;
	    test_report ( "ARCH00008.P1" ,
			  "Wait has condition" ,
			  Save /= Test_Case ) ;
	 when 7 =>
	    -- GDT 12-7-89: wait for 0 ns ;
	    wait for 10 ns ;
	    test_report ( "ARCH00008.P1" ,
			  "Wait has time" ,
			  -- GDT 12-7-89: Save = Test_Case ) ;
			  Save /= Test_Case ) ;
	 when 8 =>
	    wait ;
	    test_report ( "ARCH00008.P1" ,
			  "Wait with no clauses" ,
			  False ) ;
	 when others =>
	    wait on Test_Case ;

      end case ;
   end process P1 ;

   P2 :
   process
   begin
      Glb_Proc1 ;
   end process P2 ;

end ARCH00008 ;

entity ENT00008_Test_Bench is
end ENT00008_Test_Bench ;

architecture ARCH00008_Test_Bench of ENT00008_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00008 ) ;

   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00008_Test_Bench ;

