-- NEED RESULT: ARCH00056.P1: Loop statement with a label passed
-- NEED RESULT: ARCH00056.P2: Loop statement with a label passed
-- NEED RESULT: ARCH00056.P3: Loop statement without a label passed
-- NEED RESULT: ARCH00056.P4: Loop statement without a label passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00056
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.8 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00056)
--    ENT00056_Test_Bench(ARCH00056_Test_Bench)
--
-- REVISION HISTORY:
--
--     2-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00056 of E00000 is
   signal Dummy : Boolean := false ;
begin
   P1 :
   process ( Dummy )
      variable Counter : integer := 0 ;
   begin
      L1 :
      while Counter < 10 loop
	 Counter := Counter + 1 ;
      end loop L1 ;
      test_report ( "ARCH00056.P1" ,
		    "Loop statement with a label" ,
		    Counter = 10 ) ;
   end process P1 ;

   P2 :
   process ( Dummy )
      variable Counter : integer := 0 ;
   begin
      L1 :
      for i in 1 to 10 loop
	 Counter := Counter + 1 ;
      end loop L1 ;
      test_report ( "ARCH00056.P2" ,
		    "Loop statement with a label" ,
		    Counter = 10 ) ;
   end process P2 ;

   P3 :
   process ( Dummy )
      variable Counter : integer := 0 ;
   begin
      while Counter < 10 loop
	 Counter := Counter + 1 ;
      end loop ;
      test_report ( "ARCH00056.P3" ,
		    "Loop statement without a label" ,
		    Counter = 10 ) ;
   end process P3 ;

   P4 :
   process ( Dummy )
      variable Counter : integer := 0 ;
   begin
      for i in 1 to 10 loop
	 Counter := Counter + 1 ;
      end loop ;
      test_report ( "ARCH00056.P4" ,
		    "Loop statement without a label" ,
		    Counter = 10 ) ;
   end process P4 ;

end ARCH00056 ;

entity ENT00056_Test_Bench is
end ENT00056_Test_Bench ;

architecture ARCH00056_Test_Bench of ENT00056_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00056 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00056_Test_Bench ;
