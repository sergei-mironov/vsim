-- NEED RESULT: ARCH00600: Index ranges of variables and signals passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00600
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    3.2.1.1 (1)
--    3.2.1.1 (2)
--    3.2.1.1 (3)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00600)
--    ENT00600_Test_Bench(ARCH00600_Test_Bench)
--
-- REVISION HISTORY:
--
--    21-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES; use STANDARD_TYPES.all ;
architecture ARCH00600 of E00000 is
   signal s : STANDARD_TYPES.st_arr1 ;       -- 3.2.1.1 (for signals)
   signal t : STANDARD_TYPES.st_rec3 ;       -- 3.2.1.2 (for signals)
   signal u : STANDARD_TYPES.st_arr2 ;       -- 3.2.1.3 (for signals)
begin
   P :
   process
      variable a : STANDARD_TYPES.st_arr1 ;  -- 3.2.1.1 (for variables)
      variable b : STANDARD_TYPES.st_rec3 ;  -- 3.2.1.2 (for variables)
      variable c : STANDARD_TYPES.st_arr2 ;  -- 3.2.1.3 (for variables)
   begin
      test_report ( "ARCH00600" ,
		    "Index ranges of variables and signals" ,
		    (a'left = lowb) and
		    (a'right = highb) and
		    (b.f3'left(1) = lowb) and
		    (b.f3'right(1) = highb) and
		    (b.f3'left(2) = false) and
		    (b.f3'right(2) = true) and
		    (c(lowb,false)'left = lowb) and
		    (c(lowb,false)'right = highb) and
		    (s'left = lowb) and
		    (s'right = highb) and
		    (t.f3'left(1) = lowb) and
		    (t.f3'right(1) = highb) and
		    (t.f3'left(2) = false) and
		    (t.f3'right(2) = true) and
		    (u(lowb,false)'left = lowb) and
		    (u(lowb,false)'right = highb)
                  ) ;
      wait;
   end process P ;
end ARCH00600 ;
--
entity ENT00600_Test_Bench is
end ENT00600_Test_Bench ;

architecture ARCH00600_Test_Bench of ENT00600_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00600 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00600_Test_Bench ;
--
