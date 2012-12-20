-- NEED RESULT: ENT00005: Formal generic clause absent passed
-- NEED RESULT: ENT00005_1: Formal generic clause present passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00005
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.1.1 (1)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00005(ARCH00005)
--    ENT00005_1(ARCH00005_1)
--    ENT00005_Test_Bench(ARCH00005_Test_Bench)
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
entity ENT00005 is
end ENT00005 ;

architecture ARCH00005 of ENT00005 is
begin
   process
   begin
      test_report ( "ENT00005" ,
		    "Formal generic clause absent" ,
		    true ) ;
      wait ;
   end process ;
end ARCH00005 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00005_1 is
   generic ( dummy : boolean := True ) ;
end ENT00005_1 ;

architecture ARCH00005_1 of ENT00005_1 is
begin
   process
   begin
      test_report ( "ENT00005_1" ,
		    "Formal generic clause present" ,
		    dummy ) ;
      wait ;
   end process ;
end ARCH00005_1 ;

entity ENT00005_Test_Bench is
end ENT00005_Test_Bench ;

architecture ARCH00005_Test_Bench of ENT00005_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00005 ( ARCH00005 ) ;
      for CIS2 : UUT use entity WORK.ENT00005_1 ( ARCH00005_1 ) ;
   begin
      CIS1 : UUT ;
      CIS2 : UUT ;
   end block L1 ;
end ARCH00005_Test_Bench ;
