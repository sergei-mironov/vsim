-- NEED RESULT: ARCH00560: Variable declarations - composite dynamic subtypes passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00560
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.1.3 (12)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00560)
--    ENT00560_Test_Bench(ARCH00560_Test_Bench)
--
-- REVISION HISTORY:
--
--    19-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.test_report ;
--
architecture ARCH00560 of E00000 is
   procedure p1 (
               constant lowb : integer := 1 ;
               constant highb : integer := 10 ;
               constant lowb_i2 : integer := 0 ;
               constant highb_i2 : integer := 1000 ;
               constant lowb_p : integer := -100 ;
               constant highb_p : integer := 1000 ;
               constant lowb_r : real := 0.0 ;
               constant highb_r : real := 1000.0 ;
               constant lowb_r2 : real := 8.0 ;
               constant highb_r2 : real := 80.0
--
                ) is
      variable correct : boolean := true ;
--
-- assertion:  c_xxxxx_2 >= c_xxxxx_1
-- enumeration types
-- predefined
-- boolean
  constant c_boolean_1 : boolean := false ;
  constant c_boolean_2 : boolean := true ;
--
  type     boolean_vector is array (integer range <>) of boolean ;
  subtype  boolean_vector_range1 is integer range lowb to highb ;
  subtype  st_boolean_vector is boolean_vector (boolean_vector_range1) ;
  constant c_st_boolean_vector_1 : st_boolean_vector :=
                                     (others => c_boolean_1) ;
  constant c_st_boolean_vector_2 : st_boolean_vector :=
                                     (others => c_boolean_2) ;
--
-- bit
  constant c_bit_1 : bit := '0' ;
  constant c_bit_2 : bit := '1' ;
--
  constant c_bit_vector_1 : bit_vector := B"0000" ;
  constant c_bit_vector_2 : bit_vector := B"1111" ;
  subtype  bit_vector_range1 is integer range lowb to highb ;
  subtype  st_bit_vector is bit_vector (bit_vector_range1) ;
  constant c_st_bit_vector_1 : st_bit_vector :=
                                     (others => c_bit_1) ;
  constant c_st_bit_vector_2 : st_bit_vector :=
                                     (others => c_bit_2) ;
-- severity_level
  constant c_severity_level_1 : severity_level := NOTE ;
  constant c_severity_level_2 : severity_level := WARNING ;
--
  type     severity_level_vector is array (integer range <>) of severity_level ;
  subtype  severity_level_vector_range1 is integer range lowb to highb ;
  subtype  st_severity_level_vector is
               severity_level_vector (severity_level_vector_range1) ;
  constant c_st_severity_level_vector_1 : st_severity_level_vector :=
                                     (others => c_severity_level_1) ;
  constant c_st_severity_level_vector_2 : st_severity_level_vector :=
                                     (others => c_severity_level_2) ;
--
-- character
  constant c_character_1 : character := 'A' ;
  constant c_character_2 : character := 'a' ;
--
  constant c_string_1 : string := "ABC0000" ;
  constant c_string_2 : string := "ABC1111" ;
  subtype  string_range1 is integer range lowb to highb ;
  subtype  st_string is string (string_range1) ;
  constant c_st_string_1 : st_string :=
                                     (others => c_character_1) ;
  constant c_st_string_2 : st_string :=
                                     (others => c_character_2) ;
-- user defined enumeration
  type     t_enum1 is (en1, en2, en3, en4) ;
  constant c_t_enum1_1 : t_enum1 := en1 ;
  constant c_t_enum1_2 : t_enum1 := en2 ;
  subtype  st_enum1 is t_enum1 range en4 downto en1 ;
  constant c_st_enum1_1 : st_enum1 := en1 ;
  constant c_st_enum1_2 : st_enum1 := en2 ;
--
  type     enum1_vector is array (integer range <>) of st_enum1 ;
  subtype  enum1_vector_range1 is integer range lowb to highb ;
  subtype  st_enum1_vector is enum1_vector (enum1_vector_range1) ;
  constant c_st_enum1_vector_1 : st_enum1_vector :=
                                     (others => c_st_enum1_1) ;
  constant c_st_enum1_vector_2 : st_enum1_vector :=
                                     (others => c_st_enum1_2) ;
