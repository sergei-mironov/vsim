-- NEED RESULT: ARCH00433.Chk_s3: Guarded assignment controlled by implicit guard passed
-- NEED RESULT: ARCH00433.Chk_s2: Guarded assignment controlled by implicit guard passed
-- NEED RESULT: ARCH00433.Chk_s1: Guarded assignment controlled by implicit guard passed
-- NEED RESULT: ARCH00433.Chk_gs3: Guarded assignment controlled by explicit guard passed
-- NEED RESULT: ARCH00433.Chk_gs2: Guarded assignment controlled by explicit guard passed
-- NEED RESULT: ARCH00433.Chk_gs1: Guarded assignment controlled by explicit guard passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00433
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.5 (4)
--    9.5 (5)
--    9.5 (9)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00433)
--    ENT00433_Test_Bench(ARCH00433_Test_Bench)
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
architecture ARCH00433 of E00000 is
   signal Control, s1, s2, s3 : boolean := false ;
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

   Control <= transport True after 10 ns, False after 11 ns ;

   Chk_s1 :
   process ( s1 )
      variable SavTime : Time ;
      variable First_Time : boolean := true ;
   begin
      if First_Time then
	 First_Time := false ;
         SavTime := Std.Standard.Now ;
      else
	 test_report ( "ARCH00433.Chk_s1" ,
		       "Guarded assignment controlled by implicit guard" ,
		       s1 and ((SavTime+15 ns) = Std.Standard.Now) ) ;
      end if ;
   end process Chk_s1 ;

   Chk_s2 :
   process ( s2 )
      variable SavTime : Time ;
      variable First_Time : boolean := true ;
   begin
      if First_Time then
	 First_Time := false ;
         SavTime := Std.Standard.Now ;
      else
	 test_report ( "ARCH00433.Chk_s2" ,
		       "Guarded assignment controlled by implicit guard" ,
		       s2 and ((SavTime+15 ns) = Std.Standard.Now) ) ;
      end if ;
   end process Chk_s2 ;

   Chk_s3 :
   process ( s3 )
      variable SavTime : Time ;
      variable First_Time : boolean := true ;
   begin
      if First_Time then
	 First_Time := false ;
         SavTime := Std.Standard.Now ;
      else
	 test_report ( "ARCH00433.Chk_s3" ,
		       "Guarded assignment controlled by implicit guard" ,
		       s3 and ((SavTime+15 ns) = Std.Standard.Now) ) ;
      end if ;
   end process Chk_s3 ;


   -- The following depend on the explicit signal Guard
   gs1 <= guarded transport Not gs1 after 5 ns ;
   gs2 <= guarded transport False after 5 ns when gs2 else
                            True  after 5 ns ;
   with gs3 select
      gs3 <= guarded transport False after 5 ns when True,
			       True  after 5 ns when others ;

   Guard <= transport True after 100 ns, False after 101 ns ;

   Chk_gs1 :
   process ( gs1 )
      variable SavTime : Time ;
      variable First_Time : boolean := true ;
   begin
      if First_Time then
	 First_Time := false ;
         SavTime := Std.Standard.Now ;
      else
	 test_report ( "ARCH00433.Chk_gs1" ,
		       "Guarded assignment controlled by explicit guard" ,
		       gs1 and ((SavTime+105 ns) = Std.Standard.Now) ) ;
      end if ;
   end process Chk_gs1 ;

   Chk_gs2 :
   process ( gs2 )
      variable SavTime : Time ;
      variable First_Time : boolean := true ;
   begin
      if First_Time then
	 First_Time := false ;
         SavTime := Std.Standard.Now ;
      else
	 test_report ( "ARCH00433.Chk_gs2" ,
		       "Guarded assignment controlled by explicit guard" ,
		       gs2 and ((SavTime+105 ns) = Std.Standard.Now) ) ;
      end if ;
   end process Chk_gs2 ;

   Chk_gs3 :
   process ( gs3 )
      variable SavTime : Time ;
      variable First_Time : boolean := true ;
   begin
      if First_Time then
	 First_Time := false ;
         SavTime := Std.Standard.Now ;
      else
	 test_report ( "ARCH00433.Chk_gs3" ,
		       "Guarded assignment controlled by explicit guard" ,
		       gs3 and ((SavTime+105 ns) = Std.Standard.Now) ) ;
      end if ;
   end process Chk_gs3 ;
end ARCH00433 ;

entity ENT00433_Test_Bench is
end ENT00433_Test_Bench ;

architecture ARCH00433_Test_Bench of ENT00433_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00433 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00433_Test_Bench ;
