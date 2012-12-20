-- NEED RESULT: ARCH&(TEST_NUM): Relational operators are correctly predefined for generically sized types passed
-- NEED RESULT: ARCH&(TEST_NUM): Relational operators are correctly predefined for types passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00309
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.2.2 (1)
--    7.2.2 (2)
--    7.2.2 (6)
--    7.2.2 (9)
--    7.2.2 (10)
--    7.2.2 (11)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00309(ARCH00309)
--    GENERIC_STANDARD_TYPES(ARCH00309_1)
--    ENT00309_Test_Bench(ARCH00309_Test_Bench)
--
-- REVISION HISTORY:
--
--    21-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
entity ENT00309 is
   generic (
             i_st_bit_vector_1 : st_bit_vector
                         := c_st_bit_vector_1 ;
             i_st_bit_vector_2 : st_bit_vector
                         := c_st_bit_vector_2 ;
             i_st_boolean_vector_1 : st_boolean_vector
                         := c_st_boolean_vector_1 ;
             i_st_boolean_vector_2 : st_boolean_vector
                         := c_st_boolean_vector_2 ;
             i_st_enum1_vector_1 : st_enum1_vector
                         := c_st_enum1_vector_1 ;
             i_st_enum1_vector_2 : st_enum1_vector
                         := c_st_enum1_vector_2 ;
             i_st_integer_vector_1 : st_integer_vector
                         := c_st_integer_vector_1 ;
             i_st_integer_vector_2 : st_integer_vector
                         := c_st_integer_vector_2 ;
             i_st_severity_level_vector_1 : st_severity_level_vector
                         := c_st_severity_level_vector_1 ;
             i_st_severity_level_vector_2 : st_severity_level_vector
                         := c_st_severity_level_vector_2 ;
             i_st_string_1 : st_string := c_st_string_1 ;
             i_st_string_2 : st_string := c_st_string_2
             ) ;
   port ( locally_static_correct : out boolean ;
   globally_static_correct : out boolean ;
   dynamic_correct : out boolean ) ;
