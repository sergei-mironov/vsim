-- NEED RESULT: *** An assertion follows with Report = 'Assertion stm with report and severity clause' and Severity = 'NOTE'
-- NEED RESULT: Assertion stm with report and severity clause
-- NEED RESULT: *** An assertion follows with Report = 'Assertion stm with only a report clause' and Severity defaulting to 'ERROR'
-- NEED RESULT: *** An assertion follows with Report defaulting to 'Assertion Violation' and Severity = 'WARNING'
-- NEED RESULT: *** An assertion follows with Report defaulting to 'Assertion Violation' and Severity defaluting to 'ERROR'
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00028
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.2 (1)
--    8.2 (2)
--    8.2 (3)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00028)
--    ENT00028_Test_Bench(ARCH00028_Test_Bench)
--
-- REVISION HISTORY:
--
--    26-JUN-1987   - initial revision
--
-- NOTES:
--
--    Verify that assertion messages match the comment messages output.
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00028 of E00000 is
   signal Dummy : Boolean := false ;
begin
   P1 :
   process ( Dummy )
   begin
      print ( "*** An assertion follows with Report = "&
              "'Assertion stm with report and severity clause' and "&
              "Severity = 'NOTE'" ) ;
      assert Dummy
	report "Assertion stm with report and severity clause"
	severity NOTE ;
   end process P1 ;

   P2 :
   process ( Dummy )
   begin
      print ( "*** An assertion follows with Report = "&
              "'Assertion stm with only a report clause' and "&
              "Severity defaulting to 'ERROR'" ) ;
      assert false
	report "Assertion stm with only a report clause";
   end process P2 ;

   P3 :
   process ( Dummy )
   begin
      print ( "*** An assertion follows with Report defaulting to "&
              "'Assertion Violation' and "&
              "Severity = 'WARNING'" ) ;
      assert Dummy
	severity WARNING ;
   end process P3 ;

   P4 :
   process ( Dummy )
   begin
      print ( "*** An assertion follows with Report defaulting to "&
              "'Assertion Violation' and "&
              "Severity defaluting to 'ERROR'" ) ;
      assert false;
   end process P4 ;
end ARCH00028 ;

entity ENT00028_Test_Bench is
end ENT00028_Test_Bench ;

architecture ARCH00028_Test_Bench of ENT00028_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00028 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00028_Test_Bench ;
