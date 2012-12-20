-- NEED RESULT: ARCH00035.P1: Target of a variable assignment may be a aggregate of slices passed
-- NEED RESULT: ARCH00035.P2: Target of a variable assignment may be a aggregate of slices passed
-- NEED RESULT: ARCH00035.P3: Target of a variable assignment may be a aggregate of slices passed
-- NEED RESULT: ARCH00035.P4: Target of a variable assignment may be a aggregate of slices passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00035
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.4 (1)
--    8.4 (3)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00035)
--    ENT00035_Test_Bench(ARCH00035_Test_Bench)
--
-- REVISION HISTORY:
--
--    29-JUN-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00035 of E00000 is
   signal Dummy : Boolean := false ;
--
begin
   P1 :
   process ( Dummy )
      type arr_st_boolean_vector is
        array (integer range -1 downto - 3 ) of
          st_boolean_vector ;
      type arr_st_bit_vector is
        array (integer range -1 downto - 3 ) of
          st_bit_vector ;
      type arr_st_severity_level_vector is
        array (integer range -1 downto - 3 ) of
          st_severity_level_vector ;
      type arr_st_string is
        array (integer range -1 downto - 3 ) of
          st_string ;
      type arr_st_enum1_vector is
        array (integer range -1 downto - 3 ) of
          st_enum1_vector ;
      type arr_st_integer_vector is
        array (integer range -1 downto - 3 ) of
          st_integer_vector ;
      type arr_st_int1_vector is
        array (integer range -1 downto - 3 ) of
          st_int1_vector ;
      type arr_st_time_vector is
        array (integer range -1 downto - 3 ) of
          st_time_vector ;
      type arr_st_phys1_vector is
        array (integer range -1 downto - 3 ) of
          st_phys1_vector ;
      type arr_st_real_vector is
        array (integer range -1 downto - 3 ) of
          st_real_vector ;
      type arr_st_real1_vector is
        array (integer range -1 downto - 3 ) of
          st_real1_vector ;
      type arr_st_rec1_vector is
        array (integer range -1 downto - 3 ) of
          st_rec1_vector ;
      type arr_st_rec2_vector is
        array (integer range -1 downto - 3 ) of
          st_rec2_vector ;
      type arr_st_rec3_vector is
        array (integer range -1 downto - 3 ) of
          st_rec3_vector ;
      type arr_st_arr1_vector is
        array (integer range -1 downto - 3 ) of
          st_arr1_vector ;
      type arr_st_arr2_vector is
        array (integer range -1 downto - 3 ) of
          st_arr2_vector ;
      type arr_st_arr3_vector is
        array (integer range -1 downto - 3 ) of
          st_arr3_vector ;
--
      variable v_st_boolean_vector_1 : st_boolean_vector :=
          c_st_boolean_vector_1 ;
      variable v_st_bit_vector_1 : st_bit_vector :=
          c_st_bit_vector_1 ;
      variable v_st_severity_level_vector_1 : st_severity_level_vector :=
          c_st_severity_level_vector_1 ;
      variable v_st_string_1 : st_string :=
          c_st_string_1 ;
      variable v_st_enum1_vector_1 : st_enum1_vector :=
          c_st_enum1_vector_1 ;
      variable v_st_integer_vector_1 : st_integer_vector :=
          c_st_integer_vector_1 ;
      variable v_st_int1_vector_1 : st_int1_vector :=
          c_st_int1_vector_1 ;
      variable v_st_time_vector_1 : st_time_vector :=
          c_st_time_vector_1 ;
      variable v_st_phys1_vector_1 : st_phys1_vector :=
          c_st_phys1_vector_1 ;
      variable v_st_real_vector_1 : st_real_vector :=
          c_st_real_vector_1 ;
      variable v_st_real1_vector_1 : st_real1_vector :=
          c_st_real1_vector_1 ;
      variable v_st_rec1_vector_1 : st_rec1_vector :=
          c_st_rec1_vector_1 ;
      variable v_st_rec2_vector_1 : st_rec2_vector :=
          c_st_rec2_vector_1 ;
      variable v_st_rec3_vector_1 : st_rec3_vector :=
          c_st_rec3_vector_1 ;
      variable v_st_arr1_vector_1 : st_arr1_vector :=
          c_st_arr1_vector_1 ;
      variable v_st_arr2_vector_1 : st_arr2_vector :=
          c_st_arr2_vector_1 ;
      variable v_st_arr3_vector_1 : st_arr3_vector :=
          c_st_arr3_vector_1 ;
--
      variable v_st_boolean_vector_2 : st_boolean_vector :=
          c_st_boolean_vector_1 ;
      variable v_st_bit_vector_2 : st_bit_vector :=
          c_st_bit_vector_1 ;
      variable v_st_severity_level_vector_2 : st_severity_level_vector :=
          c_st_severity_level_vector_1 ;
      variable v_st_string_2 : st_string :=
          c_st_string_1 ;
      variable v_st_enum1_vector_2 : st_enum1_vector :=
          c_st_enum1_vector_1 ;
      variable v_st_integer_vector_2 : st_integer_vector :=
          c_st_integer_vector_1 ;
      variable v_st_int1_vector_2 : st_int1_vector :=
          c_st_int1_vector_1 ;
      variable v_st_time_vector_2 : st_time_vector :=
          c_st_time_vector_1 ;
      variable v_st_phys1_vector_2 : st_phys1_vector :=
          c_st_phys1_vector_1 ;
      variable v_st_real_vector_2 : st_real_vector :=
          c_st_real_vector_1 ;
      variable v_st_real1_vector_2 : st_real1_vector :=
          c_st_real1_vector_1 ;
      variable v_st_rec1_vector_2 : st_rec1_vector :=
          c_st_rec1_vector_1 ;
      variable v_st_rec2_vector_2 : st_rec2_vector :=
          c_st_rec2_vector_1 ;
      variable v_st_rec3_vector_2 : st_rec3_vector :=
          c_st_rec3_vector_1 ;
      variable v_st_arr1_vector_2 : st_arr1_vector :=
          c_st_arr1_vector_1 ;
      variable v_st_arr2_vector_2 : st_arr2_vector :=
          c_st_arr2_vector_1 ;
      variable v_st_arr3_vector_2 : st_arr3_vector :=
          c_st_arr3_vector_1 ;
--
      variable v_st_boolean_vector_3 : st_boolean_vector :=
          c_st_boolean_vector_1 ;
      variable v_st_bit_vector_3 : st_bit_vector :=
          c_st_bit_vector_1 ;
      variable v_st_severity_level_vector_3 : st_severity_level_vector :=
          c_st_severity_level_vector_1 ;
      variable v_st_string_3 : st_string :=
          c_st_string_1 ;
      variable v_st_enum1_vector_3 : st_enum1_vector :=
          c_st_enum1_vector_1 ;
      variable v_st_integer_vector_3 : st_integer_vector :=
          c_st_integer_vector_1 ;
      variable v_st_int1_vector_3 : st_int1_vector :=
          c_st_int1_vector_1 ;
      variable v_st_time_vector_3 : st_time_vector :=
          c_st_time_vector_1 ;
      variable v_st_phys1_vector_3 : st_phys1_vector :=
          c_st_phys1_vector_1 ;
      variable v_st_real_vector_3 : st_real_vector :=
          c_st_real_vector_1 ;
      variable v_st_real1_vector_3 : st_real1_vector :=
          c_st_real1_vector_1 ;
      variable v_st_rec1_vector_3 : st_rec1_vector :=
          c_st_rec1_vector_1 ;
      variable v_st_rec2_vector_3 : st_rec2_vector :=
          c_st_rec2_vector_1 ;
      variable v_st_rec3_vector_3 : st_rec3_vector :=
          c_st_rec3_vector_1 ;
      variable v_st_arr1_vector_3 : st_arr1_vector :=
          c_st_arr1_vector_1 ;
      variable v_st_arr2_vector_3 : st_arr2_vector :=
          c_st_arr2_vector_1 ;
      variable v_st_arr3_vector_3 : st_arr3_vector :=
          c_st_arr3_vector_1 ;
--
      variable correct : boolean := true ;
   begin
      (
        v_st_boolean_vector_1(lowb to highb)
      , v_st_boolean_vector_2(lowb to highb)
      , v_st_boolean_vector_3(lowb to highb)
      ) :=
           arr_st_boolean_vector ' (
           (others => c_st_boolean_vector_2(lowb to highb))) ;
--
      (
        v_st_bit_vector_1(lowb to highb)
      , v_st_bit_vector_2(lowb to highb)
      , v_st_bit_vector_3(lowb to highb)
      ) :=
           arr_st_bit_vector ' (
           (others => c_st_bit_vector_2(lowb to highb))) ;
