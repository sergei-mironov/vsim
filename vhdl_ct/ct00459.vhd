-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00459
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
--    E00000(ARCH00459)
--    ENT00459_Test_Bench(ARCH00459_Test_Bench)
--
-- REVISION HISTORY:
--
--     4-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES ;
use WORK.ARITHMETIC.all ;
architecture ARCH00459 of E00000 is
begin
   process
      subtype st_int1 is integer range -100 to 1000 ;
      subtype st_int2 is integer range 0 downto -100 ;
      subtype st_phys1 is t_phys range (-2**20) * ones to (2**20) * ones ;
      subtype st_phys2 is t_phys range (-2**20) * ones to (2**20) * ones ;
      subtype st_real1 is real range 0.0 to 10.0 ;
      subtype st_real2 is real range -10.0 to -1.0 ;
      variable v_int1 : st_int1 := 49 ;
      variable v_int2 : st_int2 := -2 ;
      variable v_phys1 : st_phys1 := 2 tens ;
      variable v_phys2 : st_phys2 := 10 ones ;
      variable v_real1 : st_real1 := 9.0 ;
      variable v_real2 : st_real2 := -6.0 ;
      variable bool : boolean := true ;
   begin
      bool := bool and v_int1 mod v_int2 = -1 ;

      bool := bool and v_int1 rem v_int2 = 1 ;

      bool := bool and v_int1 * v_int2 = -98 ;
      bool := bool and abs (v_real1 * v_real2 - (-54.0)) < acceptable_error ;
--
      bool := bool and v_int1 / v_int2 = -24 ;
      bool := bool and v_phys1 / v_phys2 = 2 ;
      bool := bool and abs (v_real1 / v_real2 - (-1.5)) < acceptable_error ;
      STANDARD_TYPES.test_report ( "ARCH00459" ,
		    "Operands of multiplying operators may have different"
                    & " subtypes" ,
		    bool ) ;
      wait ;
   end process ;
end ARCH00459 ;

entity ENT00459_Test_Bench is
end ENT00459_Test_Bench ;

architecture ARCH00459_Test_Bench of ENT00459_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00459 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00459_Test_Bench ;
