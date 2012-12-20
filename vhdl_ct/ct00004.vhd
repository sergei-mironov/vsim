-- NEED RESULT: ENT00004: Entity name after 'end' not present passed
-- NEED RESULT: ENT00004_1: Entity name after 'end' present passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00004
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.1 (3)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00004(ARCH00004)
--    ENT00004_1(ARCH00004_1)
--    ENT00004_Test_Bench(ARCH00004_Test_Bench)
--
-- REVISION HISTORY:
--
--    25-JUN-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
entity ENT00004 is
begin
end ;

architecture ARCH00004 of ENT00004 is
begin
   process
   begin
      test_report ( "ENT00004" ,
		    "Entity name after 'end' not present" ,
		    true ) ;
      wait ;
   end process ;
end ARCH00004 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00004_1 is
begin
end ENT00004_1 ;

architecture ARCH00004_1 of ENT00004_1 is
begin
   process
   begin
      test_report ( "ENT00004_1" ,
		    "Entity name after 'end' present" ,
		    true ) ;
      wait ;
   end process ;
end ARCH00004_1 ;

entity ENT00004_Test_Bench is
end ENT00004_Test_Bench ;

architecture ARCH00004_Test_Bench of ENT00004_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00004 ( ARCH00004 ) ;
      for CIS2 : UUT use entity WORK.ENT00004_1 ( ARCH00004_1 ) ;
   begin
      CIS1 : UUT ;
      CIS2 : UUT ;
   end block L1 ;
end ARCH00004_Test_Bench ;