--
      (
        v_st_severity_level_vector_1(lowb to highb)
      , v_st_severity_level_vector_2(lowb to highb)
      , v_st_severity_level_vector_3(lowb to highb)
      ) :=
           arr_st_severity_level_vector ' (
           (others => c_st_severity_level_vector_2(lowb to highb))) ;
--
      (
        v_st_string_1(lowb to highb)
      , v_st_string_2(lowb to highb)
      , v_st_string_3(lowb to highb)
      ) :=
           arr_st_string ' (
           (others => c_st_string_2(lowb to highb))) ;
--
      (
        v_st_enum1_vector_1(lowb to highb)
      , v_st_enum1_vector_2(lowb to highb)
      , v_st_enum1_vector_3(lowb to highb)
      ) :=
           arr_st_enum1_vector ' (
           (others => c_st_enum1_vector_2(lowb to highb))) ;
--
      (
        v_st_integer_vector_1(lowb to highb)
      , v_st_integer_vector_2(lowb to highb)
      , v_st_integer_vector_3(lowb to highb)
      ) :=
           arr_st_integer_vector ' (
           (others => c_st_integer_vector_2(lowb to highb))) ;
--
      (
        v_st_int1_vector_1(lowb to highb)
      , v_st_int1_vector_2(lowb to highb)
      , v_st_int1_vector_3(lowb to highb)
      ) :=
           arr_st_int1_vector ' (
           (others => c_st_int1_vector_2(lowb to highb))) ;
--
      (
        v_st_time_vector_1(lowb to highb)
      , v_st_time_vector_2(lowb to highb)
      , v_st_time_vector_3(lowb to highb)
      ) :=
           arr_st_time_vector ' (
           (others => c_st_time_vector_2(lowb to highb))) ;
--
      (
        v_st_phys1_vector_1(lowb to highb)
      , v_st_phys1_vector_2(lowb to highb)
      , v_st_phys1_vector_3(lowb to highb)
      ) :=
           arr_st_phys1_vector ' (
           (others => c_st_phys1_vector_2(lowb to highb))) ;
--
      (
        v_st_real_vector_1(lowb to highb)
      , v_st_real_vector_2(lowb to highb)
      , v_st_real_vector_3(lowb to highb)
      ) :=
           arr_st_real_vector ' (
           (others => c_st_real_vector_2(lowb to highb))) ;
--
      (
        v_st_real1_vector_1(lowb to highb)
      , v_st_real1_vector_2(lowb to highb)
      , v_st_real1_vector_3(lowb to highb)
      ) :=
           arr_st_real1_vector ' (
           (others => c_st_real1_vector_2(lowb to highb))) ;
--
      (
        v_st_rec1_vector_1(lowb to highb)
      , v_st_rec1_vector_2(lowb to highb)
      , v_st_rec1_vector_3(lowb to highb)
      ) :=
           arr_st_rec1_vector ' (
           (others => c_st_rec1_vector_2(lowb to highb))) ;
--
      (
        v_st_rec2_vector_1(lowb to highb)
      , v_st_rec2_vector_2(lowb to highb)
      , v_st_rec2_vector_3(lowb to highb)
      ) :=
           arr_st_rec2_vector ' (
           (others => c_st_rec2_vector_2(lowb to highb))) ;
--
      (
        v_st_rec3_vector_1(lowb to highb)
      , v_st_rec3_vector_2(lowb to highb)
      , v_st_rec3_vector_3(lowb to highb)
      ) :=
           arr_st_rec3_vector ' (
           (others => c_st_rec3_vector_2(lowb to highb))) ;
--
      (
        v_st_arr1_vector_1(lowb to highb)
      , v_st_arr1_vector_2(lowb to highb)
      , v_st_arr1_vector_3(lowb to highb)
      ) :=
           arr_st_arr1_vector ' (
           (others => c_st_arr1_vector_2(lowb to highb))) ;
--
      (
        v_st_arr2_vector_1(lowb to highb)
      , v_st_arr2_vector_2(lowb to highb)
      , v_st_arr2_vector_3(lowb to highb)
      ) :=
           arr_st_arr2_vector ' (
           (others => c_st_arr2_vector_2(lowb to highb))) ;
--
      (
        v_st_arr3_vector_1(lowb to highb)
      , v_st_arr3_vector_2(lowb to highb)
      , v_st_arr3_vector_3(lowb to highb)
      ) :=
           arr_st_arr3_vector ' (
           (others => c_st_arr3_vector_2(lowb to highb))) ;
--
--
      correct := correct and
                 v_st_boolean_vector_1(lowb to highb) =
                 c_st_boolean_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_bit_vector_1(lowb to highb) =
                 c_st_bit_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_severity_level_vector_1(lowb to highb) =
                 c_st_severity_level_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_string_1(lowb to highb) =
                 c_st_string_2(lowb to highb) ;
      correct := correct and
                 v_st_enum1_vector_1(lowb to highb) =
                 c_st_enum1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_integer_vector_1(lowb to highb) =
                 c_st_integer_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_int1_vector_1(lowb to highb) =
                 c_st_int1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_time_vector_1(lowb to highb) =
                 c_st_time_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_phys1_vector_1(lowb to highb) =
                 c_st_phys1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_real_vector_1(lowb to highb) =
                 c_st_real_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_real1_vector_1(lowb to highb) =
                 c_st_real1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec1_vector_1(lowb to highb) =
                 c_st_rec1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec2_vector_1(lowb to highb) =
                 c_st_rec2_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec3_vector_1(lowb to highb) =
                 c_st_rec3_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr1_vector_1(lowb to highb) =
                 c_st_arr1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr2_vector_1(lowb to highb) =
                 c_st_arr2_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr3_vector_1(lowb to highb) =
                 c_st_arr3_vector_2(lowb to highb) ;
--
      correct := correct and
                 v_st_boolean_vector_2(lowb to highb) =
                 c_st_boolean_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_bit_vector_2(lowb to highb) =
                 c_st_bit_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_severity_level_vector_2(lowb to highb) =
                 c_st_severity_level_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_string_2(lowb to highb) =
                 c_st_string_2(lowb to highb) ;
      correct := correct and
                 v_st_enum1_vector_2(lowb to highb) =
                 c_st_enum1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_integer_vector_2(lowb to highb) =
                 c_st_integer_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_int1_vector_2(lowb to highb) =
                 c_st_int1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_time_vector_2(lowb to highb) =
                 c_st_time_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_phys1_vector_2(lowb to highb) =
                 c_st_phys1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_real_vector_2(lowb to highb) =
                 c_st_real_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_real1_vector_2(lowb to highb) =
                 c_st_real1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec1_vector_2(lowb to highb) =
                 c_st_rec1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec2_vector_2(lowb to highb) =
                 c_st_rec2_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec3_vector_2(lowb to highb) =
                 c_st_rec3_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr1_vector_2(lowb to highb) =
                 c_st_arr1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr2_vector_2(lowb to highb) =
                 c_st_arr2_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr3_vector_2(lowb to highb) =
                 c_st_arr3_vector_2(lowb to highb) ;
--
      correct := correct and
                 v_st_boolean_vector_3(lowb to highb) =
                 c_st_boolean_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_bit_vector_3(lowb to highb) =
                 c_st_bit_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_severity_level_vector_3(lowb to highb) =
                 c_st_severity_level_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_string_3(lowb to highb) =
                 c_st_string_2(lowb to highb) ;
      correct := correct and
                 v_st_enum1_vector_3(lowb to highb) =
                 c_st_enum1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_integer_vector_3(lowb to highb) =
                 c_st_integer_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_int1_vector_3(lowb to highb) =
                 c_st_int1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_time_vector_3(lowb to highb) =
                 c_st_time_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_phys1_vector_3(lowb to highb) =
                 c_st_phys1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_real_vector_3(lowb to highb) =
                 c_st_real_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_real1_vector_3(lowb to highb) =
                 c_st_real1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec1_vector_3(lowb to highb) =
                 c_st_rec1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec2_vector_3(lowb to highb) =
                 c_st_rec2_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec3_vector_3(lowb to highb) =
                 c_st_rec3_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr1_vector_3(lowb to highb) =
                 c_st_arr1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr2_vector_3(lowb to highb) =
                 c_st_arr2_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr3_vector_3(lowb to highb) =
                 c_st_arr3_vector_2(lowb to highb) ;
--
      test_report ( "ARCH00035.P1" ,
                    "Target of a variable assignment may be a " &
                    "aggregate of slices" ,
                    correct) ;
   end process P1 ;
--
   P2 :
   process ( Dummy )
      variable correct : boolean := true ;