-- integer types
-- predefined
  constant c_integer_1 : integer := lowb ;
  constant c_integer_2 : integer := highb ;
--
  type     integer_vector is array (integer range <>) of integer ;
  subtype  integer_vector_range1 is integer range lowb to highb ;
  subtype  st_integer_vector is integer_vector (integer_vector_range1) ;
  constant c_st_integer_vector_1 : st_integer_vector :=
                                     (others => c_integer_1) ;
  constant c_st_integer_vector_2 : st_integer_vector :=
                                     (others => c_integer_2) ;
--
-- user defined integer type
  type     t_int1 is range 0 to 100 ;
  constant c_t_int1_1 : t_int1 := 0 ;
  constant c_t_int1_2 : t_int1 := 10 ;
  subtype  st_int1 is t_int1 range 8 to 60 ;
  constant c_st_int1_1 : st_int1 := 8 ;
  constant c_st_int1_2 : st_int1 := 9 ;
--
  type     int1_vector is array (integer range <>) of st_int1 ;
  subtype  int1_vector_range1 is integer range lowb to highb ;
  subtype  st_int1_vector is int1_vector (int1_vector_range1) ;
  constant c_st_int1_vector_1 : st_int1_vector :=
                                     (others => c_st_int1_1) ;
  constant c_st_int1_vector_2 : st_int1_vector :=
                                     (others => c_st_int1_2) ;
--
-- physical types
-- predefined
  constant c_time_1 : time := 1 ns ;
  constant c_time_2 : time := 2 ns ;
--
  type     time_vector is array (integer range <>) of time ;
  subtype  time_vector_range1 is integer range lowb to highb ;
  subtype  st_time_vector is time_vector (time_vector_range1) ;
  constant c_st_time_vector_1 : st_time_vector :=
                                     (others => c_time_1) ;
  constant c_st_time_vector_2 : st_time_vector :=
                                     (others => c_time_2) ;
--
-- user defined physical type
  type     t_phys1 is range -100 to 1000
      units
         phys1_1 ;
         phys1_2 = 10 phys1_1 ;
         phys1_3 = 10 phys1_2 ;
         phys1_4 = 10 phys1_3 ;
         phys1_5 = 10 phys1_4 ;
      end units ;
--
  constant c_t_phys1_1 : t_phys1 := phys1_1 ;
  constant c_t_phys1_2 : t_phys1 := phys1_2 ;
  subtype  st_phys1 is t_phys1 range phys1_2 to phys1_4 ;
  constant c_st_phys1_1 : st_phys1 := phys1_2 ;
  constant c_st_phys1_2 : st_phys1 := phys1_3 ;
--
  type     phys1_vector is array (integer range <>) of st_phys1 ;
  subtype  phys1_vector_range1 is integer range lowb to highb ;
  subtype  st_phys1_vector is phys1_vector (phys1_vector_range1) ;
  constant c_st_phys1_vector_1 : st_phys1_vector :=
                                     (others => c_st_phys1_1) ;
  constant c_st_phys1_vector_2 : st_phys1_vector :=
                                     (others => c_st_phys1_2) ;
--
--
-- floating point types
-- predefined
  constant c_real_1 : real := 0.0 ;
  constant c_real_2 : real := 1.0 ;
--
  type     real_vector is array (integer range <>) of real ;
  subtype  real_vector_range1 is integer range lowb to highb ;
  subtype  st_real_vector is real_vector (real_vector_range1) ;
  constant c_st_real_vector_1 : st_real_vector :=
                                     (others => c_real_1) ;
  constant c_st_real_vector_2 : st_real_vector :=
                                     (others => c_real_2) ;
