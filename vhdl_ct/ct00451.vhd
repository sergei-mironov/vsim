-- NEED RESULT: ARCH00451: A concurrent procedure call may appear in a generate stm passed
-- NEED RESULT: ARCH00451: A concurrent procedure call may appear in a generate stm passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00451
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.7 (1)
--    9.7 (4)
--    9.7 (8)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00451)
--    ENT00451_Test_Bench(ARCH00451_Test_Bench)
--
-- REVISION HISTORY:
--
--     5-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00451 of E00000 is
   constant C : boolean := True;
   procedure Proc (constant P : boolean) is
   begin
      test_report ( "ARCH00451" ,
		    "A concurrent procedure call may appear in a generate stm" ,
		    P ) ;
   end Proc ;
begin
   For_Gen :
   for i in 1 to 1 generate
     -- Test that a concurrent procedure call is allowed.
     Proc (i = 1) ;
   end generate For_Gen ;

   If_Gen :
   if C generate
     -- Test that a concurrent procedure call is allowed.
     Proc (C) ;
   end generate If_Gen ;
end ARCH00451 ;


entity ENT00451_Test_Bench is
end ENT00451_Test_Bench ;

architecture ARCH00451_Test_Bench of ENT00451_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00451 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00451_Test_Bench ;
