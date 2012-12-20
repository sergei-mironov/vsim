-- NEED RESULT: ARCH00646: The keyword 'Signal' is optional in a signal declaration for a formal port of an entity passed
-- NEED RESULT: ARCH00646: The keyword 'Signal' is optional in a signal declaration for a formal port of a block passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00646
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    4.3.3 (5)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00646(ARCH00646)
--    ENT00646_Test_Bench(ARCH00646_Test_Bench)
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
entity ENT00646 is
   port (        G1 : in integer := 0 ;
	  signal G2, G3, G4 : in integer := 3 ) ;

end ENT00646 ;
--
architecture ARCH00646 of ENT00646 is
begin
   process
   begin
      test_report ( "ARCH00646" ,
		    "The keyword 'Signal' is optional in a "&
                    "signal declaration for a formal port of "&
                    "an entity" ,
		    (G1 = 1) and
                    (G2 = 2) and
                    (G3 = 3) and
                    (G4 = 4) ) ;
      wait ;
   end process ;

   L1 :
   block
      port (        BG1 : in integer := 0 ;
	     signal BG2, BG3, BG4 : in integer := 3 ) ;
      port map ( G1, G2, BG4 => G4 ) ;

   begin
      process
      begin
	 test_report ( "ARCH00646" ,
		       "The keyword 'Signal' is optional in a "&
                       "signal declaration for a formal port of "&
                       "a block" ,
		       (BG1 = 1) and
                       (BG2 = 2) and
                       (BG3 = 3) and
                       (BG4 = 4) ) ;
	 wait ;
      end process ;
   end block L1 ;
end ARCH00646 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00646_Test_Bench is
end ENT00646_Test_Bench ;

architecture ARCH00646_Test_Bench of ENT00646_Test_Bench is
begin
   L1:
   block
      component UUT
         port (        CG1 : in integer ;
	        signal CG2, CG4 : in integer ) ;
      end component ;

      for CIS1 : UUT use entity WORK.ENT00646 ( ARCH00646 )
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
end ARCH00646_Test_Bench ;
--
