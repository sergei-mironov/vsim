-- NEED RESULT: ARCH00285: Block statement with no generic clause passed
-- NEED RESULT: ARCH00285: Block statement with a generic clause passed
-- NEED RESULT: ARCH00285: Block statement with a generic clause and map passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00285
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.1 (5)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00285(ARCH00285)
--    ENT00285_Test_Bench(ARCH00285_Test_Bench)
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
entity ENT00285 is
   generic ( G1, G2 : integer ) ;
end ENT00285 ;

architecture ARCH00285 of ENT00285 is
   constant C : integer := G1 + G2 ;
begin
   B1 :
   block
   begin
      process
      begin
	 test_report ( "ARCH00285" ,
		       "Block statement with no generic clause" ,
		       True ) ;
         wait ;
      end process ;
   end block B1 ;

   B2 :
   block
      generic ( G : integer := G1 + C ) ;
   begin
      process
      begin
	 test_report ( "ARCH00285" ,
		       "Block statement with a generic clause" ,
		       G = (2*G1 + G2) ) ;
         wait ;
      end process ;
   end block B2 ;

   B3 :
   block
      generic ( G : integer := G1 + C ) ;
      generic map ( G => G1 + G2 ) ;
   begin
      process
      begin
	 test_report ( "ARCH00285" ,
		       "Block statement with a generic clause and map" ,
		       G = C ) ;
         wait ;
      end process ;
   end block B3 ;
end ARCH00285 ;

entity ENT00285_Test_Bench is
end ENT00285_Test_Bench ;

architecture ARCH00285_Test_Bench of ENT00285_Test_Bench is
begin
   L1:
   block
      component UUT
	 generic ( G1,G2 : integer ) ;
      end component ;

      for CIS1 : UUT use entity WORK.ENT00285 ( ARCH00285 ) ;
   begin
      CIS1 : UUT
	 generic map ( 1, 2 );
   end block L1 ;
end ARCH00285_Test_Bench ;
