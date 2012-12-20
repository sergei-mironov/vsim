-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00647
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    4.3.3 (6)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00647(ARCH00647)
--    ENT00647_Test_Bench(ARCH00647_Test_Bench)
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
entity ENT00647 is
   port ( signal G1 : integer := 0 ;
	  signal G2, G3, G4 : in integer := 3 ) ;

end ENT00647 ;
--
architecture ARCH00647 of ENT00647 is
   procedure Proc ( signal P1 : integer := 0 ;
		    signal P2, P3, P4 : in integer := 3 ) is

   begin
      test_report ( "ARCH00647" ,
		    "The keyword 'in' is optional in a "&
                    "signal declaration for a formal parameter of "&
                    "a procedure" ,
		    (P1 = 1) and
                    (P2 = 2) and
                    (P3 = 3) and
                    (P4 = 4) ) ;
   end Proc ;
begin
   process
   begin
      test_report ( "ARCH00647" ,
		    "The keyword 'in' is optional in a "&
                    "signal declaration for a formal port of "&
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
      port ( signal BG1 : integer := 0 ;
             signal BG2, BG3, BG4 : in integer := 3 ) ;
      port map ( G1, G2, BG4 => G4 ) ;

   begin
      process
      begin
	 test_report ( "ARCH00647" ,
		       "The keyword 'in' is optional in a "&
                       "signal declaration for a formal port of "&
                       "a block" ,
		       (BG1 = 1) and
                       (BG2 = 2) and
                       (BG3 = 3) and
                       (BG4 = 4) ) ;
	 wait ;
      end process ;
   end block L1 ;
end ARCH00647 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00647_Test_Bench is
end ENT00647_Test_Bench ;

architecture ARCH00647_Test_Bench of ENT00647_Test_Bench is
begin
   L1:
   block
      component UUT
         port ( signal CG1 : integer ;
		signal CG2, CG4 : in integer ) ;
      end component ;

      for CIS1 : UUT use entity WORK.ENT00647 ( ARCH00647 )
			    port map ( G1 => CG1,
                                       G2 => CG2,
                                       G4 => CG4 );
      signal S1 : integer := 1 ;
      signal S2 : integer := 2 ;
      signal S4 : integer := 4 ;

   begin
      CIS1 : UUT
	 port map ( S1, S2, S4 );
   end block L1 ;
end ARCH00647_Test_Bench ;
--
