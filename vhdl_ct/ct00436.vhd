-- NEED RESULT: ARCH00436.Chk_s3: Guarded assignment controlled by implicit guard passed
-- NEED RESULT: ARCH00436.Chk_s2: Guarded assignment controlled by implicit guard passed
-- NEED RESULT: ARCH00436.Chk_s1: Guarded assignment controlled by implicit guard passed
-- NEED RESULT: ARCH00436.Chk_s1: Guarded assignment controlled by implicit guard passed
-- NEED RESULT: ARCH00436.Chk_s2: Guarded assignment controlled by implicit guard passed
-- NEED RESULT: ARCH00436.Chk_s3: Guarded assignment controlled by implicit guard passed
-- NEED RESULT: ARCH00436.Chk_gs3: Guarded assignment controlled by explicit guard passed
-- NEED RESULT: ARCH00436.Chk_gs2: Guarded assignment controlled by explicit guard passed
-- NEED RESULT: ARCH00436.Chk_gs1: Guarded assignment controlled by explicit guard passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    ct00436
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
--    E00000(ARCH00436)
--    ENT00436_Test_Bench(ARCH00436_Test_Bench)
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
architecture ARCH00436 of E00000 is
   function rfunc ( to_resolve : boolean_vector ) return boolean ;

   subtype rboolean is rfunc boolean ;
   signal Control : boolean := false ;
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
      s1 <= guarded transport Not s1 after 5 ns, s1 after 10 ns ;
      s2 <= guarded transport False after 5 ns, True  after 10 ns when s2 else
                              True  after 5 ns, False after 10 ns ;
      with s3 select
	 s3 <= guarded transport False after 5 ns, True  after 10 ns when True,
				 True  after 5 ns, False after 10 ns when others ;
   end block B1 ;

   Control <= transport True after 10 ns, False after 11 ns ;

   Chk_s1 :
   process ( s1 )
      variable SavTime : Time ;
      variable counter : Integer := 0 ;
   begin
      case counter is
	 when 0 =>
            SavTime := Std.Standard.Now ;
	 when 1 =>
	    test_report ( "ARCH00436.Chk_s1" ,
		          "Guarded assignment controlled by implicit guard" ,
		          s1 and ((SavTime+15 ns) = Std.Standard.Now) ) ;
	 when 2 =>
	    test_report ( "ARCH00436.Chk_s1" ,
		          "Guarded assignment controlled by implicit guard" ,
		          (Not s1) and ((SavTime+20 ns) = Std.Standard.Now) ) ;
         when 3 =>
	    test_report ( "ARCH00436.Chk_gs1" ,
		          "Guarded assignment controlled by explicit guard" ,
		           gs1 and ((SavTime+105 ns) = Std.Standard.Now) ) ;
         when others =>
	    test_report ( "ARCH00436.Chk_s1" ,
		          "Guarded assignment controlled by implicit guard" ,
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
	    test_report ( "ARCH00436.Chk_s2" ,
		          "Guarded assignment controlled by implicit guard" ,
		          s2 and ((SavTime+15 ns) = Std.Standard.Now) ) ;
	 when 2 =>
	    test_report ( "ARCH00436.Chk_s2" ,
		          "Guarded assignment controlled by implicit guard" ,
		          (Not s2) and ((SavTime+20 ns) = Std.Standard.Now) ) ;
         when 3 =>
	    test_report ( "ARCH00436.Chk_gs2" ,
		          "Guarded assignment controlled by explicit guard" ,
		           gs2 and ((SavTime+105 ns) = Std.Standard.Now) ) ;
         when others =>
	    test_report ( "ARCH00436.Chk_s2" ,
		          "Guarded assignment controlled by implicit guard" ,
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
	    test_report ( "ARCH00436.Chk_s3" ,
		          "Guarded assignment controlled by implicit guard" ,
		          s3 and ((SavTime+15 ns) = Std.Standard.Now) ) ;
	 when 2 =>
	    test_report ( "ARCH00436.Chk_s3" ,
		          "Guarded assignment controlled by implicit guard" ,
		          (Not s3) and ((SavTime+20 ns) = Std.Standard.Now) ) ;
         when 3 =>
	    test_report ( "ARCH00436.Chk_gs3" ,
		          "Guarded assignment controlled by explicit guard" ,
		           gs3 and ((SavTime+105 ns) = Std.Standard.Now) ) ;
         when others =>
	    test_report ( "ARCH00436.Chk_s3" ,
		          "Guarded assignment controlled by implicit guard" ,
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

   Guard <= transport True after 100 ns, False after 101 ns ;

end ARCH00436 ;

entity ENT00436_Test_Bench is
end ENT00436_Test_Bench ;

architecture ARCH00436_Test_Bench of ENT00436_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00436 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00436_Test_Bench ;
