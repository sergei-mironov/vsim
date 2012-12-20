-- NEED RESULT: ARCH00472: Entity designator in an attribute spec may be a simple name or an operator symbol passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00472
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    5.1 (2)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00472_Test_Bench(ARCH00472_Test_Bench)
--
-- REVISION HISTORY:
--
--     6-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00472_Test_Bench is
   attribute Attr1 : boolean ;
end ENT00472_Test_Bench ;

architecture ARCH00472_Test_Bench of ENT00472_Test_Bench is
   function Func1 return Integer ;
   function "and" ( L,R: Integer ) return boolean is
   begin
      return (L >= 1) and (R >= 1) ;
   end "AND" ;

   attribute Attr1 of Func1, "And" : function is True ;

   function Func1 return Integer is
   begin
      return 0 ;
   end Func1 ;
begin
   process
   begin
      test_report ( "ARCH00472" ,
		    "Entity designator in an attribute spec may be a "&
                    "simple name or an operator symbol" ,
		    Func1'Attr1 and ARCH00472_Test_Bench."And"'Attr1 ) ;
      wait ;
   end process ;
end ARCH00472_Test_Bench ;
