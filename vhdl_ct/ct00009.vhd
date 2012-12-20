-- NEED RESULT: ARCH00009.P1_1: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.P1_2: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.P1_3: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.P1_4: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.P2_1: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.P2_2: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.P2_3: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.P2_4: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.P3_1: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.P3_2: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.P3_3: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.P3_4: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.PROC1_1: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.PROC1_2: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.PROC1_3: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.PROC1_4: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.PROC2_1: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.PROC2_2: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.PROC2_3: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.PROC2_4: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.PROC3_1: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.PROC3_2: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.PROC3_3: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.PROC3_4: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.PROC4_1: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.PROC4_2: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.PROC4_3: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009.PROC4_4: Resume after time on timeout clause expired passed
-- NEED RESULT: ARCH00009: Wait in P1_1 did resume passed
-- NEED RESULT: ARCH00009: Wait in P1_2 did resume passed
-- NEED RESULT: ARCH00009: Wait in P1_3 did resume passed
-- NEED RESULT: ARCH00009: Wait in P1_4 did resume passed
-- NEED RESULT: ARCH00009: Wait in P2_1 did resume passed
-- NEED RESULT: ARCH00009: Wait in P2_2 did resume passed
-- NEED RESULT: ARCH00009: Wait in P2_3 did resume passed
-- NEED RESULT: ARCH00009: Wait in P2_4 did resume passed
-- NEED RESULT: ARCH00009: Wait in P3_1 did resume passed
-- NEED RESULT: ARCH00009: Wait in P3_2 did resume passed
-- NEED RESULT: ARCH00009: Wait in P3_3 did resume passed
-- NEED RESULT: ARCH00009: Wait in P3_4 did resume passed
-- NEED RESULT: ARCH00009: Wait in PROC1_1 did resume passed
-- NEED RESULT: ARCH00009: Wait in PROC1_2 did resume passed
-- NEED RESULT: ARCH00009: Wait in PROC1_3 did resume passed
-- NEED RESULT: ARCH00009: Wait in PROC1_4 did resume passed
-- NEED RESULT: ARCH00009: Wait in PROC2_1 did resume passed
-- NEED RESULT: ARCH00009: Wait in PROC2_2 did resume passed
-- NEED RESULT: ARCH00009: Wait in PROC2_3 did resume passed
-- NEED RESULT: ARCH00009: Wait in PROC2_4 did resume passed
-- NEED RESULT: ARCH00009: Wait in PROC3_1 did resume passed
-- NEED RESULT: ARCH00009: Wait in PROC3_2 did resume passed
-- NEED RESULT: ARCH00009: Wait in PROC3_3 did resume passed
-- NEED RESULT: ARCH00009: Wait in PROC3_4 did resume passed
-- NEED RESULT: ARCH00009: Wait in PROC4_1 did resume passed
-- NEED RESULT: ARCH00009: Wait in PROC4_2 did resume passed
-- NEED RESULT: ARCH00009: Wait in PROC4_3 did resume passed
-- NEED RESULT: ARCH00009: Wait in PROC4_4 did resume passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00009
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.1 (7)
--    8.1 (10)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00009(ARCH00009)
--    ENT00009_Test_Bench(ARCH00009_Test_Bench)
--
-- REVISION HISTORY:
--
--    26-JUN-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
entity ENT00009 is
   generic ( G1 : Time := 10 ns ) ;
   port ( P1 : in Time := 10 ns ) ;
end ENT00009 ;

