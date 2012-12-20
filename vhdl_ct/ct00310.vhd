-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00310
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
--    ENT00310(ARCH00310)
--    GENERIC_STANDARD_TYPES(ARCH00310_1)
--    ENT00310_Test_Bench(ARCH00310_Test_Bench)
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
entity ENT00310 is
   generic (
             i_boolean_1 : boolean
                         := c_boolean_1 ;
             i_boolean_2 : boolean
                         := c_boolean_2 ;
             i_bit_1 : bit
                         := c_bit_1 ;
             i_bit_2 : bit
                         := c_bit_2 ;
             i_severity_level_1 : severity_level
                         := c_severity_level_1 ;
             i_severity_level_2 : severity_level
                         := c_severity_level_2 ;
             i_character_1 : character
                         := c_character_1 ;
             i_character_2 : character
                         := c_character_2 ;
             i_t_enum1_1 : t_enum1
                         := c_t_enum1_1 ;
             i_t_enum1_2 : t_enum1
                         := c_t_enum1_2 ;
             i_st_enum1_1 : st_enum1
                         := c_st_enum1_1 ;
             i_st_enum1_2 : st_enum1
                         := c_st_enum1_2 ;
             i_integer_1 : integer
                         := c_integer_1 ;
             i_integer_2 : integer
                         := c_integer_2 ;
             i_t_int1_1 : t_int1
                         := c_t_int1_1 ;
             i_t_int1_2 : t_int1
                         := c_t_int1_2 ;
             i_st_int1_1 : st_int1
                         := c_st_int1_1 ;
             i_st_int1_2 : st_int1
                         := c_st_int1_2 ;
             i_time_1 : time
                         := c_time_1 ;
             i_time_2 : time
                         := c_time_2 ;
             i_t_phys1_1 : t_phys1
                         := c_t_phys1_1 ;
             i_t_phys1_2 : t_phys1
                         := c_t_phys1_2 ;
             i_st_phys1_1 : st_phys1
                         := c_st_phys1_1 ;
             i_st_phys1_2 : st_phys1
                         := c_st_phys1_2 ;
             i_real_1 : real
                         := c_real_1 ;
             i_real_2 : real
                         := c_real_2 ;
             i_t_real1_1 : t_real1
                         := c_t_real1_1 ;
             i_t_real1_2 : t_real1
                         := c_t_real1_2 ;
             i_st_real1_1 : st_real1
                         := c_st_real1_1 ;
             i_st_real1_2 : st_real1
                         := c_st_real1_2 ;
             i_st_bit_vector_1 : st_bit_vector
                         := c_st_bit_vector_1 ;
             i_st_bit_vector_2 : st_bit_vector
                         := c_st_bit_vector_2 ;
             i_st_string_1 : st_string
                         := c_st_string_1 ;
             i_st_string_2 : st_string
                         := c_st_string_2 ;
             i_t_rec1_1 : t_rec1
                         := c_t_rec1_1 ;
             i_t_rec1_2 : t_rec1
                         := c_t_rec1_2 ;
             i_st_rec1_1 : st_rec1
                         := c_st_rec1_1 ;
             i_st_rec1_2 : st_rec1
                         := c_st_rec1_2 ;
             i_t_rec2_1 : t_rec2
                         := c_t_rec2_1 ;
             i_t_rec2_2 : t_rec2
                         := c_t_rec2_2 ;
             i_st_rec2_1 : st_rec2
                         := c_st_rec2_1 ;
             i_st_rec2_2 : st_rec2
                         := c_st_rec2_2 ;
             i_t_rec3_1 : t_rec3
                         := c_t_rec3_1 ;
             i_t_rec3_2 : t_rec3
                         := c_t_rec3_2 ;
             i_st_rec3_1 : st_rec3
                         := c_st_rec3_1 ;
             i_st_rec3_2 : st_rec3
                         := c_st_rec3_2 ;
             i_st_arr1_1 : st_arr1
                         := c_st_arr1_1 ;
             i_st_arr1_2 : st_arr1
                         := c_st_arr1_2 ;
             i_st_arr2_1 : st_arr2
                         := c_st_arr2_1 ;
             i_st_arr2_2 : st_arr2
                         := c_st_arr2_2 ;
             i_st_arr3_1 : st_arr3 := c_st_arr3_1 ;
             i_st_arr3_2 : st_arr3 := c_st_arr3_2
             ) ;
   port ( locally_static_correct : out boolean ;
   globally_static_correct : out boolean ;
   dynamic_correct : out boolean ) ;
