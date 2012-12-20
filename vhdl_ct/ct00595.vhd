-- NEED RESULT: ARCH00595: The base type of a subtype is the base type of the type or subtype denoted by type mark passed
-- NEED RESULT: ARCH00595: Subtype do not define new types  passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00595
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.2 (5)
--    4.2 (6)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00595)
--    ENT00595_Test_Bench(ARCH00595_Test_Bench)
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
architecture ARCH00595 of E00000 is
   subtype severity_level_1 is severity_level ;
   subtype severity_level_2 is severity_level_1 range warning to failure ;
   subtype severity_level_3 is severity_level_2 range failure downto error ;
begin
   process
      subtype severity_level_3 is severity_level_2 range failure downto error ;
      variable v_severity_level : severity_level := failure ;
      variable v_severity_level_3 : severity_level_3 := failure ;
   begin
      test_report ( "ARCH00595" ,
		    "The base type of a subtype is the base type of"
                    & " the type or subtype denoted by type mark" ,
		    severity_level'base'left = note and
		    severity_level'base'right = failure and
		    severity_level_1'base'left = note and
		    severity_level_1'base'right = failure and
		    severity_level_2'base'left = note and
		    severity_level_2'base'right = failure and
		    severity_level_3'base'left = note and
		    severity_level_3'base'right = failure ) ;
      test_report ( "ARCH00595" ,
		    "Subtype do not define new types " ,
		    v_severity_level_3 = v_severity_level ) ;
      wait ;
   end process ;
end ARCH00595 ;
--
entity ENT00595_Test_Bench is
end ENT00595_Test_Bench ;

architecture ARCH00595_Test_Bench of ENT00595_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00595 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00595_Test_Bench ;
--
