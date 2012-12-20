-- NEED RESULT: ENT00006: port clause not present in entity header passed
-- NEED RESULT: ENT00006_1: port clause present in entity header passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00006
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.1.1 (2)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00006(ARCH00006)
--    ENT00006_1(ARCH00006_1)
--    ENT00006_Test_Bench(ARCH00006_Test_Bench)
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
entity ENT00006 is
end ENT00006 ;

architecture ARCH00006 of ENT00006 is
begin
   process
   begin
      test_report ( "ENT00006" ,
		    "port clause not present in entity header" ,
		    true ) ;
      wait ;
   end process ;
end ARCH00006 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00006_1 is
   port ( dummy : boolean := false) ;
end ENT00006_1 ;

architecture ARCH00006_1 of ENT00006_1 is
begin
   process
   begin
      test_report ( "ENT00006_1" ,
		    "port clause present in entity header" ,
		    true ) ;
      wait ;
   end process ;
end ARCH00006_1 ;

entity ENT00006_Test_Bench is
end ENT00006_Test_Bench ;

architecture ARCH00006_Test_Bench of ENT00006_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00006 ( ARCH00006 ) ;
      for CIS2 : UUT use entity WORK.ENT00006_1 ( ARCH00006_1 ) ;
   begin
      CIS1 : UUT ;
      CIS2 : UUT ;
   end block L1 ;
end ARCH00006_Test_Bench ;
