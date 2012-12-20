-- NEED RESULT: *** An assertion follows with severity level NOTE
-- NEED RESULT: An assertion with severity NOTE
-- NEED RESULT: *** An assertion follows with severity level WARNING
-- NEED RESULT: *** An assertion follows with severity level ERROR
-- NEED RESULT: *** An assertion follows with severity level FAILURE
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00029
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.2 (4)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00029)
--    ENT00029_Test_Bench(ARCH00029_Test_Bench)
--
-- REVISION HISTORY:
--
--    26-JUN-1987   - initial revision
--
-- NOTES:
--
--    Verify that assertion messages match the comment messages output.
--
use WORK.STANDARD_TYPES.all;
architecture ARCH00029 of E00000 is
   signal Dummy : Boolean := false ;
begin
   P1 :
   process ( Dummy )
   begin
      print ("*** An assertion follows with severity level NOTE") ;
      assert Dummy
	report "An assertion with severity NOTE"
	severity Severity_Level'Left ;

      print ("*** An assertion follows with severity level WARNING") ;
      assert Dummy
	report "An assertion with severity WARNING"
	severity Severity_Level'Succ (NOTE) ;

      print ("*** An assertion follows with severity level ERROR") ;
      assert Dummy
	report "An assertion with severity ERROR"
	severity Severity_Level'Val (2) ;

      print ("*** An assertion follows with severity level FAILURE") ;
      assert Dummy
	report "An assertion with severity FAILURE"
	severity Severity_Level'High ;
   end process P1 ;

end ARCH00029 ;

entity ENT00029_Test_Bench is
end ENT00029_Test_Bench ;

architecture ARCH00029_Test_Bench of ENT00029_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00029 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00029_Test_Bench ;
