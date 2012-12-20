-- NEED RESULT: ARCH00447.Chk_s3: In absence of primaries that denote signals, an equivalent process statement for the concurrent sig asg has a wait statement with no sensitivity clause except for maybe the signal 'GUARD' passed
-- NEED RESULT: ARCH00447.Chk_s2: In absence of primaries that denote signals, an equivalent process statement for the concurrent sig asg has a wait statement with no sensitivity clause except for maybe the signal 'GUARD' passed
-- NEED RESULT: ARCH00447.Chk_s1: In absence of primaries that denote signals, an equivalent process statement for the concurrent sig asg has a wait statement with no sensitivity clause except for maybe the signal 'GUARD' passed
-- NEED RESULT: ARCH00447.Chk_s1: In absence of primaries that denote signals, an equivalent process statement for the concurrent sig asg has a wait statement with no sensitivity clause except for maybe the signal 'GUARD' passed
-- NEED RESULT: ARCH00447.Chk_s2: In absence of primaries that denote signals, an equivalent process statement for the concurrent sig asg has a wait statement with no sensitivity clause except for maybe the signal 'GUARD' passed
-- NEED RESULT: ARCH00447.Chk_s3: In absence of primaries that denote signals, an equivalent process statement for the concurrent sig asg has a wait statement with no sensitivity clause except for maybe the signal 'GUARD' passed
-- NEED RESULT: ARCH00447.Chk_gs3: In absence of primaries that denote signals, an equivalent process statement for the concurrent sig asg has a wait statement with no sensitivity clause except for maybe the signal 'GUARD' passed
-- NEED RESULT: ARCH00447.Chk_gs2: In absence of primaries that denote signals, an equivalent process statement for the concurrent sig asg has a wait statement with no sensitivity clause except for maybe the signal 'GUARD' passed
-- NEED RESULT: ARCH00447.Chk_gs1: In absence of primaries that denote signals, an equivalent process statement for the concurrent sig asg has a wait statement with no sensitivity clause except for maybe the signal 'GUARD' passed
-- NEED RESULT: ARCH00447.Chk_gs1: In absence of primaries that denote signals, an equivalent process statement for the concurrent sig asg has a wait statement with no sensitivity clause except for maybe the signal 'GUARD' passed
-- NEED RESULT: ARCH00447.Chk_gs2: In absence of primaries that denote signals, an equivalent process statement for the concurrent sig asg has a wait statement with no sensitivity clause except for maybe the signal 'GUARD' passed
-- NEED RESULT: ARCH00447.Chk_gs3: In absence of primaries that denote signals, an equivalent process statement for the concurrent sig asg has a wait statement with no sensitivity clause except for maybe the signal 'GUARD' passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00447
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
--    E00000(ARCH00447)
--    ENT00447_Test_Bench(ARCH00447_Test_Bench)
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
architecture ARCH00447 of E00000 is
   signal Control : boolean := true ;
   signal s1, s2, s3 : boolean := false ;
   signal Guard, gs1, gs2, gs3 : boolean := false ;
   constant C : boolean := false ;
