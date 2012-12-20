-- NEED RESULT: ARCH00573: Library unit is visible passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00573
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    10.3 (14)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00573)
--    ENT00573_Test_Bench(ARCH00573_Test_Bench)
--    CONF00573
--
-- REVISION HISTORY:
--
--    19-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
architecture ARCH00573 of E00000 is
begin
   process
   begin
      WORK.STANDARD_TYPES.test_report ( "ARCH00573" ,
		                   "Library unit is visible" ,
		                   True ) ;
      wait ;
   end process ;
end ARCH00573 ;
--
entity ENT00573_Test_Bench is
end ENT00573_Test_Bench ;

architecture ARCH00573_Test_Bench of ENT00573_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00573 ) ;
   begin
      CIS1 : UUT ;
      CIS2 : UUT ;
   end block L1 ;
end ARCH00573_Test_Bench ;
--
configuration CONF00573 of WORK.ENT00573_Test_Bench is
   for ARCH00573_Test_Bench
      for L1
	 for CIS2 : UUT
	    use entity WORK.E00000 ( ARCH00573 );
	 end for ;
      end for ;
   end for ;
end CONF00573 ;
--