--
-- user defined floating type
  type     t_real1 is range 0.0 to 1000.0 ;
  constant c_t_real1_1 : t_real1 := 0.0 ;
  constant c_t_real1_2 : t_real1 := 1.0 ;
  subtype  st_real1 is t_real1 range 8.0 to 80.0 ;
  constant c_st_real1_1 : st_real1 := 8.0 ;
  constant c_st_real1_2 : st_real1 := 9.0 ;
--
  type     real1_vector is array (integer range <>) of st_real1 ;
  subtype  real1_vector_range1 is integer range lowb to highb ;
  subtype  st_real1_vector is real1_vector (real1_vector_range1) ;
  constant c_st_real1_vector_1 : st_real1_vector :=
                                     (others => c_st_real1_1) ;
  constant c_st_real1_vector_2 : st_real1_vector :=
                                     (others => c_st_real1_2) ;
-- composite types
--
-- simple record
  type     t_rec1 is record
              f1 : integer range lowb_i2 to highb_i2 ;
              f2 : time ;
              f3 : boolean ;
              f4 : real ;
           end record ;
  constant c_t_rec1_1 : t_rec1 :=
                          (c_integer_1, c_time_1, c_boolean_1, c_real_1) ;
  constant c_t_rec1_2 : t_rec1 :=
                          (c_integer_2, c_time_2, c_boolean_2, c_real_2) ;
  subtype  st_rec1 is t_rec1 ;
  constant c_st_rec1_1 : st_rec1 := c_t_rec1_1 ;
  constant c_st_rec1_2 : st_rec1 := c_t_rec1_2 ;
--
  type     rec1_vector is array (integer range <>) of st_rec1 ;
  subtype  rec1_vector_range1 is integer range lowb to highb ;
  subtype  st_rec1_vector is rec1_vector (rec1_vector_range1) ;
  constant c_st_rec1_vector_1 : st_rec1_vector :=
                                     (others => c_st_rec1_1) ;
  constant c_st_rec1_vector_2 : st_rec1_vector :=
                                     (others => c_st_rec1_2) ;
--
--
-- more complex record
  type     t_rec2 is record
              f1 : boolean ;
              f2 : st_rec1 ;
              f3 : time ;
           end record ;
  constant c_t_rec2_1 : t_rec2 :=
                          (c_boolean_1, c_st_rec1_1, c_time_1) ;
  constant c_t_rec2_2 : t_rec2 :=
                          (c_boolean_2, c_st_rec1_2, c_time_2) ;
  subtype  st_rec2 is t_rec2 ;
  constant c_st_rec2_1 : st_rec2 := c_t_rec2_1 ;
  constant c_st_rec2_2 : st_rec2 := c_t_rec2_2 ;
--
  type     rec2_vector is array (integer range <>) of st_rec2 ;
  subtype  rec2_vector_range1 is integer range lowb to highb ;
  subtype  st_rec2_vector is rec2_vector (rec2_vector_range1) ;
  constant c_st_rec2_vector_1 : st_rec2_vector :=
                                     (others => c_st_rec2_1) ;
  constant c_st_rec2_vector_2 : st_rec2_vector :=
                                     (others => c_st_rec2_2) ;
--
-- simple array
  type     t_arr1 is array (integer range <>) of st_int1 ;
  subtype  t_arr1_range1 is integer range lowb to highb ;
  subtype  st_arr1 is t_arr1 (t_arr1_range1) ;
  constant c_st_arr1_1 : st_arr1 := (others => c_st_int1_1) ;
  constant c_st_arr1_2 : st_arr1 := (others => c_st_int1_2) ;
  constant c_t_arr1_1  : st_arr1 := c_st_arr1_1 ;
  constant c_t_arr1_2  : st_arr1 := c_st_arr1_2 ;
--
  type     arr1_vector is array (integer range <>) of st_arr1 ;
  subtype  arr1_vector_range1 is integer range lowb to highb ;
  subtype  st_arr1_vector is arr1_vector (arr1_vector_range1) ;
  constant c_st_arr1_vector_1 : st_arr1_vector :=
                                     (others => c_st_arr1_1) ;
  constant c_st_arr1_vector_2 : st_arr1_vector :=
                                     (others => c_st_arr1_2) ;
