-- NEED RESULT: ENT00259(ARCH00259): Different architecture bodies with different entities may have same name passed
-- NEED RESULT: ENT00259_1(ARCH00259): Different architecture bodies with different entities may have same name passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00259
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.2 (2)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00259(ARCH00259)
--    ENT00259_1(ARCH00259)
--    ENT00259_Test_Bench(ARCH00259_Test_Bench)
--
-- REVISION HISTORY:
--
--    16-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
entity ENT00259 is
begin
end ENT00259 ;

architecture ARCH00259 of ENT00259 is
begin
   p :
   process
   begin
      test_report ( "ENT00259(ARCH00259)" ,
		    "Different architecture bodies with different entities" &
                    " may have same name" ,
		    true ) ;
      wait ;
   end process p ;
end ARCH00259 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00259_1 is
begin
end ENT00259_1 ;

architecture ARCH00259 of ENT00259_1 is
begin
   p :
   process
   begin
      test_report ( "ENT00259_1(ARCH00259)" ,
		    "Different architecture bodies with different entities" &
                    " may have same name" ,
		    true ) ;
       wait ;
   end process p ;
end ARCH00259 ;

entity ENT00259_Test_Bench is
end ENT00259_Test_Bench ;

architecture ARCH00259_Test_Bench of ENT00259_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00259 ( ARCH00259 ) ;
      for CIS2 : UUT use entity WORK.ENT00259_1 ( ARCH00259 ) ;
   begin
      CIS1 : UUT ;
      CIS2 : UUT ;
   end block L1 ;
end ARCH00259_Test_Bench ;
