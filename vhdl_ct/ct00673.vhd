-- NEED RESULT: ARCH00673: Variable values persist over simulation time passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00673
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.1.3 (5)
--    4.3.1.3 (6)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00673)
--    ENT00673_Test_Bench(ARCH00673_Test_Bench)
--
-- REVISION HISTORY:
--
--     1-SEP-1987   - initial revision
--     8-APR-1988   - JW: made correct1 a parameter to p1
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00673 of E00000 is
   type state is ( state1 , state2 , state3 ) ;
   signal s_state : state := state1 ;
   signal correct1 : boolean := true ;
   signal correct2 : boolean := true ;
   procedure p1 (signal correct1: inout boolean) is
      variable v_integer : integer := 5 ;
      variable v_string : string (1 to 5) ;
   begin
      v_string := "abcde" ;
      wait on s_state ;
      correct1 <= correct1 and v_integer = 5 and v_string = "abcde" ;
   end p1 ;
begin
   process
   begin
      p1(correct1) ;
   end process ;

   process
      variable v_integer : integer := 5 ;
      variable v_string : string (1 to 5) ;
   begin
      v_string := "abcde" ;
      s_state <= state3 ;
      wait on s_state ;
      correct2 <= correct2 and v_integer = 5 and v_string = "abcde" ;
   end process ;

   process (s_state)
   begin
      if s_state = state3 then
         test_report ( "ARCH00673" ,
		       "Variable values persist over simulation time" ,
		       correct1 and correct2) ;
      end if ;
   end process ;
end ARCH00673 ;
--
entity ENT00673_Test_Bench is
end ENT00673_Test_Bench ;

architecture ARCH00673_Test_Bench of ENT00673_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00673 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00673_Test_Bench ;
--
