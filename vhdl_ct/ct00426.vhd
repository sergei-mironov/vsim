-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00426
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.2.3 (4)
--    7.2.3 (9)
--    7.2.3 (10)
--    7.2.3 (11)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00426
--    ENT00426(ARCH00426)
--    ENT00426_Test_Bench(ARCH00426_Test_Bench)
--
-- REVISION HISTORY:
--
--    30-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
package PKG00426 is
   type complex1 is record
		      fl : integer ;
		      f2 : integer ;
		   end record ;
   type complex is array ( positive range <> ) of complex1 ;
   constant c_bit_vector_1 : bit_vector ( 1 downto 2 ) := (others => '0') ;
   constant c_bit_vector_2 : bit_vector := B"1100" ;
   constant c_string_1 : string := "" ;
   constant c_string_2 : string := "abc" ;
   constant c_complex1_1 : complex1 := (others => 5) ;
   constant c_complex1_2 : complex1 := (others => 7) ;
   constant c_complex_1 : complex ( 1 to 2 ) := (others => c_complex1_1) ;
   constant c_complex_2 : complex ( 2 downto 3 ) := (others => c_complex1_2) ;
   constant c_complex_3 : complex ( 1 to 2 ) := ( 1 to 2 => c_complex1_1,
                                                  others => c_complex1_2 ) ;
   subtype st_bit_vector is bit_vector ( 0 to 3 ) ;
   subtype st_string is string ( 1 to 3 ) ;
   subtype st_complex is complex ( 1 to 2 ) ;
end PKG00426 ;

use WORK.PKG00426.all ;
entity ENT00426 is
   generic (
             i_bit_vector_1 : bit_vector ( 1 downto 2 ) := (others => '0') ;
             i_bit_vector_2 : bit_vector := B"1100" ;
             i_string_1 : string := "" ;
             i_string_2 : string := "abc" ;
             i_complex_1 : complex := c_complex_1 ;
             i_complex_2 : complex := c_complex_2
             ) ;
   port ( locally_static_correct : out boolean ;
	  globally_static_correct : out boolean ;
	  dynamic_correct : out boolean ) ;
end ENT00426 ;

architecture ARCH00426 of ENT00426 is
begin
   process
      variable bool : boolean := true ;
      variable cons_correct, gen_correct, dyn_correct : boolean := true ;
--
      variable v_bit_vector_1 : bit_vector ( 1 downto 4 ) := c_bit_vector_1 ;
      variable v_bit_vector_2 : bit_vector ( 0 to 3 ) := c_bit_vector_2 ;
      variable v_string_1 : string ( 3 to 1 ) := c_string_1 ;
      variable v_string_2 : string ( 1 to 3 ):= c_string_2 ;
      variable v_complex_1 : complex ( 1 to 2 ) := c_complex_1 ;
      variable v_complex_2 : complex ( 1 downto 2 ) := c_complex_2 ;
      constant c2_bit_vector_2 : bit_vector ( 1 to 4 ) :=
         st_bit_vector' (i_bit_vector_2 & i_bit_vector_1) ;
      constant c2_bit_vector_3 : bit_vector ( 1 to 4 ) :=
         st_bit_vector' (i_bit_vector_1 & i_bit_vector_2) ;
      constant c2_string_2 : string ( 1 to 3 ) :=
         st_string' (i_string_2 & i_string_1) ;
      constant c2_string_3 : string ( 1 to 3 ) :=
         st_string' (i_string_1 & i_string_2) ;
      constant c2_complex_1 : complex ( 1 to 2 ) :=
         st_complex' (i_complex_1 & i_complex_2) ;
      constant c2_complex_2 : complex ( 1 to 2 ) :=
         st_complex' (i_complex_2 & i_complex_1) ;
   begin
      gen_correct := c2_bit_vector_2 = B"1100" and
                     c2_bit_vector_3 = B"1100" and
                     c2_string_2 = "abc" and
                     c2_string_3 = "abc" and
                     c2_complex_1 = c_complex_3 and
                     c2_complex_2 = c_complex_3 ;
      locally_static_correct <= cons_correct ;
      globally_static_correct <= gen_correct ;
      dyn_correct :=
         st_bit_vector' (v_bit_vector_2 & i_bit_vector_1) = B"1100" and
         st_bit_vector' (v_bit_vector_1 & v_bit_vector_2) = B"1100" and
         st_string' (v_string_2 & i_string_1) = "abc" and
         st_string' (v_string_1 & v_string_2) = "abc" and
         st_complex' (v_complex_2 & v_complex_1) = c_complex_3 and
         st_complex' (v_complex_1 & v_complex_2) = c_complex_3 ;
      dynamic_correct <= dyn_correct ;
      wait ;
   end process ;
end ARCH00426 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00426_Test_Bench is
end ENT00426_Test_Bench ;

architecture ARCH00426_Test_Bench of ENT00426_Test_Bench is
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

      for CIS1 : UUT use entity WORK.ENT00426 ( ARCH00426 ) ;
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
	    test_report ( "ARCH00426" ,
		          "& correctly predefined for array operands with null"
                          & " array operands" ,
		          true ) ;
	 end if ;
      end process ;
   end block L1 ;
end ARCH00426_Test_Bench ;
