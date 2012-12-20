-- NEED RESULT: ARCH00448.Chk_s3: In absence of primaries that denote signals, an equivalent process statement for the concurrent sig asg has a wait statement with no sensitivity clause except for maybe the signal 'GUARD' passed
-- NEED RESULT: ARCH00448.Chk_s2: In absence of primaries that denote signals, an equivalent process statement for the concurrent sig asg has a wait statement with no sensitivity clause except for maybe the signal 'GUARD' passed
-- NEED RESULT: ARCH00448.Chk_s1: In absence of primaries that denote signals, an equivalent process statement for the concurrent sig asg has a wait statement with no sensitivity clause except for maybe the signal 'GUARD' passed
-- NEED RESULT: ARCH00448.Chk_s1: In absence of primaries that denote signals, an equivalent process statement for the concurrent sig asg has a wait statement with no sensitivity clause except for maybe the signal 'GUARD' passed
-- NEED RESULT: ARCH00448.Chk_s2: In absence of primaries that denote signals, an equivalent process statement for the concurrent sig asg has a wait statement with no sensitivity clause except for maybe the signal 'GUARD' passed
-- NEED RESULT: ARCH00448.Chk_s3: In absence of primaries that denote signals, an equivalent process statement for the concurrent sig asg has a wait statement with no sensitivity clause except for maybe the signal 'GUARD' passed
-- NEED RESULT: ARCH00448.Chk_gs3: In absence of primaries that denote signals, an equivalent process statement for the concurrent sig asg has a wait statement with no sensitivity clause except for maybe the signal 'GUARD' passed
-- NEED RESULT: ARCH00448.Chk_gs2: In absence of primaries that denote signals, an equivalent process statement for the concurrent sig asg has a wait statement with no sensitivity clause except for maybe the signal 'GUARD' passed
-- NEED RESULT: ARCH00448.Chk_gs1: In absence of primaries that denote signals, an equivalent process statement for the concurrent sig asg has a wait statement with no sensitivity clause except for maybe the signal 'GUARD' passed
-- NEED RESULT: ARCH00448.Chk_gs1: In absence of primaries that denote signals, an equivalent process statement for the concurrent sig asg has a wait statement with no sensitivity clause except for maybe the signal 'GUARD' passed
-- NEED RESULT: ARCH00448.Chk_gs2: In absence of primaries that denote signals, an equivalent process statement for the concurrent sig asg has a wait statement with no sensitivity clause except for maybe the signal 'GUARD' passed
-- NEED RESULT: ARCH00448.Chk_gs3: In absence of primaries that denote signals, an equivalent process statement for the concurrent sig asg has a wait statement with no sensitivity clause except for maybe the signal 'GUARD' passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    ct00448
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.5 (8)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00448)
--    ENT00448_Test_Bench(ARCH00448_Test_Bench)
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
architecture ARCH00448 of E00000 is
   function rfunc ( to_resolve : boolean_vector ) return boolean ;

   subtype rboolean is rfunc boolean ;
   signal Control : boolean := true ;
   signal s1, s2, s3 : rboolean ;
   alias gs1 : rboolean is s1 ;
   alias gs2 : rboolean is s2 ;
   alias gs3 : rboolean is s3 ;
   signal Guard : boolean := false ;

   function rfunc ( to_resolve : boolean_vector ) return boolean is
      variable result : boolean := false ;
   begin
      for i in to_resolve'range loop
	 result := result or to_resolve (i) ;
      end loop ;
      return result ;
   end rfunc ;

