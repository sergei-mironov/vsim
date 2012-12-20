-- NEED RESULT: ENT00002: 'begin' may be present in entity declarations passed
-- NEED RESULT: ENT00002_1: 'begin' may be absent in entity declarations passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00002
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.1 (2)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00002(ARCH00002)
--    ENT00002_1(ARCH00002_1)
--    ENT00002_Test_Bench(ARCH00002_Test_Bench)
--
-- REVISION HISTORY:
--
--    24-JUN-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
entity ENT00002 is
begin
end ENT00002 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00002_1 is
end ENT00002_1 ;

architecture ARCH00002 of ENT00002 is
begin
   process
   begin
      test_report ( "ENT00002" ,
   	            "'begin' may be present in entity declarations" ,
	            true ) ;
      wait ;
   end process ;
end ARCH00002 ;

architecture ARCH00002_1 of ENT00002_1 is
begin
   process
   begin
      test_report ( "ENT00002_1" ,
   	            "'begin' may be absent in entity declarations" ,
	            true ) ;
      wait ;
   end process ;
end ARCH00002_1 ;

entity ENT00002_Test_Bench is
end ENT00002_Test_Bench ;

architecture ARCH00002_Test_Bench of ENT00002_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00002 ( ARCH00002 ) ;
      for CIS2 : UUT use entity WORK.ENT00002_1 ( ARCH00002_1 ) ;
   begin
      CIS1 : UUT ;
      CIS2 : UUT ;
   end block L1 ;
end ARCH00002_Test_Bench ;
