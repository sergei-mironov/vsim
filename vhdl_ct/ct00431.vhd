-- NEED RESULT: ARCH00431: & correctly predefined for 2 scalar operands passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00431
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.2.3 (7)
--    7.2.3 (9)
--    7.2.3 (10)
--    7.2.3 (11)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00431
--    ENT00431(ARCH00431)
--    ENT00431_Test_Bench(ARCH00431_Test_Bench)
--
-- REVISION HISTORY:
--
--    30-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
package PKG00431 is
   type complex1 is record
		      fl : integer ;
		      f2 : integer ;
		   end record ;
   type complex is array ( positive range <> ) of complex1 ;
   constant c_complex1_1 : complex1 := (others => 5) ;
   constant c_complex1_2 : complex1 := (others => 57) ;
   subtype st_complex2 is complex ( 1 to 2 ) ;
   subtype st_complex3 is complex ( 1 to 3 ) ;
   subtype st_bit_vector2 is bit_vector ( 0 to 1 ) ;
   subtype st_bit_vector3 is bit_vector ( 0 to 2 ) ;
   subtype st_string2 is string ( 1 to 2 ) ;
   subtype st_string3 is string ( 1 to 3 ) ;
   constant c_complex_1 : st_complex3 := (others => c_complex1_1) ;
   constant c_complex_2 : st_complex2 := ( 1 => c_complex1_1,
                                                  others => c_complex1_2 ) ;
   constant c_complex_3 : st_complex2 := ( 1 => c_complex1_2,
                                                  others => c_complex1_1 ) ;
end PKG00431 ;

use WORK.PKG00431.all ;
entity ENT00431 is
   generic (
             i_bit_1 : bit := '1' ;
             i_bit_2 : bit := '0' ;
             i_character_1 : character := 'e' ;
             i_character_2 : character := 'a' ;
             i_complex1_1 : complex1 := c_complex1_1 ;
             i_complex1_2 : complex1 := c_complex1_2
             ) ;
   port ( locally_static_correct : out boolean ;
	  globally_static_correct : out boolean ;
	  dynamic_correct : out boolean ) ;
end ENT00431 ;

architecture ARCH00431 of ENT00431 is
begin
   process
      variable bool : boolean := true ;
      variable cons_correct, gen_correct, dyn_correct : boolean := true ;
--
      variable v_bit_vector_1 : st_bit_vector3 ;
      variable v_bit_vector_2 : st_bit_vector2 ;
      variable v_bit_1 : bit := i_bit_1 ;
      variable v_bit_2 : bit := i_bit_2 ;
      variable v_string_1 : st_string3 ;
      variable v_string_2 : st_string2 ;
      variable v_character_1 : character := i_character_1 ;
      variable v_character_2 : character := i_character_2 ;
      variable v_complex_1 : st_complex3 ;
      variable v_complex_2 : st_complex2 ;
      variable v_complex1_1 : complex1 := c_complex1_1 ;
      variable v_complex1_2 : complex1 := c_complex1_2 ;
      constant c2_bit_vector_1 : st_bit_vector3 :=
         i_bit_1 & '1' & i_bit_1 ;
      constant c2_bit_vector_2 : st_bit_vector2 :=
         i_bit_1 & i_bit_2 ;
      constant c2_bit_vector_3 : st_bit_vector2 :=
         i_bit_2 & i_bit_1 ;
      constant c2_string_1 : st_string3 :=
         i_character_1 & 'e' & i_character_1 ;
      constant c2_string_2 : st_string2 :=
         i_character_1 & i_character_2 ;
      constant c2_string_3 : st_string2 :=
         i_character_2 & i_character_1 ;
      constant c2_complex_1 : st_complex3 :=
         i_complex1_1 & i_complex1_1 & i_complex1_1 ;
      constant c2_complex_2 : st_complex2 :=
         i_complex1_1 & i_complex1_2 ;
      constant c2_complex_3 : st_complex2 :=
         i_complex1_2 & i_complex1_1 ;
   begin
      gen_correct := c2_bit_vector_1 = B"111" and
                     c2_bit_vector_2 = B"10" and
                     c2_bit_vector_3 = B"01" and
                     c2_string_1 = "eee" and
                     c2_string_2 = "ea" and
                     c2_string_3 = "ae" and
                     c2_complex_1 = c_complex_1 and
                     c2_complex_2 = c_complex_2 and
                     c2_complex_3 = c_complex_3 ;
      locally_static_correct <= cons_correct ;
      globally_static_correct <= gen_correct ;
      dyn_correct :=
         st_bit_vector3' (v_bit_1 & '1' & i_bit_1) = B"111" and
         st_bit_vector2' (v_bit_1 & v_bit_2) = B"10" and
         st_bit_vector2' (v_bit_2 & v_bit_1) = B"01" and
         st_string3' (v_character_1 & 'e' & i_character_1) = "eee" and
         st_string2' (v_character_1 & v_character_2) = "ea" and
         st_string2' (v_character_2 & v_character_1) = "ae" and
         st_complex3' (st_complex2'(v_complex1_1 & i_complex1_1)
            & i_complex1_1) = c_complex_1 and
         st_complex2' (v_complex1_1 & v_complex1_2) = c_complex_2 and
         st_complex2' (v_complex1_2 & v_complex1_1) = c_complex_3 ;

      dynamic_correct <= dyn_correct ;
      wait ;
   end process ;
end ARCH00431 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00431_Test_Bench is
end ENT00431_Test_Bench ;

architecture ARCH00431_Test_Bench of ENT00431_Test_Bench is
begin
   L1:
   block
      signal locally_static_correct, globally_static_correct,
             dynamic_correct : boolean := false ;

      component UUT
         port ( locally_static_correct : out boolean := false ;
	        globally_static_correct : out boolean := false ;
	        dynamic_correct : out boolean := false ) ;
      end component ;

      for CIS1 : UUT use entity WORK.ENT00431 ( ARCH00431 ) ;
   begin
      CIS1 : UUT
	    port map ( locally_static_correct,
                       globally_static_correct,
                       dynamic_correct ) ;
      process ( locally_static_correct, globally_static_correct,
                dynamic_correct )
      begin
         if locally_static_correct and globally_static_correct and
            dynamic_correct then
	    test_report ( "ARCH00431" ,
		          "& correctly predefined for 2 scalar operands"
                           ,
		          true ) ;
	 end if ;
      end process ;
   end block L1 ;
end ARCH00431_Test_Bench ;