-- more complex array
  type     t_arr2 is array (integer range <>, boolean range <>) of st_arr1 ;
  subtype  t_arr2_range1 is integer range lowb to highb ;
  subtype  t_arr2_range2 is boolean range false to true ;
  subtype  st_arr2 is t_arr2 (t_arr2_range1, t_arr2_range2);
  constant c_st_arr2_1 : st_arr2 := (others => (others => c_st_arr1_1)) ;
  constant c_st_arr2_2 : st_arr2 := (others => (others => c_st_arr1_2)) ;
  constant c_t_arr2_1  : st_arr2 := c_st_arr2_1 ;
  constant c_t_arr2_2  : st_arr2 := c_st_arr2_2 ;
--
  type     arr2_vector is array (integer range <>) of st_arr2 ;
  subtype  arr2_vector_range1 is integer range lowb to highb ;
  subtype  st_arr2_vector is arr2_vector (arr2_vector_range1) ;
  constant c_st_arr2_vector_1 : st_arr2_vector :=
                                     (others => c_st_arr2_1) ;
  constant c_st_arr2_vector_2 : st_arr2_vector :=
                                     (others => c_st_arr2_2) ;
--
--
-- most complex record
  type     t_rec3 is record
              f1 : boolean ;
              f2 : st_rec2 ;
              f3 : st_arr2 ;
           end record ;
  constant c_t_rec3_1 : t_rec3 :=
                          (c_boolean_1, c_st_rec2_1, c_st_arr2_1) ;
  constant c_t_rec3_2 : t_rec3 :=
                          (c_boolean_2, c_st_rec2_2, c_st_arr2_2) ;
  subtype  st_rec3 is t_rec3 ;
  constant c_st_rec3_1 : st_rec3 := c_t_rec3_1 ;
  constant c_st_rec3_2 : st_rec3 := c_t_rec3_2 ;
--
  type     rec3_vector is array (integer range <>) of st_rec3 ;
  subtype  rec3_vector_range1 is integer range lowb to highb ;
  subtype  st_rec3_vector is rec3_vector (rec3_vector_range1) ;
  constant c_st_rec3_vector_1 : st_rec3_vector :=
                                     (others => c_st_rec3_1) ;
  constant c_st_rec3_vector_2 : st_rec3_vector :=
                                     (others => c_st_rec3_2) ;
--
-- most complex array
  type     t_arr3 is array (integer range <>, boolean range <>) of st_rec3 ;
  subtype  t_arr3_range1 is integer range lowb to highb ;
  subtype  t_arr3_range2 is boolean range true downto false ;
  subtype  st_arr3 is t_arr3 (t_arr3_range1, t_arr3_range2) ;
  constant c_st_arr3_1 : st_arr3 := (others => (others => c_st_rec3_1)) ;
  constant c_st_arr3_2 : st_arr3 := (others => (others => c_st_rec3_2)) ;
  constant c_t_arr3_1  : st_arr3 := c_st_arr3_1 ;
  constant c_t_arr3_2  : st_arr3 := c_st_arr3_2 ;
--
  type     arr3_vector is array (integer range <>) of st_arr3 ;
  subtype  arr3_vector_range1 is integer range lowb to highb ;
  subtype  st_arr3_vector is arr3_vector (arr3_vector_range1) ;
  constant c_st_arr3_vector_1 : st_arr3_vector :=
                                     (others => c_st_arr3_1) ;
  constant c_st_arr3_vector_2 : st_arr3_vector :=
                                     (others => c_st_arr3_2) ;
--
-- enumeration types
-- predefined
-- boolean
  function bf_boolean(to_resolve : boolean_vector) return boolean is
    variable sum : integer := 0 ;
  begin
    if to_resolve'length = 0 then
       return boolean'left ;
    else
       for i in to_resolve'range loop
          sum := sum + boolean'pos(to_resolve(i)) ;
       end loop ;
       return boolean'val(integer'pos(sum) mod
                         (boolean'pos(boolean'high) + 1)) ;
    end if ;
  end bf_boolean ;
