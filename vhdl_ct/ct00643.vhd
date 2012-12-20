-- NEED RESULT: ARCH00643: The keyword 'Constant' is optional in a constant declaration for a formal generic of an entity passed
-- NEED RESULT: ARCH00643: The keyword 'Constant' is optional in a constant declaration for a formal parameter of a procedure passed
-- NEED RESULT: ARCH00643: The keyword 'Constant' is optional in a constant declaration for a formal generic of a block passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00643
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    4.3.3 (2)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00643(ARCH00643)
--    ENT00643_Test_Bench(ARCH00643_Test_Bench)
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
entity ENT00643 is
   generic (          G1 : in integer := 0 ;
	     constant G2, G3, G4 : in integer := 3 ) ;


end ENT00643 ;
--
architecture ARCH00643 of ENT00643 is
   procedure Proc (          P1 : in integer := 0 ;
		    constant P2, P3, P4 : in integer := 3 ) is

   begin
      test_report ( "ARCH00643" ,
		    "The keyword 'Constant' is optional in a "&
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
      test_report ( "ARCH00643" ,
		    "The keyword 'Constant' is optional in a "&
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
      generic (          BG1 : in integer := 0 ;
		constant BG2, BG3, BG4 : in integer := 3 ) ;
      generic map ( G1, G2, BG4 => G4 ) ;

   begin
      process
      begin
	 test_report ( "ARCH00643" ,
		       "The keyword 'Constant' is optional in a "&
                       "constant declaration for a formal generic of "&
                       "a block" ,
		       (BG1 = 1) and
                       (BG2 = 2) and
                       (BG3 = 3) and
                       (BG4 = 4) ) ;
	 wait ;
      end process ;
   end block L1 ;
end ARCH00643 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00643_Test_Bench is
end ENT00643_Test_Bench ;

architecture ARCH00643_Test_Bench of ENT00643_Test_Bench is
begin
   L1:
   block
      component UUT
         generic (          CG1 : in integer ;
		   constant CG2, CG4 : in integer ) ;
      end component ;

      for CIS1 : UUT use entity WORK.ENT00643 ( ARCH00643 )
			    generic map ( G1 => CG1,
                                          G2 => CG2,
                                          G4 => CG4 );
   begin
      CIS1 : UUT
	 generic map ( 1, 2, 4 );
   end block L1 ;
end ARCH00643_Test_Bench ;
--