end ENT00309 ;
architecture ARCH00309 of ENT00309 is
begin
   process
      variable bool : boolean := true ;
      variable cons_correct, gen_correct, dyn_correct : boolean := true ;
          variable v_st_bit_vector_1 : st_bit_vector
                   := c_st_bit_vector_1 ;
          variable v_st_bit_vector_2 : st_bit_vector
                   := c_st_bit_vector_2 ;
          variable v_st_boolean_vector_1 : st_boolean_vector
                   := c_st_boolean_vector_1 ;
          variable v_st_boolean_vector_2 : st_boolean_vector
                   := c_st_boolean_vector_2 ;
          variable v_st_enum1_vector_1 : st_enum1_vector
                   := c_st_enum1_vector_1 ;
          variable v_st_enum1_vector_2 : st_enum1_vector
                   := c_st_enum1_vector_2 ;
          variable v_st_integer_vector_1 : st_integer_vector
                   := c_st_integer_vector_1 ;
          variable v_st_integer_vector_2 : st_integer_vector
                   := c_st_integer_vector_2 ;
          variable v_st_severity_level_vector_1 : st_severity_level_vector
                   := c_st_severity_level_vector_1 ;
          variable v_st_severity_level_vector_2 : st_severity_level_vector
                   := c_st_severity_level_vector_2 ;
          variable v_st_string_1 : st_string
                   := c_st_string_1 ;
          variable v_st_string_2 : st_string
                   := c_st_string_2 ;
         constant c2_st_bit_vector_1 : boolean :=
               i_st_bit_vector_1 < i_st_bit_vector_2 and
               i_st_bit_vector_1 <= i_st_bit_vector_2 and
               i_st_bit_vector_2 <= c_st_bit_vector_2 and
               i_st_bit_vector_2 >= i_st_bit_vector_1 and
               i_st_bit_vector_1 >= c_st_bit_vector_1 and
               i_st_bit_vector_2 > i_st_bit_vector_1 and
               i_st_bit_vector_1 = c_st_bit_vector_1 and
               i_st_bit_vector_1 /= i_st_bit_vector_2 and
               not (i_st_bit_vector_1 = i_st_bit_vector_2)
           ;
         constant c2_st_boolean_vector_1 : boolean :=
               i_st_boolean_vector_1 < i_st_boolean_vector_2 and
               i_st_boolean_vector_1 <= i_st_boolean_vector_2 and
               i_st_boolean_vector_2 <= c_st_boolean_vector_2 and
               i_st_boolean_vector_2 >= i_st_boolean_vector_1 and
               i_st_boolean_vector_1 >= c_st_boolean_vector_1 and
               i_st_boolean_vector_2 > i_st_boolean_vector_1 and
               i_st_boolean_vector_1 = c_st_boolean_vector_1 and
               i_st_boolean_vector_1 /= i_st_boolean_vector_2 and
               not (i_st_boolean_vector_1 = i_st_boolean_vector_2)
           ;
         constant c2_st_enum1_vector_1 : boolean :=
               i_st_enum1_vector_1 < i_st_enum1_vector_2 and
               i_st_enum1_vector_1 <= i_st_enum1_vector_2 and
               i_st_enum1_vector_2 <= c_st_enum1_vector_2 and
               i_st_enum1_vector_2 >= i_st_enum1_vector_1 and
               i_st_enum1_vector_1 >= c_st_enum1_vector_1 and
               i_st_enum1_vector_2 > i_st_enum1_vector_1 and
               i_st_enum1_vector_1 = c_st_enum1_vector_1 and
               i_st_enum1_vector_1 /= i_st_enum1_vector_2 and
               not (i_st_enum1_vector_1 = i_st_enum1_vector_2)
           ;
         constant c2_st_integer_vector_1 : boolean :=
               i_st_integer_vector_1 < i_st_integer_vector_2 and
               i_st_integer_vector_1 <= i_st_integer_vector_2 and
               i_st_integer_vector_2 <= c_st_integer_vector_2 and
               i_st_integer_vector_2 >= i_st_integer_vector_1 and
               i_st_integer_vector_1 >= c_st_integer_vector_1 and
               i_st_integer_vector_2 > i_st_integer_vector_1 and
               i_st_integer_vector_1 = c_st_integer_vector_1 and
               i_st_integer_vector_1 /= i_st_integer_vector_2 and
               not (i_st_integer_vector_1 = i_st_integer_vector_2)
           ;
         constant c2_st_severity_level_vector_1 : boolean :=
               i_st_severity_level_vector_1 < i_st_severity_level_vector_2 and
               i_st_severity_level_vector_1 <= i_st_severity_level_vector_2 and
               i_st_severity_level_vector_2 <= c_st_severity_level_vector_2 and
               i_st_severity_level_vector_2 >= i_st_severity_level_vector_1 and
               i_st_severity_level_vector_1 >= c_st_severity_level_vector_1 and
               i_st_severity_level_vector_2 > i_st_severity_level_vector_1 and
               i_st_severity_level_vector_1 = c_st_severity_level_vector_1 and
               i_st_severity_level_vector_1 /= i_st_severity_level_vector_2 and
               not (i_st_severity_level_vector_1 = i_st_severity_level_vector_2)
           ;
         constant c2_st_string_1 : boolean :=
               i_st_string_1 < i_st_string_2 and
               i_st_string_1 <= i_st_string_2 and
               i_st_string_2 <= c_st_string_2 and
               i_st_string_2 >= i_st_string_1 and
               i_st_string_1 >= c_st_string_1 and
               i_st_string_2 > i_st_string_1 and
               i_st_string_1 = c_st_string_1 and
               i_st_string_1 /= i_st_string_2 and
               not (i_st_string_1 = i_st_string_2)
           ;
   begin
         gen_correct := gen_correct and c2_st_bit_vector_1 = true ;
         gen_correct := gen_correct and c2_st_boolean_vector_1 = true ;
         gen_correct := gen_correct and c2_st_enum1_vector_1 = true ;
         gen_correct := gen_correct and c2_st_integer_vector_1 = true ;
         gen_correct := gen_correct and c2_st_severity_level_vector_1 = true ;
         gen_correct := gen_correct and c2_st_string_1 = true ;
         dyn_correct := dyn_correct and
               v_st_bit_vector_1 < v_st_bit_vector_2 and
               v_st_bit_vector_1 <= v_st_bit_vector_2 and
               v_st_bit_vector_2 <= c_st_bit_vector_2 and
               v_st_bit_vector_2 >= v_st_bit_vector_1 and
               v_st_bit_vector_1 >= c_st_bit_vector_1 and
               v_st_bit_vector_2 > v_st_bit_vector_1 and
               v_st_bit_vector_1 = c_st_bit_vector_1 and
               v_st_bit_vector_1 /= v_st_bit_vector_2 and
               not (v_st_bit_vector_1 = v_st_bit_vector_2)
           ;
         dyn_correct := dyn_correct and
               v_st_boolean_vector_1 < v_st_boolean_vector_2 and
               v_st_boolean_vector_1 <= v_st_boolean_vector_2 and
               v_st_boolean_vector_2 <= c_st_boolean_vector_2 and
               v_st_boolean_vector_2 >= v_st_boolean_vector_1 and
               v_st_boolean_vector_1 >= c_st_boolean_vector_1 and
               v_st_boolean_vector_2 > v_st_boolean_vector_1 and
               v_st_boolean_vector_1 = c_st_boolean_vector_1 and
               v_st_boolean_vector_1 /= v_st_boolean_vector_2 and
               not (v_st_boolean_vector_1 = v_st_boolean_vector_2)
           ;
         dyn_correct := dyn_correct and
               v_st_enum1_vector_1 < v_st_enum1_vector_2 and
               v_st_enum1_vector_1 <= v_st_enum1_vector_2 and
               v_st_enum1_vector_2 <= c_st_enum1_vector_2 and
               v_st_enum1_vector_2 >= v_st_enum1_vector_1 and
               v_st_enum1_vector_1 >= c_st_enum1_vector_1 and
               v_st_enum1_vector_2 > v_st_enum1_vector_1 and
               v_st_enum1_vector_1 = c_st_enum1_vector_1 and
               v_st_enum1_vector_1 /= v_st_enum1_vector_2 and
               not (v_st_enum1_vector_1 = v_st_enum1_vector_2)
           ;
         dyn_correct := dyn_correct and
               v_st_integer_vector_1 < v_st_integer_vector_2 and
               v_st_integer_vector_1 <= v_st_integer_vector_2 and
               v_st_integer_vector_2 <= c_st_integer_vector_2 and
               v_st_integer_vector_2 >= v_st_integer_vector_1 and
               v_st_integer_vector_1 >= c_st_integer_vector_1 and
               v_st_integer_vector_2 > v_st_integer_vector_1 and
               v_st_integer_vector_1 = c_st_integer_vector_1 and
               v_st_integer_vector_1 /= v_st_integer_vector_2 and
               not (v_st_integer_vector_1 = v_st_integer_vector_2)
           ;
         dyn_correct := dyn_correct and
               v_st_severity_level_vector_1 < v_st_severity_level_vector_2 and
               v_st_severity_level_vector_1 <= v_st_severity_level_vector_2 and
               v_st_severity_level_vector_2 <= c_st_severity_level_vector_2 and
               v_st_severity_level_vector_2 >= v_st_severity_level_vector_1 and
               v_st_severity_level_vector_1 >= c_st_severity_level_vector_1 and
               v_st_severity_level_vector_2 > v_st_severity_level_vector_1 and
               v_st_severity_level_vector_1 = c_st_severity_level_vector_1 and
               v_st_severity_level_vector_1 /= v_st_severity_level_vector_2 and
               not (v_st_severity_level_vector_1 = v_st_severity_level_vector_2)
           ;
         dyn_correct := dyn_correct and
               v_st_string_1 < v_st_string_2 and
               v_st_string_1 <= v_st_string_2 and
               v_st_string_2 <= c_st_string_2 and
               v_st_string_2 >= v_st_string_1 and
               v_st_string_1 >= c_st_string_1 and
               v_st_string_2 > v_st_string_1 and
               v_st_string_1 = c_st_string_1 and
               v_st_string_1 /= v_st_string_2 and
               not (v_st_string_1 = v_st_string_2)
           ;
      locally_static_correct <= cons_correct ;
      globally_static_correct <= gen_correct ;
      dynamic_correct <= dyn_correct ;
      wait;
   end process ;
