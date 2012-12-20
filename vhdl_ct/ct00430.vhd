-- NEED RESULT: ARCH00430: String literals passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00430
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    13.6 (1)
--    13.6 (2)
--    13.6 (3)
--    13.6 (5)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00430)
--    ENT00430_Test_Bench(ARCH00430_Test_Bench)
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
architecture ARCH00430 of E00000 is
begin
   process
   begin
      test_report ( "ARCH00430" ,
		    "String literals" ,
                    -- this tests 13.6 (1), 13.6 (2) and 13.6 (5)
                    (string'(" ") /= "") and
                    (string'("!") /= "") and
                    (string'("""") /= "") and
                    (string'("#") /= "") and
                    (string'("$") /= "") and
                    (string'("%") /= "") and
                    (string'("&") /= "") and
                    (string'("'") /= "") and
                    (string'("(") /= "") and
                    (string'(")") /= "") and
                    (string'("*") /= "") and
                    (string'("+") /= "") and
                    (string'(",") /= "") and
                    (string'("-") /= "") and
                    (string'(".") /= "") and
                    (string'("/") /= "") and
                    (string'("0") /= "") and
                    (string'("1") /= "") and
                    (string'("2") /= "") and
                    (string'("3") /= "") and
                    (string'("4") /= "") and
                    (string'("5") /= "") and
                    (string'("6") /= "") and
                    (string'("7") /= "") and
                    (string'("8") /= "") and
                    (string'("9") /= "") and
                    (string'(":") /= "") and
                    (string'(";") /= "") and
                    (string'("<") /= "") and
                    (string'("=") /= "") and
                    (string'(">") /= "") and
                    (string'("?") /= "") and
                    (string'("@") /= "") and
                    (string'("A") /= "") and
                    (string'("B") /= "") and
                    (string'("C") /= "") and
                    (string'("D") /= "") and
                    (string'("E") /= "") and
                    (string'("F") /= "") and
                    (string'("G") /= "") and
                    (string'("H") /= "") and
                    (string'("I") /= "") and
                    (string'("J") /= "") and
                    (string'("K") /= "") and
                    (string'("L") /= "") and
                    (string'("M") /= "") and
                    (string'("N") /= "") and
                    (string'("O") /= "") and
                    (string'("P") /= "") and
                    (string'("Q") /= "") and
                    (string'("R") /= "") and
                    (string'("S") /= "") and
                    (string'("T") /= "") and
                    (string'("U") /= "") and
                    (string'("V") /= "") and
                    (string'("W") /= "") and
                    (string'("X") /= "") and
                    (string'("Y") /= "") and
                    (string'("Z") /= "") and
                    (string'("[") /= "") and
                    (string'("\") /= "") and
                    (string'("]") /= "") and
                    (string'("^") /= "") and
                    (string'("_") /= "") and
                    (string'("`") /= "") and
                    (string'("a") /= "") and
                    (string'("b") /= "") and
                    (string'("c") /= "") and
                    (string'("d") /= "") and
                    (string'("e") /= "") and
                    (string'("f") /= "") and
                    (string'("g") /= "") and
                    (string'("h") /= "") and
                    (string'("i") /= "") and
                    (string'("j") /= "") and
                    (string'("k") /= "") and
                    (string'("l") /= "") and
                    (string'("m") /= "") and
                    (string'("n") /= "") and
                    (string'("o") /= "") and
                    (string'("p") /= "") and
                    (string'("q") /= "") and
                    (string'("r") /= "") and
                    (string'("s") /= "") and
                    (string'("t") /= "") and
                    (string'("u") /= "") and
                    (string'("v") /= "") and
                    (string'("w") /= "") and
                    (string'("x") /= "") and
                    (string'("y") /= "") and
                    (string'("z") /= "") and
                    (string'("{") /= "") and
                    (string'("|") /= "") and
                    (string'("}") /= "") and
                    (string'("~") /= "") and
                    -- this tests 13.6 (3)
                    (string'("A") /= "a") and
                    (string'("B") /= "b") and
                    (string'("C") /= "c") and
                    (string'("D") /= "d") and
                    (string'("E") /= "e") and
                    (string'("F") /= "f") and
                    (string'("G") /= "g") and
                    (string'("H") /= "h") and
                    (string'("I") /= "i") and
                    (string'("J") /= "j") and
                    (string'("K") /= "k") and
                    (string'("L") /= "l") and
                    (string'("M") /= "m") and
                    (string'("N") /= "n") and
                    (string'("O") /= "o") and
                    (string'("P") /= "p") and
                    (string'("Q") /= "q") and
                    (string'("R") /= "r") and
                    (string'("S") /= "s") and
                    (string'("T") /= "t") and
                    (string'("U") /= "u") and
                    (string'("V") /= "v") and
                    (string'("W") /= "w") and
                    (string'("X") /= "x") and
                    (string'("Y") /= "y") and
                    (string'("Z") /= "z")
                  ) ;
      wait ;
   end process ;
end ARCH00430 ;

entity ENT00430_Test_Bench is
end ENT00430_Test_Bench ;

architecture ARCH00430_Test_Bench of ENT00430_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00430 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00430_Test_Bench ;

