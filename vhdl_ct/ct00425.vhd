-- NEED RESULT: ARCH00425: Decimal literals passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

-- 
-- TEST NAME: 
-- 
--    CT00425 
-- 
-- AUTHOR: 
-- 
--    D. Hyman 
-- 
-- TEST OBJECTIVES: 
-- 
--    13.4.1 (1) 
--    13.4.1 (2) 
--    13.4.1 (3) 
--    13.4.1 (4) 
--    13.4.1 (5) 
--    13.4.1 (6) 
--    13.4.1 (7)
-- 
-- DESIGN UNIT ORDERING: 
--
--    E00000(ARCH00425)
--    ENT00425_Test_Bench(ARCH00425_Test_Bench)
--
-- REVISION HISTORY: 
-- 
--     3-AUG-1987   - initial revision
-- 
-- NOTES:
-- 
--    self-checking
--
-- 
use WORK.STANDARD_TYPES.all ;
architecture ARCH00425 of E00000 is
begin
   P :
   process
      -- these will test 13.4.1 (1)
      variable int_e_lower : integer := 1e6 ; 
      variable int_e_upper : integer := 1E6 ; 
      variable real_e_lower : real := 1.0e6 ; 
      variable real_e_upper : real := 1.0E6 ; 
      -- these will test 13.4.1 (2)
      variable int_underscore_1 : integer := 12_1e2 ; 
      variable int_underscore_2 : integer := 1_21e2 ; 
      variable int_underscore_3 : integer := 1e0_09 ; 
      variable int_underscore_4 : integer := 1e00_9 ; 
      variable real_underscore_1 : real := 12_1.0e2 ; 
      variable real_underscore_2 : real := 1_21.0e2 ; 
      variable real_underscore_3 : real := 1.0e0_12 ; 
      variable real_underscore_4 : real := 1.0e01_2 ; 
      -- these will test 13.4.1 (3), 13.4.1 (4) and 13.4.1 (7)
      variable int_zeroes_1 : integer := 0123 ; 
      variable int_zeroes_2 : integer := 00123E0 ; 
      variable int_zeroes_3 : integer := 
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000123
                        ; 
      -- these will test 13.4.1 (5) and 13.4.1 (6)
      variable real_zeroes_1 : real :=
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000123.4
                        ; 
      variable real_zeroes_2 : real :=
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000123.4000000
                        ;
   begin
      test_report ( "ARCH00425" ,
		    "Decimal literals" ,
		    (int_e_lower = 1000000) and
		    (int_e_upper = 1000000) and
		    (real_e_lower = 1000000.0) and
		    (real_e_upper = 1000000.0) and
		    (int_underscore_1 = 12100) and
		    (int_underscore_2 = 12100) and
		    (int_underscore_3 = 1000000000) and
		    (int_underscore_4 = 1000000000) and
		    (real_underscore_1 = 12100.0) and
		    (real_underscore_2 = 12100.0) and
		    (real_underscore_3 = 1000000000000.0) and
		    (real_underscore_4 = 1000000000000.0) and
		    (int_zeroes_1 = 123) and
		    (int_zeroes_2 = 123) and
		    (int_zeroes_3 = 123) and
		    (real_zeroes_1 = 123.4) and
		    (real_zeroes_2 = 123.4) 
                ) ;
      wait ;
   end process P ;
end ARCH00425 ;

entity ENT00425_Test_Bench is
end ENT00425_Test_Bench ;
 
architecture ARCH00425_Test_Bench of ENT00425_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
 
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00425 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00425_Test_Bench ;

