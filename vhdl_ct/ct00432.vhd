-- NEED RESULT: ARCH00432: Operands of adding operators may have different subtypes passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00432
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.2.3 (8)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00432)
--    ENT00432_Test_Bench(ARCH00432_Test_Bench)
--
-- REVISION HISTORY:
--
--     4-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00432 of E00000 is
begin
   process
      subtype st_int1 is integer range 100 to 1000 ;
      subtype st_int2 is integer range 0 downto -100 ;
      subtype st_phys1 is t_phys1 range 1 phys1_1 to 10 phys1_3 ;
      subtype st_phys2 is t_phys1 range 10 phys1_1 to 100 phys1_1 ;
      subtype st_real1 is real range 0.0 to 10.0 ;
      subtype st_real2 is real range -10.0 to -1.0 ;
      subtype st_bv1 is bit_vector ( 2 to 2 ) ;
      subtype st_bv2 is bit_vector ( 1 to 3 ) ;
      variable v_int1 : st_int1 := 100 ;
      variable v_int2 : st_int2 := -100 ;
      variable v_phys1 : st_phys1 := 2 phys1_2 ;
      variable v_phys2 : st_phys2 := 10 phys1_1 ;
      variable v_real1 : st_real1 := 9.0 ;
      variable v_real2 : st_real2 := -6.0 ;
      variable v_bv1 : st_bv1 := B"1" ;
      variable v_bv2 : st_bv2 := B"000" ;
      variable bool : boolean := true ;
   begin
      bool := bool and v_int1 + v_int2 = 0 ;
      bool := bool and v_phys1 + v_phys2 = 30 phys1_1 ;
      bool := bool and v_real1 + v_real2 = 3.0 ;
--
      bool := bool and v_int1 - v_int2 = 200 ;
      bool := bool and v_phys1 - v_phys2 = 10 phys1_1 ;
      bool := bool and v_real1 - v_real2 = 15.0 ;
--
      bool := bool and v_bv1 & v_bv2 = B"1000" ;
      test_report ( "ARCH00432" ,
		    "Operands of adding operators may have different subtypes" ,
		    bool ) ;
      wait ;
   end process ;
end ARCH00432 ;

entity ENT00432_Test_Bench is
end ENT00432_Test_Bench ;

architecture ARCH00432_Test_Bench of ENT00432_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00432 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00432_Test_Bench ;
