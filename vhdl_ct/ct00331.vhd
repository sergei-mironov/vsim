-- NEED RESULT: ARCH00331: Component instantiated with no port or generic clause passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00331
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.6 (1)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00331(ARCH00331)
--    ENT00331_Test_Bench(ARCH00331_Test_Bench)
--
-- REVISION HISTORY:
--
--    30-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00331 is
   generic ( G : in Integer := 1987 ) ;
   port ( P : in Time := 100 ns ) ;
end ENT00331 ;

architecture ARCH00331 of ENT00331 is
begin
   process
   begin
      test_report ( "ARCH00331" ,
		    "Component instantiated with no port or generic clause" ,
		    (G = 1987) and (P = 100 ns) ) ;
      wait ;
   end process ;
end ARCH00331 ;

entity ENT00331_Test_Bench is
end ENT00331_Test_Bench ;

architecture ARCH00331_Test_Bench of ENT00331_Test_Bench is
begin
   L1:
   block
      component UUT
         generic ( G : in Integer := 1987 ) ;
         port ( P : in Time := 100 ns ) ;
      end component ;

      for CIS1 : UUT use entity WORK.ENT00331 ( ARCH00331 ) ;
   begin
      CIS1 : UUT
	 generic map ( open )
	 port map ( open ) ;

   end block L1 ;
end ARCH00331_Test_Bench ;