--
      procedure Proc1 is
      type arr_st_boolean_vector is
        array (integer range -1 downto - 3 ) of
          st_boolean_vector ;
      type arr_st_bit_vector is
        array (integer range -1 downto - 3 ) of
          st_bit_vector ;
      type arr_st_severity_level_vector is
        array (integer range -1 downto - 3 ) of
          st_severity_level_vector ;
      type arr_st_string is
        array (integer range -1 downto - 3 ) of
          st_string ;
      type arr_st_enum1_vector is
        array (integer range -1 downto - 3 ) of
          st_enum1_vector ;
      type arr_st_integer_vector is
        array (integer range -1 downto - 3 ) of
          st_integer_vector ;
      type arr_st_int1_vector is
        array (integer range -1 downto - 3 ) of
          st_int1_vector ;
      type arr_st_time_vector is
        array (integer range -1 downto - 3 ) of
          st_time_vector ;
      type arr_st_phys1_vector is
        array (integer range -1 downto - 3 ) of
          st_phys1_vector ;
      type arr_st_real_vector is
        array (integer range -1 downto - 3 ) of
          st_real_vector ;
      type arr_st_real1_vector is
        array (integer range -1 downto - 3 ) of
          st_real1_vector ;
      type arr_st_rec1_vector is
        array (integer range -1 downto - 3 ) of
          st_rec1_vector ;
      type arr_st_rec2_vector is
        array (integer range -1 downto - 3 ) of
          st_rec2_vector ;
      type arr_st_rec3_vector is
        array (integer range -1 downto - 3 ) of
          st_rec3_vector ;
      type arr_st_arr1_vector is
        array (integer range -1 downto - 3 ) of
          st_arr1_vector ;
      type arr_st_arr2_vector is
        array (integer range -1 downto - 3 ) of
          st_arr2_vector ;
      type arr_st_arr3_vector is
        array (integer range -1 downto - 3 ) of
          st_arr3_vector ;
--
      variable v_st_boolean_vector_1 : st_boolean_vector :=
          c_st_boolean_vector_1 ;
      variable v_st_bit_vector_1 : st_bit_vector :=
          c_st_bit_vector_1 ;
      variable v_st_severity_level_vector_1 : st_severity_level_vector :=
          c_st_severity_level_vector_1 ;
      variable v_st_string_1 : st_string :=
          c_st_string_1 ;
      variable v_st_enum1_vector_1 : st_enum1_vector :=
          c_st_enum1_vector_1 ;
      variable v_st_integer_vector_1 : st_integer_vector :=
          c_st_integer_vector_1 ;
      variable v_st_int1_vector_1 : st_int1_vector :=
          c_st_int1_vector_1 ;
      variable v_st_time_vector_1 : st_time_vector :=
          c_st_time_vector_1 ;
      variable v_st_phys1_vector_1 : st_phys1_vector :=
          c_st_phys1_vector_1 ;
      variable v_st_real_vector_1 : st_real_vector :=
          c_st_real_vector_1 ;
      variable v_st_real1_vector_1 : st_real1_vector :=
          c_st_real1_vector_1 ;
      variable v_st_rec1_vector_1 : st_rec1_vector :=
          c_st_rec1_vector_1 ;
      variable v_st_rec2_vector_1 : st_rec2_vector :=
          c_st_rec2_vector_1 ;
      variable v_st_rec3_vector_1 : st_rec3_vector :=
          c_st_rec3_vector_1 ;
      variable v_st_arr1_vector_1 : st_arr1_vector :=
          c_st_arr1_vector_1 ;
      variable v_st_arr2_vector_1 : st_arr2_vector :=
          c_st_arr2_vector_1 ;
      variable v_st_arr3_vector_1 : st_arr3_vector :=
          c_st_arr3_vector_1 ;
--
      variable v_st_boolean_vector_2 : st_boolean_vector :=
          c_st_boolean_vector_1 ;
      variable v_st_bit_vector_2 : st_bit_vector :=
          c_st_bit_vector_1 ;
      variable v_st_severity_level_vector_2 : st_severity_level_vector :=
          c_st_severity_level_vector_1 ;
      variable v_st_string_2 : st_string :=
          c_st_string_1 ;
      variable v_st_enum1_vector_2 : st_enum1_vector :=
          c_st_enum1_vector_1 ;
      variable v_st_integer_vector_2 : st_integer_vector :=
          c_st_integer_vector_1 ;
      variable v_st_int1_vector_2 : st_int1_vector :=
          c_st_int1_vector_1 ;
      variable v_st_time_vector_2 : st_time_vector :=
          c_st_time_vector_1 ;
      variable v_st_phys1_vector_2 : st_phys1_vector :=
          c_st_phys1_vector_1 ;
      variable v_st_real_vector_2 : st_real_vector :=
          c_st_real_vector_1 ;
      variable v_st_real1_vector_2 : st_real1_vector :=
          c_st_real1_vector_1 ;
      variable v_st_rec1_vector_2 : st_rec1_vector :=
          c_st_rec1_vector_1 ;
      variable v_st_rec2_vector_2 : st_rec2_vector :=
          c_st_rec2_vector_1 ;
      variable v_st_rec3_vector_2 : st_rec3_vector :=
          c_st_rec3_vector_1 ;
      variable v_st_arr1_vector_2 : st_arr1_vector :=
          c_st_arr1_vector_1 ;
      variable v_st_arr2_vector_2 : st_arr2_vector :=
          c_st_arr2_vector_1 ;
      variable v_st_arr3_vector_2 : st_arr3_vector :=
          c_st_arr3_vector_1 ;
--
      variable v_st_boolean_vector_3 : st_boolean_vector :=
          c_st_boolean_vector_1 ;
      variable v_st_bit_vector_3 : st_bit_vector :=
          c_st_bit_vector_1 ;
      variable v_st_severity_level_vector_3 : st_severity_level_vector :=
          c_st_severity_level_vector_1 ;
      variable v_st_string_3 : st_string :=
          c_st_string_1 ;
      variable v_st_enum1_vector_3 : st_enum1_vector :=
          c_st_enum1_vector_1 ;
      variable v_st_integer_vector_3 : st_integer_vector :=
          c_st_integer_vector_1 ;
      variable v_st_int1_vector_3 : st_int1_vector :=
          c_st_int1_vector_1 ;
      variable v_st_time_vector_3 : st_time_vector :=
          c_st_time_vector_1 ;
      variable v_st_phys1_vector_3 : st_phys1_vector :=
          c_st_phys1_vector_1 ;
      variable v_st_real_vector_3 : st_real_vector :=
          c_st_real_vector_1 ;
      variable v_st_real1_vector_3 : st_real1_vector :=
          c_st_real1_vector_1 ;
      variable v_st_rec1_vector_3 : st_rec1_vector :=
          c_st_rec1_vector_1 ;
      variable v_st_rec2_vector_3 : st_rec2_vector :=
          c_st_rec2_vector_1 ;
      variable v_st_rec3_vector_3 : st_rec3_vector :=
          c_st_rec3_vector_1 ;
      variable v_st_arr1_vector_3 : st_arr1_vector :=
          c_st_arr1_vector_1 ;
      variable v_st_arr2_vector_3 : st_arr2_vector :=
          c_st_arr2_vector_1 ;
      variable v_st_arr3_vector_3 : st_arr3_vector :=
          c_st_arr3_vector_1 ;
--
      begin
         (
           v_st_boolean_vector_1(lowb to highb)
         , v_st_boolean_vector_2(lowb to highb)
         , v_st_boolean_vector_3(lowb to highb)
         ) :=
              arr_st_boolean_vector ' (
              (others => c_st_boolean_vector_2(lowb to highb))) ;
--
         (
           v_st_bit_vector_1(lowb to highb)
         , v_st_bit_vector_2(lowb to highb)
         , v_st_bit_vector_3(lowb to highb)
         ) :=
              arr_st_bit_vector ' (
              (others => c_st_bit_vector_2(lowb to highb))) ;
--
         (
           v_st_severity_level_vector_1(lowb to highb)
         , v_st_severity_level_vector_2(lowb to highb)
         , v_st_severity_level_vector_3(lowb to highb)
         ) :=
              arr_st_severity_level_vector ' (
              (others => c_st_severity_level_vector_2(lowb to highb))) ;
--
         (
           v_st_string_1(lowb to highb)
         , v_st_string_2(lowb to highb)
         , v_st_string_3(lowb to highb)
         ) :=
              arr_st_string ' (
              (others => c_st_string_2(lowb to highb))) ;
