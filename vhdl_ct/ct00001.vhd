-- NEED RESULT: ARCH00001: Different architectures associated with same entity passed
-- NEED RESULT: ARCH00001_1: Different architectures associated with same entity passed


-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00001
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.1 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00001)
--    E00000(ARCH00001_1)
--    ENT00001_Test_Bench(ARCH00001_Test_Bench)
--
-- REVISION HISTORY:
--
--    24-JUN-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
--
use WORK.STANDARD_TYPES.all ;

architecture ARCH00001 of E00000 is
begin
   process
   begin
      test_report ( "ARCH00001" ,
      "Different architectures associated with same entity" ,
      true ) ;
      wait ;
   end process ;
end ARCH00001 ;
use WORK.STANDARD_TYPES.all ;
architecture ARCH00001_1 of E00000 is
begin
   process
   begin
      test_report ( "ARCH00001_1" ,
      "Different architectures associated with same entity" ,
      true ) ;
      wait ;
   end process ;
end ARCH00001_1 ;
entity ENT00001_Test_Bench is
end ENT00001_Test_Bench ;
architecture ARCH00001_Test_Bench of ENT00001_Test_Bench is
begin
   L1 :
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00001 );
      for CIS2 : UUT use entity WORK.E00000 ( ARCH00001_1 );
   begin
      CIS1 : UUT;
      CIS2 : UUT;
   end block L1 ;
end ARCH00001_Test_Bench ;