--
--
-- bit
  function bf_bit(to_resolve : bit_vector) return bit is
    variable sum : integer := 0 ;
  begin
    if to_resolve'length = 0 then
       return bit'left ;
    else
       for i in to_resolve'range loop
          sum := sum + bit'pos(to_resolve(i)) ;
       end loop ;
       return bit'val(integer'pos(sum) mod
                     (bit'pos(bit'high) + 1)) ;
    end if ;
  end bf_bit ;
--
-- severity_level
  function bf_severity_level(to_resolve : severity_level_vector)
    return severity_level is
    variable sum : integer := 0 ;
  begin
    if to_resolve'length = 0 then
       return severity_level'left ;
    else
       for i in to_resolve'range loop
          sum := sum + severity_level'pos(to_resolve(i)) ;
       end loop ;
       return severity_level'val(integer'pos(sum) mod
                                (severity_level'pos(severity_level'high) + 1)) ;
    end if ;
  end bf_severity_level ;
--
-- character
  function bf_character(to_resolve : string) return character is
    variable sum : integer := 0 ;
  begin
    if to_resolve'length = 0 then
       return character'left ;
    else
       for i in to_resolve'range loop
          sum := sum + character'pos(to_resolve(i)) ;
       end loop ;
       return character'val(integer'pos(sum) mod
                           (character'pos(character'high) + 1)) ;
    end if ;
  end bf_character ;
--
--
-- user defined enumeration
  function bf_enum1(to_resolve : enum1_vector) return st_enum1 is
    variable sum : integer := 0 ;
  begin
    if to_resolve'length = 0 then
       return st_enum1'left ;
    else
       for i in to_resolve'range loop
         sum := sum + t_enum1'pos(to_resolve(i)) ;
       end loop ;
       return t_enum1'val(integer'pos(sum) mod
                         (t_enum1'pos(t_enum1'high) + 1)) ;
    end if ;
  end bf_enum1 ;
--
--
-- integer types
-- predefined
  function bf_integer(to_resolve : integer_vector) return integer is
    variable sum : integer := 0 ;
  begin
    if to_resolve'length = 0 then
       return integer'left ;
    else
       for i in to_resolve'range loop
          sum := sum + integer'pos(to_resolve(i)) ;
       end loop ;
       return sum ;
    end if ;
  end bf_integer ;
--
--
-- user defined integer type
  function bf_int1(to_resolve : int1_vector) return st_int1 is
    variable sum : integer := 0 ;
  begin
    if to_resolve'length = 0 then
       return st_int1'left ;
    else
       for i in to_resolve'range loop
          sum := sum + t_int1'pos(to_resolve(i)) ;
       end loop ;
       return t_int1'val(integer'pos(sum) mod
                        (t_int1'pos(t_int1'high) + 1)) ;
    end if ;
  end bf_int1 ;
--
--
-- physical types
-- predefined
  function bf_time(to_resolve : time_vector) return time is
    variable sum : time := 0 fs;
  begin
    if to_resolve'length = 0 then
       return time'left ;
    else
       for i in to_resolve'range loop
          sum := sum + to_resolve(i) ;
       end loop ;
       return sum ;
    end if ;
  end bf_time ;
--
--
-- user defined physical type
  function bf_phys1(to_resolve : phys1_vector) return st_phys1 is
    variable sum : integer := 0 ;
  begin
    if to_resolve'length = 0 then
       return c_st_phys1_1 ;
    else
       for i in to_resolve'range loop
          sum := sum + t_phys1'pos(to_resolve(i)) ;
       end loop ;
       return t_phys1'val(integer'pos(sum) mod
                         (t_phys1'pos(t_phys1'high) + 1)) ;
    end if ;
  end bf_phys1 ;
--
--
-- floating point types
-- predefined
  function bf_real(to_resolve : real_vector) return real is
    variable sum : real := 0.0 ;
  begin
    if to_resolve'length = 0 then
       return real'left ;
    else
       for i in to_resolve'range loop
          sum := sum + to_resolve(i) ;
       end loop ;
       return sum ;
    end if ;
  end bf_real ;
