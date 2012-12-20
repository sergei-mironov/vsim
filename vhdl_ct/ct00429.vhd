-- NEED RESULT: ARCH00429: Character literals passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00429
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    13.5 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00429)
--    ENT00429_Test_Bench(ARCH00429_Test_Bench)
--
-- REVISION HISTORY:
--
--     3-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00429 of E00000 is
begin
   process
   begin
      test_report ( "ARCH00429" ,
		    "Character literals" ,
                    (character'val( 32) = ' ') and
                    (character'val( 33) = '!') and
                    (character'val( 34) = '"') and
                    (character'val( 35) = '#') and
                    (character'val( 36) = '$') and
                    (character'val( 37) = '%') and
                    (character'val( 38) = '&') and
                    (character'val( 39) = ''') and
                    (character'val( 40) = '(') and
                    (character'val( 41) = ')') and
                    (character'val( 42) = '*') and
                    (character'val( 43) = '+') and
                    (character'val( 44) = ',') and
                    (character'val( 45) = '-') and
                    (character'val( 46) = '.') and
                    (character'val( 47) = '/') and
                    (character'val( 48) = '0') and
                    (character'val( 49) = '1') and
                    (character'val( 50) = '2') and
                    (character'val( 51) = '3') and
                    (character'val( 52) = '4') and
                    (character'val( 53) = '5') and
                    (character'val( 54) = '6') and
                    (character'val( 55) = '7') and
                    (character'val( 56) = '8') and
                    (character'val( 57) = '9') and
                    (character'val( 58) = ':') and
                    (character'val( 59) = ';') and
                    (character'val( 60) = '<') and
                    (character'val( 61) = '=') and
                    (character'val( 62) = '>') and
                    (character'val( 63) = '?') and
                    (character'val( 64) = '@') and
                    (character'val( 65) = 'A') and
                    (character'val( 66) = 'B') and
                    (character'val( 67) = 'C') and
                    (character'val( 68) = 'D') and
                    (character'val( 69) = 'E') and
                    (character'val( 70) = 'F') and
                    (character'val( 71) = 'G') and
                    (character'val( 72) = 'H') and
                    (character'val( 73) = 'I') and
                    (character'val( 74) = 'J') and
                    (character'val( 75) = 'K') and
                    (character'val( 76) = 'L') and
                    (character'val( 77) = 'M') and
                    (character'val( 78) = 'N') and
                    (character'val( 79) = 'O') and
                    (character'val( 80) = 'P') and
                    (character'val( 81) = 'Q') and
                    (character'val( 82) = 'R') and
                    (character'val( 83) = 'S') and
                    (character'val( 84) = 'T') and
                    (character'val( 85) = 'U') and
                    (character'val( 86) = 'V') and
                    (character'val( 87) = 'W') and
                    (character'val( 88) = 'X') and
                    (character'val( 89) = 'Y') and
                    (character'val( 90) = 'Z') and
                    (character'val( 91) = '[') and
                    (character'val( 92) = '\') and
                    (character'val( 93) = ']') and
                    (character'val( 94) = '^') and
                    (character'val( 95) = '_') and
                    (character'val( 96) = '`') and
                    (character'val( 97) = 'a') and
                    (character'val( 98) = 'b') and
                    (character'val( 99) = 'c') and
                    (character'val(100) = 'd') and
                    (character'val(101) = 'e') and
                    (character'val(102) = 'f') and
                    (character'val(103) = 'g') and
                    (character'val(104) = 'h') and
                    (character'val(105) = 'i') and
                    (character'val(106) = 'j') and
                    (character'val(107) = 'k') and
                    (character'val(108) = 'l') and
                    (character'val(109) = 'm') and
                    (character'val(110) = 'n') and
                    (character'val(111) = 'o') and
                    (character'val(112) = 'p') and
                    (character'val(113) = 'q') and
                    (character'val(114) = 'r') and
                    (character'val(115) = 's') and
                    (character'val(116) = 't') and
                    (character'val(117) = 'u') and
                    (character'val(118) = 'v') and
                    (character'val(119) = 'w') and
                    (character'val(120) = 'x') and
                    (character'val(121) = 'y') and
                    (character'val(122) = 'z') and
                    (character'val(123) = '{') and
                    (character'val(124) = '|') and
                    (character'val(125) = '}') and
                    (character'val(126) = '~')
		  ) ;
      wait ;
   end process ;
end ARCH00429 ;

entity ENT00429_Test_Bench is
end ENT00429_Test_Bench ;

architecture ARCH00429_Test_Bench of ENT00429_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00429 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00429_Test_Bench ;