begin
   B1 :
   block ( Control )  -- Implicit Guard Signal
   begin
      s1 <= guarded transport True after 5 ns, False after 10 ns ;
      s2 <= guarded transport False after 5 ns, True  after 10 ns when C else
                              True  after 5 ns, False after 10 ns ;
      with C select
	 s3 <= guarded transport False after 5 ns, True  after 10 ns when True,
				 True  after 5 ns, False after 10 ns when others ;
   end block B1 ;

   Chk_s1 :
   process ( s1 )
      variable SavTime : Time ;
      variable counter : integer := 0 ;
   begin
      case counter is
         when 0 =>
            SavTime := Std.Standard.Now ;
         when 1 =>
	    test_report ( "ARCH00447.Chk_s1" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          s1 and ((SavTime+5 ns) = Std.Standard.Now) ) ;
         when 2 =>
	    test_report ( "ARCH00447.Chk_s1" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          (Not s1) and ((SavTime+10 ns) = Std.Standard.Now) ) ;
         when others =>
	    test_report ( "ARCH00447.Chk_s1" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          False ) ;
      end case ;
      counter := counter + 1 ;
   end process Chk_s1 ;

   Chk_s2 :
   process ( s2 )
      variable SavTime : Time ;
      variable counter : integer := 0 ;
   begin
      case counter is
         when 0 =>
            SavTime := Std.Standard.Now ;
         when 1 =>
	    test_report ( "ARCH00447.Chk_s2" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          s2 and ((SavTime+5 ns) = Std.Standard.Now) ) ;
         when 2 =>
	    test_report ( "ARCH00447.Chk_s2" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          (Not s2) and ((SavTime+10 ns) = Std.Standard.Now) ) ;
         when others =>
	    test_report ( "ARCH00447.Chk_s2" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          False ) ;
      end case ;
      counter := counter + 1 ;
   end process Chk_s2 ;

   Chk_s3 :
   process ( s3 )
      variable SavTime : Time ;
      variable counter : integer := 0 ;
   begin
      case counter is
         when 0 =>
            SavTime := Std.Standard.Now ;
         when 1 =>
	    test_report ( "ARCH00447.Chk_s3" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          s3 and ((SavTime+5 ns) = Std.Standard.Now) ) ;
         when 2 =>
	    test_report ( "ARCH00447.Chk_s3" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          (Not s3) and ((SavTime+10 ns) = Std.Standard.Now) ) ;
         when others =>
	    test_report ( "ARCH00447.Chk_s3" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          False ) ;
      end case ;
      counter := counter + 1 ;
   end process Chk_s3 ;


   -- The following depend on the explicit signal Guard
   gs1 <= guarded transport True after 5 ns, False after 10 ns ;
   gs2 <= guarded transport False after 5 ns, True  after 10 ns when C else
                            True  after 5 ns, False after 10 ns ;
   with C select
      gs3 <= guarded transport False after 5 ns, True  after 10 ns when True,
			       True  after 5 ns, False after 10 ns when others ;

   Guard <= transport True after 100 ns;

   Chk_gs1 :
   process ( gs1 )
      variable SavTime : Time ;
      variable counter : integer := 0 ;
   begin
      case counter is
         when 0 =>
            SavTime := Std.Standard.Now ;
         when 1 =>
	    test_report ( "ARCH00447.Chk_gs1" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          gs1 and ((SavTime+105 ns) = Std.Standard.Now) ) ;
         when 2 =>
	    test_report ( "ARCH00447.Chk_gs1" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          (Not gs1) and ((SavTime+110 ns) = Std.Standard.Now) ) ;
         when others =>
	    test_report ( "ARCH00447.Chk_gs1" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          False ) ;
      end case ;
      counter := counter + 1 ;
   end process Chk_gs1 ;

   Chk_gs2 :
   process ( gs2 )
      variable SavTime : Time ;
      variable counter : integer := 0 ;
   begin
      case counter is
         when 0 =>
            SavTime := Std.Standard.Now ;
         when 1 =>
	    test_report ( "ARCH00447.Chk_gs2" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          gs2 and ((SavTime+105 ns) = Std.Standard.Now) ) ;
         when 2 =>
	    test_report ( "ARCH00447.Chk_gs2" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          (Not gs2) and ((SavTime+110 ns) = Std.Standard.Now) ) ;
         when others =>
	    test_report ( "ARCH00447.Chk_gs2" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          False ) ;
      end case ;
      counter := counter + 1 ;
   end process Chk_gs2 ;

   Chk_gs3 :
   process ( gs3 )
      variable SavTime : Time ;
      variable counter : integer := 0 ;
   begin
      case counter is
         when 0 =>
            SavTime := Std.Standard.Now ;
         when 1 =>
	    test_report ( "ARCH00447.Chk_gs3" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          gs3 and ((SavTime+105 ns) = Std.Standard.Now) ) ;
         when 2 =>
	    test_report ( "ARCH00447.Chk_gs3" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          (Not gs3) and ((SavTime+110 ns) = Std.Standard.Now) ) ;
         when others =>
	    test_report ( "ARCH00447.Chk_gs3" ,
                          "In absence of primaries that denote signals, an "&
                          "equivalent process statement for the concurrent "&
                          "sig asg has a wait statement with no sensitivity "&
                          "clause except for maybe the signal 'GUARD'" ,
		          False ) ;
      end case ;
      counter := counter + 1 ;
   end process Chk_gs3 ;

end ARCH00447 ;

entity ENT00447_Test_Bench is
end ENT00447_Test_Bench ;

architecture ARCH00447_Test_Bench of ENT00447_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00447 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00447_Test_Bench ;