end ENT00310 ;
architecture ARCH00310 of ENT00310 is
begin
   process
      variable bool : boolean := true ;
      variable cons_correct, gen_correct, dyn_correct : boolean := true ;
          variable v_boolean_1 : boolean
                   := c_boolean_1 ;
          variable v_boolean_2 : boolean
                   := c_boolean_2 ;
          variable v_bit_1 : bit
                   := c_bit_1 ;
          variable v_bit_2 : bit
                   := c_bit_2 ;
          variable v_severity_level_1 : severity_level
                   := c_severity_level_1 ;
          variable v_severity_level_2 : severity_level
                   := c_severity_level_2 ;
          variable v_character_1 : character
                   := c_character_1 ;
          variable v_character_2 : character
                   := c_character_2 ;
          variable v_t_enum1_1 : t_enum1
                   := c_t_enum1_1 ;
          variable v_t_enum1_2 : t_enum1
                   := c_t_enum1_2 ;
          variable v_st_enum1_1 : st_enum1
                   := c_st_enum1_1 ;
          variable v_st_enum1_2 : st_enum1
                   := c_st_enum1_2 ;
          variable v_integer_1 : integer
                   := c_integer_1 ;
          variable v_integer_2 : integer
                   := c_integer_2 ;
          variable v_t_int1_1 : t_int1
                   := c_t_int1_1 ;
          variable v_t_int1_2 : t_int1
                   := c_t_int1_2 ;
          variable v_st_int1_1 : st_int1
                   := c_st_int1_1 ;
          variable v_st_int1_2 : st_int1
                   := c_st_int1_2 ;
          variable v_time_1 : time
                   := c_time_1 ;
          variable v_time_2 : time
                   := c_time_2 ;
          variable v_t_phys1_1 : t_phys1
                   := c_t_phys1_1 ;
          variable v_t_phys1_2 : t_phys1
                   := c_t_phys1_2 ;
          variable v_st_phys1_1 : st_phys1
                   := c_st_phys1_1 ;
          variable v_st_phys1_2 : st_phys1
                   := c_st_phys1_2 ;
          variable v_real_1 : real
                   := c_real_1 ;
          variable v_real_2 : real
                   := c_real_2 ;
          variable v_t_real1_1 : t_real1
                   := c_t_real1_1 ;
          variable v_t_real1_2 : t_real1
                   := c_t_real1_2 ;
          variable v_st_real1_1 : st_real1
                   := c_st_real1_1 ;
          variable v_st_real1_2 : st_real1
                   := c_st_real1_2 ;
          variable v_st_bit_vector_1 : st_bit_vector
                   := c_st_bit_vector_1 ;
          variable v_st_bit_vector_2 : st_bit_vector
                   := c_st_bit_vector_2 ;
          variable v_st_string_1 : st_string
                   := c_st_string_1 ;
          variable v_st_string_2 : st_string
                   := c_st_string_2 ;
          variable v_t_rec1_1 : t_rec1
                   := c_t_rec1_1 ;
          variable v_t_rec1_2 : t_rec1
                   := c_t_rec1_2 ;
          variable v_st_rec1_1 : st_rec1
                   := c_st_rec1_1 ;
          variable v_st_rec1_2 : st_rec1
                   := c_st_rec1_2 ;
          variable v_t_rec2_1 : t_rec2
                   := c_t_rec2_1 ;
          variable v_t_rec2_2 : t_rec2
                   := c_t_rec2_2 ;
          variable v_st_rec2_1 : st_rec2
                   := c_st_rec2_1 ;
          variable v_st_rec2_2 : st_rec2
                   := c_st_rec2_2 ;
          variable v_t_rec3_1 : t_rec3
                   := c_t_rec3_1 ;
          variable v_t_rec3_2 : t_rec3
                   := c_t_rec3_2 ;
          variable v_st_rec3_1 : st_rec3
                   := c_st_rec3_1 ;
          variable v_st_rec3_2 : st_rec3
                   := c_st_rec3_2 ;
          variable v_st_arr1_1 : st_arr1
                   := c_st_arr1_1 ;
          variable v_st_arr1_2 : st_arr1
                   := c_st_arr1_2 ;
          variable v_st_arr2_1 : st_arr2
                   := c_st_arr2_1 ;
          variable v_st_arr2_2 : st_arr2
                   := c_st_arr2_2 ;
          variable v_st_arr3_1 : st_arr3
                   := c_st_arr3_1 ;
          variable v_st_arr3_2 : st_arr3
                   := c_st_arr3_2 ;
         constant c2_boolean_1 : boolean :=
               i_boolean_1 = c_boolean_1 and
               i_boolean_1 /= i_boolean_2 and
               not (i_boolean_1 = i_boolean_2)
           ;
         constant c2_bit_1 : boolean :=
               i_bit_1 = c_bit_1 and
               i_bit_1 /= i_bit_2 and
               not (i_bit_1 = i_bit_2)
           ;
         constant c2_severity_level_1 : boolean :=
               i_severity_level_1 = c_severity_level_1 and
               i_severity_level_1 /= i_severity_level_2 and
               not (i_severity_level_1 = i_severity_level_2)
           ;
         constant c2_character_1 : boolean :=
               i_character_1 = c_character_1 and
               i_character_1 /= i_character_2 and
               not (i_character_1 = i_character_2)
           ;
         constant c2_t_enum1_1 : boolean :=
               i_t_enum1_1 = c_t_enum1_1 and
               i_t_enum1_1 /= i_t_enum1_2 and
               not (i_t_enum1_1 = i_t_enum1_2)
           ;
         constant c2_st_enum1_1 : boolean :=
               i_st_enum1_1 = c_st_enum1_1 and
               i_st_enum1_1 /= i_st_enum1_2 and
               not (i_st_enum1_1 = i_st_enum1_2)
           ;
         constant c2_integer_1 : boolean :=
               i_integer_1 = c_integer_1 and
               i_integer_1 /= i_integer_2 and
               not (i_integer_1 = i_integer_2)
           ;
         constant c2_t_int1_1 : boolean :=
               i_t_int1_1 = c_t_int1_1 and
               i_t_int1_1 /= i_t_int1_2 and
               not (i_t_int1_1 = i_t_int1_2)
           ;
         constant c2_st_int1_1 : boolean :=
               i_st_int1_1 = c_st_int1_1 and
               i_st_int1_1 /= i_st_int1_2 and
               not (i_st_int1_1 = i_st_int1_2)
           ;
         constant c2_time_1 : boolean :=
               i_time_1 = c_time_1 and
               i_time_1 /= i_time_2 and
               not (i_time_1 = i_time_2)
           ;
         constant c2_t_phys1_1 : boolean :=
               i_t_phys1_1 = c_t_phys1_1 and
               i_t_phys1_1 /= i_t_phys1_2 and
               not (i_t_phys1_1 = i_t_phys1_2)
           ;
         constant c2_st_phys1_1 : boolean :=
               i_st_phys1_1 = c_st_phys1_1 and
               i_st_phys1_1 /= i_st_phys1_2 and
               not (i_st_phys1_1 = i_st_phys1_2)
           ;
         constant c2_real_1 : boolean :=
               i_real_1 = c_real_1 and
               i_real_1 /= i_real_2 and
               not (i_real_1 = i_real_2)
           ;
         constant c2_t_real1_1 : boolean :=
               i_t_real1_1 = c_t_real1_1 and
               i_t_real1_1 /= i_t_real1_2 and
               not (i_t_real1_1 = i_t_real1_2)
           ;
         constant c2_st_real1_1 : boolean :=
               i_st_real1_1 = c_st_real1_1 and
               i_st_real1_1 /= i_st_real1_2 and
               not (i_st_real1_1 = i_st_real1_2)
           ;
         constant c2_st_bit_vector_1 : boolean :=
               i_st_bit_vector_1 = c_st_bit_vector_1 and
               i_st_bit_vector_1 /= i_st_bit_vector_2 and
               not (i_st_bit_vector_1 = i_st_bit_vector_2)
           ;
         constant c2_st_string_1 : boolean :=
               i_st_string_1 = c_st_string_1 and
               i_st_string_1 /= i_st_string_2 and
               not (i_st_string_1 = i_st_string_2)
           ;
         constant c2_t_rec1_1 : boolean :=
               i_t_rec1_1 = c_t_rec1_1 and
               i_t_rec1_1 /= i_t_rec1_2 and
               not (i_t_rec1_1 = i_t_rec1_2)
           ;
         constant c2_st_rec1_1 : boolean :=
               i_st_rec1_1 = c_st_rec1_1 and
               i_st_rec1_1 /= i_st_rec1_2 and
               not (i_st_rec1_1 = i_st_rec1_2)
           ;
         constant c2_t_rec2_1 : boolean :=
               i_t_rec2_1 = c_t_rec2_1 and
               i_t_rec2_1 /= i_t_rec2_2 and
               not (i_t_rec2_1 = i_t_rec2_2)
           ;
         constant c2_st_rec2_1 : boolean :=
               i_st_rec2_1 = c_st_rec2_1 and
               i_st_rec2_1 /= i_st_rec2_2 and
               not (i_st_rec2_1 = i_st_rec2_2)
           ;
         constant c2_t_rec3_1 : boolean :=
               i_t_rec3_1 = c_t_rec3_1 and
               i_t_rec3_1 /= i_t_rec3_2 and
               not (i_t_rec3_1 = i_t_rec3_2)
           ;
         constant c2_st_rec3_1 : boolean :=
               i_st_rec3_1 = c_st_rec3_1 and
               i_st_rec3_1 /= i_st_rec3_2 and
               not (i_st_rec3_1 = i_st_rec3_2)
           ;
         constant c2_st_arr1_1 : boolean :=
               i_st_arr1_1 = c_st_arr1_1 and
               i_st_arr1_1 /= i_st_arr1_2 and
               not (i_st_arr1_1 = i_st_arr1_2)
           ;
         constant c2_st_arr2_1 : boolean :=
               i_st_arr2_1 = c_st_arr2_1 and
               i_st_arr2_1 /= i_st_arr2_2 and
               not (i_st_arr2_1 = i_st_arr2_2)
           ;
         constant c2_st_arr3_1 : boolean :=
               i_st_arr3_1 = c_st_arr3_1 and
               i_st_arr3_1 /= i_st_arr3_2 and
               not (i_st_arr3_1 = i_st_arr3_2)
           ;
   begin
         gen_correct := gen_correct and c2_boolean_1 = true ;
         gen_correct := gen_correct and c2_bit_1 = true ;
         gen_correct := gen_correct and c2_severity_level_1 = true ;
         gen_correct := gen_correct and c2_character_1 = true ;
         gen_correct := gen_correct and c2_t_enum1_1 = true ;
         gen_correct := gen_correct and c2_st_enum1_1 = true ;
         gen_correct := gen_correct and c2_integer_1 = true ;
         gen_correct := gen_correct and c2_t_int1_1 = true ;
         gen_correct := gen_correct and c2_st_int1_1 = true ;
         gen_correct := gen_correct and c2_time_1 = true ;
         gen_correct := gen_correct and c2_t_phys1_1 = true ;
         gen_correct := gen_correct and c2_st_phys1_1 = true ;
         gen_correct := gen_correct and c2_real_1 = true ;
         gen_correct := gen_correct and c2_t_real1_1 = true ;
         gen_correct := gen_correct and c2_st_real1_1 = true ;
         gen_correct := gen_correct and c2_st_bit_vector_1 = true ;
         gen_correct := gen_correct and c2_st_string_1 = true ;
         gen_correct := gen_correct and c2_t_rec1_1 = true ;
         gen_correct := gen_correct and c2_st_rec1_1 = true ;
         gen_correct := gen_correct and c2_t_rec2_1 = true ;
         gen_correct := gen_correct and c2_st_rec2_1 = true ;
         gen_correct := gen_correct and c2_t_rec3_1 = true ;
         gen_correct := gen_correct and c2_st_rec3_1 = true ;
         gen_correct := gen_correct and c2_st_arr1_1 = true ;
         gen_correct := gen_correct and c2_st_arr2_1 = true ;
         gen_correct := gen_correct and c2_st_arr3_1 = true ;
         dyn_correct := dyn_correct and
               v_boolean_1 = c_boolean_1 and
               v_boolean_1 /= v_boolean_2 and
               not (v_boolean_1 = v_boolean_2)
           ;
         dyn_correct := dyn_correct and
               v_bit_1 = c_bit_1 and
               v_bit_1 /= v_bit_2 and
               not (v_bit_1 = v_bit_2)
           ;
         dyn_correct := dyn_correct and
               v_severity_level_1 = c_severity_level_1 and
               v_severity_level_1 /= v_severity_level_2 and
               not (v_severity_level_1 = v_severity_level_2)
           ;
         dyn_correct := dyn_correct and
               v_character_1 = c_character_1 and
               v_character_1 /= v_character_2 and
               not (v_character_1 = v_character_2)
           ;
         dyn_correct := dyn_correct and
               v_t_enum1_1 = c_t_enum1_1 and
               v_t_enum1_1 /= v_t_enum1_2 and
               not (v_t_enum1_1 = v_t_enum1_2)
           ;
         dyn_correct := dyn_correct and
               v_st_enum1_1 = c_st_enum1_1 and
               v_st_enum1_1 /= v_st_enum1_2 and
               not (v_st_enum1_1 = v_st_enum1_2)
           ;
         dyn_correct := dyn_correct and
               v_integer_1 = c_integer_1 and
               v_integer_1 /= v_integer_2 and
               not (v_integer_1 = v_integer_2)
           ;
         dyn_correct := dyn_correct and
               v_t_int1_1 = c_t_int1_1 and
               v_t_int1_1 /= v_t_int1_2 and
               not (v_t_int1_1 = v_t_int1_2)
           ;
         dyn_correct := dyn_correct and
               v_st_int1_1 = c_st_int1_1 and
               v_st_int1_1 /= v_st_int1_2 and
               not (v_st_int1_1 = v_st_int1_2)
           ;
         dyn_correct := dyn_correct and
               v_time_1 = c_time_1 and
               v_time_1 /= v_time_2 and
               not (v_time_1 = v_time_2)
           ;
         dyn_correct := dyn_correct and
               v_t_phys1_1 = c_t_phys1_1 and
               v_t_phys1_1 /= v_t_phys1_2 and
               not (v_t_phys1_1 = v_t_phys1_2)
           ;
         dyn_correct := dyn_correct and
               v_st_phys1_1 = c_st_phys1_1 and
               v_st_phys1_1 /= v_st_phys1_2 and
               not (v_st_phys1_1 = v_st_phys1_2)
           ;
         dyn_correct := dyn_correct and
               v_real_1 = c_real_1 and
               v_real_1 /= v_real_2 and
               not (v_real_1 = v_real_2)
           ;
         dyn_correct := dyn_correct and
               v_t_real1_1 = c_t_real1_1 and
               v_t_real1_1 /= v_t_real1_2 and
               not (v_t_real1_1 = v_t_real1_2)
           ;
         dyn_correct := dyn_correct and
               v_st_real1_1 = c_st_real1_1 and
               v_st_real1_1 /= v_st_real1_2 and
               not (v_st_real1_1 = v_st_real1_2)
           ;
         dyn_correct := dyn_correct and
               v_st_bit_vector_1 = c_st_bit_vector_1 and
               v_st_bit_vector_1 /= v_st_bit_vector_2 and
               not (v_st_bit_vector_1 = v_st_bit_vector_2)
           ;
         dyn_correct := dyn_correct and
               v_st_string_1 = c_st_string_1 and
               v_st_string_1 /= v_st_string_2 and
               not (v_st_string_1 = v_st_string_2)
           ;
         dyn_correct := dyn_correct and
               v_t_rec1_1 = c_t_rec1_1 and
               v_t_rec1_1 /= v_t_rec1_2 and
               not (v_t_rec1_1 = v_t_rec1_2)
           ;
         dyn_correct := dyn_correct and
               v_st_rec1_1 = c_st_rec1_1 and
               v_st_rec1_1 /= v_st_rec1_2 and
               not (v_st_rec1_1 = v_st_rec1_2)
           ;
         dyn_correct := dyn_correct and
               v_t_rec2_1 = c_t_rec2_1 and
               v_t_rec2_1 /= v_t_rec2_2 and
               not (v_t_rec2_1 = v_t_rec2_2)
           ;
         dyn_correct := dyn_correct and
               v_st_rec2_1 = c_st_rec2_1 and
               v_st_rec2_1 /= v_st_rec2_2 and
               not (v_st_rec2_1 = v_st_rec2_2)
           ;
         dyn_correct := dyn_correct and
               v_t_rec3_1 = c_t_rec3_1 and
               v_t_rec3_1 /= v_t_rec3_2 and
               not (v_t_rec3_1 = v_t_rec3_2)
           ;
         dyn_correct := dyn_correct and
               v_st_rec3_1 = c_st_rec3_1 and
               v_st_rec3_1 /= v_st_rec3_2 and
               not (v_st_rec3_1 = v_st_rec3_2)
           ;
         dyn_correct := dyn_correct and
               v_st_arr1_1 = c_st_arr1_1 and
               v_st_arr1_1 /= v_st_arr1_2 and
               not (v_st_arr1_1 = v_st_arr1_2)
           ;
         dyn_correct := dyn_correct and
               v_st_arr2_1 = c_st_arr2_1 and
               v_st_arr2_1 /= v_st_arr2_2 and
               not (v_st_arr2_1 = v_st_arr2_2)
           ;
         dyn_correct := dyn_correct and
               v_st_arr3_1 = c_st_arr3_1 and
               v_st_arr3_1 /= v_st_arr3_2 and
               not (v_st_arr3_1 = v_st_arr3_2)
           ;
      locally_static_correct <= cons_correct ;
      globally_static_correct <= gen_correct ;
      dynamic_correct <= dyn_correct ;
      wait;
   end process ;
