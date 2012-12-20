-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00545
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.3.4 (1)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00545(ARCH00545)
--    ENT00545_Test_Bench(ARCH00545_Test_Bench)
--
-- REVISION HISTORY:
--
--    17-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
entity ENT00545 is
end ENT00545 ;
--
architecture ARCH00545 of ENT00545 is
--
   procedure p1 (
                 g1 : integer := -5 ;
    	         g2 : integer := 5 ;
                 g3 : severity_level := warning ;
	         g4 : severity_level := failure
                ) is
--
     type rec_1 is record
		    f1 : bit ;
		    f2 : boolean ;
		    f3 : bit_vector ( 0 to g2 ) ;
		 end record ;
     type arr_1 is array ( severity_level range <> , integer range <> ) of
        rec_1 ;

     type bv_rec is record
		    f1 : bit_vector ( 0 to g2 ) ;
		    f2 : bit_vector ( 0 to g2 ) ;
		    f3 : bit_vector ( 0 to g2 ) ;
		 end record ;
      type bv1 is array ( natural range <> , natural range <> ) of bit ;
      type bv2 is array ( natural range <> ) of bit_vector ( 0 to g2 ) ;

      type string_rec is record
		    f1 : string ( 1 to g2 + 1 ) ;
		    f2 : string ( 1 to g2 + 1 ) ;
		    f3 : string ( 1 to g2 + 1 ) ;
		 end record ;
      type str1 is array ( positive range <> , positive range <> ) of
         character ;
      type str2 is array ( positive range <> ) of string ( 1 to g2 + 1 ) ;
--
      subtype c_st_arr_1 is arr_1 ( g4 downto g3 , -3 downto g1 ) ;
      subtype c_st_string is string ( 1 to g2 + 1) ;
      subtype c_st_bit_vector is bit_vector ( g1 + g2 to g2 ) ;
      subtype c_st_bv1 is bv1 ( g1 + g2 to g2 - 3, g2 + g1 to g2 ) ;
      subtype c_st_bv2 is bv2 ( g2 + g1 to g2 - 3 ) ;
      subtype c_st_str1 is str1 ( g1 + g2 + 1 to g2 - 2,
                                  g2 + g1 + 1 to g2 + 1 ) ;
      subtype c_st_str2 is str2 ( g2 + g1 + 1 to g2 - 2 ) ;
--
      variable v_rec_1, v_rec_2 : rec_1 ;
      variable v_st_arr_1, v_st_arr_2 : c_st_arr_1 ;
      variable v_st_string_1, v_st_string_2 : c_st_string ;
      variable v_st_bit_vector_1, v_st_bit_vector_2 : c_st_bit_vector ;
      variable v_bv_rec_1, v_bv_rec_2 : bv_rec ;
      variable v_st_bv1_1, v_st_bv1_2 : c_st_bv1 ;
      variable v_st_bv2_1, v_st_bv2_2 : c_st_bv2 ;
      variable v_string_rec_1, v_string_rec_2 : string_rec ;
      variable v_st_str1_1, v_st_str1_2 : c_st_str1 ;
      variable v_st_str2_1, v_st_str2_2 : c_st_str2 ;

      variable correct : boolean := true ;
   begin
