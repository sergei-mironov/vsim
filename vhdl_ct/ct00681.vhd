-- NEED RESULT: ARCH00681: Conversion between different real types passed
-- NEED RESULT: ARCH00681: Conversion between from floating to real type passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00681
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.3.5 (2)
--    7.3.5 (4)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00681)
--    ENT00681_Test_Bench(ARCH00681_Test_Bench)
--
-- REVISION HISTORY:
--
--     7-SEP-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00681 of E00000 is
   type real1 is range -10.0 to 100.5 ;
   type int1 is range -10 to 100 ;
begin
   process
      variable c_real1 : real1 := -2.3 ;
      variable c_real : real := 70.6 ;
      variable v_real1 : real1 ;
      variable v_real : real ;
--
      variable c_int1_1 : int1 := -2 ;
      variable c_integer_1 : integer := 10 ;
      variable c_int1_2 : int1 := -10 ;
      variable c_integer_2 : integer := 0 ;
      variable v_int1 : int1 ;
      variable v_integer : integer ;
      variable correct : boolean := True ;
   begin
      v_real1 := real1 ( c_real ) ;
      correct := correct and v_real1 = 70.6 ;
      v_real := real ( c_real1 ) ;
      correct := correct and v_real = -2.3 ;
      test_report ( "ARCH00681" ,
		    "Conversion between different real types" ,
		    correct ) ;
--
      v_real1 := real1 ( c_int1_1 ) ;
      correct := correct and v_real1 = -2.0 ;
      v_real1 := real1 ( c_int1_2 ) ;
      correct := correct and v_real1 = -10.0 ;
      v_real1 := real1 ( c_integer_1 ) ;
      correct := correct and v_real1 = 10.0 ;
      v_real1 := real1 ( c_integer_2 ) ;
      correct := correct and v_real1 = 0.0 ;

      v_real := real ( c_int1_1 ) ;
      correct := correct and v_real = -2.0 ;
      v_real := real ( c_int1_2 ) ;
      correct := correct and v_real = -10.0 ;
      v_real := real ( c_integer_1 ) ;
      correct := correct and v_real = 10.0 ;
      v_real := real ( c_integer_2 ) ;
      correct := correct and v_real = 0.0 ;
      test_report ( "ARCH00681" ,
		    "Conversion between from floating to real type" ,
		    correct ) ;
      wait ;
   end process ;
end ARCH00681 ;
--
entity ENT00681_Test_Bench is
end ENT00681_Test_Bench ;

architecture ARCH00681_Test_Bench of ENT00681_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00681 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00681_Test_Bench ;
--
