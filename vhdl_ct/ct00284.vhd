-- NEED RESULT: ARCH00284: Predefined enumeration types failed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00284
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    3.1.1.1 (1)
--    3.1.1.1 (2)
--    3.1.1.1 (3)
--    3.1.1.1 (4)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00284)
--    ENT00284_Test_Bench(ARCH00284_Test_Bench)
--
-- REVISION HISTORY:
--
--    21-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00284 of E00000 is
begin
   P :
   process
   begin
      test_report ( "ARCH00284" ,
		    "Predefined enumeration types" ,
                    (character'pos(NUL) =   0) and
                    (character'pos(SOH) =   1) and
                    (character'pos(STX) =   2) and
                    (character'pos(ETX) =   3) and
                    (character'pos(EOT) =   4) and
                    (character'pos(ENQ) =   5) and
                    (character'pos(ACK) =   6) and
                    (character'pos(BEL) =   7) and
                    (character'pos(BS ) =   8) and
                    (character'pos(HT ) =   9) and
                    (character'pos(LF ) =  10) and
                    (character'pos(VT ) =  11) and
                    (character'pos(FF ) =  12) and
                    (character'pos(CR ) =  13) and
                    (character'pos(SO ) =  14) and
                    (character'pos(SI ) =  15) and
                    (character'pos(DLE) =  16) and
                    (character'pos(DC1) =  17) and
                    (character'pos(DC2) =  18) and
                    (character'pos(DC3) =  19) and
                    (character'pos(DC4) =  20) and
                    (character'pos(NAK) =  21) and
                    (character'pos(SYN) =  22) and
                    (character'pos(ETB) =  23) and
                    (character'pos(CAN) =  24) and
                    (character'pos(EM ) =  25) and
                    (character'pos(SUB) =  26) and
                    (character'pos(ESC) =  27) and
                    (character'pos(FSP) =  28) and
                    (character'pos(GSP) =  29) and
                    (character'pos(RSP) =  30) and
                    (character'pos(USP) =  31) and
                    (character'pos(' ') =  32) and
                    (character'pos('!') =  33) and
                    (character'pos('"') =  34) and
                    (character'pos('#') =  35) and
                    (character'pos('$') =  36) and
                    (character'pos('%') =  37) and
                    (character'pos('&') =  38) and
                    (character'pos(''') =  39) and
                    (character'pos('(') =  40) and
                    (character'pos(')') =  41) and
                    (character'pos('*') =  42) and
                    (character'pos('+') =  43) and
                    (character'pos(',') =  44) and
                    (character'pos('-') =  45) and
                    (character'pos('.') =  46) and
                    (character'pos('/') =  47) and
                    (character'pos('0') =  48) and
                    (character'pos('1') =  49) and
                    (character'pos('2') =  50) and
                    (character'pos('3') =  51) and
                    (character'pos('4') =  52) and
                    (character'pos('5') =  53) and
                    (character'pos('6') =  54) and
                    (character'pos('7') =  55) and
                    (character'pos('8') =  56) and
                    (character'pos('9') =  57) and
                    (character'pos(':') =  58) and
                    (character'pos(';') =  59) and
                    (character'pos('<') =  60) and
                    (character'pos('=') =  61) and
                    (character'pos('>') =  62) and
                    (character'pos('?') =  63) and
                    (character'pos('@') =  64) and
                    (character'pos('A') =  65) and
                    (character'pos('B') =  66) and
                    (character'pos('C') =  67) and
                    (character'pos('D') =  68) and
                    (character'pos('E') =  69) and
                    (character'pos('F') =  70) and
                    (character'pos('G') =  71) and
                    (character'pos('H') =  72) and
                    (character'pos('I') =  73) and
                    (character'pos('J') =  74) and
                    (character'pos('K') =  75) and
                    (character'pos('L') =  76) and
                    (character'pos('M') =  77) and
                    (character'pos('N') =  78) and
                    (character'pos('O') =  79) and
                    (character'pos('P') =  80) and
                    (character'pos('Q') =  81) and
                    (character'pos('R') =  82) and
                    (character'pos('S') =  83) and
                    (character'pos('T') =  84) and
                    (character'pos('U') =  85) and
                    (character'pos('V') =  86) and
                    (character'pos('W') =  87) and
                    (character'pos('X') =  88) and
                    (character'pos('Y') =  89) and
                    (character'pos('Z') =  90) and
                    (character'pos('[') =  91) and
                    (character'pos('\') =  92) and
                    (character'pos(']') =  93) and
                    (character'pos('^') =  94) and
                    (character'pos('_') =  95) and
                    (character'pos('`') =  96) and
                    (character'pos('a') =  97) and
                    (character'pos('b') =  98) and
                    (character'pos('c') =  99) and
                    (character'pos('d') = 100) and
                    (character'pos('e') = 101) and
                    (character'pos('f') = 102) and
                    (character'pos('g') = 103) and
                    (character'pos('h') = 104) and
                    (character'pos('i') = 105) and
                    (character'pos('j') = 106) and
                    (character'pos('k') = 107) and
                    (character'pos('l') = 108) and
                    (character'pos('m') = 109) and
                    (character'pos('n') = 110) and
                    (character'pos('o') = 111) and
                    (character'pos('p') = 112) and
                    (character'pos('q') = 113) and
                    (character'pos('r') = 114) and
                    (character'pos('s') = 115) and
                    (character'pos('t') = 116) and
                    (character'pos('u') = 117) and
                    (character'pos('v') = 118) and
                    (character'pos('w') = 119) and
                    (character'pos('x') = 120) and
                    (character'pos('y') = 121) and
                    (character'pos('z') = 122) and
                    (character'pos('{') = 123) and
                    (character'pos('|') = 124) and
                    (character'pos('}') = 125) and
                    (character'pos('~') = 126) and
                    (character'pos(DEL) = 127) and
		    (character'pos(character'right) = 127) and
		    (bit'pos('0') = 0) and
		    (bit'pos('1') = 1) and
		    (bit'pos(bit'right) = 1) and
		    (boolean'pos(false) = 0) and
		    (boolean'pos(true)  = 1) and
		    (boolean'pos(boolean'right) = 1) and
		    (severity_level'pos(NOTE)    = 0) and
		    (severity_level'pos(WARNING) = 1) and
		    (severity_level'pos(ERROR)   = 2) and
		    (severity_level'pos(FAILURE) = 3) and
		    (severity_level'pos(severity_level'right) = 3)
                  ) ;
      wait ;
   end process P ;
end ARCH00284 ;

entity ENT00284_Test_Bench is
end ENT00284_Test_Bench ;

architecture ARCH00284_Test_Bench of ENT00284_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00284 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00284_Test_Bench ;
