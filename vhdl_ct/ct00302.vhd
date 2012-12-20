-- NEED RESULT: ARCH00302: Block statement with generic map passed
-- NEED RESULT: ARCH00302: Block statement without generic map passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00302
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.1 (7)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00302)
--    ENT00302_Test_Bench(ARCH00302_Test_Bench)
--
-- REVISION HISTORY:
--
--    24-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00302 of E00000 is
begin
   B1 :
   block
      generic ( g1 : boolean ;
		g2 : bit ) ;
      generic map ( false,
		    g2 => '0' ) ;
   begin
      process
      begin
	 test_report ( "ARCH00302" ,
		       "Block statement with generic map" ,
		       (not g1) and (g2='0') ) ;
         wait ;
      end process ;
   end block B1 ;

   B2 :
   block
      generic ( g1 : boolean := false ;
		g2 : bit := '0') ;
   begin
      process
      begin
	 test_report ( "ARCH00302" ,
		       "Block statement without generic map" ,
		       (not g1) and (g2='0') ) ;
         wait ;
      end process ;
   end block B2 ;
end ARCH00302 ;

entity ENT00302_Test_Bench is
end ENT00302_Test_Bench ;

architecture ARCH00302_Test_Bench of ENT00302_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00302 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00302_Test_Bench ;
