-- NEED RESULT: ARCH00469: Entity name list has more than one designator passed
-- NEED RESULT: ARCH00469: Entity name list has one designator passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00469
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    5.1 (1)
--    5.1 (4)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00469
--    ENT00469_Test_Bench(ARCH00469_Test_Bench)
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
package PKG00469 is
   attribute Attr1 : Integer ;
   attribute Attr2 : WORK.STANDARD_TYPES.st_boolean_vector ;
end PKG00469 ;

use WORK.PKG00469.all, WORK.STANDARD_TYPES.all ;
entity ENT00469_Test_Bench is
end ENT00469_Test_Bench ;

use WORK.STANDARD_TYPES.all ;
architecture ARCH00469_Test_Bench of ENT00469_Test_Bench is
    constant C1, C2 : Real := 0.0 ;
    signal S1 : Bit := '0' ;
    signal S2, S3 : Std.Standard.Severity_Level := NOTE ;

    attribute Attr1 of C1 : constant is Integer'Low ;
    attribute Attr2 of S3 : signal is c_st_boolean_vector_1 ;
    attribute Attr1 of S1, S2 : signal is Integer'High ;
    attribute Attr2 of C1, C2 : constant is c_st_boolean_vector_2 ;

begin
   process
   begin
      test_report ( "ARCH00469" ,
		    "Entity name list has more than one designator" ,
		    S1'Attr1 = Integer'High and
		    S2'Attr1 = Integer'High and
                    C1'Attr2 = c_st_boolean_vector_2 and
                    C2'Attr2 = c_st_boolean_vector_2 ) ;
      wait ;
   end process ;

   process
   begin
      test_report ( "ARCH00469" ,
		    "Entity name list has one designator" ,
		    C1'Attr1 = Integer'Low and
                    S3'Attr2 = c_st_boolean_vector_1 ) ;
      wait ;
   end process ;

end ARCH00469_Test_Bench ;
