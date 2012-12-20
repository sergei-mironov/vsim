-- NEED RESULT: *** An assertion follows with severity level WARNING
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00323
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
--    E00000(ARCH00323)
--    ENT00323_Test_Bench(ARCH00323_Test_Bench)
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
architecture ARCH00323 of E00000 is
   signal Dummy : Boolean := false;
begin
   P1 :
   process ( Dummy )
   begin
      print ("*** An assertion follows with severity level WARNING") ;
   end process P1 ;

   assert Dummy
      report "An assertion with severity WARNING"
      severity Severity_Level'Succ (NOTE) ;

end ARCH00323 ;

entity ENT00323_Test_Bench is
end ENT00323_Test_Bench ;

architecture ARCH00323_Test_Bench of ENT00323_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00323 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00323_Test_Bench ;
