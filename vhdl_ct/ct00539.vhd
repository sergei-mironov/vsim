-- NEED RESULT: ARCH00539: Local port/generic visibility test passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00539
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    10.3 (8)
--    10.3 (9)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00539(ARCH00539)
--    PKG00539
--    ENT00539_Test_Bench(ARCH00539_Test_Bench)
--
-- REVISION HISTORY:
--
--    18-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
entity ENT00539 is
          generic (G : CHARACTER) ;
          port    (P1 : inout INTEGER; P2 : out BIT; P3 : in BOOLEAN);
end ENT00539 ;
--
architecture ARCH00539 of ENT00539 is
begin
   process ( P1 )
   begin
      P2 <= transport '1' after 0 ns ;
   end process ;
end ARCH00539 ;
--
package PKG00539 is
   component PkgCOMP generic (DDD : CHARACTER) ;
                     port    (AAA : inout INTEGER;
                              BBB : out BIT;
                              CCC : in BOOLEAN) ;
   end component;
end PKG00539 ;
--
use WORK.STANDARD_TYPES.all, WORK.PKG00539 ;
entity ENT00539_Test_Bench is
end ENT00539_Test_Bench ;

architecture ARCH00539_Test_Bench of ENT00539_Test_Bench is

   component COMP1 generic (D : CHARACTER) ;
      port    (A : inout INTEGER := 0 ; 
               B : out BIT := '0' ; 
               C : in BOOLEAN := false);
   end component;

   component COMP2 generic (DD : CHARACTER) ;
      port    (AA : inout INTEGER := 0 ; 
               BB : out BIT := '0' ; 
               CC : in BOOLEAN := false) ;
   end component;

   signal SA : INTEGER := 0 ;
   signal SB : BIT := '0' ;
   signal SC : BOOLEAN := false ;
   constant SD : CHARACTER := 'D';

   signal AA : INTEGER := 0 ;
   signal BB : BIT := '0' ;
   signal CC : BOOLEAN := false ;
   constant DD : CHARACTER := 'D';

   signal PSA : INTEGER := 0 ;
   signal PSB : BIT := '0' ;
   signal PSC : BOOLEAN := false ;
   constant PSD : CHARACTER := 'D';


   for A1 : COMP1 use entity WORK.ENT00539 ( ARCH00539 )
			 generic map ( G => D )
			 port map ( A, B, C ) ;
      -- names denoting local port or generic are permitted

   for others : COMP2 use entity WORK.ENT00539 ( ARCH00539 )
			 generic map ( G => DD )
			 port map ( AA, BB, CC ) ;
      -- names denoting local port or generic are permitted

   for all : PKG00539.PkgCOMP use entity WORK.ENT00539 ( ARCH00539 )
			 generic map ( G => DDD )
			 port map ( AAA, BBB, CCC ) ;
      -- names denoting local port or generic are permitted

begin
   A1 : COMP1 generic map (D => SD)
              port map    (A => SA, B => SB, C => SC) ;
      -- names denoting local port or generic are permitted

   A2 : COMP2 generic map (DD => DD)
              port map    (AA => AA, BB => BB, CC => CC) ;
      -- names denoting local port or generic are permitted

   A3 : PKG00539.PkgCOMP generic map (DDD => PSD)
                         port map    (AAA => PSA, BBB => PSB, CCC => PSC) ;
      -- names denoting local port or generic are permitted

   process
   begin
      wait for 10 ns ;
      test_report ( "ARCH00539" ,
		    "Local port/generic visibility test" ,
		    (SB = '1') and
                    (BB = '1') and
                    (PSB = '1') ) ;
      wait;
   end process ;

end ARCH00539_Test_Bench ;
--
