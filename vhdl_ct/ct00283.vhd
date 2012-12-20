-- NEED RESULT: ARCH00283: Enumeration types passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00283
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    3.1.1 (1)
--    3.1.1 (2)
--    3.1.1 (3)
--    3.1.1 (4)
--    3.1.1 (5)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00283)
--    ENT00283_Test_Bench(ARCH00283_Test_Bench)
--
-- REVISION HISTORY:
--
--    21-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00283 of E00000 is
   type single_element is ( s ) ;                   -- this tests 3.1.1 (1)
   type mixed_type is ( a, b, 'a', 'b' ) ;          -- this tests 3.1.1 (2)
   type overloaded_type is ( s, a, b, 'a', 'b' ) ;  -- this tests 3.1.1 (4)
begin
   P :
   process
   begin
      -- this tests 3.1.1 (3) and 3.1.1 (5)
      test_report ( "ARCH00283" ,
		    "Enumeration types" ,
		    (single_element'pos(s) = 0) and
		    (mixed_type'pos(a)   = 0) and
		    (mixed_type'pos(b)   = 1) and
		    (mixed_type'pos('a') = 2) and
		    (mixed_type'pos('b') = 3) and
		    (overloaded_type'pos(s)   = 0) and
		    (overloaded_type'pos(a)   = 1) and
		    (overloaded_type'pos(b)   = 2) and
		    (overloaded_type'pos('a') = 3) and
		    (overloaded_type'pos('b') = 4)
                  ) ;
      wait ;
   end process P ;
end ARCH00283 ;

entity ENT00283_Test_Bench is
end ENT00283_Test_Bench ;

architecture ARCH00283_Test_Bench of ENT00283_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00283 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00283_Test_Bench ;

