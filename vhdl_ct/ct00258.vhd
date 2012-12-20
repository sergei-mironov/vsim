-- NEED RESULT: ARCH00258: Matching end name not necessary on architecture body passed
-- NEED RESULT: ARCH00258: Matching end name permitted on architecture body passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00258
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.2 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00258)
--    E00000(ARCH00258_1)
--    ENT00258_Test_Bench(ARCH00258_Test_Bench)
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
architecture ARCH00258 of E00000 is
begin
   process
   begin
      test_report ( "ARCH00258" ,
		    "Matching end name not necessary on architecture body" ,
		    true ) ;
       wait ;
   end process ;
end ;

use WORK.STANDARD_TYPES.all ;
architecture ARCH00258_1 of E00000 is
begin
   process
   begin
      test_report ( "ARCH00258" ,
		    "Matching end name permitted on architecture body" ,
		    true ) ;
      wait ;
   end process ;
end ARCH00258_1 ;

entity ENT00258_Test_Bench is
end ENT00258_Test_Bench ;

architecture ARCH00258_Test_Bench of ENT00258_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00258 ) ;
      for CIS2 : UUT use entity WORK.E00000 ( ARCH00258_1 ) ;
   begin
      CIS1 : UUT ;
      CIS2 : UUT ;
   end block L1 ;
end ARCH00258_Test_Bench ;