--
         (
           v_st_enum1_vector_1(lowb to highb)
         , v_st_enum1_vector_2(lowb to highb)
         , v_st_enum1_vector_3(lowb to highb)
         ) :=
              arr_st_enum1_vector ' (
              (others => c_st_enum1_vector_2(lowb to highb))) ;
--
         (
           v_st_integer_vector_1(lowb to highb)
         , v_st_integer_vector_2(lowb to highb)
         , v_st_integer_vector_3(lowb to highb)
         ) :=
              arr_st_integer_vector ' (
              (others => c_st_integer_vector_2(lowb to highb))) ;
--
         (
           v_st_int1_vector_1(lowb to highb)
         , v_st_int1_vector_2(lowb to highb)
         , v_st_int1_vector_3(lowb to highb)
         ) :=
              arr_st_int1_vector ' (
              (others => c_st_int1_vector_2(lowb to highb))) ;
--
         (
           v_st_time_vector_1(lowb to highb)
         , v_st_time_vector_2(lowb to highb)
         , v_st_time_vector_3(lowb to highb)
         ) :=
              arr_st_time_vector ' (
              (others => c_st_time_vector_2(lowb to highb))) ;
--
         (
           v_st_phys1_vector_1(lowb to highb)
         , v_st_phys1_vector_2(lowb to highb)
         , v_st_phys1_vector_3(lowb to highb)
         ) :=
              arr_st_phys1_vector ' (
              (others => c_st_phys1_vector_2(lowb to highb))) ;
--
         (
           v_st_real_vector_1(lowb to highb)
         , v_st_real_vector_2(lowb to highb)
         , v_st_real_vector_3(lowb to highb)
         ) :=
              arr_st_real_vector ' (
              (others => c_st_real_vector_2(lowb to highb))) ;
--
         (
           v_st_real1_vector_1(lowb to highb)
         , v_st_real1_vector_2(lowb to highb)
         , v_st_real1_vector_3(lowb to highb)
         ) :=
              arr_st_real1_vector ' (
              (others => c_st_real1_vector_2(lowb to highb))) ;
--
         (
           v_st_rec1_vector_1(lowb to highb)
         , v_st_rec1_vector_2(lowb to highb)
         , v_st_rec1_vector_3(lowb to highb)
         ) :=
              arr_st_rec1_vector ' (
              (others => c_st_rec1_vector_2(lowb to highb))) ;
--
         (
           v_st_rec2_vector_1(lowb to highb)
         , v_st_rec2_vector_2(lowb to highb)
         , v_st_rec2_vector_3(lowb to highb)
         ) :=
              arr_st_rec2_vector ' (
              (others => c_st_rec2_vector_2(lowb to highb))) ;
--
         (
           v_st_rec3_vector_1(lowb to highb)
         , v_st_rec3_vector_2(lowb to highb)
         , v_st_rec3_vector_3(lowb to highb)
         ) :=
              arr_st_rec3_vector ' (
              (others => c_st_rec3_vector_2(lowb to highb))) ;
--
         (
           v_st_arr1_vector_1(lowb to highb)
         , v_st_arr1_vector_2(lowb to highb)
         , v_st_arr1_vector_3(lowb to highb)
         ) :=
              arr_st_arr1_vector ' (
              (others => c_st_arr1_vector_2(lowb to highb))) ;
--
         (
           v_st_arr2_vector_1(lowb to highb)
         , v_st_arr2_vector_2(lowb to highb)
         , v_st_arr2_vector_3(lowb to highb)
         ) :=
              arr_st_arr2_vector ' (
              (others => c_st_arr2_vector_2(lowb to highb))) ;
--
         (
           v_st_arr3_vector_1(lowb to highb)
         , v_st_arr3_vector_2(lowb to highb)
         , v_st_arr3_vector_3(lowb to highb)
         ) :=
              arr_st_arr3_vector ' (
              (others => c_st_arr3_vector_2(lowb to highb))) ;
--
--
      correct := correct and
                 v_st_boolean_vector_1(lowb to highb) =
                 c_st_boolean_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_bit_vector_1(lowb to highb) =
                 c_st_bit_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_severity_level_vector_1(lowb to highb) =
                 c_st_severity_level_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_string_1(lowb to highb) =
                 c_st_string_2(lowb to highb) ;
      correct := correct and
                 v_st_enum1_vector_1(lowb to highb) =
                 c_st_enum1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_integer_vector_1(lowb to highb) =
                 c_st_integer_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_int1_vector_1(lowb to highb) =
                 c_st_int1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_time_vector_1(lowb to highb) =
                 c_st_time_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_phys1_vector_1(lowb to highb) =
                 c_st_phys1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_real_vector_1(lowb to highb) =
                 c_st_real_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_real1_vector_1(lowb to highb) =
                 c_st_real1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec1_vector_1(lowb to highb) =
                 c_st_rec1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec2_vector_1(lowb to highb) =
                 c_st_rec2_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec3_vector_1(lowb to highb) =
                 c_st_rec3_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr1_vector_1(lowb to highb) =
                 c_st_arr1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr2_vector_1(lowb to highb) =
                 c_st_arr2_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr3_vector_1(lowb to highb) =
                 c_st_arr3_vector_2(lowb to highb) ;
--
      correct := correct and
                 v_st_boolean_vector_2(lowb to highb) =
                 c_st_boolean_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_bit_vector_2(lowb to highb) =
                 c_st_bit_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_severity_level_vector_2(lowb to highb) =
                 c_st_severity_level_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_string_2(lowb to highb) =
                 c_st_string_2(lowb to highb) ;
      correct := correct and
                 v_st_enum1_vector_2(lowb to highb) =
                 c_st_enum1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_integer_vector_2(lowb to highb) =
                 c_st_integer_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_int1_vector_2(lowb to highb) =
                 c_st_int1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_time_vector_2(lowb to highb) =
                 c_st_time_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_phys1_vector_2(lowb to highb) =
                 c_st_phys1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_real_vector_2(lowb to highb) =
                 c_st_real_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_real1_vector_2(lowb to highb) =
                 c_st_real1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec1_vector_2(lowb to highb) =
                 c_st_rec1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec2_vector_2(lowb to highb) =
                 c_st_rec2_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec3_vector_2(lowb to highb) =
                 c_st_rec3_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr1_vector_2(lowb to highb) =
                 c_st_arr1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr2_vector_2(lowb to highb) =
                 c_st_arr2_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr3_vector_2(lowb to highb) =
                 c_st_arr3_vector_2(lowb to highb) ;
--
      correct := correct and
                 v_st_boolean_vector_3(lowb to highb) =
                 c_st_boolean_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_bit_vector_3(lowb to highb) =
                 c_st_bit_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_severity_level_vector_3(lowb to highb) =
                 c_st_severity_level_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_string_3(lowb to highb) =
                 c_st_string_2(lowb to highb) ;
      correct := correct and
                 v_st_enum1_vector_3(lowb to highb) =
                 c_st_enum1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_integer_vector_3(lowb to highb) =
                 c_st_integer_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_int1_vector_3(lowb to highb) =
                 c_st_int1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_time_vector_3(lowb to highb) =
                 c_st_time_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_phys1_vector_3(lowb to highb) =
                 c_st_phys1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_real_vector_3(lowb to highb) =
                 c_st_real_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_real1_vector_3(lowb to highb) =
                 c_st_real1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec1_vector_3(lowb to highb) =
                 c_st_rec1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec2_vector_3(lowb to highb) =
                 c_st_rec2_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec3_vector_3(lowb to highb) =
                 c_st_rec3_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr1_vector_3(lowb to highb) =
                 c_st_arr1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr2_vector_3(lowb to highb) =
                 c_st_arr2_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr3_vector_3(lowb to highb) =
                 c_st_arr3_vector_2(lowb to highb) ;
--
      end Proc1 ;
   begin
      Proc1 ;
      test_report ( "ARCH00035.P2" ,
                    "Target of a variable assignment may be a " &
                    "aggregate of slices" ,
                    correct) ;
   end process P2 ;
