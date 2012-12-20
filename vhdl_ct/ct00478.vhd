-- NEED RESULT: ARCH00478: Choices in an element association of an aggregate may contain several or no choices passed
-- NEED RESULT: ARCH00478: Element simple name properly disambiguated from simple expressions in aggregate element associations passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00478
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.3.2 (3)
--    7.3.2 (4)
--    7.3.2 (5)
--    7.3.2 (6)
--    7.3.2 (8)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00478)
--    ENT00478_Test_Bench(ARCH00478_Test_Bench)
--
-- REVISION HISTORY:
--
--     6-AUG-1987   - initial revision
--     5-MAY-1988   -CSW
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00478 of E00000 is
   type rec_1 is record
		    f1 : integer ;
		    f2 : integer ;
		    f3 : boolean ;
		    f4 : real ;
		 end record ;
   type rec_2 is record
		    f1 : integer ;
		 end record ;
   type arr_1 is array ( integer range <> ) of rec_1 ;
begin
   process
      constant c_int1 : integer := 1 ;
      constant f1 : integer := 3 ;
      variable v_int1 : integer := 10 ;
      variable v_int2 : integer := 1 ;
      variable v_int3 : integer := 5 ;
      variable v_bool1 : boolean := true ;
      variable v_real1 : real := 3.5 ;
      subtype st_arr_1 is arr_1 ( 1 to 4 ) ;
      subtype st_arr_2 is arr_1 ( v_int2 to v_int3 ) ;
      subtype st_arr_3 is arr_1 ( 2 to 2 ) ;
      variable v_arr_1_1, v_arr_1_2 : st_arr_1 ;
      variable v_arr_2_1, v_arr_2_2 : st_arr_2 ;
      variable v_arr_3_1, v_arr_3_2 : st_arr_3 ;
      variable v_rec_1_1, v_rec_1_2 : rec_1 ;
      variable v_rec_2_2 : rec_2 ;
      variable bool : boolean := true ;
   begin
      v_rec_1_1 := ( v_int1, v_int2, v_bool1, v_real1 );
      v_rec_1_2 := ( f1 | f2 => 3 , f3 => false , f4 => 0.0 ) ;

      v_arr_1_1 := ( 1 to 2 | f1 | 4 => v_rec_1_1 ) ;
      v_arr_1_2 := ( 1 to 2 | 10 - 6 downto 3 + c_int1 => v_rec_1_2,
                     others => v_rec_1_1 ) ;

      v_arr_2_1 := ( v_rec_1_1, v_rec_1_2, v_rec_1_1, v_rec_1_1, v_rec_1_2 ) ;
      v_arr_2_2 := ( 5 downto 1 => v_rec_1_1 ) ;

      v_arr_3_1 := ( 2 to 2 => v_rec_1_2 ) ;
      v_arr_3_2 := ( others => v_rec_1_1 ) ;

      bool := bool and v_rec_1_1.f1 = v_int1 ;
      bool := bool and v_rec_1_1.f2 = v_int2 ;
      bool := bool and v_rec_1_1.f3 = v_bool1 ;
      bool := bool and v_rec_1_1.f4 = v_real1 ;

      for i in 1 to 4 loop
	 bool := bool and v_arr_1_1(i) = v_rec_1_1 ;
      end loop ;

      bool := bool and v_arr_1_2(1) = v_rec_1_2 ;
      bool := bool and v_arr_1_2(2) = v_rec_1_2 ;
      bool := bool and v_arr_1_2(3) = v_rec_1_1 ;
      bool := bool and v_arr_1_2(4) = v_rec_1_2 ;

      bool := bool and v_arr_2_1(1) = v_rec_1_1 ;
      bool := bool and v_arr_2_1(2) = v_rec_1_2 ;
      bool := bool and v_arr_2_1(3) = v_rec_1_1 ;
      bool := bool and v_arr_2_1(4) = v_rec_1_1 ;
      bool := bool and v_arr_2_1(5) = v_rec_1_2 ;

      for i in 5 downto 1 loop
	 bool := bool and v_arr_2_2(i) = v_rec_1_1 ;
      end loop ;

      bool := bool and v_arr_3_1(2) = v_rec_1_2 ;

      bool := bool and v_arr_3_2(2) = v_rec_1_1 ;

      test_report ( "ARCH00478" ,
		    "Choices in an element association of an aggregate"
                    & " may contain several or no choices" ,
		    bool ) ;

      v_rec_2_2 := ( f1 => f1 ) ;
      v_arr_1_1 := ( f1 => v_rec_1_2, others => v_rec_1_1 ) ;

      test_report ( "ARCH00478" ,
		    "Element simple name properly disambiguated from simple"
                    & " expressions in aggregate element associations" ,
		    v_rec_2_2.f1 = 3 and v_arr_1_1(3) = v_rec_1_2 ) ;

      wait ;
   end process ;
end ARCH00478 ;

entity ENT00478_Test_Bench is
end ENT00478_Test_Bench ;

architecture ARCH00478_Test_Bench of ENT00478_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00478 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00478_Test_Bench ;
