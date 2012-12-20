-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00333
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.2.3 (3)
--    7.2.3 (9)
--    7.2.3 (10)
--    7.2.3 (11)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00333
--    ENT00333(ARCH00333)
--    ENT00333_Test_Bench(ARCH00333_Test_Bench)
--
-- REVISION HISTORY:
--
--    30-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
package PKG00333 is
   type complex1 is record
		      fl : integer ;
		      f2 : integer ;
		   end record ;
   type complex is array ( integer range <> ) of complex1 ;
   constant c_bit_vector_1 : bit_vector := B"0011" ;
   constant c_bit_vector_2 : bit_vector := B"110" ;
   constant c_string_1 : string := "abc" ;
   constant c_string_2 : string := "efg" ;
   constant c_complex1_1 : complex1 := (others => 5) ;
   constant c_complex1_2 : complex1 := (others => 7) ;
   subtype st_bit_vector is bit_vector ( 0 to 6 ) ;
   subtype st_string is string ( 1 to 6 ) ;
   subtype st_complex is complex ( 1 to 5 ) ;
   subtype st_bit_vector2 is bit_vector ( 2 to 8 ) ;
   subtype st_string2 is string ( 2 to 7 ) ;
   subtype st_complex2 is complex ( 2 to 6 ) ;
   constant c_complex_1 : complex ( 1 to 2 ) := (others => c_complex1_1) ;
   constant c_complex_2 : complex ( 1 to 3 ) := (others => c_complex1_2) ;
   constant c_complex_3 : st_complex := ( 1 to 2 => c_complex1_1,
                                          others => c_complex1_2 ) ;
   constant c_complex_4 : st_complex := ( 1 to 3 => c_complex1_2,
                                          others => c_complex1_1 ) ;
end PKG00333 ;

use WORK.PKG00333.all ;
entity ENT00333 is
   generic (
             i_bit_vector_1 : bit_vector := B"0011" ;
             i_bit_vector_2 : bit_vector ( 2 to 4 ) := B"110" ;
             i_string_1 : string := "abc" ;
             i_string_2 : string ( 2 to 4 ) := "efg" ;
             i_complex_1 : complex := c_complex_1 ;
             i_complex_2 : complex ( 2 to 4 ) := c_complex_2
             ) ;
   port ( globally_static_correct : out boolean ;
	  dynamic_correct : out boolean ) ;
end ENT00333 ;

architecture ARCH00333 of ENT00333 is
begin
   process
      variable bool : boolean := true ;
      variable gen_correct, dyn_correct : boolean := true ;
--
      variable v_bit_vector_1 : bit_vector ( 0 to 3 ) := c_bit_vector_1 ;
      variable v_bit_vector_2 : bit_vector ( 2 to 4 ) := c_bit_vector_2 ;
      variable v_string_1 : string ( 1 to 3 ) := c_string_1 ;
      variable v_string_2 : string ( 2 to 4 ) := c_string_2 ;
      variable v_complex_1 : complex ( 1 to 2 ) := c_complex_1 ;
      variable v_complex_2 : complex ( 2 to 4 ) := c_complex_2 ;
      constant c2_bit_vector_1 : st_bit_vector :=
         st_bit_vector' (i_bit_vector_1 & B"110") ;
      constant c2_bit_vector_2 : st_bit_vector :=
         st_bit_vector2' (i_bit_vector_2 & i_bit_vector_1) ;
      constant c2_bit_vector_3 : st_bit_vector :=
         st_bit_vector' (i_bit_vector_1 & i_bit_vector_2) ;
      constant c2_string_1 : st_string :=
         st_string' (i_string_1 & "efg") ;
      constant c2_string_2 : st_string :=
         st_string2' (i_string_2 & i_string_1) ;
      constant c2_string_3 : st_string :=
         st_string' (i_string_1 & i_string_2) ;
      constant c2_complex_1 : st_complex :=
         st_complex2' (i_complex_2 & i_complex_1) ;
      constant c2_complex_2 : st_complex :=
         st_complex' (i_complex_1 & i_complex_2) ;
   begin
      gen_correct := c2_bit_vector_1 = B"0011110" and
                     c2_bit_vector_2 = B"1100011" and
                     c2_bit_vector_3 = B"0011110" and
                     c2_string_1 = "abcefg" and
                     c2_string_2 = "efgabc" and
                     c2_string_3 = "abcefg" and
                     c2_complex_1 = c_complex_4 and
                     c2_complex_2 = c_complex_3 ;
      globally_static_correct <= gen_correct ;
      dyn_correct :=
         st_bit_vector' (v_bit_vector_1 & B"110") = B"0011110" and
         st_bit_vector2' (v_bit_vector_2 & i_bit_vector_1) = B"1100011" and
         st_bit_vector' (v_bit_vector_1 & v_bit_vector_2) = B"0011110" and
         st_string' (v_string_1 & "efg") = "abcefg" and
         st_string2' (v_string_2 & i_string_1) = "efgabc" and
         st_string' (v_string_1 & v_string_2) = "abcefg" and
         st_complex2' (v_complex_2 & v_complex_1) = c_complex_4 and
         st_complex' (i_complex_1 & v_complex_2) = c_complex_3 ;
      dynamic_correct <= dyn_correct ;
      wait ;
   end process ;
end ARCH00333 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00333_Test_Bench is
end ENT00333_Test_Bench ;

architecture ARCH00333_Test_Bench of ENT00333_Test_Bench is
begin
   L1:
   block
      signal globally_static_correct,
             dynamic_correct : boolean := false ;
      signal Is_first_run : boolean := true;

      component UUT
         port ( globally_static_correct : out boolean ;
	        dynamic_correct : out boolean ) ;
      end component ;

      for CIS1 : UUT use entity WORK.ENT00333 ( ARCH00333 ) ;
   begin
      CIS1 : UUT
	    port map ( globally_static_correct,
                       dynamic_correct ) ;
      process ( globally_static_correct,
                dynamic_correct )
      begin
         if  Is_first_run  then
             Is_first_run <= False ;
         else
            test_report("ARCH00333",
                    "& correctly defined for non-null array operands (static)",
                    globally_static_correct);
            test_report("ARCH00333",
                    "& correctly defined for non-null array operands (dynamic)",
                    dynamic_correct);
         end if ;
      end process ;
   end block L1 ;
end ARCH00333_Test_Bench ;