--
   P3 :
   process ( Dummy )
      type arr_st_boolean_vector is
        array (integer range -1 downto - 3 ) of
          st_boolean_vector ;
      type arr_st_bit_vector is
        array (integer range -1 downto - 3 ) of
          st_bit_vector ;
      type arr_st_severity_level_vector is
        array (integer range -1 downto - 3 ) of
          st_severity_level_vector ;
      type arr_st_string is
        array (integer range -1 downto - 3 ) of
          st_string ;
      type arr_st_enum1_vector is
        array (integer range -1 downto - 3 ) of
          st_enum1_vector ;
      type arr_st_integer_vector is
        array (integer range -1 downto - 3 ) of
          st_integer_vector ;
      type arr_st_int1_vector is
        array (integer range -1 downto - 3 ) of
          st_int1_vector ;
      type arr_st_time_vector is
        array (integer range -1 downto - 3 ) of
          st_time_vector ;
      type arr_st_phys1_vector is
        array (integer range -1 downto - 3 ) of
          st_phys1_vector ;
      type arr_st_real_vector is
        array (integer range -1 downto - 3 ) of
          st_real_vector ;
      type arr_st_real1_vector is
        array (integer range -1 downto - 3 ) of
          st_real1_vector ;
      type arr_st_rec1_vector is
        array (integer range -1 downto - 3 ) of
          st_rec1_vector ;
      type arr_st_rec2_vector is
        array (integer range -1 downto - 3 ) of
          st_rec2_vector ;
      type arr_st_rec3_vector is
        array (integer range -1 downto - 3 ) of
          st_rec3_vector ;
      type arr_st_arr1_vector is
        array (integer range -1 downto - 3 ) of
          st_arr1_vector ;
      type arr_st_arr2_vector is
        array (integer range -1 downto - 3 ) of
          st_arr2_vector ;
      type arr_st_arr3_vector is
        array (integer range -1 downto - 3 ) of
          st_arr3_vector ;
--
      variable v_st_boolean_vector_1 : st_boolean_vector :=
          c_st_boolean_vector_1 ;
      variable v_st_bit_vector_1 : st_bit_vector :=
          c_st_bit_vector_1 ;
      variable v_st_severity_level_vector_1 : st_severity_level_vector :=
          c_st_severity_level_vector_1 ;
      variable v_st_string_1 : st_string :=
          c_st_string_1 ;
      variable v_st_enum1_vector_1 : st_enum1_vector :=
          c_st_enum1_vector_1 ;
      variable v_st_integer_vector_1 : st_integer_vector :=
          c_st_integer_vector_1 ;
      variable v_st_int1_vector_1 : st_int1_vector :=
          c_st_int1_vector_1 ;
      variable v_st_time_vector_1 : st_time_vector :=
          c_st_time_vector_1 ;
      variable v_st_phys1_vector_1 : st_phys1_vector :=
          c_st_phys1_vector_1 ;
      variable v_st_real_vector_1 : st_real_vector :=
          c_st_real_vector_1 ;
      variable v_st_real1_vector_1 : st_real1_vector :=
          c_st_real1_vector_1 ;
      variable v_st_rec1_vector_1 : st_rec1_vector :=
          c_st_rec1_vector_1 ;
      variable v_st_rec2_vector_1 : st_rec2_vector :=
          c_st_rec2_vector_1 ;
      variable v_st_rec3_vector_1 : st_rec3_vector :=
          c_st_rec3_vector_1 ;
      variable v_st_arr1_vector_1 : st_arr1_vector :=
          c_st_arr1_vector_1 ;
      variable v_st_arr2_vector_1 : st_arr2_vector :=
          c_st_arr2_vector_1 ;
      variable v_st_arr3_vector_1 : st_arr3_vector :=
          c_st_arr3_vector_1 ;
--
      variable v_st_boolean_vector_2 : st_boolean_vector :=
          c_st_boolean_vector_1 ;
      variable v_st_bit_vector_2 : st_bit_vector :=
          c_st_bit_vector_1 ;
      variable v_st_severity_level_vector_2 : st_severity_level_vector :=
          c_st_severity_level_vector_1 ;
      variable v_st_string_2 : st_string :=
          c_st_string_1 ;
      variable v_st_enum1_vector_2 : st_enum1_vector :=
          c_st_enum1_vector_1 ;
      variable v_st_integer_vector_2 : st_integer_vector :=
          c_st_integer_vector_1 ;
      variable v_st_int1_vector_2 : st_int1_vector :=
          c_st_int1_vector_1 ;
      variable v_st_time_vector_2 : st_time_vector :=
          c_st_time_vector_1 ;
      variable v_st_phys1_vector_2 : st_phys1_vector :=
          c_st_phys1_vector_1 ;
      variable v_st_real_vector_2 : st_real_vector :=
          c_st_real_vector_1 ;
      variable v_st_real1_vector_2 : st_real1_vector :=
          c_st_real1_vector_1 ;
      variable v_st_rec1_vector_2 : st_rec1_vector :=
          c_st_rec1_vector_1 ;
      variable v_st_rec2_vector_2 : st_rec2_vector :=
          c_st_rec2_vector_1 ;
      variable v_st_rec3_vector_2 : st_rec3_vector :=
          c_st_rec3_vector_1 ;
      variable v_st_arr1_vector_2 : st_arr1_vector :=
          c_st_arr1_vector_1 ;
      variable v_st_arr2_vector_2 : st_arr2_vector :=
          c_st_arr2_vector_1 ;
      variable v_st_arr3_vector_2 : st_arr3_vector :=
          c_st_arr3_vector_1 ;
--
      variable v_st_boolean_vector_3 : st_boolean_vector :=
          c_st_boolean_vector_1 ;
      variable v_st_bit_vector_3 : st_bit_vector :=
          c_st_bit_vector_1 ;
      variable v_st_severity_level_vector_3 : st_severity_level_vector :=
          c_st_severity_level_vector_1 ;
      variable v_st_string_3 : st_string :=
          c_st_string_1 ;
      variable v_st_enum1_vector_3 : st_enum1_vector :=
          c_st_enum1_vector_1 ;
      variable v_st_integer_vector_3 : st_integer_vector :=
          c_st_integer_vector_1 ;
      variable v_st_int1_vector_3 : st_int1_vector :=
          c_st_int1_vector_1 ;
      variable v_st_time_vector_3 : st_time_vector :=
          c_st_time_vector_1 ;
      variable v_st_phys1_vector_3 : st_phys1_vector :=
          c_st_phys1_vector_1 ;
      variable v_st_real_vector_3 : st_real_vector :=
          c_st_real_vector_1 ;
      variable v_st_real1_vector_3 : st_real1_vector :=
          c_st_real1_vector_1 ;
      variable v_st_rec1_vector_3 : st_rec1_vector :=
          c_st_rec1_vector_1 ;
      variable v_st_rec2_vector_3 : st_rec2_vector :=
          c_st_rec2_vector_1 ;
      variable v_st_rec3_vector_3 : st_rec3_vector :=
          c_st_rec3_vector_1 ;
      variable v_st_arr1_vector_3 : st_arr1_vector :=
          c_st_arr1_vector_1 ;
      variable v_st_arr2_vector_3 : st_arr2_vector :=
          c_st_arr2_vector_1 ;
      variable v_st_arr3_vector_3 : st_arr3_vector :=
          c_st_arr3_vector_1 ;
--
      variable correct : boolean := true ;
--
      procedure Proc1 is
      begin
         (
           v_st_boolean_vector_1(lowb to highb)
         , v_st_boolean_vector_2(lowb to highb)
         , v_st_boolean_vector_3(lowb to highb)
         ) :=
              arr_st_boolean_vector ' (
              (others => c_st_boolean_vector_2(lowb to highb))) ;
--
         (
           v_st_bit_vector_1(lowb to highb)
         , v_st_bit_vector_2(lowb to highb)
         , v_st_bit_vector_3(lowb to highb)
         ) :=
              arr_st_bit_vector ' (
              (others => c_st_bit_vector_2(lowb to highb))) ;
--
         (
           v_st_severity_level_vector_1(lowb to highb)
         , v_st_severity_level_vector_2(lowb to highb)
         , v_st_severity_level_vector_3(lowb to highb)
         ) :=
              arr_st_severity_level_vector ' (
              (others => c_st_severity_level_vector_2(lowb to highb))) ;
--
         (
           v_st_string_1(lowb to highb)
         , v_st_string_2(lowb to highb)
         , v_st_string_3(lowb to highb)
         ) :=
              arr_st_string ' (
              (others => c_st_string_2(lowb to highb))) ;
--
         (
           v_st_enum1_vector_1(lowb to highb)
         , v_st_enum1_vector_2(lowb to highb)
         , v_st_enum1_vector_3(lowb to highb)
         ) :=
              arr_st_enum1_vector ' (
              (others => c_st_enum1_vector_2(lowb to highb))) ;
--
         (
           v_st_integer_vector_1(lowb to highb)
         , v_st_integer_vector_2(lowb to highb)
         , v_st_integer_vector_3(lowb to highb)
         ) :=
              arr_st_integer_vector ' (
              (others => c_st_integer_vector_2(lowb to highb))) ;
--
         (
           v_st_int1_vector_1(lowb to highb)
         , v_st_int1_vector_2(lowb to highb)
         , v_st_int1_vector_3(lowb to highb)
         ) :=
              arr_st_int1_vector ' (
              (others => c_st_int1_vector_2(lowb to highb))) ;
