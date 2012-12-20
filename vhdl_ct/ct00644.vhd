-- NEED RESULT: ARCH00644: The keyword 'in' is optional in a constant declaration for a formal generic of an entity passed
-- NEED RESULT: ARCH00644: The keyword 'in' is optional in a constant declaration for a formal parameter of a procedure passed
-- NEED RESULT: ARCH00644: The keyword 'in' is optional in a constant declaration for a formal generic of a block passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00644
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    4.3.3 (3)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00644(ARCH00644)
--    ENT00644_Test_Bench(ARCH00644_Test_Bench)
--
-- REVISION HISTORY:
--
--    25-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00644 is
   generic ( constant G1 : integer := 0 ;
	     constant G2, G3, G4 : in integer := 3 ) ;


end ENT00644 ;
--
architecture ARCH00644 of ENT00644 is
   procedure Proc ( constant P1 : integer := 0 ;
		    constant P2, P3, P4 : in integer := 3 ) is

   begin
      test_report ( "ARCH00644" ,
		    "The keyword 'in' is optional in a "&
                    "constant declaration for a formal parameter of "&
                    "a procedure" ,
		    (P1 = 1) and
                    (P2 = 2) and
                    (P3 = 3) and
                    (P4 = 4) ) ;
   end Proc ;
begin
   process
   begin
      test_report ( "ARCH00644" ,
		    "The keyword 'in' is optional in a "&
                    "constant declaration for a formal generic of "&
                    "an entity" ,
		    (G1 = 1) and
                    (G2 = 2) and
                    (G3 = 3) and
                    (G4 = 4) ) ;
      Proc (P1 => G1, P2 => G2, P4 => G4) ;
      wait ;
   end process ;

   L1 :
   block
      generic ( constant BG1 : integer := 0 ;
		constant BG2, BG3, BG4 : in integer := 3 ) ;
      generic map ( G1, G2, BG4 => G4 ) ;

   begin
      process
      begin
	 test_report ( "ARCH00644" ,
		       "The keyword 'in' is optional in a "&
                       "constant declaration for a formal generic of "&
                       "a block" ,
		       (BG1 = 1) and
                       (BG2 = 2) and
                       (BG3 = 3) and
                       (BG4 = 4) ) ;
	 wait ;
      end process ;
   end block L1 ;
end ARCH00644 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00644_Test_Bench is
end ENT00644_Test_Bench ;

architecture ARCH00644_Test_Bench of ENT00644_Test_Bench is
begin
   L1:
   block
      component UUT
         generic ( constant CG1 : integer ;
		   constant CG2, CG4 : in integer ) ;
      end component ;

      for CIS1 : UUT use entity WORK.ENT00644 ( ARCH00644 )
			    generic map ( G1 => CG1,
                                          G2 => CG2,
                                          G4 => CG4 );
   begin
      CIS1 : UUT
	 generic map ( 1, 2, 4 );
   end block L1 ;
end ARCH00644_Test_Bench ;
--
