-- NEED RESULT: ARCH00316: An if statement in a Process passed
-- NEED RESULT: ARCH00316: A procedure/function call and a variable asg in a Process passed
-- NEED RESULT: An assert in a Process Passed
-- NEED RESULT: ARCH00316: A case statement in a Process passed
-- NEED RESULT: ARCH00316: Loop and exit statement in a Process passed
-- NEED RESULT: ARCH00316: Loop and next statement in a Process passed
-- NEED RESULT: ARCH00316: Null, signal asg, and wait statements in a Process passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00316
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.2 (3)
--    9.2 (5)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00316)
--    ENT00316_Test_Bench(ARCH00316_Test_Bench)
--
-- REVISION HISTORY:
--
--    29-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00316 of E00000 is
   signal s1 : boolean := false ;
begin
   P1 :
   process
      procedure A_Proc ( variable Entered : inout boolean ) ;

      constant C : integer := 2 ;

      function A_Func ( Dummy : integer := C ) return boolean is
      begin
	 return Dummy = C ;
      end A_Func ;

      procedure A_Proc ( variable Entered : inout boolean ) is
      begin
	 Entered := True ;
      end A_Proc ;

      type A_Type is ( e0, e1, e2, e3, e4, e5 ) ;

      subtype A_Subtype is A_Type range e2 to e4 ;

      alias An_Alias : Integer range 2 to 4 is C ;

      variable A_Var : A_Subtype := A_Type'Val (An_Alias) ; -- e2

      attribute An_Attr : A_Subtype ;

      attribute An_Attr of A_Var : variable is e2 ;

      variable v1, v2 : boolean ;

   begin
      if A_Var = A_Var'An_Attr then
	 test_report ( "ARCH00316" ,
		       "An if statement in a Process" ,
		       True ) ;
      else
	 test_report ( "ARCH00316" ,
		       "An if statement in a Process" ,
		       False ) ;
      end if ;

      A_Proc ( v1 ) ; -- Returns True
      v2 := v1 ;
      test_report ( "ARCH00316" ,
		    "A procedure/function call and a variable asg in a Process" ,
		    A_Func and v1 and v2 ) ;

      assert False
	report "An assert in a Process Passed"
	severity Note ;

      case A_Subtype'Low is
	 when e2 =>
	    test_report ( "ARCH00316" ,
			  "A case statement in a Process" ,
			  True ) ;
	 when Others =>
	    test_report ( "ARCH00316" ,
			  "A case statement in a Process" ,
			  False ) ;
      end case ;

      loop
         exit ;
	 v2 := false ;
      end loop ;
      test_report ( "ARCH00316" ,
		    "Loop and exit statement in a Process" ,
		    v2 ) ;

      for i in 1 to 10 loop
	 next ;
	 v1 := false;
      end loop ;
      test_report ( "ARCH00316" ,
		    "Loop and next statement in a Process" ,
		    v1 ) ;

      null ;
      s1 <= transport Not s1 ; -- Schedule True
      wait on s1 for 1 ns ;
      test_report ( "ARCH00316" ,
		    "Null, signal asg, and wait statements in a Process" ,
		    s1 ) ;

      wait ;

   end process P1 ;
end ARCH00316 ;

entity ENT00316_Test_Bench is
end ENT00316_Test_Bench ;

architecture ARCH00316_Test_Bench of ENT00316_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00316 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00316_Test_Bench ;