--
         (
           v_st_time_vector_1(lowb to highb)
         , v_st_time_vector_2(lowb to highb)
         , v_st_time_vector_3(lowb to highb)
         ) :=
              arr_st_time_vector ' (
              (others => c_st_time_vector_2(lowb to highb))) ;
--
         (
           v_st_phys1_vector_1(lowb to highb)
         , v_st_phys1_vector_2(lowb to highb)
         , v_st_phys1_vector_3(lowb to highb)
         ) :=
              arr_st_phys1_vector ' (
              (others => c_st_phys1_vector_2(lowb to highb))) ;
--
         (
           v_st_real_vector_1(lowb to highb)
         , v_st_real_vector_2(lowb to highb)
         , v_st_real_vector_3(lowb to highb)
         ) :=
              arr_st_real_vector ' (
              (others => c_st_real_vector_2(lowb to highb))) ;
--
         (
           v_st_real1_vector_1(lowb to highb)
         , v_st_real1_vector_2(lowb to highb)
         , v_st_real1_vector_3(lowb to highb)
         ) :=
              arr_st_real1_vector ' (
              (others => c_st_real1_vector_2(lowb to highb))) ;
--
         (
           v_st_rec1_vector_1(lowb to highb)
         , v_st_rec1_vector_2(lowb to highb)
         , v_st_rec1_vector_3(lowb to highb)
         ) :=
              arr_st_rec1_vector ' (
              (others => c_st_rec1_vector_2(lowb to highb))) ;
--
         (
           v_st_rec2_vector_1(lowb to highb)
         , v_st_rec2_vector_2(lowb to highb)
         , v_st_rec2_vector_3(lowb to highb)
         ) :=
              arr_st_rec2_vector ' (
              (others => c_st_rec2_vector_2(lowb to highb))) ;
--
         (
           v_st_rec3_vector_1(lowb to highb)
         , v_st_rec3_vector_2(lowb to highb)
         , v_st_rec3_vector_3(lowb to highb)
         ) :=
              arr_st_rec3_vector ' (
              (others => c_st_rec3_vector_2(lowb to highb))) ;
--
         (
           v_st_arr1_vector_1(lowb to highb)
         , v_st_arr1_vector_2(lowb to highb)
         , v_st_arr1_vector_3(lowb to highb)
         ) :=
              arr_st_arr1_vector ' (
              (others => c_st_arr1_vector_2(lowb to highb))) ;
--
         (
           v_st_arr2_vector_1(lowb to highb)
         , v_st_arr2_vector_2(lowb to highb)
         , v_st_arr2_vector_3(lowb to highb)
         ) :=
              arr_st_arr2_vector ' (
              (others => c_st_arr2_vector_2(lowb to highb))) ;
--
         (
           v_st_arr3_vector_1(lowb to highb)
         , v_st_arr3_vector_2(lowb to highb)
         , v_st_arr3_vector_3(lowb to highb)
         ) :=
              arr_st_arr3_vector ' (
              (others => c_st_arr3_vector_2(lowb to highb))) ;
--
--
      end Proc1 ;
   begin
      Proc1 ;
      correct := correct and
                 v_st_boolean_vector_1(lowb to highb) =
                 c_st_boolean_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_bit_vector_1(lowb to highb) =
                 c_st_bit_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_severity_level_vector_1(lowb to highb) =
                 c_st_severity_level_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_string_1(lowb to highb) =
                 c_st_string_2(lowb to highb) ;
      correct := correct and
                 v_st_enum1_vector_1(lowb to highb) =
                 c_st_enum1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_integer_vector_1(lowb to highb) =
                 c_st_integer_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_int1_vector_1(lowb to highb) =
                 c_st_int1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_time_vector_1(lowb to highb) =
                 c_st_time_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_phys1_vector_1(lowb to highb) =
                 c_st_phys1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_real_vector_1(lowb to highb) =
                 c_st_real_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_real1_vector_1(lowb to highb) =
                 c_st_real1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec1_vector_1(lowb to highb) =
                 c_st_rec1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec2_vector_1(lowb to highb) =
                 c_st_rec2_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec3_vector_1(lowb to highb) =
                 c_st_rec3_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr1_vector_1(lowb to highb) =
                 c_st_arr1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr2_vector_1(lowb to highb) =
                 c_st_arr2_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr3_vector_1(lowb to highb) =
                 c_st_arr3_vector_2(lowb to highb) ;
--
      correct := correct and
                 v_st_boolean_vector_2(lowb to highb) =
                 c_st_boolean_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_bit_vector_2(lowb to highb) =
                 c_st_bit_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_severity_level_vector_2(lowb to highb) =
                 c_st_severity_level_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_string_2(lowb to highb) =
                 c_st_string_2(lowb to highb) ;
      correct := correct and
                 v_st_enum1_vector_2(lowb to highb) =
                 c_st_enum1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_integer_vector_2(lowb to highb) =
                 c_st_integer_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_int1_vector_2(lowb to highb) =
                 c_st_int1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_time_vector_2(lowb to highb) =
                 c_st_time_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_phys1_vector_2(lowb to highb) =
                 c_st_phys1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_real_vector_2(lowb to highb) =
                 c_st_real_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_real1_vector_2(lowb to highb) =
                 c_st_real1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec1_vector_2(lowb to highb) =
                 c_st_rec1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec2_vector_2(lowb to highb) =
                 c_st_rec2_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec3_vector_2(lowb to highb) =
                 c_st_rec3_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr1_vector_2(lowb to highb) =
                 c_st_arr1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr2_vector_2(lowb to highb) =
                 c_st_arr2_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr3_vector_2(lowb to highb) =
                 c_st_arr3_vector_2(lowb to highb) ;
--
      correct := correct and
                 v_st_boolean_vector_3(lowb to highb) =
                 c_st_boolean_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_bit_vector_3(lowb to highb) =
                 c_st_bit_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_severity_level_vector_3(lowb to highb) =
                 c_st_severity_level_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_string_3(lowb to highb) =
                 c_st_string_2(lowb to highb) ;
      correct := correct and
                 v_st_enum1_vector_3(lowb to highb) =
                 c_st_enum1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_integer_vector_3(lowb to highb) =
                 c_st_integer_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_int1_vector_3(lowb to highb) =
                 c_st_int1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_time_vector_3(lowb to highb) =
                 c_st_time_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_phys1_vector_3(lowb to highb) =
                 c_st_phys1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_real_vector_3(lowb to highb) =
                 c_st_real_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_real1_vector_3(lowb to highb) =
                 c_st_real1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec1_vector_3(lowb to highb) =
                 c_st_rec1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec2_vector_3(lowb to highb) =
                 c_st_rec2_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec3_vector_3(lowb to highb) =
                 c_st_rec3_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr1_vector_3(lowb to highb) =
                 c_st_arr1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr2_vector_3(lowb to highb) =
                 c_st_arr2_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr3_vector_3(lowb to highb) =
                 c_st_arr3_vector_2(lowb to highb) ;
--
      test_report ( "ARCH00035.P3" ,
                    "Target of a variable assignment may be a " &
                    "aggregate of slices" ,
                    correct) ;
   end process P3 ;
--
   P4 :
   process ( Dummy )
      type arr_st_boolean_vector is
        array (integer range -1 downto - 3 ) of
          st_boolean_vector ;
      type arr_st_bit_vector is
        array (integer range -1 downto - 3 ) of
          st_bit_vector ;
      type arr_st_severity_level_vector is
        array (integer range -1 downto - 3 ) of
          st_severity_level_vector ;
      type arr_st_string is
        array (integer range -1 downto - 3 ) of
          st_string ;
      type arr_st_enum1_vector is
        array (integer range -1 downto - 3 ) of
          st_enum1_vector ;
      type arr_st_integer_vector is
        array (integer range -1 downto - 3 ) of
          st_integer_vector ;
      type arr_st_int1_vector is
        array (integer range -1 downto - 3 ) of
          st_int1_vector ;
      type arr_st_time_vector is
        array (integer range -1 downto - 3 ) of
          st_time_vector ;
      type arr_st_phys1_vector is
        array (integer range -1 downto - 3 ) of
          st_phys1_vector ;
      type arr_st_real_vector is
        array (integer range -1 downto - 3 ) of
          st_real_vector ;
      type arr_st_real1_vector is
        array (integer range -1 downto - 3 ) of
          st_real1_vector ;
      type arr_st_rec1_vector is
        array (integer range -1 downto - 3 ) of
          st_rec1_vector ;
      type arr_st_rec2_vector is
        array (integer range -1 downto - 3 ) of
          st_rec2_vector ;
      type arr_st_rec3_vector is
        array (integer range -1 downto - 3 ) of
          st_rec3_vector ;
      type arr_st_arr1_vector is
        array (integer range -1 downto - 3 ) of
          st_arr1_vector ;
      type arr_st_arr2_vector is
        array (integer range -1 downto - 3 ) of
          st_arr2_vector ;
      type arr_st_arr3_vector is
        array (integer range -1 downto - 3 ) of
          st_arr3_vector ;