--
      v_rec_1 :=
            rec_1 ' ( '1', true, B"000111" ) ;
      v_st_arr_1 :=
            c_st_arr_1 ' ( ( ('0', false, B"111000" ), v_rec_1, v_rec_1),
                           ( v_rec_1, ('0', false, B"111000" ), v_rec_1),
                           ( v_rec_1, v_rec_1, ('0', false, B"111000" )) ) ;
      v_st_string_1 :=
            c_st_string ' ( '1', '0', '0', '0', '1', '1' ) ;
      v_st_bit_vector_1 :=
            c_st_bit_vector ' ( '1', '0', '0', '0', '1', '1' ) ;
      v_bv_rec_1 :=
            bv_rec     ' ( "000111", ('1', '0', '1', '0', '1', '0'),
                           "111000" ) ;
      v_st_bv1_1 :=
            c_st_bv1   ' ( ('0', '0', '0', '1', '1', '1'),
                           ('1', '0', '1', '0', '1', '0'),
                           ('1', '1', '1', '0', '0', '0') ) ;
      v_st_bv2_1 :=
            c_st_bv2   ' ( "000111", ('1', '0', '1', '0', '1', '0'),
                           "111000" ) ;
      v_string_rec_1 :=
            string_rec ' ( "000111", ('1', '0', '1', '0', '1', '0'),
                           "111000" ) ;
      v_st_str1_1 :=
            c_st_str1  ' ( ('0', '0', '0', '1', '1', '1'),
                           ('1', '0', '1', '0', '1', '0'),
                           ('1', '1', '1', '0', '0', '0') ) ;
      v_st_str2_1 :=
            c_st_str2  ' ( "000111", ('1', '0', '1', '0', '1', '0'),
                           "111000" ) ;

      correct := correct and v_rec_1.f1 = '1' and v_rec_1.f2 = true and
                  v_rec_1.f3 = B"000111" ;
      correct := correct and v_st_arr_1(failure, -3) = ('0', false, B"111000")
                  and v_st_arr_1(failure, -4) = v_rec_1
                  and v_st_arr_1(failure, -5) = v_rec_1
                  and v_st_arr_1(error, -3) = v_rec_1
                  and v_st_arr_1(error, -4) = ('0', false, B"111000")
                  and v_st_arr_1(error, -5) = v_rec_1
                  and v_st_arr_1(warning, -3) = v_rec_1
                  and v_st_arr_1(warning, -4) = v_rec_1
                  and v_st_arr_1(warning, -5) = ('0', false, B"111000")  ;
      correct := correct and v_st_string_1 = "100011" ;
      correct := correct and v_st_bit_vector_1 = "100011" ;
      correct := correct and v_bv_rec_1.f1 = "000111" and
                  v_bv_rec_1.f2 = "101010" and v_bv_rec_1.f3 = "111000"  ;
      for i in 0 to 2 loop
         correct := correct and v_st_bv1_1(0, i) = '0' ;
         correct := correct and v_st_bv1_1(1, i) = bit'val((i + 1) mod 2 ) ;
         correct := correct and v_st_bv1_1(2, i) = '1' ;
      end loop ;
      for i in 3 to 5 loop
         correct := correct and v_st_bv1_1(0, i) = '1' ;
         correct := correct and v_st_bv1_1(1, i) = bit'val((i + 1) mod 2 ) ;
         correct := correct and v_st_bv1_1(2, i) = '0' ;
      end loop ;
      correct := correct and v_st_bv2_1(0) = "000111" and
                  v_st_bv2_1(1) = "101010" and
                  v_st_bv2_1(2) = "111000"  ;
      correct := correct and v_string_rec_1.f1 = "000111" and
                  v_string_rec_1.f2 = "101010" and
                  v_string_rec_1.f3 = "111000"  ;
      for i in 1 to 3 loop
         correct := correct and v_st_str1_1(1, i) = '0' ;
         correct := correct and v_st_str1_1(2, i) =
                character'val((i + 2) mod 2 + character'pos('0')) ;
         correct := correct and v_st_str1_1(3, i) = '1' ;
      end loop ;
      for i in 4 to 6 loop
         correct := correct and v_st_str1_1(1, i) = '1' ;
         correct := correct and v_st_str1_1(2, i) =
                character'val((i + 2) mod 2 + character'pos('0')) ;
         correct := correct and v_st_str1_1(3, i) = '0' ;
      end loop ;
      correct := correct and v_st_str2_1(1) = "000111" and
                  v_st_str2_1(2) = "101010" and
                  v_st_str2_1(3) = "111000"  ;

      test_report ( "ARCH00545" ,
		    "Qualified expressions (aggregates) (dynamic subtypes)" ,
		    correct ) ;
      wait ;
   end ;
begin
   process
   begin
      p1 ;
   end process ;
end ARCH00545 ;
--
entity ENT00545_Test_Bench is
end ENT00545_Test_Bench ;

architecture ARCH00545_Test_Bench of ENT00545_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00545 ( ARCH00545 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00545_Test_Bench ;
--
