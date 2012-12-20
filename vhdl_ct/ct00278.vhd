-- NEED RESULT: ARCH00278: Block Statement with label on end of stm passed
-- NEED RESULT: ARCH00278: Block Statement with no label on end of stm passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00278
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.1 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00278)
--    ENT00278_Test_Bench(ARCH00278_Test_Bench)
--
-- REVISION HISTORY:
--
--    21-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00278 of E00000 is
   signal S : boolean := true ;
begin
   B1 :
   block
   begin
      P1 :
      process ( S )
      begin
	 test_report ( "ARCH00278" ,
		       "Block Statement with label on end of stm" ,
		       True ) ;
      end process P1 ;
   end block B1 ;

   B2 :
   block
      signal S : boolean := true ;
   begin
      P1 :
      process ( S )
      begin
	 test_report ( "ARCH00278" ,
		       "Block Statement with no label on end of stm" ,
		       True ) ;
      end process P1 ;
   end block ;
end ARCH00278 ;

entity ENT00278_Test_Bench is
end ENT00278_Test_Bench ;

architecture ARCH00278_Test_Bench of ENT00278_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00278 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00278_Test_Bench ;
