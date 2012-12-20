-- NEED RESULT: *** An assertion follows with severity level NOTE
-- NEED RESULT: An assertion with severity NOTE
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00322
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.4 (5)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00322)
--    ENT00322_Test_Bench(ARCH00322_Test_Bench)
--
-- REVISION HISTORY:
--
--    29-JUL-1987   - initial revision
--
-- NOTES:
--
--    Verify that assertion messages match the comment messages output.
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00322 of E00000 is
   signal Dummy : Boolean := false;
begin
   P1 :
   process ( Dummy )
   begin
      print ("*** An assertion follows with severity level NOTE") ;
   end process ;

   assert Dummy
      report "An assertion with severity NOTE"
      severity Severity_Level'Left ;

end ARCH00322 ;

entity ENT00322_Test_Bench is
end ENT00322_Test_Bench ;

architecture ARCH00322_Test_Bench of ENT00322_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00322 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00322_Test_Bench ;