--
--
-- user defined floating type
  function bf_real1(to_resolve : real1_vector) return st_real1 is
    variable sum : t_real1 := 0.0 ;
  begin
    if to_resolve'length = 0 then
       return c_st_real1_1 ;
    else
       for i in to_resolve'range loop
          sum := sum + to_resolve(i) ;
       end loop ;
       return sum ;
    end if ;
  end bf_real1 ;
--
--
-- composite types
--
-- simple record
  function bf_rec1(to_resolve : rec1_vector) return st_rec1 is
    variable f1array : integer_vector (to_resolve'range) ;
    variable f2array : time_vector (to_resolve'range) ;
    variable f3array : boolean_vector (to_resolve'range) ;
    variable f4array : real_vector (to_resolve'range) ;
    variable result : st_rec1 ;
  begin
    if to_resolve'length = 0 then
       return c_st_rec1_1 ;
    else
       for i in to_resolve'range loop
          f1array(i) := to_resolve(i).f1 ;
          f2array(i) := to_resolve(i).f2 ;
          f3array(i) := to_resolve(i).f3 ;
          f4array(i) := to_resolve(i).f4 ;
       end loop ;
       result.f1 := bf_integer(f1array) ;
       result.f2 := bf_time(f2array) ;
       result.f3 := bf_boolean(f3array) ;
       result.f4 := bf_real(f4array) ;
       return result ;
    end if ;
  end bf_rec1 ;
--
--
-- more complex record
  function bf_rec2(to_resolve : rec2_vector) return st_rec2 is
    variable f1array : boolean_vector (to_resolve'range) ;
    variable f2array : rec1_vector (to_resolve'range) ;
    variable f3array : time_vector (to_resolve'range) ;
    variable result : st_rec2 ;
  begin
    if to_resolve'length = 0 then
       return c_st_rec2_1 ;
    else
       for i in to_resolve'range loop
          f1array(i) := to_resolve(i).f1 ;
          f2array(i) := to_resolve(i).f2 ;
          f3array(i) := to_resolve(i).f3 ;
       end loop ;
       result.f1 := bf_boolean(f1array) ;
       result.f2 := bf_rec1(f2array) ;
       result.f3 := bf_time(f3array) ;
       return result ;
    end if ;
  end bf_rec2 ;
--
--
-- simple array
  function bf_arr1(to_resolve : arr1_vector) return st_arr1 is
    variable temp : int1_vector (to_resolve'range) ;
    variable result : st_arr1 ;
  begin
    if to_resolve'length = 0 then
       return c_st_arr1_1 ;
    else
       for i in st_arr1'range loop
          for j in to_resolve'range(1) loop
             temp(j) := to_resolve(j)(i) ;
          end loop;
          result(i) := bf_int1(temp) ;
       end loop ;
       return result ;
    end if ;
  end bf_arr1 ;
--
--
-- more complex array
  function bf_arr2(to_resolve : arr2_vector) return st_arr2 is
    variable temp : arr1_vector (to_resolve'range) ;
    variable result : st_arr2 ;
  begin
    if to_resolve'length = 0 then
       return c_st_arr2_1 ;
    else
       for i in st_arr2'range(1) loop
          for j in st_arr2'range(2) loop
             for k in to_resolve'range loop
                temp(k) := to_resolve(k)(i,j) ;
             end loop ;
             result(i, j) := bf_arr1(temp) ;
          end loop ;
       end loop ;
       return result ;
    end if ;
  end bf_arr2 ;
--
--
-- most complex record
  function bf_rec3(to_resolve : rec3_vector) return st_rec3 is
    variable f1array : boolean_vector (to_resolve'range) ;
    variable f2array : rec2_vector (to_resolve'range) ;
    variable f3array : arr2_vector (to_resolve'range) ;
    variable result : st_rec3 ;
  begin
    if to_resolve'length = 0 then
       return c_st_rec3_1 ;
    else
       for i in to_resolve'range loop
          f1array(i) := to_resolve(i).f1 ;
          f2array(i) := to_resolve(i).f2 ;
          f3array(i) := to_resolve(i).f3 ;
       end loop ;
       result.f1 := bf_boolean(f1array) ;
       result.f2 := bf_rec2(f2array) ;
       result.f3 := bf_arr2(f3array) ;
       return result ;
    end if ;
  end bf_rec3 ;
--
--
-- most complex array
  function bf_arr3(to_resolve : arr3_vector) return st_arr3 is
    variable temp : rec3_vector (to_resolve'range) ;
    variable result : st_arr3 ;
  begin
    if to_resolve'length = 0 then
       return c_st_arr3_1 ;
    else
       for i in st_arr3'range(1) loop
          for j in st_arr3'range(2) loop
             for k in to_resolve'range loop
                temp(k) := to_resolve(k)(i,j) ;
             end loop ;
             result(i, j) := bf_rec3(temp) ;
          end loop ;
       end loop ;
       return result ;
    end if ;
  end bf_arr3 ;
--
      variable va_st_bit_vector_1 : st_bit_vector
           := c_st_bit_vector_1 ;
      variable va_st_string_1 : st_string
           := c_st_string_1 ;
      variable va_st_rec1_1 : st_rec1
           := c_st_rec1_1 ;
      variable va_st_rec2_1 : st_rec2
           := c_st_rec2_1 ;
      variable va_st_rec3_1 : st_rec3
           := c_st_rec3_1 ;
      variable va_st_arr1_1 : st_arr1
           := c_st_arr1_1 ;
      variable va_st_arr2_1 : st_arr2
           := c_st_arr2_1 ;
      variable va_st_arr3_1 : st_arr3
           := c_st_arr3_1 ;
   begin
      correct := correct and va_st_bit_vector_1 = c_st_bit_vector_1 ;
      correct := correct and va_st_string_1 = c_st_string_1 ;
      correct := correct and va_st_rec1_1 = c_st_rec1_1 ;
      correct := correct and va_st_rec2_1 = c_st_rec2_1 ;
      correct := correct and va_st_rec3_1 = c_st_rec3_1 ;
      correct := correct and va_st_arr1_1 = c_st_arr1_1 ;
      correct := correct and va_st_arr2_1 = c_st_arr2_1 ;
      correct := correct and va_st_arr3_1 = c_st_arr3_1 ;
      va_st_bit_vector_1 := c_st_bit_vector_2 ;
      va_st_string_1 := c_st_string_2 ;
      va_st_rec1_1 := c_st_rec1_2 ;
      va_st_rec2_1 := c_st_rec2_2 ;
      va_st_rec3_1 := c_st_rec3_2 ;
      va_st_arr1_1 := c_st_arr1_2 ;
      va_st_arr2_1 := c_st_arr2_2 ;
      va_st_arr3_1 := c_st_arr3_2 ;
      correct := correct and va_st_bit_vector_1 = c_st_bit_vector_2 ;
      correct := correct and va_st_string_1 = c_st_string_2 ;
      correct := correct and va_st_rec1_1 = c_st_rec1_2 ;
      correct := correct and va_st_rec2_1 = c_st_rec2_2 ;
      correct := correct and va_st_rec3_1 = c_st_rec3_2 ;
      correct := correct and va_st_arr1_1 = c_st_arr1_2 ;
      correct := correct and va_st_arr2_1 = c_st_arr2_2 ;
      correct := correct and va_st_arr3_1 = c_st_arr3_2 ;
      test_report ( "ARCH00560" ,
     "Variable declarations - composite dynamic subtypes" ,
      correct) ;
   end p1 ;
begin
   process
   begin
      p1 ;
      wait ;
   end process ;
end ARCH00560 ;
--
entity ENT00560_Test_Bench is
end ENT00560_Test_Bench ;
--
architecture ARCH00560_Test_Bench of ENT00560_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00560 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00560_Test_Bench ;
