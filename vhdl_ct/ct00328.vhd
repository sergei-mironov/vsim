-- NEED RESULT: *** 10 assertion messages should follow
-- NEED RESULT: Assertion # 1
-- NEED RESULT: Assertion # 2
-- NEED RESULT: Assertion # 3
-- NEED RESULT: Assertion # 4
-- NEED RESULT: Assertion # 5
-- NEED RESULT: Assertion # 6
-- NEED RESULT: Assertion # 7
-- NEED RESULT: Assertion # 8
-- NEED RESULT: Assertion # 9
-- NEED RESULT: Assertion #10
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00328
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.4 (8)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00328_Test_Bench(ARCH00328_Test_Bench)
--
-- REVISION HISTORY:
--
--    29-JUL-1987   - initial revision
--
-- NOTES:
--
--    Verify that assertion messages match comment messages output
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00328_Test_Bench is
end ENT00328_Test_Bench ;

architecture ARCH00328_Test_Bench of ENT00328_Test_Bench is
   subtype ST is String ( 1 to 2 ) ;
   signal S : ST := " 1";
begin
   process
   begin
      print ( "*** 10 assertion messages should follow" ) ;
      wait ;
   end process ;

   assert S /= S
     report "Assertion #" & S (1 to 2)
     severity Note ;

   P1 :
   process ( S )
      variable count : integer := 1 ;
   begin
      case count is
	 when 1 =>
	    S(2) <= transport '2' after 10 ns ;
	 when 2 =>
	    S(2 to 2) <= transport "3" after 10 ns ;
	 when 3 =>
	    S(2) <= transport '4' after 10 ns ;
	 when 4 =>
	    S(2) <= transport '5' after 10 ns ;
	 when 5 =>
	    S(2) <= transport '6' after 10 ns ;
	 when 6 =>
	    S(2) <= transport '7' after 10 ns ;
	 when 7 =>
	    S(2) <= transport '8' after 10 ns ;
	 when 8 =>
	    S(2) <= transport '9' after 10 ns ;
	 when 9 =>
	    S <= transport "10" after 10 ns ;
	 when others =>
	    null;
      end case ;

      count := count + 1 ;

   end process P1 ;
end ARCH00328_Test_Bench ;
