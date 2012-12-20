-- NEED RESULT: *** An assertion with Report ARCH00326: An assertion with complex string expressions passed and severity of Note should follow
-- NEED RESULT: ARCH00326: An assertion with complex string expressions passed
-- NEED RESULT: *** An assertion with Report ARCH00326: An assertion with complex string expressions passed and severity of Note should follow
-- NEED RESULT: ARCH00326: An assertion with complex string expressions passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00326
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.4 (6)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00326(ARCH00326)
--    ENT00326_Test_Bench(ARCH00326_Test_Bench)
--
-- REVISION HISTORY:
--
--    26-JUN-1987   - initial revision
--
-- NOTES:
--
--    Check that assertion messages match comment messages in output
--
use WORK.STANDARD_TYPES.all ;
entity ENT00326 is
   generic ( Lowb  : Integer := 1 ;
	     Highb : Integer := 12 ) ;
   port ( msg1 : in string ;
	  msg2 : in string ) ;

   constant c_msg : string ( 1 to 12 ) := "passedfailed" ;
end ENT00326 ;

architecture ARCH00326 of ENT00326 is
   subtype sm_string is string ( Lowb to Highb ) ;
   constant cc_msg : sm_string := "failedpassed" ;

   signal Dummy : Boolean := false;

begin
   p1 :
   process ( Dummy )
   begin
      print ( "*** An assertion with Report " & msg1 & msg2 & c_msg(1 to 6)
              & " and severity of Note should follow" ) ;
   end process p1 ;

   assert Dummy
      report msg1 & msg2 & c_msg(1 to 6)
      severity NOTE ;

   p2 :
   process ( Dummy )
   begin
      print ( "*** An assertion with Report " & msg1 & msg2 & cc_msg(7 to Highb)
              & " and severity of Note should follow" ) ;
   end process p2 ;

   assert Dummy
      report msg1 & msg2 & cc_msg(7 to HighB)
      severity NOTE ;

end ARCH00326 ;

entity ENT00326_Test_Bench is
end ENT00326_Test_Bench ;

architecture ARCH00326_Test_Bench of ENT00326_Test_Bench is
begin
   L1:
   block
      subtype p1st is string (1 to 11) ;
      signal p1 : p1st := "ARCH00326: " ;
      subtype p2st is string (1 to 45) ;
      signal p2 : p2st := "An assertion with complex string expressions " ;


      component UUT
	 generic ( Lowb : Integer ;
		   Highb : Integer ) ;
	 port ( msg1 : in string ;
		msg2 : in string ) ;
      end component ;

      for CIS1 : UUT use entity WORK.ENT00326 ( ARCH00326 ) ;
   begin
      CIS1 : UUT
	 generic map ( 1, 12 )
	 port map ( p1, p2 ) ;

   end block L1 ;
end ARCH00326_Test_Bench ;
