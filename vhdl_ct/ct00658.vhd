-- NEED RESULT: ARCH00658: Block ports of mode 'inout' may be read passed
-- NEED RESULT: ARCH00658: Subp variable parameters of mode 'inout' may be read passed
-- NEED RESULT: ARCH00658: Subp variable parameters of mode 'inout' may be updated passed
-- NEED RESULT: ARCH00658: Subp signal parameters of mode 'inout' may be read passed
-- NEED RESULT: ARCH00658: Subp signal parameters of mode 'inout' may be updated passed
-- NEED RESULT: ARCH00658: Entity formal ports of mode 'inout' may be read passed
-- NEED RESULT: ARCH00658: Ports on blocks and entities along with signal parameters of mode 'inout' may be updated passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00658
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    4.3.3 (16)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00658(ARCH00658)
--    ENT00658_Test_Bench(ARCH00658_Test_Bench)
--
-- REVISION HISTORY:
--
--    26-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00658 is
   port ( Pt1 : inout Integer ) ;

end ENT00658 ;
--
architecture ARCH00658 of ENT00658 is
   function To_Integer ( P : Real ) return Integer is
   begin
      if P = -1.0 then
	 return -1 ;
      else
	 return -2 ;
      end if ;
   end To_Integer ;

   function To_Real ( P : Integer ) return Real is
   begin
      if P = -1 then
	 return -1.0 ;
      else
	 return -2.0 ;
      end if ;
   end To_Real ;

   procedure Proc1 ( variable V : inout Integer ) is
   begin
      test_report ( "ARCH00658" ,
	            "Subp variable parameters of mode 'inout' may "&
                    "be read" ,
		    V = -2 ) ;
      V := -1 ;
   end Proc1 ;

   procedure Proc2 ( signal S : inout Real ) is
   begin
      test_report ( "ARCH00658" ,
	            "Subp signal parameters of mode 'inout' may "&
                    "be read" ,
		    S = -2.0 ) ;
      S <= transport -1.0 after 10 ns ;
   end Proc2 ;

begin
   P1 :
   process ( Pt1 )
      variable First_Time : boolean := True ;
   begin
      if First_Time then
	 First_Time := false ;
      else
	 test_report ( "ARCH00658" ,
		       "Entity formal ports of mode 'inout' may be read" ,
		       Pt1 = -1 ) ;
      end if ;
   end process P1 ;

   L1 :
   block
      port ( Pt1 : inout Real ) ;
      port map ( To_Integer(Pt1) => To_Real(Pt1) ) ;  -- Check block 'inout' por
   begin
      BP1 :
      process
         variable Var : Integer := -2 ;
      begin
         test_report ( "ARCH00658" ,
		       "Block ports of mode 'inout' may "&
                       "be read" ,
		       Pt1 = -2.0 ) ;

         Proc1 (Var) ;
         test_report ( "ARCH00658" ,
		       "Subp variable parameters of mode 'inout' may "&
                       "be updated" ,
		       Var = -1 ) ;

         Proc2 (Pt1) ;  -- Check signal 'out' parameter
         test_report ( "ARCH00658" ,
		       "Subp signal parameters of mode 'inout' may "&
                       "be updated" ,
		       Pt1 = -2.0 ) ;  -- Value shouldn't have changed yet

         wait ;
      end process BP1 ;

   end block L1 ;
end ARCH00658 ;
--
use WORK.STANDARD_TYPES.all;
entity ENT00658_Test_Bench is
end ENT00658_Test_Bench ;

architecture ARCH00658_Test_Bench of ENT00658_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      signal S1 : Integer := -2 ;

      for CIS1 : UUT use entity WORK.ENT00658 ( ARCH00658 )
                            port map ( S1 ) ;  -- Check entity 'out' port
   begin

      CIS1 : UUT ;

      process
      begin
         wait for 11 ns ;
	 test_report ( "ARCH00658" ,
		       "Ports on blocks and entities along with signal "&
                       "parameters of mode 'inout' may be updated" ,
		       S1 = -1 ) ;
	 wait ;
      end process ;
   end block L1 ;
end ARCH00658_Test_Bench ;
--
