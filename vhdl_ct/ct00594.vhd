-- NEED RESULT: ARCH00594: Type mark in subtype indication may be either a  type or a subtype name passed
-- NEED RESULT: ARCH00594: Constraint need not be present in subtype indication passed
-- NEED RESULT: ARCH00594: Constraint in subtype indication may be range or index constraint passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00594
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.2 (2)
--    4.2 (3)
--    4.2 (4)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00594)
--    ENT00594_Test_Bench(ARCH00594_Test_Bench)
--
-- REVISION HISTORY:
--
--    26-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00594 of E00000 is
   subtype st_boolean is boolean ;
   subtype st_string2 is st_string ;
   subtype st_integer is integer range 1 to 3 ;
   subtype st_string3 is string ( st_integer ) ;
-- these subtype definitions minimally cover the objectives -
--  the standard_types package covers with much more variation
begin
   process
      variable v_boolean : st_boolean := true ;
      variable v_string2 : st_string2 ;
      variable v_integer : st_integer := 2 ;
      variable v_string3 : st_string3 ;
       begin
      v_string2 := "abcde" ;
      v_string3 := "cde" ;
      test_report ( "ARCH00594" ,
		    "Type mark in subtype indication may be either a "
                    & " type or a subtype name" ,
		    v_boolean = true and v_integer = 2 and
                    v_string2 = "abcde" and v_string3 = "cde") ;
      test_report ( "ARCH00594" ,
		    "Constraint need not be present in subtype indication" ,
		    v_boolean = true and v_integer = 2 and
                    v_string2 = "abcde" and v_string3 = "cde") ;
      test_report ( "ARCH00594" ,
		    "Constraint in subtype indication may be range or"
                    & " index constraint" ,
		    v_boolean = true and v_integer = 2 and
                    v_string2 = "abcde" and v_string3 = "cde") ;
      wait ;
   end process ;
end ARCH00594 ;
--
entity ENT00594_Test_Bench is
end ENT00594_Test_Bench ;

architecture ARCH00594_Test_Bench of ENT00594_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00594 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00594_Test_Bench ;
--