end ARCH00310 ;
architecture ARCH00310_1 of GENERIC_STANDARD_TYPES is
begin
   B : block
         generic (
                   i_boolean_1 : boolean
                               := c_boolean_1 ;
                   i_boolean_2 : boolean
                               := c_boolean_2 ;
                   i_bit_1 : bit
                               := c_bit_1 ;
                   i_bit_2 : bit
                               := c_bit_2 ;
                   i_severity_level_1 : severity_level
                               := c_severity_level_1 ;
                   i_severity_level_2 : severity_level
                               := c_severity_level_2 ;
                   i_character_1 : character
                               := c_character_1 ;
                   i_character_2 : character
                               := c_character_2 ;
                   i_t_enum1_1 : t_enum1
                               := c_t_enum1_1 ;
                   i_t_enum1_2 : t_enum1
                               := c_t_enum1_2 ;
                   i_st_enum1_1 : st_enum1
                               := c_st_enum1_1 ;
                   i_st_enum1_2 : st_enum1
                               := c_st_enum1_2 ;
                   i_integer_1 : integer
                               := c_integer_1 ;
                   i_integer_2 : integer
                               := c_integer_2 ;
                   i_t_int1_1 : t_int1
                               := c_t_int1_1 ;
                   i_t_int1_2 : t_int1
                               := c_t_int1_2 ;
                   i_st_int1_1 : st_int1
                               := c_st_int1_1 ;
                   i_st_int1_2 : st_int1
                               := c_st_int1_2 ;
                   i_time_1 : time
                               := c_time_1 ;
                   i_time_2 : time
                               := c_time_2 ;
                   i_t_phys1_1 : t_phys1
                               := c_t_phys1_1 ;
                   i_t_phys1_2 : t_phys1
                               := c_t_phys1_2 ;
                   i_st_phys1_1 : st_phys1
                               := c_st_phys1_1 ;
                   i_st_phys1_2 : st_phys1
                               := c_st_phys1_2 ;
                   i_real_1 : real
                               := c_real_1 ;
                   i_real_2 : real
                               := c_real_2 ;
                   i_t_real1_1 : t_real1
                               := c_t_real1_1 ;
                   i_t_real1_2 : t_real1
                               := c_t_real1_2 ;
                   i_st_real1_1 : st_real1
                               := c_st_real1_1 ;
                   i_st_real1_2 : st_real1
                               := c_st_real1_2 ;
                   i_st_bit_vector_1 : st_bit_vector
                               := c_st_bit_vector_1 ;
                   i_st_bit_vector_2 : st_bit_vector
                               := c_st_bit_vector_2 ;
                   i_st_string_1 : st_string
                               := c_st_string_1 ;
                   i_st_string_2 : st_string
                               := c_st_string_2 ;
                   i_t_rec1_1 : t_rec1
                               := c_t_rec1_1 ;
                   i_t_rec1_2 : t_rec1
                               := c_t_rec1_2 ;
                   i_st_rec1_1 : st_rec1
                               := c_st_rec1_1 ;
                   i_st_rec1_2 : st_rec1
                               := c_st_rec1_2 ;
                   i_t_rec2_1 : t_rec2
                               := c_t_rec2_1 ;
                   i_t_rec2_2 : t_rec2
                               := c_t_rec2_2 ;
                   i_st_rec2_1 : st_rec2
                               := c_st_rec2_1 ;
                   i_st_rec2_2 : st_rec2
                               := c_st_rec2_2 ;
                   i_t_rec3_1 : t_rec3
                               := c_t_rec3_1 ;
                   i_t_rec3_2 : t_rec3
                               := c_t_rec3_2 ;
                   i_st_rec3_1 : st_rec3
                               := c_st_rec3_1 ;
                   i_st_rec3_2 : st_rec3
                               := c_st_rec3_2 ;
                   i_st_arr1_1 : st_arr1
                               := c_st_arr1_1 ;
                   i_st_arr1_2 : st_arr1
                               := c_st_arr1_2 ;
                   i_st_arr2_1 : st_arr2
                               := c_st_arr2_1 ;
                   i_st_arr2_2 : st_arr2
                               := c_st_arr2_2 ;
                   i_st_arr3_1 : st_arr3 := c_st_arr3_1 ;
                   i_st_arr3_2 : st_arr3 := c_st_arr3_2
                  ) ;
   begin
      process
         variable bool : boolean := true ;
         variable gen_correct, dyn_correct : boolean := true ;
          variable v_boolean_1 : boolean
                   := c_boolean_1 ;
          variable v_boolean_2 : boolean
                   := c_boolean_2 ;
          variable v_bit_1 : bit
                   := c_bit_1 ;
          variable v_bit_2 : bit
                   := c_bit_2 ;
          variable v_severity_level_1 : severity_level
                   := c_severity_level_1 ;
          variable v_severity_level_2 : severity_level
                   := c_severity_level_2 ;
          variable v_character_1 : character
                   := c_character_1 ;
          variable v_character_2 : character
                   := c_character_2 ;
          variable v_t_enum1_1 : t_enum1
                   := c_t_enum1_1 ;
          variable v_t_enum1_2 : t_enum1
                   := c_t_enum1_2 ;
          variable v_st_enum1_1 : st_enum1
                   := c_st_enum1_1 ;
          variable v_st_enum1_2 : st_enum1
                   := c_st_enum1_2 ;
          variable v_integer_1 : integer
                   := c_integer_1 ;
          variable v_integer_2 : integer
                   := c_integer_2 ;
          variable v_t_int1_1 : t_int1
                   := c_t_int1_1 ;
          variable v_t_int1_2 : t_int1
                   := c_t_int1_2 ;
          variable v_st_int1_1 : st_int1
                   := c_st_int1_1 ;
          variable v_st_int1_2 : st_int1
                   := c_st_int1_2 ;
          variable v_time_1 : time
                   := c_time_1 ;
          variable v_time_2 : time
                   := c_time_2 ;
          variable v_t_phys1_1 : t_phys1
                   := c_t_phys1_1 ;
          variable v_t_phys1_2 : t_phys1
                   := c_t_phys1_2 ;
          variable v_st_phys1_1 : st_phys1
                   := c_st_phys1_1 ;
          variable v_st_phys1_2 : st_phys1
                   := c_st_phys1_2 ;
          variable v_real_1 : real
                   := c_real_1 ;
          variable v_real_2 : real
                   := c_real_2 ;
          variable v_t_real1_1 : t_real1
                   := c_t_real1_1 ;
          variable v_t_real1_2 : t_real1
                   := c_t_real1_2 ;
          variable v_st_real1_1 : st_real1
                   := c_st_real1_1 ;
          variable v_st_real1_2 : st_real1
                   := c_st_real1_2 ;
          variable v_st_bit_vector_1 : st_bit_vector
                   := c_st_bit_vector_1 ;
          variable v_st_bit_vector_2 : st_bit_vector
                   := c_st_bit_vector_2 ;
          variable v_st_string_1 : st_string
                   := c_st_string_1 ;
          variable v_st_string_2 : st_string
                   := c_st_string_2 ;
          variable v_t_rec1_1 : t_rec1
                   := c_t_rec1_1 ;
          variable v_t_rec1_2 : t_rec1
                   := c_t_rec1_2 ;
          variable v_st_rec1_1 : st_rec1
                   := c_st_rec1_1 ;
          variable v_st_rec1_2 : st_rec1
                   := c_st_rec1_2 ;
          variable v_t_rec2_1 : t_rec2
                   := c_t_rec2_1 ;
          variable v_t_rec2_2 : t_rec2
                   := c_t_rec2_2 ;
          variable v_st_rec2_1 : st_rec2
                   := c_st_rec2_1 ;
          variable v_st_rec2_2 : st_rec2
                   := c_st_rec2_2 ;
          variable v_t_rec3_1 : t_rec3
                   := c_t_rec3_1 ;
          variable v_t_rec3_2 : t_rec3
                   := c_t_rec3_2 ;
          variable v_st_rec3_1 : st_rec3
                   := c_st_rec3_1 ;
          variable v_st_rec3_2 : st_rec3
                   := c_st_rec3_2 ;
          variable v_st_arr1_1 : st_arr1
                   := c_st_arr1_1 ;
          variable v_st_arr1_2 : st_arr1
                   := c_st_arr1_2 ;
          variable v_st_arr2_1 : st_arr2
                   := c_st_arr2_1 ;
          variable v_st_arr2_2 : st_arr2
                   := c_st_arr2_2 ;
          variable v_st_arr3_1 : st_arr3
                   := c_st_arr3_1 ;
          variable v_st_arr3_2 : st_arr3
                   := c_st_arr3_2 ;
         constant c2_boolean_1 : boolean :=
               i_boolean_1 = c_boolean_1 and
               i_boolean_1 /= i_boolean_2 and
               not (i_boolean_1 = i_boolean_2)
           ;
         constant c2_bit_1 : boolean :=
               i_bit_1 = c_bit_1 and
               i_bit_1 /= i_bit_2 and
               not (i_bit_1 = i_bit_2)
           ;
         constant c2_severity_level_1 : boolean :=
               i_severity_level_1 = c_severity_level_1 and
               i_severity_level_1 /= i_severity_level_2 and
               not (i_severity_level_1 = i_severity_level_2)
           ;
         constant c2_character_1 : boolean :=
               i_character_1 = c_character_1 and
               i_character_1 /= i_character_2 and
               not (i_character_1 = i_character_2)
           ;
         constant c2_t_enum1_1 : boolean :=
               i_t_enum1_1 = c_t_enum1_1 and
               i_t_enum1_1 /= i_t_enum1_2 and
               not (i_t_enum1_1 = i_t_enum1_2)
           ;
         constant c2_st_enum1_1 : boolean :=
               i_st_enum1_1 = c_st_enum1_1 and
               i_st_enum1_1 /= i_st_enum1_2 and
               not (i_st_enum1_1 = i_st_enum1_2)
           ;
         constant c2_integer_1 : boolean :=
               i_integer_1 = c_integer_1 and
               i_integer_1 /= i_integer_2 and
               not (i_integer_1 = i_integer_2)
           ;
         constant c2_t_int1_1 : boolean :=
               i_t_int1_1 = c_t_int1_1 and
               i_t_int1_1 /= i_t_int1_2 and
               not (i_t_int1_1 = i_t_int1_2)
           ;
         constant c2_st_int1_1 : boolean :=
               i_st_int1_1 = c_st_int1_1 and
               i_st_int1_1 /= i_st_int1_2 and
               not (i_st_int1_1 = i_st_int1_2)
           ;
         constant c2_time_1 : boolean :=
               i_time_1 = c_time_1 and
               i_time_1 /= i_time_2 and
               not (i_time_1 = i_time_2)
           ;
         constant c2_t_phys1_1 : boolean :=
               i_t_phys1_1 = c_t_phys1_1 and
               i_t_phys1_1 /= i_t_phys1_2 and
               not (i_t_phys1_1 = i_t_phys1_2)
           ;
         constant c2_st_phys1_1 : boolean :=
               i_st_phys1_1 = c_st_phys1_1 and
               i_st_phys1_1 /= i_st_phys1_2 and
               not (i_st_phys1_1 = i_st_phys1_2)
           ;
         constant c2_real_1 : boolean :=
               i_real_1 = c_real_1 and
               i_real_1 /= i_real_2 and
               not (i_real_1 = i_real_2)
           ;
         constant c2_t_real1_1 : boolean :=
               i_t_real1_1 = c_t_real1_1 and
               i_t_real1_1 /= i_t_real1_2 and
               not (i_t_real1_1 = i_t_real1_2)
           ;
         constant c2_st_real1_1 : boolean :=
               i_st_real1_1 = c_st_real1_1 and
               i_st_real1_1 /= i_st_real1_2 and
               not (i_st_real1_1 = i_st_real1_2)
           ;
         constant c2_st_bit_vector_1 : boolean :=
               i_st_bit_vector_1 = c_st_bit_vector_1 and
               i_st_bit_vector_1 /= i_st_bit_vector_2 and
               not (i_st_bit_vector_1 = i_st_bit_vector_2)
           ;
         constant c2_st_string_1 : boolean :=
               i_st_string_1 = c_st_string_1 and
               i_st_string_1 /= i_st_string_2 and
               not (i_st_string_1 = i_st_string_2)
           ;
         constant c2_t_rec1_1 : boolean :=
               i_t_rec1_1 = c_t_rec1_1 and
               i_t_rec1_1 /= i_t_rec1_2 and
               not (i_t_rec1_1 = i_t_rec1_2)
           ;
         constant c2_st_rec1_1 : boolean :=
               i_st_rec1_1 = c_st_rec1_1 and
               i_st_rec1_1 /= i_st_rec1_2 and
               not (i_st_rec1_1 = i_st_rec1_2)
           ;
         constant c2_t_rec2_1 : boolean :=
               i_t_rec2_1 = c_t_rec2_1 and
               i_t_rec2_1 /= i_t_rec2_2 and
               not (i_t_rec2_1 = i_t_rec2_2)
           ;
         constant c2_st_rec2_1 : boolean :=
               i_st_rec2_1 = c_st_rec2_1 and
               i_st_rec2_1 /= i_st_rec2_2 and
               not (i_st_rec2_1 = i_st_rec2_2)
           ;
         constant c2_t_rec3_1 : boolean :=
               i_t_rec3_1 = c_t_rec3_1 and
               i_t_rec3_1 /= i_t_rec3_2 and
               not (i_t_rec3_1 = i_t_rec3_2)
           ;
         constant c2_st_rec3_1 : boolean :=
               i_st_rec3_1 = c_st_rec3_1 and
               i_st_rec3_1 /= i_st_rec3_2 and
               not (i_st_rec3_1 = i_st_rec3_2)
           ;
         constant c2_st_arr1_1 : boolean :=
               i_st_arr1_1 = c_st_arr1_1 and
               i_st_arr1_1 /= i_st_arr1_2 and
               not (i_st_arr1_1 = i_st_arr1_2)
           ;
         constant c2_st_arr2_1 : boolean :=
               i_st_arr2_1 = c_st_arr2_1 and
               i_st_arr2_1 /= i_st_arr2_2 and
               not (i_st_arr2_1 = i_st_arr2_2)
           ;
         constant c2_st_arr3_1 : boolean :=
               i_st_arr3_1 = c_st_arr3_1 and
               i_st_arr3_1 /= i_st_arr3_2 and
               not (i_st_arr3_1 = i_st_arr3_2)
           ;
   begin
         dyn_correct := dyn_correct and
               v_boolean_1 = c_boolean_1 and
               v_boolean_1 /= v_boolean_2 and
               not (v_boolean_1 = v_boolean_2)
           ;
         dyn_correct := dyn_correct and
               v_bit_1 = c_bit_1 and
               v_bit_1 /= v_bit_2 and
               not (v_bit_1 = v_bit_2)
           ;
         dyn_correct := dyn_correct and
               v_severity_level_1 = c_severity_level_1 and
               v_severity_level_1 /= v_severity_level_2 and
               not (v_severity_level_1 = v_severity_level_2)
           ;
         dyn_correct := dyn_correct and
               v_character_1 = c_character_1 and
               v_character_1 /= v_character_2 and
               not (v_character_1 = v_character_2)
           ;
         dyn_correct := dyn_correct and
               v_t_enum1_1 = c_t_enum1_1 and
               v_t_enum1_1 /= v_t_enum1_2 and
               not (v_t_enum1_1 = v_t_enum1_2)
           ;
         dyn_correct := dyn_correct and
               v_st_enum1_1 = c_st_enum1_1 and
               v_st_enum1_1 /= v_st_enum1_2 and
               not (v_st_enum1_1 = v_st_enum1_2)
           ;
         dyn_correct := dyn_correct and
               v_integer_1 = c_integer_1 and
               v_integer_1 /= v_integer_2 and
               not (v_integer_1 = v_integer_2)
           ;
         dyn_correct := dyn_correct and
               v_t_int1_1 = c_t_int1_1 and
               v_t_int1_1 /= v_t_int1_2 and
               not (v_t_int1_1 = v_t_int1_2)
           ;
         dyn_correct := dyn_correct and
               v_st_int1_1 = c_st_int1_1 and
               v_st_int1_1 /= v_st_int1_2 and
               not (v_st_int1_1 = v_st_int1_2)
           ;
         dyn_correct := dyn_correct and
               v_time_1 = c_time_1 and
               v_time_1 /= v_time_2 and
               not (v_time_1 = v_time_2)
           ;
         dyn_correct := dyn_correct and
               v_t_phys1_1 = c_t_phys1_1 and
               v_t_phys1_1 /= v_t_phys1_2 and
               not (v_t_phys1_1 = v_t_phys1_2)
           ;
         dyn_correct := dyn_correct and
               v_st_phys1_1 = c_st_phys1_1 and
               v_st_phys1_1 /= v_st_phys1_2 and
               not (v_st_phys1_1 = v_st_phys1_2)
           ;
         dyn_correct := dyn_correct and
               v_real_1 = c_real_1 and
               v_real_1 /= v_real_2 and
               not (v_real_1 = v_real_2)
           ;
         dyn_correct := dyn_correct and
               v_t_real1_1 = c_t_real1_1 and
               v_t_real1_1 /= v_t_real1_2 and
               not (v_t_real1_1 = v_t_real1_2)
           ;
         dyn_correct := dyn_correct and
               v_st_real1_1 = c_st_real1_1 and
               v_st_real1_1 /= v_st_real1_2 and
               not (v_st_real1_1 = v_st_real1_2)
           ;
         dyn_correct := dyn_correct and
               v_st_bit_vector_1 = c_st_bit_vector_1 and
               v_st_bit_vector_1 /= v_st_bit_vector_2 and
               not (v_st_bit_vector_1 = v_st_bit_vector_2)
           ;
         dyn_correct := dyn_correct and
               v_st_string_1 = c_st_string_1 and
               v_st_string_1 /= v_st_string_2 and
               not (v_st_string_1 = v_st_string_2)
           ;
         dyn_correct := dyn_correct and
               v_t_rec1_1 = c_t_rec1_1 and
               v_t_rec1_1 /= v_t_rec1_2 and
               not (v_t_rec1_1 = v_t_rec1_2)
           ;
         dyn_correct := dyn_correct and
               v_st_rec1_1 = c_st_rec1_1 and
               v_st_rec1_1 /= v_st_rec1_2 and
               not (v_st_rec1_1 = v_st_rec1_2)
           ;
         dyn_correct := dyn_correct and
               v_t_rec2_1 = c_t_rec2_1 and
               v_t_rec2_1 /= v_t_rec2_2 and
               not (v_t_rec2_1 = v_t_rec2_2)
           ;
         dyn_correct := dyn_correct and
               v_st_rec2_1 = c_st_rec2_1 and
               v_st_rec2_1 /= v_st_rec2_2 and
               not (v_st_rec2_1 = v_st_rec2_2)
           ;
         dyn_correct := dyn_correct and
               v_t_rec3_1 = c_t_rec3_1 and
               v_t_rec3_1 /= v_t_rec3_2 and
               not (v_t_rec3_1 = v_t_rec3_2)
           ;
         dyn_correct := dyn_correct and
               v_st_rec3_1 = c_st_rec3_1 and
               v_st_rec3_1 /= v_st_rec3_2 and
               not (v_st_rec3_1 = v_st_rec3_2)
           ;
         dyn_correct := dyn_correct and
               v_st_arr1_1 = c_st_arr1_1 and
               v_st_arr1_1 /= v_st_arr1_2 and
               not (v_st_arr1_1 = v_st_arr1_2)
           ;
         dyn_correct := dyn_correct and
               v_st_arr2_1 = c_st_arr2_1 and
               v_st_arr2_1 /= v_st_arr2_2 and
               not (v_st_arr2_1 = v_st_arr2_2)
           ;
         dyn_correct := dyn_correct and
               v_st_arr3_1 = c_st_arr3_1 and
               v_st_arr3_1 /= v_st_arr3_2 and
               not (v_st_arr3_1 = v_st_arr3_2)
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
end ARCH00310_1 ;
use WORK.STANDARD_TYPES.all ;
entity ENT00310_Test_Bench is
end ENT00310_Test_Bench ;
architecture ARCH00310_Test_Bench of ENT00310_Test_Bench is
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
      for CIS2 : UUT_1 use entity WORK.ENT00310 ( ARCH00310 ) ;
      for CIS1 : UUT use entity
                 WORK.GENERIC_STANDARD_TYPES ( ARCH00310_1 ) ;
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
end ARCH00310_Test_Bench ;
