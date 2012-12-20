-- NEED RESULT: *** An assertion with Report ARCH00027: An assertion with complex string expressions passed and severity of Note should follow
-- NEED RESULT: ARCH00027: An assertion with complex string expressions passed
-- NEED RESULT: *** An assertion with Report ARCH00027: An assertion with complex string expressions passed and severity of Note should follow
-- NEED RESULT: ARCH00027: An assertion with complex string expressions passed
-- NEED RESULT: *** An assertion with Report ARCH00027: An assertion with complex string expressions passed and default severity of Error should follow
-- NEED RESULT: *** An assertion with Report ARCH00027: An assertion with complex string expressions failed and default severity of Error should follow
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00027
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.2 (5)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00027(ARCH00027)
--    ENT00027_Test_Bench(ARCH00027_Test_Bench)
--
-- REVISION HISTORY:
--
--    26-JUN-1987   - initial revision
--
-- NOTES:
--
--    Check that assertion messages match comment messages in output
--
use WORK.STANDARD_TYPES.all;
entity ENT00027 is
   generic ( Lowb  : Integer := 1 ;
	     Highb : Integer := 12 ) ;
   port ( msg1 : in string ;
	  msg2 : in string ) ;

   constant c_msg : string ( 1 to 12 ) := "passedfailed" ;
end ENT00027 ;

architecture ARCH00027 of ENT00027 is
   subtype sm_string is string ( Lowb to Highb ) ;
   constant cc_msg : sm_string := "failedpassed" ;

   procedure Proc1 ( part1, part2, part3 : in string ) is
   begin
      print ( "*** An assertion with Report " & part1 & part2 & part3
              & " and default severity of Error should follow" ) ;
      assert false
	report part1 & part2 & part3;
   end Proc1 ;

   signal Dummy : Boolean := false ;

begin
   p1 :
   process ( Dummy )
   begin
      print ( "*** An assertion with Report " & msg1 & msg2 & c_msg(1 to 6)
              & " and severity of Note should follow" ) ;
      assert Dummy
	report msg1 & msg2 & c_msg(1 to 6)
	severity NOTE ;

      print ( "*** An assertion with Report " & msg1 & msg2 & cc_msg(7 to Highb)
              & " and severity of Note should follow" ) ;
      assert Dummy
	report msg1 & msg2 & cc_msg(7 to HighB)
	severity NOTE ;

      Proc1 ( msg1, msg2, cc_msg(7 to HighB) ) ;
      Proc1 ( msg1, msg2, cc_msg(1 to 6) ) ;

   end process p1 ;
end ARCH00027 ;

entity ENT00027_Test_Bench is
end ENT00027_Test_Bench ;

architecture ARCH00027_Test_Bench of ENT00027_Test_Bench is
begin
   L1:
   block

      component UUT
	 generic ( Lowb : Integer ;
		   Highb : Integer ) ;
	 port ( msg1 : in string ;
		msg2 : in string ) ;
      end component ;

      for CIS1 : UUT use entity WORK.ENT00027 ( ARCH00027 ) ;

      subtype Name_ST is string (1 to 11) ;
      signal DU_Name : Name_ST := "ARCH00027: ";

      subtype Msg_St is string (1 to 45) ;
      signal msg : Msg_ST :=
         "An assertion with complex string expressions " ;

   begin
      CIS1 : UUT
	 generic map ( 1, 12 )
	 port map ( DU_Name, msg ) ;

   end block L1 ;
end ARCH00027_Test_Bench ;