architecture ARCH00009 of ENT00009 is
   signal Num_Cycles : Integer := 0 ;

   signal Dummy, Dummy_Cond : Boolean := false ;

   signal P1_1_Did_Resume, P1_2_Did_Resume,
          P1_3_Did_Resume, P1_4_Did_Resume : Boolean := false ;
   signal P2_1_Did_Resume, P2_2_Did_Resume,
          P2_3_Did_Resume, P2_4_Did_Resume : Boolean := false ;
   signal P3_1_Did_Resume, P3_2_Did_Resume,
          P3_3_Did_Resume, P3_4_Did_Resume : Boolean := false ;
   signal PROC1_1_Did_Resume, PROC1_2_Did_Resume,
          PROC1_3_Did_Resume, PROC1_4_Did_Resume : Boolean := false ;
   signal PROC2_1_Did_Resume, PROC2_2_Did_Resume,
          PROC2_3_Did_Resume, PROC2_4_Did_Resume : Boolean := false ;
   signal PROC3_1_Did_Resume, PROC3_2_Did_Resume,
          PROC3_3_Did_Resume, PROC3_4_Did_Resume : Boolean := false ;
   signal PROC4_1_Did_Resume, PROC4_2_Did_Resume,
          PROC4_3_Did_Resume, PROC4_4_Did_Resume : Boolean := false ;


   constant Time_To_Wait : Time := 10 ns ;

   procedure PROC1_1 ( Signal Resume_Chk : inout Boolean ) is
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait on Dummy until Dummy_Cond for Time_To_Wait ; -- Locally Static
      test_report ( "ARCH00009.PROC1_1" ,
		    "Resume after time on timeout clause expired",
		    Time_To_Wait = (Std.Standard.Now - Save_Time)) ;
      Resume_Chk <= transport True ;
   end PROC1_1 ;

   procedure PROC1_2 ( Signal Resume_Chk : inout Boolean ) is
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait on Dummy for Time_To_Wait ;  -- Locally Static
      test_report ( "ARCH00009.PROC1_2" ,
		    "Resume after time on timeout clause expired",
		    Time_To_Wait = (Std.Standard.Now - Save_Time)) ;
      Resume_Chk <= transport True ;
   end PROC1_2 ;

   procedure PROC1_3 ( Signal Resume_Chk : inout Boolean ) is
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait until Dummy_Cond for Time_To_Wait ;  -- Locally Static
      test_report ( "ARCH00009.PROC1_3" ,
		    "Resume after time on timeout clause expired",
		    Time_To_Wait = (Std.Standard.Now - Save_Time)) ;
      Resume_Chk <= transport True ;
   end PROC1_3 ;

   procedure PROC1_4 ( Signal Resume_Chk : inout Boolean ) is
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait for Time_To_Wait ;  -- Locally Static
      test_report ( "ARCH00009.PROC1_4" ,
		    "Resume after time on timeout clause expired",
		    Time_To_Wait = (Std.Standard.Now - Save_Time)) ;
      Resume_Chk <= transport True ;
   end PROC1_4 ;

   procedure PROC2_1 ( Signal Resume_Chk : inout Boolean ) is
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait on Dummy until Dummy_Cond for G1 ; -- Globally Static
      test_report ( "ARCH00009.PROC2_1" ,
		    "Resume after time on timeout clause expired",
		    G1 = (Std.Standard.Now - Save_Time)) ;
      Resume_Chk <= transport True ;
   end PROC2_1 ;

   procedure PROC2_2 ( Signal Resume_Chk : inout Boolean ) is
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait on Dummy for G1 ;  -- Globally Static
      test_report ( "ARCH00009.PROC2_2" ,
		    "Resume after time on timeout clause expired",
		    G1 = (Std.Standard.Now - Save_Time)) ;
      Resume_Chk <= transport True ;
   end PROC2_2 ;

   procedure PROC2_3 ( Signal Resume_Chk : inout Boolean ) is
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait until Dummy_Cond for G1 ;  -- Globally Static
      test_report ( "ARCH00009.PROC2_3" ,
		    "Resume after time on timeout clause expired",
		    G1 = (Std.Standard.Now - Save_Time)) ;
      Resume_Chk <= transport True ;
   end PROC2_3 ;

   procedure PROC2_4 ( Signal Resume_Chk : inout Boolean ) is
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait for G1 ;  -- Globally Static
      test_report ( "ARCH00009.PROC2_4" ,
		    "Resume after time on timeout clause expired",
		    G1 = (Std.Standard.Now - Save_Time)) ;
      Resume_Chk <= transport True ;
   end PROC2_4 ;

   procedure PROC3_1 ( Signal Resume_Chk : inout Boolean ) is
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait on Dummy until Dummy_Cond for P1 ; -- Dynamic
      test_report ( "ARCH00009.PROC3_1" ,
		    "Resume after time on timeout clause expired",
		    P1 = (Std.Standard.Now - Save_Time)) ;
      Resume_Chk <= transport True ;
   end PROC3_1 ;

   procedure PROC3_2 ( Signal Resume_Chk : inout Boolean ) is
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait on Dummy for P1 ;  -- Dynamic
      test_report ( "ARCH00009.PROC3_2" ,
		    "Resume after time on timeout clause expired",
		    P1 = (Std.Standard.Now - Save_Time)) ;
      Resume_Chk <= transport True ;
   end PROC3_2 ;

   procedure PROC3_3 ( Signal Resume_Chk : inout Boolean ) is
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait until Dummy_Cond for P1 ;  -- Dynamic
      test_report ( "ARCH00009.PROC3_3" ,
		    "Resume after time on timeout clause expired",
		    P1 = (Std.Standard.Now - Save_Time)) ;
      Resume_Chk <= transport True ;
   end PROC3_3 ;

   procedure PROC3_4 ( Signal Resume_Chk : inout Boolean ) is
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait for P1 ;  -- Dynamic
      test_report ( "ARCH00009.PROC3_4" ,
		    "Resume after time on timeout clause expired",
		    P1 = (Std.Standard.Now - Save_Time)) ;
      Resume_Chk <= transport True ;
   end PROC3_4 ;

   procedure PROC4_1 (Time_To_Wait : Time; Signal Resume_Chk : inout Boolean) is
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait on Dummy until Dummy_Cond for Time_To_Wait ;
      test_report ( "ARCH00009.PROC4_1" ,
		    "Resume after time on timeout clause expired",
		    Time_To_Wait = (Std.Standard.Now - Save_Time)) ;
      Resume_Chk <= transport True ;
   end PROC4_1 ;

   procedure PROC4_2 (Time_To_Wait : Time; Signal Resume_Chk : inout Boolean) is
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait on Dummy for Time_To_Wait ;
      test_report ( "ARCH00009.PROC4_2" ,
		    "Resume after time on timeout clause expired",
		    Time_To_Wait = (Std.Standard.Now - Save_Time)) ;
      Resume_Chk <= transport True ;
   end PROC4_2 ;

   procedure PROC4_3 (Time_To_Wait : Time; Signal Resume_Chk : inout Boolean) is
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait until Dummy_Cond for Time_To_Wait ;
      test_report ( "ARCH00009.PROC4_3" ,
		    "Resume after time on timeout clause expired",
		    Time_To_Wait = (Std.Standard.Now - Save_Time)) ;
      Resume_Chk <= transport True ;
   end PROC4_3 ;

   procedure PROC4_4 (Time_To_Wait : Time; Signal Resume_Chk : inout Boolean) is
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait for Time_To_Wait ;
      test_report ( "ARCH00009.PROC4_4" ,
		    "Resume after time on timeout clause expired",
		    Time_To_Wait = (Std.Standard.Now - Save_Time)) ;
      Resume_Chk <= transport True ;
   end PROC4_4 ;

