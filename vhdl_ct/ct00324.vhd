-- NEED RESULT: *** An assertion follows with severity level ERROR
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00324
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
--    E00000(ARCH00324)
--    ENT00324_Test_Bench(ARCH00324_Test_Bench)
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
architecture ARCH00324 of E00000 is
   signal Dummy : Boolean := false;
begin
   P1 :
   process ( Dummy )
   begin
      print ("*** An assertion follows with severity level ERROR") ;
   end process P1 ;

   assert Dummy
      report "An assertion with severity ERROR"
      severity Severity_Level'Val (2) ;

end ARCH00324 ;

entity ENT00324_Test_Bench is
end ENT00324_Test_Bench ;

architecture ARCH00324_Test_Bench of ENT00324_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00324 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00324_Test_Bench ;
