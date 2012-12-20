-- NEED RESULT: ARCH00445.Chk_s3: Guarded assignment triggered by an event on one of its inputs when implicit signal guard is TRUE passed
-- NEED RESULT: ARCH00445.Chk_s2: Guarded assignment triggered by an event on one of its inputs when implicit signal guard is TRUE passed
-- NEED RESULT: ARCH00445.Chk_s1: Guarded assignment triggered by an event on one of its inputs when implicit signal guard is TRUE passed
-- NEED RESULT: ARCH00445.Chk_s1: Guarded assignment triggered by an event on one of its inputs when implicit signal guard is TRUE passed
-- NEED RESULT: ARCH00445.Chk_s2: Guarded assignment triggered by an event on one of its inputs when implicit signal guard is TRUE passed
-- NEED RESULT: ARCH00445.Chk_s3: Guarded assignment triggered by an event on one of its inputs when implicit signal guard is TRUE passed
-- NEED RESULT: ARCH00445.Chk_gs3: Guarded assignment triggered by an event on one of its inputs when explicit signal guard is TRUE passed
-- NEED RESULT: ARCH00445.Chk_gs2: Guarded assignment triggered by an event on one of its inputs when explicit signal guard is TRUE passed
-- NEED RESULT: ARCH00445.Chk_gs1: Guarded assignment triggered by an event on one of its inputs when explicit signal guard is TRUE passed
-- NEED RESULT: ARCH00445.Chk_gs1: Guarded assignment triggered by an event on one of its inputs when signal guard is TRUE passed
-- NEED RESULT: ARCH00445.Chk_gs2: Guarded assignment triggered by an event on one of its inputs when signal guard is TRUE passed
-- NEED RESULT: ARCH00445.Chk_gs3: Guarded assignment triggered by an event on one of its inputs when signal guard is TRUE passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00445
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.5 (4)
--    9.5 (6)
--    9.5 (9)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00445)
--    ENT00445_Test_Bench(ARCH00445_Test_Bench)
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
architecture ARCH00445 of E00000 is
   signal Control : boolean := true ;
   signal s1, s2, s3 : boolean := false ;
   signal Guard, gs1, gs2, gs3 : boolean := false ;
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

   Control <= transport False after 9 ns ;

   Chk_s1 :
   process ( s1 )
      variable SavTime : Time ;
      variable counter : integer := 0 ;
   begin
      case counter is
         when 0 =>
            SavTime := Std.Standard.Now ;
         when 1 =>
	    test_report ( "ARCH00445.Chk_s1" ,
		          "Guarded assignment triggered by an event on one " &
                          "of its inputs when implicit signal guard is TRUE" ,
		          s1 and ((SavTime+5 ns) = Std.Standard.Now) ) ;
         when 2 =>
	    test_report ( "ARCH00445.Chk_s1" ,
		          "Guarded assignment triggered by an event on one " &
                          "of its inputs when implicit signal guard is TRUE" ,
		          (Not s1) and ((SavTime+10 ns) = Std.Standard.Now) ) ;
         when others =>
	    test_report ( "ARCH00445.Chk_s1" ,
		          "Guarded assignment triggered by an event on one " &
                          "of its inputs when implicit signal guard is TRUE" ,
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
	    test_report ( "ARCH00445.Chk_s2" ,
		          "Guarded assignment triggered by an event on one " &
                          "of its inputs when implicit signal guard is TRUE" ,
		          s2 and ((SavTime+5 ns) = Std.Standard.Now) ) ;
         when 2 =>
	    test_report ( "ARCH00445.Chk_s2" ,
		          "Guarded assignment triggered by an event on one " &
                          "of its inputs when implicit signal guard is TRUE" ,
		          (Not s2) and ((SavTime+10 ns) = Std.Standard.Now) ) ;
         when others =>
	    test_report ( "ARCH00445.Chk_s2" ,
		          "Guarded assignment triggered by an event on one " &
                          "of its inputs when implicit signal guard is TRUE" ,
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
	    test_report ( "ARCH00445.Chk_s3" ,
		          "Guarded assignment triggered by an event on one " &
                          "of its inputs when implicit signal guard is TRUE" ,
		          s3 and ((SavTime+5 ns) = Std.Standard.Now) ) ;
         when 2 =>
	    test_report ( "ARCH00445.Chk_s3" ,
		          "Guarded assignment triggered by an event on one " &
                          "of its inputs when implicit signal guard is TRUE" ,
		          (Not s3) and ((SavTime+10 ns) = Std.Standard.Now) ) ;
         when others =>
	    test_report ( "ARCH00445.Chk_s3" ,
		          "Guarded assignment triggered by an event on one " &
                          "of its inputs when implicit signal guard is TRUE" ,
		          False ) ;
      end case ;
      counter := counter + 1 ;
   end process Chk_s3 ;


   -- The following depend on the explicit signal Guard
   gs1 <= guarded transport Not gs1 after 5 ns ;
   gs2 <= guarded transport False after 5 ns when gs2 else
                            True  after 5 ns ;
   with gs3 select
      gs3 <= guarded transport False after 5 ns when True,
			       True  after 5 ns when others ;

   Guard <= transport True after 100 ns, False after 109 ns ;

   Chk_gs1 :
   process ( gs1 )
      variable SavTime : Time ;
      variable counter : integer := 0 ;
   begin
      case counter is
         when 0 =>
            SavTime := Std.Standard.Now ;
         when 1 =>
	    test_report ( "ARCH00445.Chk_gs1" ,
		          "Guarded assignment triggered by an event on one " &
                          "of its inputs when explicit signal guard is TRUE" ,
		          gs1 and ((SavTime+105 ns) = Std.Standard.Now) ) ;
         when 2 =>
	    test_report ( "ARCH00445.Chk_gs1" ,
		          "Guarded assignment triggered by an event on one " &
                          "of its inputs when signal guard is TRUE" ,
		          (Not gs1) and ((SavTime+110 ns) = Std.Standard.Now) ) ;
         when others =>
	    test_report ( "ARCH00445.Chk_gs1" ,
		          "Guarded assignment triggered by an event on one " &
                          "of its inputs when signal guard is TRUE" ,
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
	    test_report ( "ARCH00445.Chk_gs2" ,
		          "Guarded assignment triggered by an event on one " &
                          "of its inputs when explicit signal guard is TRUE" ,
		          gs2 and ((SavTime+105 ns) = Std.Standard.Now) ) ;
         when 2 =>
	    test_report ( "ARCH00445.Chk_gs2" ,
		          "Guarded assignment triggered by an event on one " &
                          "of its inputs when signal guard is TRUE" ,
		          (Not gs2) and ((SavTime+110 ns) = Std.Standard.Now) ) ;
         when others =>
	    test_report ( "ARCH00445.Chk_gs2" ,
		          "Guarded assignment triggered by an event on one " &
                          "of its inputs when signal guard is TRUE" ,
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
	    test_report ( "ARCH00445.Chk_gs3" ,
		          "Guarded assignment triggered by an event on one " &
                          "of its inputs when explicit signal guard is TRUE" ,
		          gs3 and ((SavTime+105 ns) = Std.Standard.Now) ) ;
         when 2 =>
	    test_report ( "ARCH00445.Chk_gs3" ,
		          "Guarded assignment triggered by an event on one " &
                          "of its inputs when signal guard is TRUE" ,
		          (Not gs3) and ((SavTime+110 ns) = Std.Standard.Now) ) ;
         when others =>
	    test_report ( "ARCH00445.Chk_gs3" ,
		          "Guarded assignment triggered by an event on one " &
                          "of its inputs when signal guard is TRUE" ,
		          False ) ;
      end case ;
      counter := counter + 1 ;
   end process Chk_gs3 ;

end ARCH00445 ;

entity ENT00445_Test_Bench is
end ENT00445_Test_Bench ;

architecture ARCH00445_Test_Bench of ENT00445_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00445 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00445_Test_Bench ;