end ARCH00309 ;
architecture ARCH00309_1 of GENERIC_STANDARD_TYPES is
begin
   B : block
         generic (
                   i_st_bit_vector_1 : st_bit_vector
                               := c_st_bit_vector_1 ;
                   i_st_bit_vector_2 : st_bit_vector
                               := c_st_bit_vector_2 ;
                   i_st_boolean_vector_1 : st_boolean_vector
                               := c_st_boolean_vector_1 ;
                   i_st_boolean_vector_2 : st_boolean_vector
                               := c_st_boolean_vector_2 ;
                   i_st_enum1_vector_1 : st_enum1_vector
                               := c_st_enum1_vector_1 ;
                   i_st_enum1_vector_2 : st_enum1_vector
                               := c_st_enum1_vector_2 ;
                   i_st_integer_vector_1 : st_integer_vector
                               := c_st_integer_vector_1 ;
                   i_st_integer_vector_2 : st_integer_vector
                               := c_st_integer_vector_2 ;
                   i_st_severity_level_vector_1 : st_severity_level_vector
                               := c_st_severity_level_vector_1 ;
                   i_st_severity_level_vector_2 : st_severity_level_vector
                               := c_st_severity_level_vector_2 ;
                   i_st_string_1 : st_string := c_st_string_1 ;
                   i_st_string_2 : st_string := c_st_string_2
                  ) ;
   begin
      process
         variable bool : boolean := true ;
         variable gen_correct, dyn_correct : boolean := true ;
          variable v_st_bit_vector_1 : st_bit_vector
                   := c_st_bit_vector_1 ;
          variable v_st_bit_vector_2 : st_bit_vector
                   := c_st_bit_vector_2 ;
          variable v_st_boolean_vector_1 : st_boolean_vector
                   := c_st_boolean_vector_1 ;
          variable v_st_boolean_vector_2 : st_boolean_vector
                   := c_st_boolean_vector_2 ;
          variable v_st_enum1_vector_1 : st_enum1_vector
                   := c_st_enum1_vector_1 ;
          variable v_st_enum1_vector_2 : st_enum1_vector
                   := c_st_enum1_vector_2 ;
          variable v_st_integer_vector_1 : st_integer_vector
                   := c_st_integer_vector_1 ;
          variable v_st_integer_vector_2 : st_integer_vector
                   := c_st_integer_vector_2 ;
          variable v_st_severity_level_vector_1 : st_severity_level_vector
                   := c_st_severity_level_vector_1 ;
          variable v_st_severity_level_vector_2 : st_severity_level_vector
                   := c_st_severity_level_vector_2 ;
          variable v_st_string_1 : st_string
                   := c_st_string_1 ;
          variable v_st_string_2 : st_string
                   := c_st_string_2 ;
         constant c2_st_bit_vector_1 : boolean :=
               i_st_bit_vector_1 < i_st_bit_vector_2 and
               i_st_bit_vector_1 <= i_st_bit_vector_2 and
               i_st_bit_vector_2 <= c_st_bit_vector_2 and
               i_st_bit_vector_2 >= i_st_bit_vector_1 and
               i_st_bit_vector_1 >= c_st_bit_vector_1 and
               i_st_bit_vector_2 > i_st_bit_vector_1 and
               i_st_bit_vector_1 = c_st_bit_vector_1 and
               i_st_bit_vector_1 /= i_st_bit_vector_2 and
               not (i_st_bit_vector_1 = i_st_bit_vector_2)
           ;
         constant c2_st_boolean_vector_1 : boolean :=
               i_st_boolean_vector_1 < i_st_boolean_vector_2 and
               i_st_boolean_vector_1 <= i_st_boolean_vector_2 and
               i_st_boolean_vector_2 <= c_st_boolean_vector_2 and
               i_st_boolean_vector_2 >= i_st_boolean_vector_1 and
               i_st_boolean_vector_1 >= c_st_boolean_vector_1 and
               i_st_boolean_vector_2 > i_st_boolean_vector_1 and
               i_st_boolean_vector_1 = c_st_boolean_vector_1 and
               i_st_boolean_vector_1 /= i_st_boolean_vector_2 and
               not (i_st_boolean_vector_1 = i_st_boolean_vector_2)
           ;
         constant c2_st_enum1_vector_1 : boolean :=
               i_st_enum1_vector_1 < i_st_enum1_vector_2 and
               i_st_enum1_vector_1 <= i_st_enum1_vector_2 and
               i_st_enum1_vector_2 <= c_st_enum1_vector_2 and
               i_st_enum1_vector_2 >= i_st_enum1_vector_1 and
               i_st_enum1_vector_1 >= c_st_enum1_vector_1 and
               i_st_enum1_vector_2 > i_st_enum1_vector_1 and
               i_st_enum1_vector_1 = c_st_enum1_vector_1 and
               i_st_enum1_vector_1 /= i_st_enum1_vector_2 and
               not (i_st_enum1_vector_1 = i_st_enum1_vector_2)
           ;
         constant c2_st_integer_vector_1 : boolean :=
               i_st_integer_vector_1 < i_st_integer_vector_2 and
               i_st_integer_vector_1 <= i_st_integer_vector_2 and
               i_st_integer_vector_2 <= c_st_integer_vector_2 and
               i_st_integer_vector_2 >= i_st_integer_vector_1 and
               i_st_integer_vector_1 >= c_st_integer_vector_1 and
               i_st_integer_vector_2 > i_st_integer_vector_1 and
               i_st_integer_vector_1 = c_st_integer_vector_1 and
               i_st_integer_vector_1 /= i_st_integer_vector_2 and
               not (i_st_integer_vector_1 = i_st_integer_vector_2)
           ;
         constant c2_st_severity_level_vector_1 : boolean :=
               i_st_severity_level_vector_1 < i_st_severity_level_vector_2 and
               i_st_severity_level_vector_1 <= i_st_severity_level_vector_2 and
               i_st_severity_level_vector_2 <= c_st_severity_level_vector_2 and
               i_st_severity_level_vector_2 >= i_st_severity_level_vector_1 and
               i_st_severity_level_vector_1 >= c_st_severity_level_vector_1 and
               i_st_severity_level_vector_2 > i_st_severity_level_vector_1 and
               i_st_severity_level_vector_1 = c_st_severity_level_vector_1 and
               i_st_severity_level_vector_1 /= i_st_severity_level_vector_2 and
               not (i_st_severity_level_vector_1 = i_st_severity_level_vector_2)
           ;
         constant c2_st_string_1 : boolean :=
               i_st_string_1 < i_st_string_2 and
               i_st_string_1 <= i_st_string_2 and
               i_st_string_2 <= c_st_string_2 and
               i_st_string_2 >= i_st_string_1 and
               i_st_string_1 >= c_st_string_1 and
               i_st_string_2 > i_st_string_1 and
               i_st_string_1 = c_st_string_1 and
               i_st_string_1 /= i_st_string_2 and
               not (i_st_string_1 = i_st_string_2)
           ;
   begin
         dyn_correct := dyn_correct and
               v_st_bit_vector_1 < v_st_bit_vector_2 and
               v_st_bit_vector_1 <= v_st_bit_vector_2 and
               v_st_bit_vector_2 <= c_st_bit_vector_2 and
               v_st_bit_vector_2 >= v_st_bit_vector_1 and
               v_st_bit_vector_1 >= c_st_bit_vector_1 and
               v_st_bit_vector_2 > v_st_bit_vector_1 and
               v_st_bit_vector_1 = c_st_bit_vector_1 and
               v_st_bit_vector_1 /= v_st_bit_vector_2 and
               not (v_st_bit_vector_1 = v_st_bit_vector_2)
           ;
         dyn_correct := dyn_correct and
               v_st_boolean_vector_1 < v_st_boolean_vector_2 and
               v_st_boolean_vector_1 <= v_st_boolean_vector_2 and
               v_st_boolean_vector_2 <= c_st_boolean_vector_2 and
               v_st_boolean_vector_2 >= v_st_boolean_vector_1 and
               v_st_boolean_vector_1 >= c_st_boolean_vector_1 and
               v_st_boolean_vector_2 > v_st_boolean_vector_1 and
               v_st_boolean_vector_1 = c_st_boolean_vector_1 and
               v_st_boolean_vector_1 /= v_st_boolean_vector_2 and
               not (v_st_boolean_vector_1 = v_st_boolean_vector_2)
           ;
         dyn_correct := dyn_correct and
               v_st_enum1_vector_1 < v_st_enum1_vector_2 and
               v_st_enum1_vector_1 <= v_st_enum1_vector_2 and
               v_st_enum1_vector_2 <= c_st_enum1_vector_2 and
               v_st_enum1_vector_2 >= v_st_enum1_vector_1 and
               v_st_enum1_vector_1 >= c_st_enum1_vector_1 and
               v_st_enum1_vector_2 > v_st_enum1_vector_1 and
               v_st_enum1_vector_1 = c_st_enum1_vector_1 and
               v_st_enum1_vector_1 /= v_st_enum1_vector_2 and
               not (v_st_enum1_vector_1 = v_st_enum1_vector_2)
           ;
         dyn_correct := dyn_correct and
               v_st_integer_vector_1 < v_st_integer_vector_2 and
               v_st_integer_vector_1 <= v_st_integer_vector_2 and
               v_st_integer_vector_2 <= c_st_integer_vector_2 and
               v_st_integer_vector_2 >= v_st_integer_vector_1 and
               v_st_integer_vector_1 >= c_st_integer_vector_1 and
               v_st_integer_vector_2 > v_st_integer_vector_1 and
               v_st_integer_vector_1 = c_st_integer_vector_1 and
               v_st_integer_vector_1 /= v_st_integer_vector_2 and
               not (v_st_integer_vector_1 = v_st_integer_vector_2)
           ;
         dyn_correct := dyn_correct and
               v_st_severity_level_vector_1 < v_st_severity_level_vector_2 and
               v_st_severity_level_vector_1 <= v_st_severity_level_vector_2 and
               v_st_severity_level_vector_2 <= c_st_severity_level_vector_2 and
               v_st_severity_level_vector_2 >= v_st_severity_level_vector_1 and
               v_st_severity_level_vector_1 >= c_st_severity_level_vector_1 and
               v_st_severity_level_vector_2 > v_st_severity_level_vector_1 and
               v_st_severity_level_vector_1 = c_st_severity_level_vector_1 and
               v_st_severity_level_vector_1 /= v_st_severity_level_vector_2 and
               not (v_st_severity_level_vector_1 = v_st_severity_level_vector_2)
           ;
         dyn_correct := dyn_correct and
               v_st_string_1 < v_st_string_2 and
               v_st_string_1 <= v_st_string_2 and
               v_st_string_2 <= c_st_string_2 and
               v_st_string_2 >= v_st_string_1 and
               v_st_string_1 >= c_st_string_1 and
               v_st_string_2 > v_st_string_1 and
               v_st_string_1 = c_st_string_1 and
               v_st_string_1 /= v_st_string_2 and
               not (v_st_string_1 = v_st_string_2)
           ;
         if gen_correct and dyn_correct then
     work.standard_types.test_report ( "ARCH&(TEST_NUM)" ,
            "Relational operators are correctly predefined"
                          & " for generically sized types" ,
            true ) ;
         else
     work.standard_types.test_report ( "ARCH&(TEST_NUM)" ,
            "Relational operators are correctly predefined"
                          & " for generically sized types" ,
            false ) ;
  end if ;
         wait;
      end process ;
   end block ;
