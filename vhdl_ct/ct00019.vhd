-- NEED RESULT: ARCH00019: Wait in P1_1 did resume passed
-- NEED RESULT: ARCH00019: Wait in P1_2 did resume passed
-- NEED RESULT: ARCH00019: Wait in P2_1 did resume passed
-- NEED RESULT: ARCH00019: Wait in P2_2 did resume passed
-- NEED RESULT: ARCH00019: Wait in P3_1 did resume passed
-- NEED RESULT: ARCH00019: Wait in P3_2 did resume passed
-- NEED RESULT: ARCH00019: Wait in R1_1 did resume passed
-- NEED RESULT: ARCH00019: Wait in R1_2 did resume passed
-- NEED RESULT: ARCH00019: Wait in PROC1_1 did resume passed
-- NEED RESULT: ARCH00019: Wait in PROC1_2 did resume passed
-- NEED RESULT: ARCH00019: Wait in PROC2_1 did resume passed
-- NEED RESULT: ARCH00019: Wait in PROC2_2 did resume passed
-- NEED RESULT: ARCH00019: Wait in PROC3_1 did resume passed
-- NEED RESULT: ARCH00019: Wait in PROC3_2 did resume passed
-- NEED RESULT: ARCH00019: Wait in PROC4_1 did resume passed
-- NEED RESULT: ARCH00019: Wait in PROC4_2 did resume passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00019
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.1 (9)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00019(ARCH00019)
--    ENT00019_Test_Bench(ARCH00019_Test_Bench)
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
entity ENT00019 is
   generic ( G1 : Time := 10 ns ) ;
   port ( P1 : in Time := 10 ns ) ;
end ENT00019 ;

architecture ARCH00019 of ENT00019 is
   signal Pulse1, Pulse2, Pulse3 : Boolean := false ;
   signal TestIt : Boolean := false;

   signal P1_1_Did_Resume, P1_2_Did_Resume : Boolean := false ;
   signal P2_1_Did_Resume, P2_2_Did_Resume : Boolean := false ;
   signal P3_1_Did_Resume, P3_2_Did_Resume : Boolean := false ;
   signal R1_1_Did_Resume, R1_2_Did_Resume : Boolean := false ;
   signal PROC1_1_Did_Resume, PROC1_2_Did_Resume : Boolean := false ;
   signal PROC2_1_Did_Resume, PROC2_2_Did_Resume : Boolean := false ;
   signal PROC3_1_Did_Resume, PROC3_2_Did_Resume : Boolean := false ;
   signal PROC4_1_Did_Resume, PROC4_2_Did_Resume : Boolean := false ;


   constant Time_To_Wait : Time := 10 ns ;

   procedure PROC1_1 ( Signal Resume_Chk : inout boolean ) is
   begin
      wait on Pulse1,Pulse2,Pulse3 until (Pulse1 and Pulse2 and Pulse3)
           for Time_To_Wait ;
      if Pulse1 and Pulse2 and Pulse3 then
         Resume_Chk <= transport True ;
      else
         test_report ( "ARCH00019" ,
		       "Wait in PROC1_1 resumed when condition was false" ,
		       false ) ;
      end if ;
   end PROC1_1 ;

   procedure PROC1_2 ( Signal Resume_Chk : inout boolean ) is
   begin
      wait until (Pulse1 and Pulse2 and Pulse3) for Time_To_Wait ;
      if Pulse1 and Pulse2 and Pulse3 then
         Resume_Chk <= transport True ;
      else
         test_report ( "ARCH00019" ,
		       "Wait in PROC1_2 resumed when condition was false" ,
		       false ) ;
      end if ;
   end PROC1_2 ;

   procedure PROC2_1 ( Signal Resume_Chk : inout boolean ) is
   begin
      wait on Pulse1,Pulse2,Pulse3 until (Pulse1 and Pulse2 and Pulse3)
           for G1 ;
      if Pulse1 and Pulse2 and Pulse3 then
         Resume_Chk <= transport True ;
      else
         test_report ( "ARCH00019" ,
		       "Wait in PROC2_1 resumed when condition was false" ,
		       false ) ;
      end if ;
   end PROC2_1 ;

   procedure PROC2_2 ( Signal Resume_Chk : inout boolean ) is
   begin
      wait until (Pulse1 and Pulse2 and Pulse3) for G1 ;
      if Pulse1 and Pulse2 and Pulse3 then
         Resume_Chk <= transport True ;
      else
         test_report ( "ARCH00019" ,
		       "Wait in PROC2_2 resumed when condition was false" ,
		       false ) ;
      end if ;
   end PROC2_2 ;

   procedure PROC3_1 ( Signal Resume_Chk : inout boolean ) is
   begin
      wait on Pulse1,Pulse2,Pulse3 until (Pulse1 and Pulse2 and Pulse3)
           for P1 ;
      if Pulse1 and Pulse2 and Pulse3 then
         Resume_Chk <= transport True ;
      else
         test_report ( "ARCH00019" ,
		       "Wait in PROC3_1 resumed when condition was false" ,
		       false ) ;
      end if ;
   end PROC3_1 ;

   procedure PROC3_2 ( Signal Resume_Chk : inout boolean ) is
   begin
      wait until (Pulse1 and Pulse2 and Pulse3) for P1 ;
      if Pulse1 and Pulse2 and Pulse3 then
         Resume_Chk <= transport True ;
      else
         test_report ( "ARCH00019" ,
		       "Wait in PROC3_2 resumed when condition was false" ,
		       false ) ;
      end if ;
   end PROC3_2 ;

   procedure PROC4_1 (Time_To_Wait : Time ;
                      signal Pulse1, Pulse2, Pulse3 : Boolean ;
                      signal Resume_Chk : inout boolean) is
   begin
      wait on Pulse1,Pulse2,Pulse3 until (Pulse1 and Pulse2 and Pulse3)
           for Time_To_Wait ;
      if Pulse1 and Pulse2 and Pulse3 then
         Resume_Chk <= transport True ;
      else
         test_report ( "ARCH00019" ,
		       "Wait in PROC4_1 resumed when condition was false" ,
		       false ) ;
      end if ;
   end PROC4_1 ;

   procedure PROC4_2 (Time_To_Wait : Time;
                      signal Pulse1, Pulse2, Pulse3 : Boolean ;
                      signal Resume_Chk : inout boolean) is
   begin
      wait until (Pulse1 and Pulse2 and Pulse3) for Time_To_Wait ;
      if Pulse1 and Pulse2 and Pulse3 then
         Resume_Chk <= transport True ;
      else
         test_report ( "ARCH00019" ,
		       "Wait in PROC4_2 resumed when condition was false" ,
		       false ) ;
      end if ;
   end PROC4_2 ;

