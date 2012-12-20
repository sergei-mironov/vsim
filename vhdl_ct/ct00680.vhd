-- NEED RESULT: ARCH00680: Conversion between different integer types passed
-- NEED RESULT: ARCH00680: Conversion between from floating to integer type passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00680
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
--    E00000(ARCH00680)
--    ENT00680_Test_Bench(ARCH00680_Test_Bench)
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
architecture ARCH00680 of E00000 is
   type int1 is range -10 to 100 ;
   type real1 is range -10.0 to 100.5 ;
begin
   process
      variable c_int1 : int1 := -2 ;
      variable c_integer : integer := 70 ;
      variable v_int1 : int1 ;
      variable v_integer : integer ;
--
      variable c_real1_1 : real1 := -2.3 ;
      variable c_real_1 : real := 70.6 ;
      variable c_real1_2 : real1 := -2.7 ;
      variable c_real_2 : real := 70.49 ;
      variable v_real1 : real1 ;
      variable v_real : real ;
      variable correct : boolean := true ;
   begin
      v_int1 := int1 ( c_integer ) ;
      correct := correct and v_int1 = 70 ;
      v_integer := integer ( c_int1 ) ;
      correct := correct and v_integer = -2 ;
      test_report ( "ARCH00680" ,
		    "Conversion between different integer types" ,
		    correct ) ;
--
      v_int1 := int1 ( c_real1_1 ) ;
      correct := correct and v_int1 = -2 ;
      v_int1 := int1 ( c_real1_2 ) ;
      correct := correct and v_int1 = -3 ;
      v_int1 := int1 ( c_real_1 ) ;
      correct := correct and v_int1 = 71 ;
      v_int1 := int1 ( c_real_2 ) ;
      correct := correct and v_int1 = 70 ;

      v_integer := integer ( c_real1_1 ) ;
      correct := correct and v_integer = -2 ;
      v_integer := integer ( c_real1_2 ) ;
      correct := correct and v_integer = -3 ;
      v_integer := integer ( c_real_1 ) ;
      correct := correct and v_integer = 71 ;
      v_integer := integer ( c_real_2 ) ;
      correct := correct and v_integer = 70 ;
      test_report ( "ARCH00680" ,
		    "Conversion between from floating to integer type" ,
		    correct ) ;
      wait ;
   end process ;
end ARCH00680 ;
--
entity ENT00680_Test_Bench is
end ENT00680_Test_Bench ;

architecture ARCH00680_Test_Bench of ENT00680_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00680 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00680_Test_Bench ;
--
