-- NEED RESULT: ARCH00051: One or more elsif's are allowed in if statement passed
-- NEED RESULT: ARCH00051: One or more elsif's are allowed in if statement passed
-- NEED RESULT: ARCH00051: One or more elsif's are allowed in if statement passed
-- NEED RESULT: ARCH00051: One or more elsif's are allowed in if statement passed
-- NEED RESULT: ARCH00051: One or more elsif's are allowed in if statement passed
-- NEED RESULT: ARCH00051: One or more elsif's are allowed in if statement passed
-- NEED RESULT: ARCH00051: One or more elsif's are allowed in if statement passed
-- NEED RESULT: ARCH00051: One or more elsif's are allowed in if statement passed
-- NEED RESULT: ARCH00051: One or more elsif's are allowed in if statement passed
-- NEED RESULT: ARCH00051: One or more elsif's are allowed in if statement passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00051
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.6 (2)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00051)
--    ENT00051_Test_Bench(ARCH00051_Test_Bench)
--
-- REVISION HISTORY:
--
--     1-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00051 of E00000 is
   signal Dummy : boolean := false ;
begin
   P1 :
   process ( Dummy )
      variable correct : boolean := false ;
   begin
      for i in 1 to 10 loop
	 if i = 1 then
            correct := (i = 1) ;
	 elsif i = 2 then
            correct := (i = 2) ;
	 elsif i = 3 then
            correct := (i = 3) ;
	 elsif i = 4 then
            correct := (i = 4) ;
	 elsif i = 5 then
            correct := (i = 5) ;
	 elsif i = 6 then
            correct := (i = 6) ;
	 elsif i = 7 then
            correct := (i = 7) ;
	 elsif i = 8 then
            correct := (i = 8) ;
	 elsif i = 9 then
            correct := (i = 9) ;
	 else
            correct := (i = 10) ;
	 end if ;
	 test_report ( "ARCH00051" ,
		       "One or more elsif's are allowed in if statement" ,
		       correct ) ;
      end loop ;
   end process P1 ;
end ARCH00051 ;

entity ENT00051_Test_Bench is
end ENT00051_Test_Bench ;

architecture ARCH00051_Test_Bench of ENT00051_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00051 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00051_Test_Bench ;
