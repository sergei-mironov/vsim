-- NEED RESULT: ARCH00581: Overloading context rule 2 -- discrete type required passed
-- NEED RESULT: ARCH00581: Overloading context rule 2 -- boolean type required passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00581
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    10.5 (1)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00581
--    PKG00581/BODY
--    ENT00581_Test_Bench(ARCH00581_Test_Bench)
--
-- REVISION HISTORY:
--
--    20-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
package PKG00581 is
   type T is ( false , true ) ;
   type Integer is range 0.0 to 100.0 ;

   function "and" ( L,R : T ) return T ;

   function F1 (P : Std.Standard.Integer := 0) return Std.Standard.Integer ;
   function F1 (P : Integer := 0.0) return Integer ;

end PKG00581 ;
--
package body PKG00581 is
   function "and" ( L,R : T ) return T is
   begin
      case L is
	 when false =>
	    return false ;
	 when true =>
	    return R ;
      end case ;
   end "and" ;

   function F1 (P : Std.Standard.Integer := 0) return Std.Standard.Integer is
   begin
      return P ;
   end F1 ;

   function F1 (P : Integer := 0.0) return Integer is
   begin
      return P ;
   end F1 ;
end PKG00581 ;
--
use WORK.STANDARD_TYPES.Test_Report ;
use WORK.PKG00581.all ;
entity ENT00581_Test_Bench is
end ENT00581_Test_Bench ;

architecture ARCH00581_Test_Bench of ENT00581_Test_Bench is
begin
   L1 :
   block ( true )
   begin
      process ( GUARD )
      begin
	 case F1 is  -- overloaded Function
	    when others =>
	       test_report ( "ARCH00581" ,
			     "Overloading context rule 2 -- discrete type "&
                             "required" ,
			     True ) ;
	 end case ;

	 test_report ( "ARCH00581" ,
		       "Overloading context rule 2 -- boolean type required",
		       true and true ) ;  -- overloaded operator
      end process ;
   end block L1 ;
end ARCH00581_Test_Bench ;
--
