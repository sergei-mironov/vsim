-- NEED RESULT: ARCH00281: Implicit signal GUARD used in a expression passed
-- NEED RESULT: ARCH00281: Implicit signal GUARD passed to procedure passed
-- NEED RESULT: ARCH00281: Implicit signal GUARD passed in to component passed
-- NEED RESULT: ARCH00281: Implicit signal GUARD used in a expression passed
-- NEED RESULT: ARCH00281: Implicit signal GUARD passed to procedure passed
-- NEED RESULT: ARCH00281: Implicit signal GUARD passed in to component passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00281
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.1 (3)
--    9.1 (4)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00281_1(ARCH00281_1)
--    E00000(ARCH00281)
--    ENT00281_Test_Bench(ARCH00281_Test_Bench)
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
entity ENT00281_1 is
   port ( G  : in boolean ;
	  P1 : in integer ;
	  P2 : in integer ) ;
end ;

architecture ARCH00281_1 of ENT00281_1 is
begin
      process (G)
      begin
	 test_report ( "ARCH00281" ,
		       "Implicit signal GUARD passed in to component" ,
		       (G = (P1 = P2)) ) ;
      end process ;
end ;

use WORK.STANDARD_TYPES.all ;
architecture ARCH00281 of E00000 is
   signal S1 : integer := 0 ;
   signal S2 : integer := 1 ;
begin
   B1 :
   block ( S1 = S2 )
   begin
      process (GUARD)
      begin
	 test_report ( "ARCH00281" ,
		       "Implicit signal GUARD used in a expression" ,
		       (GUARD = (S1 = S2)) ) ;
      end process ;
   end block B1 ;

   B2 :
   block ( S1 = S2 )
      procedure Proc ( constant G : in boolean ;
		       constant P1, P2 : in integer ) is
      begin
	 test_report ( "ARCH00281" ,
		       "Implicit signal GUARD passed to procedure" ,
		       (G = (P1 = P2)) ) ;
      end Proc ;
   begin
      P1 :
      process ( GUARD )
      begin
	 Proc (GUARD, S1, S2) ;
      end process P1 ;
   end block B2 ;

   B3 :
   block ( S1 = S2 )
      component Test_Comp
	 port ( G : in boolean ;
		P1 : in integer ;
		P2 : in integer ) ;
      end component ;

      for all : Test_Comp
         use entity WORK.ENT00281_1 ( ARCH00281_1 );

   begin
      CIS1 : Test_Comp
	 port map ( GUARD, S1, S2 ) ;
   end block B3 ;

   S1 <= transport 1 after 10 ns ;
end ARCH00281 ;

entity ENT00281_Test_Bench is
end ENT00281_Test_Bench ;

architecture ARCH00281_Test_Bench of ENT00281_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00281 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00281_Test_Bench ;
