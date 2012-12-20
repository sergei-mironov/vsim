-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00306
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
--    ENT00306(ARCH00306)
--    GENERIC_STANDARD_TYPES(ARCH00306_1)
--    ENT00306_Test_Bench(ARCH00306_Test_Bench)
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
entity ENT00306 is
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
             i_st_real1_1 : st_real1 := c_st_real1_1 ;
             i_st_real1_2 : st_real1 := c_st_real1_2
             ) ;
   port ( locally_static_correct : out boolean ;
   globally_static_correct : out boolean ;
   dynamic_correct : out boolean ) ;
end ENT00306 ;
architecture ARCH00306 of ENT00306 is
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
         constant c2_boolean_1 : boolean :=
               i_boolean_1 < i_boolean_2 and
               i_boolean_1 <= i_boolean_2 and
               i_boolean_2 <= c_boolean_2 and
               i_boolean_2 >= i_boolean_1 and
               i_boolean_1 >= c_boolean_1 and
               i_boolean_2 > i_boolean_1 and
               i_boolean_1 = c_boolean_1 and
               i_boolean_1 /= i_boolean_2 and
               not (i_boolean_1 = i_boolean_2)
           ;
         constant c2_bit_1 : boolean :=
               i_bit_1 < i_bit_2 and
               i_bit_1 <= i_bit_2 and
               i_bit_2 <= c_bit_2 and
               i_bit_2 >= i_bit_1 and
               i_bit_1 >= c_bit_1 and
               i_bit_2 > i_bit_1 and
               i_bit_1 = c_bit_1 and
               i_bit_1 /= i_bit_2 and
               not (i_bit_1 = i_bit_2)
           ;
         constant c2_severity_level_1 : boolean :=
               i_severity_level_1 < i_severity_level_2 and
               i_severity_level_1 <= i_severity_level_2 and
               i_severity_level_2 <= c_severity_level_2 and
               i_severity_level_2 >= i_severity_level_1 and
               i_severity_level_1 >= c_severity_level_1 and
               i_severity_level_2 > i_severity_level_1 and
               i_severity_level_1 = c_severity_level_1 and
               i_severity_level_1 /= i_severity_level_2 and
               not (i_severity_level_1 = i_severity_level_2)
           ;
         constant c2_character_1 : boolean :=
               i_character_1 < i_character_2 and
               i_character_1 <= i_character_2 and
               i_character_2 <= c_character_2 and
               i_character_2 >= i_character_1 and
               i_character_1 >= c_character_1 and
               i_character_2 > i_character_1 and
               i_character_1 = c_character_1 and
               i_character_1 /= i_character_2 and
               not (i_character_1 = i_character_2)
           ;
         constant c2_t_enum1_1 : boolean :=
               i_t_enum1_1 < i_t_enum1_2 and
               i_t_enum1_1 <= i_t_enum1_2 and
               i_t_enum1_2 <= c_t_enum1_2 and
               i_t_enum1_2 >= i_t_enum1_1 and
               i_t_enum1_1 >= c_t_enum1_1 and
               i_t_enum1_2 > i_t_enum1_1 and
               i_t_enum1_1 = c_t_enum1_1 and
               i_t_enum1_1 /= i_t_enum1_2 and
               not (i_t_enum1_1 = i_t_enum1_2)
           ;
         constant c2_st_enum1_1 : boolean :=
               i_st_enum1_1 < i_st_enum1_2 and
               i_st_enum1_1 <= i_st_enum1_2 and
               i_st_enum1_2 <= c_st_enum1_2 and
               i_st_enum1_2 >= i_st_enum1_1 and
               i_st_enum1_1 >= c_st_enum1_1 and
               i_st_enum1_2 > i_st_enum1_1 and
               i_st_enum1_1 = c_st_enum1_1 and
               i_st_enum1_1 /= i_st_enum1_2 and
               not (i_st_enum1_1 = i_st_enum1_2)
           ;
         constant c2_integer_1 : boolean :=
               i_integer_1 < i_integer_2 and
               i_integer_1 <= i_integer_2 and
               i_integer_2 <= c_integer_2 and
               i_integer_2 >= i_integer_1 and
               i_integer_1 >= c_integer_1 and
               i_integer_2 > i_integer_1 and
               i_integer_1 = c_integer_1 and
               i_integer_1 /= i_integer_2 and
               not (i_integer_1 = i_integer_2)
           ;
         constant c2_t_int1_1 : boolean :=
               i_t_int1_1 < i_t_int1_2 and
               i_t_int1_1 <= i_t_int1_2 and
               i_t_int1_2 <= c_t_int1_2 and
               i_t_int1_2 >= i_t_int1_1 and
               i_t_int1_1 >= c_t_int1_1 and
               i_t_int1_2 > i_t_int1_1 and
               i_t_int1_1 = c_t_int1_1 and
               i_t_int1_1 /= i_t_int1_2 and
               not (i_t_int1_1 = i_t_int1_2)
           ;
         constant c2_st_int1_1 : boolean :=
               i_st_int1_1 < i_st_int1_2 and
               i_st_int1_1 <= i_st_int1_2 and
               i_st_int1_2 <= c_st_int1_2 and
               i_st_int1_2 >= i_st_int1_1 and
               i_st_int1_1 >= c_st_int1_1 and
               i_st_int1_2 > i_st_int1_1 and
               i_st_int1_1 = c_st_int1_1 and
               i_st_int1_1 /= i_st_int1_2 and
               not (i_st_int1_1 = i_st_int1_2)
           ;
         constant c2_time_1 : boolean :=
               i_time_1 < i_time_2 and
               i_time_1 <= i_time_2 and
               i_time_2 <= c_time_2 and
               i_time_2 >= i_time_1 and
               i_time_1 >= c_time_1 and
               i_time_2 > i_time_1 and
               i_time_1 = c_time_1 and
               i_time_1 /= i_time_2 and
               not (i_time_1 = i_time_2)
           ;
         constant c2_t_phys1_1 : boolean :=
               i_t_phys1_1 < i_t_phys1_2 and
               i_t_phys1_1 <= i_t_phys1_2 and
               i_t_phys1_2 <= c_t_phys1_2 and
               i_t_phys1_2 >= i_t_phys1_1 and
               i_t_phys1_1 >= c_t_phys1_1 and
               i_t_phys1_2 > i_t_phys1_1 and
               i_t_phys1_1 = c_t_phys1_1 and
               i_t_phys1_1 /= i_t_phys1_2 and
               not (i_t_phys1_1 = i_t_phys1_2)
           ;
         constant c2_st_phys1_1 : boolean :=
               i_st_phys1_1 < i_st_phys1_2 and
               i_st_phys1_1 <= i_st_phys1_2 and
               i_st_phys1_2 <= c_st_phys1_2 and
               i_st_phys1_2 >= i_st_phys1_1 and
               i_st_phys1_1 >= c_st_phys1_1 and
               i_st_phys1_2 > i_st_phys1_1 and
               i_st_phys1_1 = c_st_phys1_1 and
               i_st_phys1_1 /= i_st_phys1_2 and
               not (i_st_phys1_1 = i_st_phys1_2)
           ;
         constant c2_real_1 : boolean :=
               i_real_1 < i_real_2 and
               i_real_1 <= i_real_2 and
               i_real_2 <= c_real_2 and
               i_real_2 >= i_real_1 and
               i_real_1 >= c_real_1 and
               i_real_2 > i_real_1 and
               i_real_1 = c_real_1 and
               i_real_1 /= i_real_2 and
               not (i_real_1 = i_real_2)
           ;
         constant c2_t_real1_1 : boolean :=
               i_t_real1_1 < i_t_real1_2 and
               i_t_real1_1 <= i_t_real1_2 and
               i_t_real1_2 <= c_t_real1_2 and
               i_t_real1_2 >= i_t_real1_1 and
               i_t_real1_1 >= c_t_real1_1 and
               i_t_real1_2 > i_t_real1_1 and
               i_t_real1_1 = c_t_real1_1 and
               i_t_real1_1 /= i_t_real1_2 and
               not (i_t_real1_1 = i_t_real1_2)
           ;
         constant c2_st_real1_1 : boolean :=
               i_st_real1_1 < i_st_real1_2 and
               i_st_real1_1 <= i_st_real1_2 and
               i_st_real1_2 <= c_st_real1_2 and
               i_st_real1_2 >= i_st_real1_1 and
               i_st_real1_1 >= c_st_real1_1 and
               i_st_real1_2 > i_st_real1_1 and
               i_st_real1_1 = c_st_real1_1 and
               i_st_real1_1 /= i_st_real1_2 and
               not (i_st_real1_1 = i_st_real1_2)
           ;
   begin
         case bool is
            when (
               c_boolean_1 < c_boolean_2 and
               c_boolean_1 <= c_boolean_2 and
               c_boolean_2 <= c_boolean_2 and
               c_boolean_2 >= c_boolean_1 and
               c_boolean_1 >= c_boolean_1 and
               c_boolean_2 > c_boolean_1 and
               c_boolean_1 = c_boolean_1 and
               c_boolean_1 /= c_boolean_2 and
               not (c_boolean_1 = c_boolean_2)
                            ) =>
               cons_correct := cons_correct and true ;
            when others =>
               cons_correct := false ;
         end case ;
         case bool is
            when (
               c_bit_1 < c_bit_2 and
               c_bit_1 <= c_bit_2 and
               c_bit_2 <= c_bit_2 and
               c_bit_2 >= c_bit_1 and
               c_bit_1 >= c_bit_1 and
               c_bit_2 > c_bit_1 and
               c_bit_1 = c_bit_1 and
               c_bit_1 /= c_bit_2 and
               not (c_bit_1 = c_bit_2)
                            ) =>
               cons_correct := cons_correct and true ;
            when others =>
               cons_correct := false ;
         end case ;
         case bool is
            when (
               c_severity_level_1 < c_severity_level_2 and
               c_severity_level_1 <= c_severity_level_2 and
               c_severity_level_2 <= c_severity_level_2 and
               c_severity_level_2 >= c_severity_level_1 and
               c_severity_level_1 >= c_severity_level_1 and
               c_severity_level_2 > c_severity_level_1 and
               c_severity_level_1 = c_severity_level_1 and
               c_severity_level_1 /= c_severity_level_2 and
               not (c_severity_level_1 = c_severity_level_2)
                            ) =>
               cons_correct := cons_correct and true ;
            when others =>
               cons_correct := false ;
         end case ;
         case bool is
            when (
               c_character_1 < c_character_2 and
               c_character_1 <= c_character_2 and
               c_character_2 <= c_character_2 and
               c_character_2 >= c_character_1 and
               c_character_1 >= c_character_1 and
               c_character_2 > c_character_1 and
               c_character_1 = c_character_1 and
               c_character_1 /= c_character_2 and
               not (c_character_1 = c_character_2)
                            ) =>
               cons_correct := cons_correct and true ;
            when others =>
               cons_correct := false ;
         end case ;
         case bool is
            when (
               c_t_enum1_1 < c_t_enum1_2 and
               c_t_enum1_1 <= c_t_enum1_2 and
               c_t_enum1_2 <= c_t_enum1_2 and
               c_t_enum1_2 >= c_t_enum1_1 and
               c_t_enum1_1 >= c_t_enum1_1 and
               c_t_enum1_2 > c_t_enum1_1 and
               c_t_enum1_1 = c_t_enum1_1 and
               c_t_enum1_1 /= c_t_enum1_2 and
               not (c_t_enum1_1 = c_t_enum1_2)
                            ) =>
               cons_correct := cons_correct and true ;
            when others =>
               cons_correct := false ;
         end case ;
         case bool is
            when (
               c_st_enum1_1 < c_st_enum1_2 and
               c_st_enum1_1 <= c_st_enum1_2 and
               c_st_enum1_2 <= c_st_enum1_2 and
               c_st_enum1_2 >= c_st_enum1_1 and
               c_st_enum1_1 >= c_st_enum1_1 and
               c_st_enum1_2 > c_st_enum1_1 and
               c_st_enum1_1 = c_st_enum1_1 and
               c_st_enum1_1 /= c_st_enum1_2 and
               not (c_st_enum1_1 = c_st_enum1_2)
                            ) =>
               cons_correct := cons_correct and true ;
            when others =>
               cons_correct := false ;
         end case ;
         case bool is
            when (
               c_integer_1 < c_integer_2 and
               c_integer_1 <= c_integer_2 and
               c_integer_2 <= c_integer_2 and
               c_integer_2 >= c_integer_1 and
               c_integer_1 >= c_integer_1 and
               c_integer_2 > c_integer_1 and
               c_integer_1 = c_integer_1 and
               c_integer_1 /= c_integer_2 and
               not (c_integer_1 = c_integer_2)
                            ) =>
               cons_correct := cons_correct and true ;
            when others =>
               cons_correct := false ;
         end case ;
         case bool is
            when (
               c_t_int1_1 < c_t_int1_2 and
               c_t_int1_1 <= c_t_int1_2 and
               c_t_int1_2 <= c_t_int1_2 and
               c_t_int1_2 >= c_t_int1_1 and
               c_t_int1_1 >= c_t_int1_1 and
               c_t_int1_2 > c_t_int1_1 and
               c_t_int1_1 = c_t_int1_1 and
               c_t_int1_1 /= c_t_int1_2 and
               not (c_t_int1_1 = c_t_int1_2)
                            ) =>
               cons_correct := cons_correct and true ;
            when others =>
               cons_correct := false ;
         end case ;
         case bool is
            when (
               c_st_int1_1 < c_st_int1_2 and
               c_st_int1_1 <= c_st_int1_2 and
               c_st_int1_2 <= c_st_int1_2 and
               c_st_int1_2 >= c_st_int1_1 and
               c_st_int1_1 >= c_st_int1_1 and
               c_st_int1_2 > c_st_int1_1 and
               c_st_int1_1 = c_st_int1_1 and
               c_st_int1_1 /= c_st_int1_2 and
               not (c_st_int1_1 = c_st_int1_2)
                            ) =>
               cons_correct := cons_correct and true ;
            when others =>
               cons_correct := false ;
         end case ;
         case bool is
            when (
               c_time_1 < c_time_2 and
               c_time_1 <= c_time_2 and
               c_time_2 <= c_time_2 and
               c_time_2 >= c_time_1 and
               c_time_1 >= c_time_1 and
               c_time_2 > c_time_1 and
               c_time_1 = c_time_1 and
               c_time_1 /= c_time_2 and
               not (c_time_1 = c_time_2)
                            ) =>
               cons_correct := cons_correct and true ;
            when others =>
               cons_correct := false ;
         end case ;
         case bool is
            when (
               c_t_phys1_1 < c_t_phys1_2 and
               c_t_phys1_1 <= c_t_phys1_2 and
               c_t_phys1_2 <= c_t_phys1_2 and
               c_t_phys1_2 >= c_t_phys1_1 and
               c_t_phys1_1 >= c_t_phys1_1 and
               c_t_phys1_2 > c_t_phys1_1 and
               c_t_phys1_1 = c_t_phys1_1 and
               c_t_phys1_1 /= c_t_phys1_2 and
               not (c_t_phys1_1 = c_t_phys1_2)
                            ) =>
               cons_correct := cons_correct and true ;
            when others =>
               cons_correct := false ;
         end case ;
         case bool is
            when (
               c_st_phys1_1 < c_st_phys1_2 and
               c_st_phys1_1 <= c_st_phys1_2 and
               c_st_phys1_2 <= c_st_phys1_2 and
               c_st_phys1_2 >= c_st_phys1_1 and
               c_st_phys1_1 >= c_st_phys1_1 and
               c_st_phys1_2 > c_st_phys1_1 and
               c_st_phys1_1 = c_st_phys1_1 and
               c_st_phys1_1 /= c_st_phys1_2 and
               not (c_st_phys1_1 = c_st_phys1_2)
                            ) =>
               cons_correct := cons_correct and true ;
            when others =>
               cons_correct := false ;
         end case ;
         case bool is
            when (
               c_real_1 < c_real_2 and
               c_real_1 <= c_real_2 and
               c_real_2 <= c_real_2 and
               c_real_2 >= c_real_1 and
               c_real_1 >= c_real_1 and
               c_real_2 > c_real_1 and
               c_real_1 = c_real_1 and
               c_real_1 /= c_real_2 and
               not (c_real_1 = c_real_2)
                            ) =>
               cons_correct := cons_correct and true ;
            when others =>
               cons_correct := false ;
         end case ;
         case bool is
            when (
               c_t_real1_1 < c_t_real1_2 and
               c_t_real1_1 <= c_t_real1_2 and
               c_t_real1_2 <= c_t_real1_2 and
               c_t_real1_2 >= c_t_real1_1 and
               c_t_real1_1 >= c_t_real1_1 and
               c_t_real1_2 > c_t_real1_1 and
               c_t_real1_1 = c_t_real1_1 and
               c_t_real1_1 /= c_t_real1_2 and
               not (c_t_real1_1 = c_t_real1_2)
                            ) =>
               cons_correct := cons_correct and true ;
            when others =>
               cons_correct := false ;
         end case ;
         case bool is
            when (
               c_st_real1_1 < c_st_real1_2 and
               c_st_real1_1 <= c_st_real1_2 and
               c_st_real1_2 <= c_st_real1_2 and
               c_st_real1_2 >= c_st_real1_1 and
               c_st_real1_1 >= c_st_real1_1 and
               c_st_real1_2 > c_st_real1_1 and
               c_st_real1_1 = c_st_real1_1 and
               c_st_real1_1 /= c_st_real1_2 and
               not (c_st_real1_1 = c_st_real1_2)
                            ) =>
               cons_correct := cons_correct and true ;
            when others =>
               cons_correct := false ;
         end case ;
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
         dyn_correct := dyn_correct and
               v_boolean_1 < v_boolean_2 and
               v_boolean_1 <= v_boolean_2 and
               v_boolean_2 <= c_boolean_2 and
               v_boolean_2 >= v_boolean_1 and
               v_boolean_1 >= c_boolean_1 and
               v_boolean_2 > v_boolean_1 and
               v_boolean_1 = c_boolean_1 and
               v_boolean_1 /= v_boolean_2 and
               not (v_boolean_1 = v_boolean_2)
           ;
         dyn_correct := dyn_correct and
               v_bit_1 < v_bit_2 and
               v_bit_1 <= v_bit_2 and
               v_bit_2 <= c_bit_2 and
               v_bit_2 >= v_bit_1 and
               v_bit_1 >= c_bit_1 and
               v_bit_2 > v_bit_1 and
               v_bit_1 = c_bit_1 and
               v_bit_1 /= v_bit_2 and
               not (v_bit_1 = v_bit_2)
           ;
         dyn_correct := dyn_correct and
               v_severity_level_1 < v_severity_level_2 and
               v_severity_level_1 <= v_severity_level_2 and
               v_severity_level_2 <= c_severity_level_2 and
               v_severity_level_2 >= v_severity_level_1 and
               v_severity_level_1 >= c_severity_level_1 and
               v_severity_level_2 > v_severity_level_1 and
               v_severity_level_1 = c_severity_level_1 and
               v_severity_level_1 /= v_severity_level_2 and
               not (v_severity_level_1 = v_severity_level_2)
           ;
         dyn_correct := dyn_correct and
               v_character_1 < v_character_2 and
               v_character_1 <= v_character_2 and
               v_character_2 <= c_character_2 and
               v_character_2 >= v_character_1 and
               v_character_1 >= c_character_1 and
               v_character_2 > v_character_1 and
               v_character_1 = c_character_1 and
               v_character_1 /= v_character_2 and
               not (v_character_1 = v_character_2)
           ;
         dyn_correct := dyn_correct and
               v_t_enum1_1 < v_t_enum1_2 and
               v_t_enum1_1 <= v_t_enum1_2 and
               v_t_enum1_2 <= c_t_enum1_2 and
               v_t_enum1_2 >= v_t_enum1_1 and
               v_t_enum1_1 >= c_t_enum1_1 and
               v_t_enum1_2 > v_t_enum1_1 and
               v_t_enum1_1 = c_t_enum1_1 and
               v_t_enum1_1 /= v_t_enum1_2 and
               not (v_t_enum1_1 = v_t_enum1_2)
           ;
         dyn_correct := dyn_correct and
               v_st_enum1_1 < v_st_enum1_2 and
               v_st_enum1_1 <= v_st_enum1_2 and
               v_st_enum1_2 <= c_st_enum1_2 and
               v_st_enum1_2 >= v_st_enum1_1 and
               v_st_enum1_1 >= c_st_enum1_1 and
               v_st_enum1_2 > v_st_enum1_1 and
               v_st_enum1_1 = c_st_enum1_1 and
               v_st_enum1_1 /= v_st_enum1_2 and
               not (v_st_enum1_1 = v_st_enum1_2)
           ;
         dyn_correct := dyn_correct and
               v_integer_1 < v_integer_2 and
               v_integer_1 <= v_integer_2 and
               v_integer_2 <= c_integer_2 and
               v_integer_2 >= v_integer_1 and
               v_integer_1 >= c_integer_1 and
               v_integer_2 > v_integer_1 and
               v_integer_1 = c_integer_1 and
               v_integer_1 /= v_integer_2 and
               not (v_integer_1 = v_integer_2)
           ;
         dyn_correct := dyn_correct and
               v_t_int1_1 < v_t_int1_2 and
               v_t_int1_1 <= v_t_int1_2 and
               v_t_int1_2 <= c_t_int1_2 and
               v_t_int1_2 >= v_t_int1_1 and
               v_t_int1_1 >= c_t_int1_1 and
               v_t_int1_2 > v_t_int1_1 and
               v_t_int1_1 = c_t_int1_1 and
               v_t_int1_1 /= v_t_int1_2 and
               not (v_t_int1_1 = v_t_int1_2)
           ;
         dyn_correct := dyn_correct and
               v_st_int1_1 < v_st_int1_2 and
               v_st_int1_1 <= v_st_int1_2 and
               v_st_int1_2 <= c_st_int1_2 and
               v_st_int1_2 >= v_st_int1_1 and
               v_st_int1_1 >= c_st_int1_1 and
               v_st_int1_2 > v_st_int1_1 and
               v_st_int1_1 = c_st_int1_1 and
               v_st_int1_1 /= v_st_int1_2 and
               not (v_st_int1_1 = v_st_int1_2)
           ;
         dyn_correct := dyn_correct and
               v_time_1 < v_time_2 and
               v_time_1 <= v_time_2 and
               v_time_2 <= c_time_2 and
               v_time_2 >= v_time_1 and
               v_time_1 >= c_time_1 and
               v_time_2 > v_time_1 and
               v_time_1 = c_time_1 and
               v_time_1 /= v_time_2 and
               not (v_time_1 = v_time_2)
           ;
         dyn_correct := dyn_correct and
               v_t_phys1_1 < v_t_phys1_2 and
               v_t_phys1_1 <= v_t_phys1_2 and
               v_t_phys1_2 <= c_t_phys1_2 and
               v_t_phys1_2 >= v_t_phys1_1 and
               v_t_phys1_1 >= c_t_phys1_1 and
               v_t_phys1_2 > v_t_phys1_1 and
               v_t_phys1_1 = c_t_phys1_1 and
               v_t_phys1_1 /= v_t_phys1_2 and
               not (v_t_phys1_1 = v_t_phys1_2)
           ;
         dyn_correct := dyn_correct and
               v_st_phys1_1 < v_st_phys1_2 and
               v_st_phys1_1 <= v_st_phys1_2 and
               v_st_phys1_2 <= c_st_phys1_2 and
               v_st_phys1_2 >= v_st_phys1_1 and
               v_st_phys1_1 >= c_st_phys1_1 and
               v_st_phys1_2 > v_st_phys1_1 and
               v_st_phys1_1 = c_st_phys1_1 and
               v_st_phys1_1 /= v_st_phys1_2 and
               not (v_st_phys1_1 = v_st_phys1_2)
           ;
         dyn_correct := dyn_correct and
               v_real_1 < v_real_2 and
               v_real_1 <= v_real_2 and
               v_real_2 <= c_real_2 and
               v_real_2 >= v_real_1 and
               v_real_1 >= c_real_1 and
               v_real_2 > v_real_1 and
               v_real_1 = c_real_1 and
               v_real_1 /= v_real_2 and
               not (v_real_1 = v_real_2)
           ;
         dyn_correct := dyn_correct and
               v_t_real1_1 < v_t_real1_2 and
               v_t_real1_1 <= v_t_real1_2 and
               v_t_real1_2 <= c_t_real1_2 and
               v_t_real1_2 >= v_t_real1_1 and
               v_t_real1_1 >= c_t_real1_1 and
               v_t_real1_2 > v_t_real1_1 and
               v_t_real1_1 = c_t_real1_1 and
               v_t_real1_1 /= v_t_real1_2 and
               not (v_t_real1_1 = v_t_real1_2)
           ;
         dyn_correct := dyn_correct and
               v_st_real1_1 < v_st_real1_2 and
               v_st_real1_1 <= v_st_real1_2 and
               v_st_real1_2 <= c_st_real1_2 and
               v_st_real1_2 >= v_st_real1_1 and
               v_st_real1_1 >= c_st_real1_1 and
               v_st_real1_2 > v_st_real1_1 and
               v_st_real1_1 = c_st_real1_1 and
               v_st_real1_1 /= v_st_real1_2 and
               not (v_st_real1_1 = v_st_real1_2)
           ;
      locally_static_correct <= cons_correct ;
      globally_static_correct <= gen_correct ;
      dynamic_correct <= dyn_correct ;
      wait;
   end process ;
