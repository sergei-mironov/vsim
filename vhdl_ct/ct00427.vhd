-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00427
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.2.3 (5)
--    7.2.3 (6)
--    7.2.3 (9)
--    7.2.3 (10)
--    7.2.3 (11)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00427
--    ENT00427(ARCH00427)
--    ENT00427_Test_Bench(ARCH00427_Test_Bench)
--
-- REVISION HISTORY:
--
--    30-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
package PKG00427 is
   type complex1 is record
		      fl : integer ;
		      f2 : integer ;
		   end record ;
   type complex is array ( positive range <> ) of complex1 ;
   constant c_bit_vector_1 : bit_vector := B"0011" ;
   constant c_bit_1 : bit := '1' ;
   constant c_string_1 : string := "abc" ;
   constant c_character_1 : character := 'e' ;
   constant c_complex1_1 : complex1 := (others => 5) ;
   constant c_complex1_2 : complex1 := (others => 57) ;
   constant c_complex_1 : complex ( 1 to 2 ) := (others => c_complex1_2) ;
   constant c_complex_3 : complex ( 1 to 3 ) := ( 1 to 2 => c_complex1_2,
                                                  others => c_complex1_1 ) ;
   constant c_complex_4 : complex ( 1 to 3 ) := ( 2 to 3 => c_complex1_2,
                                                  others => c_complex1_1 ) ;
   subtype st_bit_vector is bit_vector ( 0 to 4 ) ;
   subtype st_string is string ( 1 to 4 ) ;
   subtype st_complex is complex ( 1 to 3 ) ;
end PKG00427 ;

use WORK.PKG00427.all ;
entity ENT00427 is
   generic (
             i_bit_vector_1 : bit_vector := B"0011" ;
             i_bit_1 : bit := '1' ;
             i_string_1 : string := "abc" ;
             i_character_1 : character := 'e' ;
             i_complex_1 : complex := c_complex_1 ;
             i_complex1_1 : complex1 := c_complex1_1
             ) ;
   port ( locally_static_correct : out boolean ;
	  globally_static_correct : out boolean ;
	  dynamic_correct : out boolean ) ;
end ENT00427 ;

architecture ARCH00427 of ENT00427 is
begin
   process
      variable bool : boolean := true ;
      variable cons_correct, gen_correct, dyn_correct : boolean := true ;
--
      variable v_bit_vector_1 : bit_vector ( 0 to 3 ):= c_bit_vector_1 ;
      variable v_bit_1 : bit := c_bit_1 ;
      variable v_string_1 : string ( 1 to 3 ) := c_string_1 ;
      variable v_character_1 : character := c_character_1 ;
      variable v_complex_1 : complex ( 1 to 2 ) := c_complex_1 ;
      variable v_complex1_1 : complex1 := c_complex1_1 ;
      constant c2_bit_vector_1 : bit_vector ( 1 to 5 ) :=
         st_bit_vector' (i_bit_1 & B"110" & '0') ;
      constant c2_bit_vector_2 : bit_vector ( 1 to 5 ) :=
         st_bit_vector' (i_bit_1 & i_bit_vector_1) ;
      constant c2_bit_vector_3 : bit_vector ( 1 to 5 ) :=
         st_bit_vector' (i_bit_vector_1 & i_bit_1) ;
      constant c2_string_1 : string ( 1 to 4 ) :=
         st_string' (i_character_1 & "efg") ;
      constant c2_string_2 : string ( 1 to 4 ) :=
         st_string' (i_character_1 & i_string_1) ;
      constant c2_string_3 : string ( 1 to 4 ) :=
         st_string' (i_string_1 & i_character_1) ;
      constant c2_complex_1 : complex ( 1 to 3 ) :=
         st_complex' (i_complex_1 & i_complex1_1) ;
      constant c2_complex_2 : complex ( 1 to 3 ) :=
         st_complex' (i_complex1_1 & i_complex_1) ;
   begin
      gen_correct := c2_bit_vector_1 = B"11100" and
                     c2_bit_vector_2 = B"10011" and
                     c2_bit_vector_3 = B"00111" and
                     c2_string_1 = "eefg" and
                     c2_string_2 = "eabc" and
                     c2_string_3 = "abce" and
                     c2_complex_1 = c_complex_3 and
                     c2_complex_2 = c_complex_4 ;
      locally_static_correct <= cons_correct ;
      globally_static_correct <= gen_correct ;
      dyn_correct :=
         st_bit_vector' (v_bit_1 & B"110" & '0') = B"11100" and
         st_bit_vector' (v_bit_1 & i_bit_vector_1) = B"10011" and
         st_bit_vector' (v_bit_vector_1 & v_bit_1) = B"00111" and
         st_string' (v_character_1 & "efg") = "eefg" and
         st_string' (v_character_1 & i_string_1) = "eabc" and
         st_string' (v_string_1 & v_character_1) = "abce" and
         st_complex' (v_complex1_1 & v_complex_1) = c_complex_4 and
         st_complex' (i_complex_1 & v_complex1_1) = c_complex_3 ;
      dynamic_correct <= dyn_correct ;
      wait ;
   end process ;
end ARCH00427 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00427_Test_Bench is
end ENT00427_Test_Bench ;

architecture ARCH00427_Test_Bench of ENT00427_Test_Bench is
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

      for CIS1 : UUT use entity WORK.ENT00427 ( ARCH00427 ) ;
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
	    test_report ( "ARCH00427" ,
		          "& correctly predefined for array and scalar operand"
                           ,
		          true ) ;
	 end if ;
      end process ;
   end block L1 ;
end ARCH00427_Test_Bench ;
