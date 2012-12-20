-- NEED RESULT: ARCH00479: Choices in an element association of an aggregate may contain several or no choices passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00479
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.3.2 (7)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00479)
--    ENT00479_Test_Bench(ARCH00479_Test_Bench)
--
-- REVISION HISTORY:
--
--     6-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00479 of E00000 is
   type rec_1 is record
		    f1 : integer ;
		    f2 : integer ;
		    f3 : integer ;
		    f4 : bit_vector ( 0 to 3 ) ;
		 end record ;
   type arr_1 is array ( integer range <> ) of bit_vector ( 0 to 3 ) ;
begin
   process
      variable v_int1 : integer := 4 ;
      variable bool : boolean := true ;
      variable v_rec_1_1, v_rec_1_2, v_rec_1_3 : rec_1 ;
      subtype st_arr1 is arr_1 ( 1 to 4 ) ;
      variable v_arr_1_1, v_arr_1_2, v_arr_1_3 : st_arr1 ;
   begin
      v_rec_1_1 := ( v_int1, v_int1, 3, f4 => B"0011" );
      v_rec_1_2 := ( 3, f4 => B"1100", f2 | f3 => 4 ) ;
      v_rec_1_3 := ( 3, 5, f4 => B"1010", others => 2 ) ;

      v_arr_1_1 := ( B"0000", B"0001", B"0010", others => B"0010" ) ;
      v_arr_1_2 := ( B"0011", B"0100", others => B"0101" ) ;
      v_arr_1_3 := ( B"0110", B"1000", B"0111", others => B"1000" ) ;

      bool := bool and v_rec_1_1.f1 = v_int1 ;
      bool := bool and v_rec_1_1.f2 = v_int1 ;
      bool := bool and v_rec_1_1.f3 = 3 ;
      bool := bool and v_rec_1_1.f4 = B"0011" ;

      bool := bool and v_rec_1_2.f1 = 3 ;
      bool := bool and v_rec_1_2.f2 = 4 ;
      bool := bool and v_rec_1_2.f3 = 4 ;
      bool := bool and v_rec_1_2.f4 = B"1100" ;

      bool := bool and v_rec_1_3.f1 = 3 ;
      bool := bool and v_rec_1_3.f2 = 5 ;
      bool := bool and v_rec_1_3.f3 = 2 ;
      bool := bool and v_rec_1_3.f4 = B"1010" ;

      bool := bool and v_arr_1_1(1) = B"0000" ;
      bool := bool and v_arr_1_1(2) = B"0001" ;
      bool := bool and v_arr_1_1(3) = B"0010" ;
      bool := bool and v_arr_1_1(4) = B"0010" ;

      bool := bool and v_arr_1_2(1) = B"0011" ;
      bool := bool and v_arr_1_2(2) = B"0100" ;
      bool := bool and v_arr_1_2(3) = B"0101" ;
      bool := bool and v_arr_1_2(4) = B"0101" ;

      bool := bool and v_arr_1_3(1) = B"0110" ;
      bool := bool and v_arr_1_3(2) = B"1000" ;
      bool := bool and v_arr_1_3(3) = B"0111" ;
      bool := bool and v_arr_1_3(4) = B"1000" ;

      test_report ( "ARCH00479" ,
		    "Choices in an element association of an aggregate"
                    & " may contain several or no choices" ,
		    bool ) ;

      wait ;
   end process ;
end ARCH00479 ;

entity ENT00479_Test_Bench is
end ENT00479_Test_Bench ;

architecture ARCH00479_Test_Bench of ENT00479_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00479 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00479_Test_Bench ;