--
      variable v_st_boolean_vector_1 : st_boolean_vector :=
          c_st_boolean_vector_1 ;
      variable v_st_bit_vector_1 : st_bit_vector :=
          c_st_bit_vector_1 ;
      variable v_st_severity_level_vector_1 : st_severity_level_vector :=
          c_st_severity_level_vector_1 ;
      variable v_st_string_1 : st_string :=
          c_st_string_1 ;
      variable v_st_enum1_vector_1 : st_enum1_vector :=
          c_st_enum1_vector_1 ;
      variable v_st_integer_vector_1 : st_integer_vector :=
          c_st_integer_vector_1 ;
      variable v_st_int1_vector_1 : st_int1_vector :=
          c_st_int1_vector_1 ;
      variable v_st_time_vector_1 : st_time_vector :=
          c_st_time_vector_1 ;
      variable v_st_phys1_vector_1 : st_phys1_vector :=
          c_st_phys1_vector_1 ;
      variable v_st_real_vector_1 : st_real_vector :=
          c_st_real_vector_1 ;
      variable v_st_real1_vector_1 : st_real1_vector :=
          c_st_real1_vector_1 ;
      variable v_st_rec1_vector_1 : st_rec1_vector :=
          c_st_rec1_vector_1 ;
      variable v_st_rec2_vector_1 : st_rec2_vector :=
          c_st_rec2_vector_1 ;
      variable v_st_rec3_vector_1 : st_rec3_vector :=
          c_st_rec3_vector_1 ;
      variable v_st_arr1_vector_1 : st_arr1_vector :=
          c_st_arr1_vector_1 ;
      variable v_st_arr2_vector_1 : st_arr2_vector :=
          c_st_arr2_vector_1 ;
      variable v_st_arr3_vector_1 : st_arr3_vector :=
          c_st_arr3_vector_1 ;
--
      variable v_st_boolean_vector_2 : st_boolean_vector :=
          c_st_boolean_vector_1 ;
      variable v_st_bit_vector_2 : st_bit_vector :=
          c_st_bit_vector_1 ;
      variable v_st_severity_level_vector_2 : st_severity_level_vector :=
          c_st_severity_level_vector_1 ;
      variable v_st_string_2 : st_string :=
          c_st_string_1 ;
      variable v_st_enum1_vector_2 : st_enum1_vector :=
          c_st_enum1_vector_1 ;
      variable v_st_integer_vector_2 : st_integer_vector :=
          c_st_integer_vector_1 ;
      variable v_st_int1_vector_2 : st_int1_vector :=
          c_st_int1_vector_1 ;
      variable v_st_time_vector_2 : st_time_vector :=
          c_st_time_vector_1 ;
      variable v_st_phys1_vector_2 : st_phys1_vector :=
          c_st_phys1_vector_1 ;
      variable v_st_real_vector_2 : st_real_vector :=
          c_st_real_vector_1 ;
      variable v_st_real1_vector_2 : st_real1_vector :=
          c_st_real1_vector_1 ;
      variable v_st_rec1_vector_2 : st_rec1_vector :=
          c_st_rec1_vector_1 ;
      variable v_st_rec2_vector_2 : st_rec2_vector :=
          c_st_rec2_vector_1 ;
      variable v_st_rec3_vector_2 : st_rec3_vector :=
          c_st_rec3_vector_1 ;
      variable v_st_arr1_vector_2 : st_arr1_vector :=
          c_st_arr1_vector_1 ;
      variable v_st_arr2_vector_2 : st_arr2_vector :=
          c_st_arr2_vector_1 ;
      variable v_st_arr3_vector_2 : st_arr3_vector :=
          c_st_arr3_vector_1 ;
--
      variable v_st_boolean_vector_3 : st_boolean_vector :=
          c_st_boolean_vector_1 ;
      variable v_st_bit_vector_3 : st_bit_vector :=
          c_st_bit_vector_1 ;
      variable v_st_severity_level_vector_3 : st_severity_level_vector :=
          c_st_severity_level_vector_1 ;
      variable v_st_string_3 : st_string :=
          c_st_string_1 ;
      variable v_st_enum1_vector_3 : st_enum1_vector :=
          c_st_enum1_vector_1 ;
      variable v_st_integer_vector_3 : st_integer_vector :=
          c_st_integer_vector_1 ;
      variable v_st_int1_vector_3 : st_int1_vector :=
          c_st_int1_vector_1 ;
      variable v_st_time_vector_3 : st_time_vector :=
          c_st_time_vector_1 ;
      variable v_st_phys1_vector_3 : st_phys1_vector :=
          c_st_phys1_vector_1 ;
      variable v_st_real_vector_3 : st_real_vector :=
          c_st_real_vector_1 ;
      variable v_st_real1_vector_3 : st_real1_vector :=
          c_st_real1_vector_1 ;
      variable v_st_rec1_vector_3 : st_rec1_vector :=
          c_st_rec1_vector_1 ;
      variable v_st_rec2_vector_3 : st_rec2_vector :=
          c_st_rec2_vector_1 ;
      variable v_st_rec3_vector_3 : st_rec3_vector :=
          c_st_rec3_vector_1 ;
      variable v_st_arr1_vector_3 : st_arr1_vector :=
          c_st_arr1_vector_1 ;
      variable v_st_arr2_vector_3 : st_arr2_vector :=
          c_st_arr2_vector_1 ;
      variable v_st_arr3_vector_3 : st_arr3_vector :=
          c_st_arr3_vector_1 ;
--
      variable correct : boolean := true ;
--
      procedure Proc1 (
           v_st_boolean_vector_2 : inout st_boolean_vector
         ; v_st_bit_vector_2 : inout st_bit_vector
         ; v_st_severity_level_vector_2 : inout st_severity_level_vector
         ; v_st_string_2 : inout st_string
         ; v_st_enum1_vector_2 : inout st_enum1_vector
         ; v_st_integer_vector_2 : inout st_integer_vector
         ; v_st_int1_vector_2 : inout st_int1_vector
         ; v_st_time_vector_2 : inout st_time_vector
         ; v_st_phys1_vector_2 : inout st_phys1_vector
         ; v_st_real_vector_2 : inout st_real_vector
         ; v_st_real1_vector_2 : inout st_real1_vector
         ; v_st_rec1_vector_2 : inout st_rec1_vector
         ; v_st_rec2_vector_2 : inout st_rec2_vector
         ; v_st_rec3_vector_2 : inout st_rec3_vector
         ; v_st_arr1_vector_2 : inout st_arr1_vector
         ; v_st_arr2_vector_2 : inout st_arr2_vector
         ; v_st_arr3_vector_2 : inout st_arr3_vector
                      )
      is
      begin
         (
           v_st_boolean_vector_1(lowb to highb)
         , v_st_boolean_vector_2(lowb to highb)
         , v_st_boolean_vector_3(lowb to highb)
         ) :=
              arr_st_boolean_vector ' (
              (others => c_st_boolean_vector_2(lowb to highb))) ;
--
         (
           v_st_bit_vector_1(lowb to highb)
         , v_st_bit_vector_2(lowb to highb)
         , v_st_bit_vector_3(lowb to highb)
         ) :=
              arr_st_bit_vector ' (
              (others => c_st_bit_vector_2(lowb to highb))) ;
--
         (
           v_st_severity_level_vector_1(lowb to highb)
         , v_st_severity_level_vector_2(lowb to highb)
         , v_st_severity_level_vector_3(lowb to highb)
         ) :=
              arr_st_severity_level_vector ' (
              (others => c_st_severity_level_vector_2(lowb to highb))) ;
--
         (
           v_st_string_1(lowb to highb)
         , v_st_string_2(lowb to highb)
         , v_st_string_3(lowb to highb)
         ) :=
              arr_st_string ' (
              (others => c_st_string_2(lowb to highb))) ;
--
         (
           v_st_enum1_vector_1(lowb to highb)
         , v_st_enum1_vector_2(lowb to highb)
         , v_st_enum1_vector_3(lowb to highb)
         ) :=
              arr_st_enum1_vector ' (
              (others => c_st_enum1_vector_2(lowb to highb))) ;
