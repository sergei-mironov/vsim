-- NEED RESULT: ARCH00435: Bit string literals passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00435
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    13.7 (1)
--    13.7 (2)
--    13.7 (3)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00435)
--    ENT00435_Test_Bench(ARCH00435_Test_Bench)
--
-- REVISION HISTORY:
--
--     4-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00435 of E00000 is
begin
   process
   begin
      test_report ( "ARCH00435" ,
		    "Bit string literals" ,
                    (B"010" = b"010") and
                    (O"76543210" = o"76543210") and
                    (X"0123456789ABCDEF" = x"0123456789abcdef") and
                    (O"0" = B"0_0_0") and
                    (O"1" = B"0_01") and
                    (O"2" = B"01_0") and
                    (O"3" = B"011") and
                    (O"4" = B"100") and
                    (O"5" = B"1_0_1") and
                    (O"6" = B"1_10") and
                    (O"7" = B"11_1") and
                    (O"0123_456_7" = B"000_001_010_011_100_101_110_111") and
                    (X"A" = B"1010") and
                    (X"B" = B"1_011") and
                    (X"C" = B"11_00") and
                    (X"D" = B"110_1") and
                    (X"E" = B"1_1_10") and
                    (X"F" = B"11_1_1") and
                    (X"a" = B"1_01_0") and
                    (X"b" = B"1_0_1_1") and
                    (X"c" = B"1100") and
                    (X"d" = B"1101") and
                    (X"e" = B"1110") and
                    (X"f" = B"1111") and
                    (X"abc_def" = X"AB_CD_EF")
                  ) ;
      wait ;
   end process ;
end ARCH00435 ;

entity ENT00435_Test_Bench is
end ENT00435_Test_Bench ;

architecture ARCH00435_Test_Bench of ENT00435_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00435 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00435_Test_Bench ;