begin
   Test_Control :
   process ( Num_Cycles )
   begin
      if Num_Cycles < 11 then
	 Num_Cycles <= transport Num_Cycles + 1 after 1 ns ;

      elsif Num_Cycles = 11 then
         -- Verify that in fact, each of the wait statements did resume
         test_report ( "ARCH00009" ,
		       "Wait in P1_1 did resume" ,
		       P1_1_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in P1_2 did resume" ,
		       P1_2_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in P1_3 did resume" ,
		       P1_3_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in P1_4 did resume" ,
		       P1_4_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in P2_1 did resume" ,
		       P2_1_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in P2_2 did resume" ,
		       P2_2_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in P2_3 did resume" ,
		       P2_3_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in P2_4 did resume" ,
		       P2_4_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in P3_1 did resume" ,
		       P3_1_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in P3_2 did resume" ,
		       P3_2_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in P3_3 did resume" ,
		       P3_3_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in P3_4 did resume" ,
		       P3_4_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in PROC1_1 did resume" ,
		       PROC1_1_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in PROC1_2 did resume" ,
		       PROC1_2_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in PROC1_3 did resume" ,
		       PROC1_3_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in PROC1_4 did resume" ,
		       PROC1_4_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in PROC2_1 did resume" ,
		       PROC2_1_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in PROC2_2 did resume" ,
		       PROC2_2_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in PROC2_3 did resume" ,
		       PROC2_3_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in PROC2_4 did resume" ,
		       PROC2_4_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in PROC3_1 did resume" ,
		       PROC3_1_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in PROC3_2 did resume" ,
		       PROC3_2_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in PROC3_3 did resume" ,
		       PROC3_3_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in PROC3_4 did resume" ,
		       PROC3_4_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in PROC4_1 did resume" ,
		       PROC4_1_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in PROC4_2 did resume" ,
		       PROC4_2_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in PROC4_3 did resume" ,
		       PROC4_3_Did_Resume ) ;
         test_report ( "ARCH00009" ,
		       "Wait in PROC4_4 did resume" ,
		       PROC4_4_Did_Resume ) ;

      end if ;
   end process Test_Control ;

   P1_1 :
   process
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait on Dummy until Dummy_Cond for Time_To_Wait ; -- Locally Static
      test_report ( "ARCH00009.P1_1" ,
		    "Resume after time on timeout clause expired",
		    Time_To_Wait = (Std.Standard.Now - Save_Time)) ;
      P1_1_Did_Resume <= transport True ;
      wait;
   end process P1_1 ;

   P1_2 :
   process
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait on Dummy for Time_To_Wait ;  -- Locally Static
      test_report ( "ARCH00009.P1_2" ,
		    "Resume after time on timeout clause expired",
		    Time_To_Wait = (Std.Standard.Now - Save_Time)) ;
      P1_2_Did_Resume <= transport True ;
      wait;
   end process P1_2 ;

   P1_3 :
   process
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait until Dummy_Cond for Time_To_Wait ;  -- Locally Static
      test_report ( "ARCH00009.P1_3" ,
		    "Resume after time on timeout clause expired",
		    Time_To_Wait = (Std.Standard.Now - Save_Time)) ;
      P1_3_Did_Resume <= transport True ;
      wait;
   end process P1_3 ;

   P1_4 :
   process
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait for Time_To_Wait ;  -- Locally Static
      test_report ( "ARCH00009.P1_4" ,
		    "Resume after time on timeout clause expired",
		    Time_To_Wait = (Std.Standard.Now - Save_Time)) ;
      P1_4_Did_Resume <= transport True ;
      wait;
   end process P1_4 ;

   P2_1 :
   process
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait on Dummy until Dummy_Cond for G1 ; -- Globally Static
      test_report ( "ARCH00009.P2_1" ,
		    "Resume after time on timeout clause expired",
		    G1 = (Std.Standard.Now - Save_Time)) ;
      P2_1_Did_Resume <= transport True ;
      wait;
   end process P2_1 ;

   P2_2 :
   process
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait on Dummy for G1 ;  -- Globally Static
      test_report ( "ARCH00009.P2_2" ,
		    "Resume after time on timeout clause expired",
		    G1 = (Std.Standard.Now - Save_Time)) ;
      P2_2_Did_Resume <= transport True ;
      wait;
   end process P2_2 ;

   P2_3 :
   process
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait until Dummy_Cond for G1 ;  -- Globally Static
      test_report ( "ARCH00009.P2_3" ,
		    "Resume after time on timeout clause expired",
		    G1 = (Std.Standard.Now - Save_Time)) ;
      P2_3_Did_Resume <= transport True ;
      wait;
   end process P2_3 ;

   P2_4 :
   process
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait for G1 ;  -- Globally Static
      test_report ( "ARCH00009.P2_4" ,
		    "Resume after time on timeout clause expired",
		    G1 = (Std.Standard.Now - Save_Time)) ;
      P2_4_Did_Resume <= transport True ;
      wait;
   end process P2_4 ;

   P3_1 :
   process
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait on Dummy until Dummy_Cond for P1 ; -- Dynamic
      test_report ( "ARCH00009.P3_1" ,
		    "Resume after time on timeout clause expired",
		    P1 = (Std.Standard.Now - Save_Time)) ;
      P3_1_Did_Resume <= transport True ;
      wait;
   end process P3_1 ;

   P3_2 :
   process
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait on Dummy for P1 ;  -- Dynamic
      test_report ( "ARCH00009.P3_2" ,
		    "Resume after time on timeout clause expired",
		    P1 = (Std.Standard.Now - Save_Time)) ;
      P3_2_Did_Resume <= transport True ;
      wait;
   end process P3_2 ;

   P3_3 :
   process
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait until Dummy_Cond for P1 ;  -- Dynamic
      test_report ( "ARCH00009.P3_3" ,
		    "Resume after time on timeout clause expired",
		    P1 = (Std.Standard.Now - Save_Time)) ;
      P3_3_Did_Resume <= transport True ;
      wait;
   end process P3_3 ;

   P3_4 :
   process
      variable Save_Time : Time ;
   begin
      Save_Time := Std.Standard.Now ;
      wait for P1 ;  -- Dynamic
      test_report ( "ARCH00009.P3_4" ,
		    "Resume after time on timeout clause expired",
		    P1 = (Std.Standard.Now - Save_Time)) ;
      P3_4_Did_Resume <= transport True ;
      wait;
   end process P3_4 ;

   Q1_1 :
   process
   begin
      PROC1_1 (PROC1_1_Did_Resume);
      wait;
   end process Q1_1 ;

   Q1_2 :
   process
   begin
      PROC1_2 (PROC1_2_Did_Resume);
      wait;
   end process Q1_2 ;

   Q1_3 :
   process
   begin
      PROC1_3 (PROC1_3_Did_Resume);
      wait;
   end process Q1_3 ;

   Q1_4 :
   process
   begin
      PROC1_4 (PROC1_4_Did_Resume);
      wait;
   end process Q1_4 ;

   Q2_1 :
   process
   begin
      PROC2_1 (PROC2_1_Did_Resume);
      wait;
   end process Q2_1 ;

   Q2_2 :
   process
   begin
      PROC2_2 (PROC2_2_Did_Resume);
      wait;
   end process Q2_2 ;

   Q2_3 :
   process
   begin
      PROC2_3 (PROC2_3_Did_Resume);
      wait;
   end process Q2_3 ;

   Q2_4 :
   process
   begin
      PROC2_4 (PROC2_4_Did_Resume);
      wait;
   end process Q2_4 ;

   Q3_1 :
   process
   begin
      PROC3_1 (PROC3_1_Did_Resume);
      wait;
   end process Q3_1 ;

   Q3_2 :
   process
   begin
      PROC3_2 (PROC3_2_Did_Resume);
      wait;
   end process Q3_2 ;

   Q3_3 :
   process
   begin
      PROC3_3 (PROC3_3_Did_Resume);
      wait;
   end process Q3_3 ;

   Q3_4 :
   process
   begin
      PROC3_4 (PROC3_4_Did_Resume);
      wait;
   end process Q3_4 ;

   Q4_1 :
   process
   begin
      PROC4_1 (Time_To_Wait, PROC4_1_Did_Resume) ;
      wait;
   end process Q4_1 ;

   Q4_2 :
   process
   begin
      PROC4_2 (G1, PROC4_2_Did_Resume) ;
      wait;
   end process Q4_2 ;

   Q4_3 :
   process
   begin
      PROC4_3 (P1, PROC4_3_Did_Resume) ;
      wait;
   end process Q4_3 ;

   Q4_4 :
   process
   begin
      PROC4_4 (P1, PROC4_4_Did_Resume) ;
      wait;
   end process Q4_4 ;


end ARCH00009 ;

entity ENT00009_Test_Bench is
end ENT00009_Test_Bench ;

architecture ARCH00009_Test_Bench of ENT00009_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00009 ( ARCH00009 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00009_Test_Bench ;