--
         (
           v_st_integer_vector_1(lowb to highb)
         , v_st_integer_vector_2(lowb to highb)
         , v_st_integer_vector_3(lowb to highb)
         ) :=
              arr_st_integer_vector ' (
              (others => c_st_integer_vector_2(lowb to highb))) ;
--
         (
           v_st_int1_vector_1(lowb to highb)
         , v_st_int1_vector_2(lowb to highb)
         , v_st_int1_vector_3(lowb to highb)
         ) :=
              arr_st_int1_vector ' (
              (others => c_st_int1_vector_2(lowb to highb))) ;
--
         (
           v_st_time_vector_1(lowb to highb)
         , v_st_time_vector_2(lowb to highb)
         , v_st_time_vector_3(lowb to highb)
         ) :=
              arr_st_time_vector ' (
              (others => c_st_time_vector_2(lowb to highb))) ;
--
         (
           v_st_phys1_vector_1(lowb to highb)
         , v_st_phys1_vector_2(lowb to highb)
         , v_st_phys1_vector_3(lowb to highb)
         ) :=
              arr_st_phys1_vector ' (
              (others => c_st_phys1_vector_2(lowb to highb))) ;
--
         (
           v_st_real_vector_1(lowb to highb)
         , v_st_real_vector_2(lowb to highb)
         , v_st_real_vector_3(lowb to highb)
         ) :=
              arr_st_real_vector ' (
              (others => c_st_real_vector_2(lowb to highb))) ;
--
         (
           v_st_real1_vector_1(lowb to highb)
         , v_st_real1_vector_2(lowb to highb)
         , v_st_real1_vector_3(lowb to highb)
         ) :=
              arr_st_real1_vector ' (
              (others => c_st_real1_vector_2(lowb to highb))) ;
--
         (
           v_st_rec1_vector_1(lowb to highb)
         , v_st_rec1_vector_2(lowb to highb)
         , v_st_rec1_vector_3(lowb to highb)
         ) :=
              arr_st_rec1_vector ' (
              (others => c_st_rec1_vector_2(lowb to highb))) ;
--
         (
           v_st_rec2_vector_1(lowb to highb)
         , v_st_rec2_vector_2(lowb to highb)
         , v_st_rec2_vector_3(lowb to highb)
         ) :=
              arr_st_rec2_vector ' (
              (others => c_st_rec2_vector_2(lowb to highb))) ;
--
         (
           v_st_rec3_vector_1(lowb to highb)
         , v_st_rec3_vector_2(lowb to highb)
         , v_st_rec3_vector_3(lowb to highb)
         ) :=
              arr_st_rec3_vector ' (
              (others => c_st_rec3_vector_2(lowb to highb))) ;
--
         (
           v_st_arr1_vector_1(lowb to highb)
         , v_st_arr1_vector_2(lowb to highb)
         , v_st_arr1_vector_3(lowb to highb)
         ) :=
              arr_st_arr1_vector ' (
              (others => c_st_arr1_vector_2(lowb to highb))) ;
--
         (
           v_st_arr2_vector_1(lowb to highb)
         , v_st_arr2_vector_2(lowb to highb)
         , v_st_arr2_vector_3(lowb to highb)
         ) :=
              arr_st_arr2_vector ' (
              (others => c_st_arr2_vector_2(lowb to highb))) ;
--
         (
           v_st_arr3_vector_1(lowb to highb)
         , v_st_arr3_vector_2(lowb to highb)
         , v_st_arr3_vector_3(lowb to highb)
         ) :=
              arr_st_arr3_vector ' (
              (others => c_st_arr3_vector_2(lowb to highb))) ;
--
--
      end Proc1 ;
   begin
      Proc1 (
           v_st_boolean_vector_2
         , v_st_bit_vector_2
         , v_st_severity_level_vector_2
         , v_st_string_2
         , v_st_enum1_vector_2
         , v_st_integer_vector_2
         , v_st_int1_vector_2
         , v_st_time_vector_2
         , v_st_phys1_vector_2
         , v_st_real_vector_2
         , v_st_real1_vector_2
         , v_st_rec1_vector_2
         , v_st_rec2_vector_2
         , v_st_rec3_vector_2
         , v_st_arr1_vector_2
         , v_st_arr2_vector_2
         , v_st_arr3_vector_2
            ) ;
      correct := correct and
                 v_st_boolean_vector_1(lowb to highb) =
                 c_st_boolean_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_bit_vector_1(lowb to highb) =
                 c_st_bit_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_severity_level_vector_1(lowb to highb) =
                 c_st_severity_level_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_string_1(lowb to highb) =
                 c_st_string_2(lowb to highb) ;
      correct := correct and
                 v_st_enum1_vector_1(lowb to highb) =
                 c_st_enum1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_integer_vector_1(lowb to highb) =
                 c_st_integer_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_int1_vector_1(lowb to highb) =
                 c_st_int1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_time_vector_1(lowb to highb) =
                 c_st_time_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_phys1_vector_1(lowb to highb) =
                 c_st_phys1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_real_vector_1(lowb to highb) =
                 c_st_real_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_real1_vector_1(lowb to highb) =
                 c_st_real1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec1_vector_1(lowb to highb) =
                 c_st_rec1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec2_vector_1(lowb to highb) =
                 c_st_rec2_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec3_vector_1(lowb to highb) =
                 c_st_rec3_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr1_vector_1(lowb to highb) =
                 c_st_arr1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr2_vector_1(lowb to highb) =
                 c_st_arr2_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr3_vector_1(lowb to highb) =
                 c_st_arr3_vector_2(lowb to highb) ;
--
      correct := correct and
                 v_st_boolean_vector_2(lowb to highb) =
                 c_st_boolean_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_bit_vector_2(lowb to highb) =
                 c_st_bit_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_severity_level_vector_2(lowb to highb) =
                 c_st_severity_level_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_string_2(lowb to highb) =
                 c_st_string_2(lowb to highb) ;
      correct := correct and
                 v_st_enum1_vector_2(lowb to highb) =
                 c_st_enum1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_integer_vector_2(lowb to highb) =
                 c_st_integer_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_int1_vector_2(lowb to highb) =
                 c_st_int1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_time_vector_2(lowb to highb) =
                 c_st_time_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_phys1_vector_2(lowb to highb) =
                 c_st_phys1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_real_vector_2(lowb to highb) =
                 c_st_real_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_real1_vector_2(lowb to highb) =
                 c_st_real1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec1_vector_2(lowb to highb) =
                 c_st_rec1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec2_vector_2(lowb to highb) =
                 c_st_rec2_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec3_vector_2(lowb to highb) =
                 c_st_rec3_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr1_vector_2(lowb to highb) =
                 c_st_arr1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr2_vector_2(lowb to highb) =
                 c_st_arr2_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr3_vector_2(lowb to highb) =
                 c_st_arr3_vector_2(lowb to highb) ;
--
      correct := correct and
                 v_st_boolean_vector_3(lowb to highb) =
                 c_st_boolean_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_bit_vector_3(lowb to highb) =
                 c_st_bit_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_severity_level_vector_3(lowb to highb) =
                 c_st_severity_level_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_string_3(lowb to highb) =
                 c_st_string_2(lowb to highb) ;
      correct := correct and
                 v_st_enum1_vector_3(lowb to highb) =
                 c_st_enum1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_integer_vector_3(lowb to highb) =
                 c_st_integer_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_int1_vector_3(lowb to highb) =
                 c_st_int1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_time_vector_3(lowb to highb) =
                 c_st_time_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_phys1_vector_3(lowb to highb) =
                 c_st_phys1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_real_vector_3(lowb to highb) =
                 c_st_real_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_real1_vector_3(lowb to highb) =
                 c_st_real1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec1_vector_3(lowb to highb) =
                 c_st_rec1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec2_vector_3(lowb to highb) =
                 c_st_rec2_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_rec3_vector_3(lowb to highb) =
                 c_st_rec3_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr1_vector_3(lowb to highb) =
                 c_st_arr1_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr2_vector_3(lowb to highb) =
                 c_st_arr2_vector_2(lowb to highb) ;
      correct := correct and
                 v_st_arr3_vector_3(lowb to highb) =
                 c_st_arr3_vector_2(lowb to highb) ;
--
      test_report ( "ARCH00035.P4" ,
                    "Target of a variable assignment may be a " &
                    "aggregate of slices" ,
                    correct) ;
   end process P4 ;
--
end ARCH00035 ;
--
entity ENT00035_Test_Bench is
end ENT00035_Test_Bench ;
--
architecture ARCH00035_Test_Bench of ENT00035_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00035 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00035_Test_Bench ;