end ARCH00306 ;
architecture ARCH00306_1 of GENERIC_STANDARD_TYPES is
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
                   i_st_real1_1 : st_real1 := c_st_real1_1 ;
                   i_st_real1_2 : st_real1 := c_st_real1_2
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
         constant c2_boolean_1 : boolean :=
               i_boolean_1 < i_boolean_2 and
               i_boolean_1 <= i_boolean_2 and
               i_boolean_2 <= c_boolean_2 and
               i_boolean_2 >= i_boolean_1 and
               i_boolean_1 >= c_boolean_1 and
               i_boolean_2 > i_boolean_1 and
               i_boolean_1 = c_boolean_1 and
               i_boolean_1 /= i_boolean_2 and
               not (i_boolean_1 = i_boolean_2)
           ;
         constant c2_bit_1 : boolean :=
               i_bit_1 < i_bit_2 and
               i_bit_1 <= i_bit_2 and
               i_bit_2 <= c_bit_2 and
               i_bit_2 >= i_bit_1 and
               i_bit_1 >= c_bit_1 and
               i_bit_2 > i_bit_1 and
               i_bit_1 = c_bit_1 and
               i_bit_1 /= i_bit_2 and
               not (i_bit_1 = i_bit_2)
           ;
         constant c2_severity_level_1 : boolean :=
               i_severity_level_1 < i_severity_level_2 and
               i_severity_level_1 <= i_severity_level_2 and
               i_severity_level_2 <= c_severity_level_2 and
               i_severity_level_2 >= i_severity_level_1 and
               i_severity_level_1 >= c_severity_level_1 and
               i_severity_level_2 > i_severity_level_1 and
               i_severity_level_1 = c_severity_level_1 and
               i_severity_level_1 /= i_severity_level_2 and
               not (i_severity_level_1 = i_severity_level_2)
           ;
         constant c2_character_1 : boolean :=
               i_character_1 < i_character_2 and
               i_character_1 <= i_character_2 and
               i_character_2 <= c_character_2 and
               i_character_2 >= i_character_1 and
               i_character_1 >= c_character_1 and
               i_character_2 > i_character_1 and
               i_character_1 = c_character_1 and
               i_character_1 /= i_character_2 and
               not (i_character_1 = i_character_2)
           ;
         constant c2_t_enum1_1 : boolean :=
               i_t_enum1_1 < i_t_enum1_2 and
               i_t_enum1_1 <= i_t_enum1_2 and
               i_t_enum1_2 <= c_t_enum1_2 and
               i_t_enum1_2 >= i_t_enum1_1 and
               i_t_enum1_1 >= c_t_enum1_1 and
               i_t_enum1_2 > i_t_enum1_1 and
               i_t_enum1_1 = c_t_enum1_1 and
               i_t_enum1_1 /= i_t_enum1_2 and
               not (i_t_enum1_1 = i_t_enum1_2)
           ;
         constant c2_st_enum1_1 : boolean :=
               i_st_enum1_1 < i_st_enum1_2 and
               i_st_enum1_1 <= i_st_enum1_2 and
               i_st_enum1_2 <= c_st_enum1_2 and
               i_st_enum1_2 >= i_st_enum1_1 and
               i_st_enum1_1 >= c_st_enum1_1 and
               i_st_enum1_2 > i_st_enum1_1 and
               i_st_enum1_1 = c_st_enum1_1 and
               i_st_enum1_1 /= i_st_enum1_2 and
               not (i_st_enum1_1 = i_st_enum1_2)
           ;
         constant c2_integer_1 : boolean :=
               i_integer_1 < i_integer_2 and
               i_integer_1 <= i_integer_2 and
               i_integer_2 <= c_integer_2 and
               i_integer_2 >= i_integer_1 and
               i_integer_1 >= c_integer_1 and
               i_integer_2 > i_integer_1 and
               i_integer_1 = c_integer_1 and
               i_integer_1 /= i_integer_2 and
               not (i_integer_1 = i_integer_2)
           ;
         constant c2_t_int1_1 : boolean :=
               i_t_int1_1 < i_t_int1_2 and
               i_t_int1_1 <= i_t_int1_2 and
               i_t_int1_2 <= c_t_int1_2 and
               i_t_int1_2 >= i_t_int1_1 and
               i_t_int1_1 >= c_t_int1_1 and
               i_t_int1_2 > i_t_int1_1 and
               i_t_int1_1 = c_t_int1_1 and
               i_t_int1_1 /= i_t_int1_2 and
               not (i_t_int1_1 = i_t_int1_2)
           ;
         constant c2_st_int1_1 : boolean :=
               i_st_int1_1 < i_st_int1_2 and
               i_st_int1_1 <= i_st_int1_2 and
               i_st_int1_2 <= c_st_int1_2 and
               i_st_int1_2 >= i_st_int1_1 and
               i_st_int1_1 >= c_st_int1_1 and
               i_st_int1_2 > i_st_int1_1 and
               i_st_int1_1 = c_st_int1_1 and
               i_st_int1_1 /= i_st_int1_2 and
               not (i_st_int1_1 = i_st_int1_2)
           ;
         constant c2_time_1 : boolean :=
               i_time_1 < i_time_2 and
               i_time_1 <= i_time_2 and
               i_time_2 <= c_time_2 and
               i_time_2 >= i_time_1 and
               i_time_1 >= c_time_1 and
               i_time_2 > i_time_1 and
               i_time_1 = c_time_1 and
               i_time_1 /= i_time_2 and
               not (i_time_1 = i_time_2)
           ;
         constant c2_t_phys1_1 : boolean :=
               i_t_phys1_1 < i_t_phys1_2 and
               i_t_phys1_1 <= i_t_phys1_2 and
               i_t_phys1_2 <= c_t_phys1_2 and
               i_t_phys1_2 >= i_t_phys1_1 and
               i_t_phys1_1 >= c_t_phys1_1 and
               i_t_phys1_2 > i_t_phys1_1 and
               i_t_phys1_1 = c_t_phys1_1 and
               i_t_phys1_1 /= i_t_phys1_2 and
               not (i_t_phys1_1 = i_t_phys1_2)
           ;
         constant c2_st_phys1_1 : boolean :=
               i_st_phys1_1 < i_st_phys1_2 and
               i_st_phys1_1 <= i_st_phys1_2 and
               i_st_phys1_2 <= c_st_phys1_2 and
               i_st_phys1_2 >= i_st_phys1_1 and
               i_st_phys1_1 >= c_st_phys1_1 and
               i_st_phys1_2 > i_st_phys1_1 and
               i_st_phys1_1 = c_st_phys1_1 and
               i_st_phys1_1 /= i_st_phys1_2 and
               not (i_st_phys1_1 = i_st_phys1_2)
           ;
         constant c2_real_1 : boolean :=
               i_real_1 < i_real_2 and
               i_real_1 <= i_real_2 and
               i_real_2 <= c_real_2 and
               i_real_2 >= i_real_1 and
               i_real_1 >= c_real_1 and
               i_real_2 > i_real_1 and
               i_real_1 = c_real_1 and
               i_real_1 /= i_real_2 and
               not (i_real_1 = i_real_2)
           ;
         constant c2_t_real1_1 : boolean :=
               i_t_real1_1 < i_t_real1_2 and
               i_t_real1_1 <= i_t_real1_2 and
               i_t_real1_2 <= c_t_real1_2 and
               i_t_real1_2 >= i_t_real1_1 and
               i_t_real1_1 >= c_t_real1_1 and
               i_t_real1_2 > i_t_real1_1 and
               i_t_real1_1 = c_t_real1_1 and
               i_t_real1_1 /= i_t_real1_2 and
               not (i_t_real1_1 = i_t_real1_2)
           ;
         constant c2_st_real1_1 : boolean :=
               i_st_real1_1 < i_st_real1_2 and
               i_st_real1_1 <= i_st_real1_2 and
               i_st_real1_2 <= c_st_real1_2 and
               i_st_real1_2 >= i_st_real1_1 and
               i_st_real1_1 >= c_st_real1_1 and
               i_st_real1_2 > i_st_real1_1 and
               i_st_real1_1 = c_st_real1_1 and
               i_st_real1_1 /= i_st_real1_2 and
               not (i_st_real1_1 = i_st_real1_2)
           ;
   begin
         dyn_correct := dyn_correct and
               v_boolean_1 < v_boolean_2 and
               v_boolean_1 <= v_boolean_2 and
               v_boolean_2 <= c_boolean_2 and
               v_boolean_2 >= v_boolean_1 and
               v_boolean_1 >= c_boolean_1 and
               v_boolean_2 > v_boolean_1 and
               v_boolean_1 = c_boolean_1 and
               v_boolean_1 /= v_boolean_2 and
               not (v_boolean_1 = v_boolean_2)
           ;
         dyn_correct := dyn_correct and
               v_bit_1 < v_bit_2 and
               v_bit_1 <= v_bit_2 and
               v_bit_2 <= c_bit_2 and
               v_bit_2 >= v_bit_1 and
               v_bit_1 >= c_bit_1 and
               v_bit_2 > v_bit_1 and
               v_bit_1 = c_bit_1 and
               v_bit_1 /= v_bit_2 and
               not (v_bit_1 = v_bit_2)
           ;
         dyn_correct := dyn_correct and
               v_severity_level_1 < v_severity_level_2 and
               v_severity_level_1 <= v_severity_level_2 and
               v_severity_level_2 <= c_severity_level_2 and
               v_severity_level_2 >= v_severity_level_1 and
               v_severity_level_1 >= c_severity_level_1 and
               v_severity_level_2 > v_severity_level_1 and
               v_severity_level_1 = c_severity_level_1 and
               v_severity_level_1 /= v_severity_level_2 and
               not (v_severity_level_1 = v_severity_level_2)
           ;
         dyn_correct := dyn_correct and
               v_character_1 < v_character_2 and
               v_character_1 <= v_character_2 and
               v_character_2 <= c_character_2 and
               v_character_2 >= v_character_1 and
               v_character_1 >= c_character_1 and
               v_character_2 > v_character_1 and
               v_character_1 = c_character_1 and
               v_character_1 /= v_character_2 and
               not (v_character_1 = v_character_2)
           ;
         dyn_correct := dyn_correct and
               v_t_enum1_1 < v_t_enum1_2 and
               v_t_enum1_1 <= v_t_enum1_2 and
               v_t_enum1_2 <= c_t_enum1_2 and
               v_t_enum1_2 >= v_t_enum1_1 and
               v_t_enum1_1 >= c_t_enum1_1 and
               v_t_enum1_2 > v_t_enum1_1 and
               v_t_enum1_1 = c_t_enum1_1 and
               v_t_enum1_1 /= v_t_enum1_2 and
               not (v_t_enum1_1 = v_t_enum1_2)
           ;
         dyn_correct := dyn_correct and
               v_st_enum1_1 < v_st_enum1_2 and
               v_st_enum1_1 <= v_st_enum1_2 and
               v_st_enum1_2 <= c_st_enum1_2 and
               v_st_enum1_2 >= v_st_enum1_1 and
               v_st_enum1_1 >= c_st_enum1_1 and
               v_st_enum1_2 > v_st_enum1_1 and
               v_st_enum1_1 = c_st_enum1_1 and
               v_st_enum1_1 /= v_st_enum1_2 and
               not (v_st_enum1_1 = v_st_enum1_2)
           ;
         dyn_correct := dyn_correct and
               v_integer_1 < v_integer_2 and
               v_integer_1 <= v_integer_2 and
               v_integer_2 <= c_integer_2 and
               v_integer_2 >= v_integer_1 and
               v_integer_1 >= c_integer_1 and
               v_integer_2 > v_integer_1 and
               v_integer_1 = c_integer_1 and
               v_integer_1 /= v_integer_2 and
               not (v_integer_1 = v_integer_2)
           ;
         dyn_correct := dyn_correct and
               v_t_int1_1 < v_t_int1_2 and
               v_t_int1_1 <= v_t_int1_2 and
               v_t_int1_2 <= c_t_int1_2 and
               v_t_int1_2 >= v_t_int1_1 and
               v_t_int1_1 >= c_t_int1_1 and
               v_t_int1_2 > v_t_int1_1 and
               v_t_int1_1 = c_t_int1_1 and
               v_t_int1_1 /= v_t_int1_2 and
               not (v_t_int1_1 = v_t_int1_2)
           ;
         dyn_correct := dyn_correct and
               v_st_int1_1 < v_st_int1_2 and
               v_st_int1_1 <= v_st_int1_2 and
               v_st_int1_2 <= c_st_int1_2 and
               v_st_int1_2 >= v_st_int1_1 and
               v_st_int1_1 >= c_st_int1_1 and
               v_st_int1_2 > v_st_int1_1 and
               v_st_int1_1 = c_st_int1_1 and
               v_st_int1_1 /= v_st_int1_2 and
               not (v_st_int1_1 = v_st_int1_2)
           ;
         dyn_correct := dyn_correct and
               v_time_1 < v_time_2 and
               v_time_1 <= v_time_2 and
               v_time_2 <= c_time_2 and
               v_time_2 >= v_time_1 and
               v_time_1 >= c_time_1 and
               v_time_2 > v_time_1 and
               v_time_1 = c_time_1 and
               v_time_1 /= v_time_2 and
               not (v_time_1 = v_time_2)
           ;
         dyn_correct := dyn_correct and
               v_t_phys1_1 < v_t_phys1_2 and
               v_t_phys1_1 <= v_t_phys1_2 and
               v_t_phys1_2 <= c_t_phys1_2 and
               v_t_phys1_2 >= v_t_phys1_1 and
               v_t_phys1_1 >= c_t_phys1_1 and
               v_t_phys1_2 > v_t_phys1_1 and
               v_t_phys1_1 = c_t_phys1_1 and
               v_t_phys1_1 /= v_t_phys1_2 and
               not (v_t_phys1_1 = v_t_phys1_2)
           ;
         dyn_correct := dyn_correct and
               v_st_phys1_1 < v_st_phys1_2 and
               v_st_phys1_1 <= v_st_phys1_2 and
               v_st_phys1_2 <= c_st_phys1_2 and
               v_st_phys1_2 >= v_st_phys1_1 and
               v_st_phys1_1 >= c_st_phys1_1 and
               v_st_phys1_2 > v_st_phys1_1 and
               v_st_phys1_1 = c_st_phys1_1 and
               v_st_phys1_1 /= v_st_phys1_2 and
               not (v_st_phys1_1 = v_st_phys1_2)
           ;
         dyn_correct := dyn_correct and
               v_real_1 < v_real_2 and
               v_real_1 <= v_real_2 and
               v_real_2 <= c_real_2 and
               v_real_2 >= v_real_1 and
               v_real_1 >= c_real_1 and
               v_real_2 > v_real_1 and
               v_real_1 = c_real_1 and
               v_real_1 /= v_real_2 and
               not (v_real_1 = v_real_2)
           ;
         dyn_correct := dyn_correct and
               v_t_real1_1 < v_t_real1_2 and
               v_t_real1_1 <= v_t_real1_2 and
               v_t_real1_2 <= c_t_real1_2 and
               v_t_real1_2 >= v_t_real1_1 and
               v_t_real1_1 >= c_t_real1_1 and
               v_t_real1_2 > v_t_real1_1 and
               v_t_real1_1 = c_t_real1_1 and
               v_t_real1_1 /= v_t_real1_2 and
               not (v_t_real1_1 = v_t_real1_2)
           ;
         dyn_correct := dyn_correct and
               v_st_real1_1 < v_st_real1_2 and
               v_st_real1_1 <= v_st_real1_2 and
               v_st_real1_2 <= c_st_real1_2 and
               v_st_real1_2 >= v_st_real1_1 and
               v_st_real1_1 >= c_st_real1_1 and
               v_st_real1_2 > v_st_real1_1 and
               v_st_real1_1 = c_st_real1_1 and
               v_st_real1_1 /= v_st_real1_2 and
               not (v_st_real1_1 = v_st_real1_2)
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
end ARCH00306_1 ;
use WORK.STANDARD_TYPES.all ;
entity ENT00306_Test_Bench is
end ENT00306_Test_Bench ;
architecture ARCH00306_Test_Bench of ENT00306_Test_Bench is
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
      for CIS2 : UUT_1 use entity WORK.ENT00306 ( ARCH00306 ) ;
      for CIS1 : UUT use entity
                 WORK.GENERIC_STANDARD_TYPES ( ARCH00306_1 ) ;
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
end ARCH00306_Test_Bench ;