begin
   B1 :
   block ( Control )  -- Implicit Guard Signal
   begin
      s1 <= guarded transport Not s1 after 5 ns ;
      s2 <= guarded transport False after 5 ns when s2 else
                              True  after 5 ns ;
      with s3 select
	 s3 <= guarded transport False after 5 ns when True,
				 True  after 5 ns when others ;
   end block B1 ;

   Chk_s1 :
   process ( s1 )
      variable SavTime : Time ;
      variable counter : Integer := 0 ;
   begin
      case counter is
	 when 0 =>
            SavTime := Std.Standard.Now ;
	 when 1 =>
	    test_report ( "ARCH00448.Chk_s1" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          s1 and ((SavTime+5 ns) = Std.Standard.Now) ) ;
	 when 2 =>
	    test_report ( "ARCH00448.Chk_s1" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          (Not s1) and ((SavTime+10 ns) = Std.Standard.Now) ) ;
         when 3 =>
	    test_report ( "ARCH00448.Chk_gs1" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		           gs1 and ((SavTime+105 ns) = Std.Standard.Now) ) ;
         when 4 =>
	    test_report ( "ARCH00448.Chk_gs1" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		           (Not gs1) and ((SavTime+110 ns) = Std.Standard.Now) ) ;
         when others =>
	    test_report ( "ARCH00448.Chk_s1" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          False ) ;
      end case ;
      counter := counter + 1;
   end process Chk_s1 ;

   Chk_s2 :
   process ( s2 )
      variable SavTime : Time ;
      variable counter : Integer := 0 ;
   begin
      case counter is
	 when 0 =>
            SavTime := Std.Standard.Now ;
	 when 1 =>
	    test_report ( "ARCH00448.Chk_s2" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          s2 and ((SavTime+5 ns) = Std.Standard.Now) ) ;
	 when 2 =>
	    test_report ( "ARCH00448.Chk_s2" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          (Not s2) and ((SavTime+10 ns) = Std.Standard.Now) ) ;
         when 3 =>
	    test_report ( "ARCH00448.Chk_gs2" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		           gs2 and ((SavTime+105 ns) = Std.Standard.Now) ) ;
         when 4 =>
	    test_report ( "ARCH00448.Chk_gs2" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		           (Not gs2) and ((SavTime+110 ns) = Std.Standard.Now) ) ;
         when others =>
	    test_report ( "ARCH00448.Chk_s2" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          False ) ;
      end case ;
      counter := counter + 1;
   end process Chk_s2 ;

   Chk_s3 :
   process ( s3 )
      variable SavTime : Time ;
      variable counter : Integer := 0 ;
   begin
      case counter is
	 when 0 =>
            SavTime := Std.Standard.Now ;
	 when 1 =>
	    test_report ( "ARCH00448.Chk_s3" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          s3 and ((SavTime+5 ns) = Std.Standard.Now) ) ;
	 when 2 =>
	    test_report ( "ARCH00448.Chk_s3" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          (Not s3) and ((SavTime+10 ns) = Std.Standard.Now) ) ;
         when 3 =>
	    test_report ( "ARCH00448.Chk_gs3" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		           gs3 and ((SavTime+105 ns) = Std.Standard.Now) ) ;
         when 4 =>
	    test_report ( "ARCH00448.Chk_gs3" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		           (Not gs3) and ((SavTime+110 ns) = Std.Standard.Now) ) ;
         when others =>
	    test_report ( "ARCH00448.Chk_s3" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          False ) ;
      end case ;
      counter := counter + 1;
   end process Chk_s3 ;


   -- The following depend on the explicit signal Guard
   gs1 <= guarded transport Not gs1 after 5 ns ;
   gs2 <= guarded transport False after 5 ns when gs2 else
                            True  after 5 ns ;
   with gs3 select
      gs3 <= guarded transport False after 5 ns when True,
			       True  after 5 ns when others ;

   -- DD modified this test 26-JUN-88 because the VHDL seemed to be an
   --  infinite loop.  He did not really understand the test, he just wanted
   --  to get it to terminate.
   -- The test used to read:
 --Guard <= transport True after 100 ns;
   -- Now it reads:
   Guard <= transport True after 100 ns, False after 110 ns;
   Control <= transport False after 10 ns;

end ARCH00448 ;

entity ENT00448_Test_Bench is
end ENT00448_Test_Bench ;

architecture ARCH00448_Test_Bench of ENT00448_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00448 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00448_Test_Bench ;
