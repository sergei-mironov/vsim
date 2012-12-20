-- NEED RESULT: ARCH00280: Block statement with a guard expression passed
-- NEED RESULT: ARCH00280: Block statement without a guard expression passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00280
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.1 (2)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00280)
--    ENT00280_Test_Bench(ARCH00280_Test_Bench)
--
-- REVISION HISTORY:
--
--    21-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00280 of E00000 is
   signal S : boolean := false ;
begin
   B1 :
   block ( S )
   begin
      B1_2 :
      block ( Not S )
      begin
	 process
	 begin
	    test_report ( "ARCH00280" ,
			  "Block statement with a guard expression" ,
			  True ) ;
            wait ;
	 end process ;
      end block B1_2 ;
   end block B1 ;

   B2 :
   block ( S )
   begin
      B2_2 :
      block
      begin
	 process
	 begin
	    test_report ( "ARCH00280" ,
			  "Block statement without a guard expression" ,
			  True ) ;
            wait ;
	 end process ;
      end block B2_2 ;
   end block B2 ;
end ARCH00280 ;

entity ENT00280_Test_Bench is
end ENT00280_Test_Bench ;

architecture ARCH00280_Test_Bench of ENT00280_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00280 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00280_Test_Bench ;