begin
   Test_Control :
   process ( Pulse1, Pulse2, Pulse3, TestIt)
   begin
      if not Pulse1 then
	 Pulse1 <= transport not Pulse1 after 1 ns ;

      elsif not Pulse2 then
	 Pulse2 <= transport not Pulse2 after 1 ns ;

      elsif not Pulse3 then
	 Pulse3 <= transport not Pulse3 after 1 ns ;
         TestIt <= transport TRUE after 2 ns;
      elsif TestIt then
         -- Verify that in fact, all of the wait statements resumed
         test_report ( "ARCH00019" ,
		       "Wait in P1_1 did resume" ,
		       P1_1_Did_Resume ) ;
         test_report ( "ARCH00019" ,
		       "Wait in P1_2 did resume" ,
		       P1_2_Did_Resume ) ;
         test_report ( "ARCH00019" ,
		       "Wait in P2_1 did resume" ,
		       P2_1_Did_Resume ) ;
         test_report ( "ARCH00019" ,
		       "Wait in P2_2 did resume" ,
		       P2_2_Did_Resume ) ;
         test_report ( "ARCH00019" ,
		       "Wait in P3_1 did resume" ,
		       P3_1_Did_Resume ) ;
         test_report ( "ARCH00019" ,
		       "Wait in P3_2 did resume" ,
		       P3_2_Did_Resume ) ;
         test_report ( "ARCH00019" ,
		       "Wait in R1_1 did resume" ,
		       R1_1_Did_Resume ) ;
         test_report ( "ARCH00019" ,
		       "Wait in R1_2 did resume" ,
		       R1_2_Did_Resume ) ;
         test_report ( "ARCH00019" ,
		       "Wait in PROC1_1 did resume" ,
		       PROC1_1_Did_Resume ) ;
         test_report ( "ARCH00019" ,
		       "Wait in PROC1_2 did resume" ,
		       PROC1_2_Did_Resume ) ;
         test_report ( "ARCH00019" ,
		       "Wait in PROC2_1 did resume" ,
		       PROC2_1_Did_Resume ) ;
         test_report ( "ARCH00019" ,
		       "Wait in PROC2_2 did resume" ,
		       PROC2_2_Did_Resume ) ;
         test_report ( "ARCH00019" ,
		       "Wait in PROC3_1 did resume" ,
		       PROC3_1_Did_Resume ) ;
         test_report ( "ARCH00019" ,
		       "Wait in PROC3_2 did resume" ,
		       PROC3_2_Did_Resume ) ;
         test_report ( "ARCH00019" ,
		       "Wait in PROC4_1 did resume" ,
		       PROC4_1_Did_Resume ) ;
         test_report ( "ARCH00019" ,
		       "Wait in PROC4_2 did resume" ,
		       PROC4_2_Did_Resume ) ;

      end if ;
   end process Test_Control ;

   P1_1 :
   process
   begin
      wait on Pulse1,Pulse2,Pulse3 until (Pulse1 and Pulse2 and Pulse3)
           for Time_To_Wait ;
      if Pulse1 and Pulse2 and Pulse3 then
         P1_1_Did_Resume <= transport True ;
      else
         test_report ( "ARCH00019" ,
		       "Wait in P1_1 resumed when condition was false" ,
		       false ) ;
      end if ;
      wait;
   end process P1_1 ;

   P1_2 :
   process
   begin
      wait until (Pulse1 and Pulse2 and Pulse3) for Time_To_Wait ;
      if Pulse1 and Pulse2 and Pulse3 then
         P1_2_Did_Resume <= transport True ;
      else
         test_report ( "ARCH00019" ,
		       "Wait in P1_2 resumed when condition was false" ,
		       false ) ;
      end if ;
      wait;
   end process P1_2 ;

   P2_1 :
   process
   begin
      wait on Pulse1,Pulse2,Pulse3 until (Pulse1 and Pulse2 and Pulse3)
           for G1 ;
      if Pulse1 and Pulse2 and Pulse3 then
         P2_1_Did_Resume <= transport True ;
      else
         test_report ( "ARCH00019" ,
		       "Wait in P2_1 resumed when condition was false" ,
		       false ) ;
      end if ;
      wait;
   end process P2_1 ;

   P2_2 :
   process
   begin
      wait until (Pulse1 and Pulse2 and Pulse3) for G1 ;
      if Pulse1 and Pulse2 and Pulse3 then
         P2_2_Did_Resume <= transport True ;
      else
         test_report ( "ARCH00019" ,
		       "Wait in P2_2 resumed when condition was false" ,
		       false ) ;
      end if ;
      wait;
   end process P2_2 ;

   P3_1 :
   process
   begin
      wait on Pulse1,Pulse2,Pulse3 until (Pulse1 and Pulse2 and Pulse3)
           for P1 ;
      if Pulse1 and Pulse2 and Pulse3 then
         P3_1_Did_Resume <= transport True ;
      else
         test_report ( "ARCH00019" ,
		       "Wait in P3_1 resumed when condition was false" ,
		       false ) ;
      end if ;
      wait;
   end process P3_1 ;

   P3_2 :
   process
   begin
      wait until (Pulse1 and Pulse2 and Pulse3) for P1 ;
      if Pulse1 and Pulse2 and Pulse3 then
         P3_2_Did_Resume <= transport True ;
      else
         test_report ( "ARCH00019" ,
		       "Wait in P3_2 resumed when condition was false" ,
		       false ) ;
      end if ;
      wait;
   end process P3_2 ;

   Q1_1 :
   process
   begin
      PROC1_1 (PROC1_1_Did_Resume) ;
      wait;
   end process Q1_1 ;

   Q1_2 :
   process
   begin
      PROC1_2 (PROC1_2_Did_Resume) ;
      wait;
   end process Q1_2 ;

   Q2_1 :
   process
   begin
      PROC2_1 (PROC2_1_Did_Resume) ;
      wait;
   end process Q2_1 ;

   Q2_2 :
   process
   begin
      PROC2_2 (PROC2_2_Did_Resume) ;
      wait;
   end process Q2_2 ;

   Q3_1 :
   process
   begin
      PROC3_1 (PROC3_1_Did_Resume) ;
      wait;
   end process Q3_1 ;

   Q3_2 :
   process
   begin
      PROC3_2 (PROC3_2_Did_Resume) ;
      wait;
   end process Q3_2 ;

   Q4_1 :
   process
   begin
      PROC4_1 (Time_To_Wait, Pulse1, Pulse2, Pulse3, PROC4_1_Did_Resume) ;
      wait;
   end process Q4_1 ;

   Q4_2 :
   process
   begin
      PROC4_2 (P1, Pulse1, Pulse2, Pulse3, PROC4_2_Did_Resume) ;
      wait;
   end process Q4_2 ;

   R1_1 :
   process
   begin
      wait on Pulse1,Pulse2,Pulse3 until (Pulse1 and Pulse2 and Pulse3) ;
      if Pulse1 and Pulse2 and Pulse3 then
         R1_1_Did_Resume <= transport True ;
      else
         test_report ( "ARCH00019" ,
		       "Wait in R1_1 resumed when condition was false" ,
		       false ) ;
      end if ;
      wait;
   end process R1_1 ;

   R1_2 :
   process
   begin
      wait until (Pulse1 and Pulse2 and Pulse3) ;
      if Pulse1 and Pulse2 and Pulse3 then
         R1_2_Did_Resume <= transport True ;
      else
         test_report ( "ARCH00019" ,
		       "Wait in R1_2 resumed when condition was false" ,
		       false ) ;
      end if ;
      wait;
   end process R1_2 ;


end ARCH00019 ;

entity ENT00019_Test_Bench is
end ENT00019_Test_Bench ;

architecture ARCH00019_Test_Bench of ENT00019_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00019 ( ARCH00019 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00019_Test_Bench ;
