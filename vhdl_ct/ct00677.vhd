-- NEED RESULT: ARCH00677: Attributes inherited by aliases passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00677
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.4 (2)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00677)
--    ENT00677_Test_Bench(ARCH00677_Test_Bench)
--
-- REVISION HISTORY:
--
--     1-SEP-1987   - initial revision
--    17-JUN-1988   - (KLM) added wait at end of process
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00677 of E00000 is
   signal s : string ( 1 to 3 ) ;
   attribute at : boolean ;
   attribute at of s : signal is true ;
   alias al_s : string ( 2 to 4) is s ;
begin
   process
      subtype st is integer range al_s'range ;
   begin
      test_report ( "ARCH00677" ,
		    "Attributes inherited by aliases" ,
		    st'left = 2 and al_s'at ) ;
      wait;
   end process ;
end ARCH00677 ;
--
entity ENT00677_Test_Bench is
end ENT00677_Test_Bench ;

architecture ARCH00677_Test_Bench of ENT00677_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00677 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00677_Test_Bench ;
--