end ARCH00309_1 ;
use WORK.STANDARD_TYPES.all ;
entity ENT00309_Test_Bench is
end ENT00309_Test_Bench ;
architecture ARCH00309_Test_Bench of ENT00309_Test_Bench is
begin
   L1:
   block
      signal locally_static_correct, globally_static_correct,
             dynamic_correct : boolean := false ;
      component UUT
      end component ;
      component UUT_1
         port ( locally_static_correct, globally_static_correct,
                dynamic_correct : out boolean ) ;
      end component ;
      for CIS2 : UUT_1 use entity WORK.ENT00309 ( ARCH00309 ) ;
      for CIS1 : UUT use entity
                 WORK.GENERIC_STANDARD_TYPES ( ARCH00309_1 ) ;
   begin
      CIS2 : UUT_1
     port map ( locally_static_correct,
                       globally_static_correct,
                       dynamic_correct ) ;
      CIS1 : UUT ;
      process ( locally_static_correct, globally_static_correct,
                dynamic_correct )
      begin
         if locally_static_correct and globally_static_correct and
            dynamic_correct then
     test_report ( "ARCH&(TEST_NUM)" ,
            "Relational operators are correctly predefined"
                          & " for types" ,
            true ) ;
  end if ;
      end process ;
   end block L1 ;
end ARCH00309_Test_Bench ;
