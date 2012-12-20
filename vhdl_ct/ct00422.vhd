-- NEED RESULT: ARCH00422: Dynamic elaboration passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00422
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    12.5 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00422)
--    ENT00422_Test_Bench(ARCH00422_Test_Bench)
--
-- REVISION HISTORY:
--
--    31-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00422 of E00000 is
   function f ( x,y : integer ) return integer is
      constant cx : integer := x+2 ;
      constant cy : integer := 2*y ;
   begin
      return cx + cy ;
   end f ;
begin
   P :
   process
   begin
      test_report ( "ARCH00422" ,
		    "Dynamic elaboration" ,
		    f(10, 4) = (10+2) + (2*4)
                  ) ;
      wait ;
   end process P ;
end ARCH00422 ;

entity ENT00422_Test_Bench is
end ENT00422_Test_Bench ;

architecture ARCH00422_Test_Bench of ENT00422_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00422 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00422_Test_Bench ;

