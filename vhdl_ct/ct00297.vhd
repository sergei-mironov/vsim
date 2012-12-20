-- NEED RESULT: ARCH00297: Predefined array types passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00297
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    3.2.1.2 (1)
--    3.2.1.2 (2)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00297)
--    ENT00297_Test_Bench(ARCH00297_Test_Bench)
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
architecture ARCH00297 of E00000 is
begin
   P :
   process
      variable alphabet : string (1 to 26) := "ABCDEFGHIJKLMNOPQRSTUVWXYZ" ;
      variable very_short_string: string (1 to 1) := "!" ;
      variable word : bit_vector (15 downto 0) := "1111000011110000" ;
      variable byte : bit_vector (0 to 7) := "00110011" ;
   begin
      test_report ( "ARCH00297" ,
		    "Predefined array types" ,
		    (alphabet( 1) = 'A') and
		    (alphabet( 2) = 'B') and
		    (alphabet(25) = 'Y') and
		    (alphabet(26) = 'Z') and
                    (very_short_string(1) = '!') and
                    (word(15) = '1') and
                    (word(14) = '1') and
                    (word( 1) = '0') and
                    (byte( 0) = '0') and
                    (byte( 1) = '0') and
                    (byte( 6) = '1') and
                    (byte( 7) = '1')
                  ) ;
      wait ;
   end process P ;
end ARCH00297 ;

entity ENT00297_Test_Bench is
end ENT00297_Test_Bench ;

architecture ARCH00297_Test_Bench of ENT00297_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00297 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00297_Test_Bench ;

