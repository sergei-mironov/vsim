-- NEED RESULT: ARCH00488: String and bit string literals allowed at place of one dimensional character type passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00488
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.3.2.2 (2)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00488)
--    ENT00488_Test_Bench(ARCH00488_Test_Bench)
--
-- REVISION HISTORY:
--
--     7-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00488 of E00000 is
   type arr_1 is array ( severity_level range <> , boolean range <> ,
                         integer range <> ) of character ;
   type arr_2 is array ( bit range <> , integer range <> ) of bit ;
   type arr_3 is array ( bit range <> , integer range <> ) of bit_vector
                                                                 (0 to 2)  ;
begin
   process
      variable bool : boolean := true ;
      variable add_pos : integer := 0 ;

      subtype range1_1 is severity_level range note to error ;
      subtype range1_2 is boolean range false to true ;
      subtype range1_3 is integer range 0 to 1 ;
      subtype st_arr_1 is arr_1 ( range1_1 , range1_2 , range1_3 ) ;
      variable v_arr_1_1 : st_arr_1 ;

      subtype range2_1 is bit range '1' downto '0' ;
      subtype range2_2 is integer range 1 to 2 ;
      subtype st_arr_2 is arr_2 ( range2_1 , range2_2 ) ;
      variable v_arr_2_1 : st_arr_2 ;

      subtype range3_1 is bit range '1' downto '0' ;
      subtype range3_2 is integer range 1 to 2 ;
      subtype st_arr_3 is arr_3 ( range3_1 , range3_2 ) ;
      variable v_arr_3_1 : st_arr_3 ;

   begin
      v_arr_1_1 := ( note =>    ( false => "ab" ,
                                  true =>  "cd" ) ,
                     warning => ( false => "ef" ,
                                  true =>  "gh" ) ,
                     error =>   ( false => "ij" ,
                                  true =>  "kl" ) ) ;
      v_arr_2_1 := ( B"01", B"10" ) ;
      v_arr_3_1 := ( (B"000", B"001"), (B"110", B"111") ) ;

      for i in range1_1 loop
	 for j in range1_2 loop
	    for k in range1_3 loop
	       bool := bool and v_arr_1_1 (i, j, k) =
                 character'val (character'pos('a') + add_pos) ;
                 add_pos := add_pos + 1 ;
	    end loop ;
	 end loop ;
      end loop ;

      bool := bool and v_arr_2_1('1', 1) = '0' and v_arr_2_1('1', 2) = '1' ;
      bool := bool and v_arr_2_1('0', 1) = '1' and v_arr_2_1('0', 2) = '0' ;

      bool := bool and v_arr_3_1('1', 1)(0) = '0' and
                       v_arr_3_1('1', 1)(1) = '0' and
                       v_arr_3_1('1', 1)(2) = '0' ;

      bool := bool and v_arr_3_1('1', 2)(0) = '0' and
                       v_arr_3_1('1', 2)(1) = '0' and
                       v_arr_3_1('1', 2)(2) = '1' ;

      bool := bool and v_arr_3_1('0', 1)(0) = '1' and
                       v_arr_3_1('0', 1)(1) = '1' and
                       v_arr_3_1('0', 1)(2) = '0' ;

      bool := bool and v_arr_3_1('0', 2)(0) = '1' and
                       v_arr_3_1('0', 2)(1) = '1' and
                       v_arr_3_1('0', 2)(2) = '1' ;

      test_report ( "ARCH00488" ,
                    "String and bit string literals allowed at place of"
                    & " one dimensional character type" ,
                    bool ) ;
      wait ;
   end process ;
end ARCH00488 ;

entity ENT00488_Test_Bench is
end ENT00488_Test_Bench ;

architecture ARCH00488_Test_Bench of ENT00488_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00488 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00488_Test_Bench ;
