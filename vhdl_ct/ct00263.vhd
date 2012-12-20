-- NEED RESULT: Assertion statement in architecture body
-- NEED RESULT: ARCH00263: Block statements, process_statements, signal assignment statements, component instantiation statements, concurrent procedure call statements and generate statements in architecture statement part passed
-- NEED RESULT: *** Check simulation log for the following message:
-- NEED RESULT: Assertion statement in architecture body
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00263
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.2.2 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00263)
--    ENT00263_Test_Bench(ARCH00263_Test_Bench)
--
-- REVISION HISTORY:
--
--    16-JUL-1987   - initial revision
--
-- NOTES:
--
--    partially self checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00263 of E00000 is
   signal s1, s2, s3, s4, s5, s6 : integer := 0 ;
   constant c1 : boolean := false ;
   procedure p1 ( signal s : inout integer ) is
   begin
      s <= 5 ;
   end p1 ;
begin
   Bl1 :
   block
   begin
      s1 <=  5 ;
   end block Bl1 ;

   P01 :
   process
   begin
      s2 <= 5 ;
      wait ;
   end process P01 ;

   s3 <=  5 ;

   with c1 select
      s4 <= 5 when false,
	    0 when true ;

   G1 :
   if not c1 generate
      s5 <=  5 ;
   end generate G1 ;

   p1 ( s6 ) ;

   assert false
     report "Assertion statement in architecture body"
     severity note ;

   process ( s1, s2, s3, s4, s5, s6 )
   begin
      if s1 = 5 and s2 = 5 and s3 = 5 and s4 = 5 and s5 = 5 and s6 = 5 then
         test_report ( "ARCH00263" ,
   		       "Block statements, process_statements, signal"
                       & " assignment statements, component instantiation"
                       & " statements, concurrent procedure call statements"
                       & " and generate statements in architecture"
                       & " statement part" ,
		       true ) ;
         print ( "*** Check simulation log for the following message:" ) ;
         print ( "Assertion statement in architecture body" ) ;
      end if ;
   end process ;
end ARCH00263 ;

entity ENT00263_Test_Bench is
end ENT00263_Test_Bench ;

architecture ARCH00263_Test_Bench of ENT00263_Test_Bench is
   component UUT
   end component ;

   for CIS1 : UUT use entity WORK.E00000 ( ARCH00263 ) ;
begin
   CIS1 : UUT ;  -- component instantiation in architecture
end ARCH00263_Test_Bench ;
