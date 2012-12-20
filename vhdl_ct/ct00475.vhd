-- NEED RESULT: ARCH00475: Aggregates may have one or many element associations passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00475
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.3.2 (1)
--    7.3.2 (2)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00475)
--    ENT00475_Test_Bench(ARCH00475_Test_Bench)
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
architecture ARCH00475 of E00000 is
   type rec_1 is record
		    f1 : integer ;
		    f2 : boolean ;
		    f3 : real ;
		 end record ;
   type rec_2 is record
		    f1 : integer ;
		 end record ;
   type arr_1 is array ( integer range <> ) of rec_1 ;
begin
   process
      variable v_int1 : integer := 10 ;
      variable v_bool1 : boolean := true ;
      variable v_real1 : real := 3.5 ;
      subtype st_arr_1 is arr_1 ( 1 to 4 ) ;
      subtype st_arr_2 is arr_1 ( 1 to 5 ) ;
      subtype st_arr_3 is arr_1 ( 2 to 2 ) ;
      variable v_arr_1 : st_arr_1 ;
      variable v_arr_2 : st_arr_2 ;
      variable v_arr_3 : st_arr_3 ;
      variable v_rec_1, v_rec_3 : rec_1 ;
      variable v_rec_2 : rec_2 ;
      variable bool : boolean := true ;
   begin
      v_rec_1 := ( f1 => v_int1, f2 => v_bool1, f3 => v_real1 ) ;
      v_rec_3 := ( 4, false, 3.3 ) ;
      v_rec_2 := ( f1 => v_int1 ) ;
      v_arr_1 := ( 1 => v_rec_1, 3 downto 2 => v_rec_3, others => v_rec_1 ) ;
      v_arr_2 := ( 1 to 5 => v_rec_1 ) ;
      v_arr_3 := ( 2 => v_rec_3 ) ;

      bool := bool and v_rec_1.f1 = v_int1 ;
      bool := bool and v_rec_1.f2 = v_bool1 ;
      bool := bool and v_rec_1.f3 = v_real1 ;
      bool := bool and v_rec_2.f1 = v_int1 ;
      bool := bool and v_arr_1(1) = v_rec_1 ;
      bool := bool and v_arr_1(2) = v_rec_3 ;
      bool := bool and v_arr_1(3) = v_rec_3 ;
      bool := bool and v_arr_1(4) = v_rec_1 ;
      for i in 5 downto 1 loop
	 bool := bool and v_arr_2(i) = v_rec_1 ;
      end loop ;
      bool := bool and v_arr_3(2) = v_rec_3 ;

      test_report ( "ARCH00475" ,
		    "Aggregates may have one or many element associations" ,
		    bool ) ;
      wait ;
   end process ;
end ARCH00475 ;

entity ENT00475_Test_Bench is
end ENT00475_Test_Bench ;

architecture ARCH00475_Test_Bench of ENT00475_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00475 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00475_Test_Bench ;
