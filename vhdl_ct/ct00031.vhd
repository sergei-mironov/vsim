-- NEED RESULT: ARCH00031.P1: Target of a variable assignment may be a aggregate of simple names passed
-- NEED RESULT: ARCH00031.P2: Target of a variable assignment may be a aggregate of simple names passed
-- NEED RESULT: ARCH00031.P3: Target of a variable assignment may be a aggregate of simple names passed
-- NEED RESULT: ARCH00031.P4: Target of a variable assignment may be a aggregate of simple names passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00031
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
--    E00000(ARCH00031)
--    ENT00031_Test_Bench(ARCH00031_Test_Bench)
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
architecture ARCH00031 of E00000 is
   signal Dummy : Boolean := false ;
--
begin
   P1 :
   process ( Dummy )
      type arr_boolean is
        array (integer range -1 downto - 3 ) of
          boolean ;
      type arr_bit is
        array (integer range -1 downto - 3 ) of
          bit ;
      type arr_severity_level is
        array (integer range -1 downto - 3 ) of
          severity_level ;
      type arr_character is
        array (integer range -1 downto - 3 ) of
          character ;
      type arr_st_enum1 is
        array (integer range -1 downto - 3 ) of
          st_enum1 ;
      type arr_integer is
        array (integer range -1 downto - 3 ) of
          integer ;
      type arr_st_int1 is
        array (integer range -1 downto - 3 ) of
          st_int1 ;
      type arr_time is
        array (integer range -1 downto - 3 ) of
          time ;
      type arr_st_phys1 is
        array (integer range -1 downto - 3 ) of
          st_phys1 ;
      type arr_real is
        array (integer range -1 downto - 3 ) of
          real ;
      type arr_st_real1 is
        array (integer range -1 downto - 3 ) of
          st_real1 ;
      type arr_st_rec1 is
        array (integer range -1 downto - 3 ) of
          st_rec1 ;
      type arr_st_rec2 is
        array (integer range -1 downto - 3 ) of
          st_rec2 ;
      type arr_st_rec3 is
        array (integer range -1 downto - 3 ) of
          st_rec3 ;
      type arr_st_arr1 is
        array (integer range -1 downto - 3 ) of
          st_arr1 ;
      type arr_st_arr2 is
        array (integer range -1 downto - 3 ) of
          st_arr2 ;
      type arr_st_arr3 is
        array (integer range -1 downto - 3 ) of
          st_arr3 ;
--
      variable v_boolean_1 : boolean :=
          c_boolean_1 ;
      variable v_bit_1 : bit :=
          c_bit_1 ;
      variable v_severity_level_1 : severity_level :=
          c_severity_level_1 ;
      variable v_character_1 : character :=
          c_character_1 ;
      variable v_st_enum1_1 : st_enum1 :=
          c_st_enum1_1 ;
      variable v_integer_1 : integer :=
          c_integer_1 ;
      variable v_st_int1_1 : st_int1 :=
          c_st_int1_1 ;
      variable v_time_1 : time :=
          c_time_1 ;
      variable v_st_phys1_1 : st_phys1 :=
          c_st_phys1_1 ;
      variable v_real_1 : real :=
          c_real_1 ;
      variable v_st_real1_1 : st_real1 :=
          c_st_real1_1 ;
      variable v_st_rec1_1 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2_1 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3_1 : st_rec3 :=
          c_st_rec3_1 ;
      variable v_st_arr1_1 : st_arr1 :=
          c_st_arr1_1 ;
      variable v_st_arr2_1 : st_arr2 :=
          c_st_arr2_1 ;
      variable v_st_arr3_1 : st_arr3 :=
          c_st_arr3_1 ;
--
      variable v_boolean_2 : boolean :=
          c_boolean_1 ;
      variable v_bit_2 : bit :=
          c_bit_1 ;
      variable v_severity_level_2 : severity_level :=
          c_severity_level_1 ;
      variable v_character_2 : character :=
          c_character_1 ;
      variable v_st_enum1_2 : st_enum1 :=
          c_st_enum1_1 ;
      variable v_integer_2 : integer :=
          c_integer_1 ;
      variable v_st_int1_2 : st_int1 :=
          c_st_int1_1 ;
      variable v_time_2 : time :=
          c_time_1 ;
      variable v_st_phys1_2 : st_phys1 :=
          c_st_phys1_1 ;
      variable v_real_2 : real :=
          c_real_1 ;
      variable v_st_real1_2 : st_real1 :=
          c_st_real1_1 ;
      variable v_st_rec1_2 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2_2 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3_2 : st_rec3 :=
          c_st_rec3_1 ;
      variable v_st_arr1_2 : st_arr1 :=
          c_st_arr1_1 ;
      variable v_st_arr2_2 : st_arr2 :=
          c_st_arr2_1 ;
      variable v_st_arr3_2 : st_arr3 :=
          c_st_arr3_1 ;
--
      variable v_boolean_3 : boolean :=
          c_boolean_1 ;
      variable v_bit_3 : bit :=
          c_bit_1 ;
      variable v_severity_level_3 : severity_level :=
          c_severity_level_1 ;
      variable v_character_3 : character :=
          c_character_1 ;
      variable v_st_enum1_3 : st_enum1 :=
          c_st_enum1_1 ;
      variable v_integer_3 : integer :=
          c_integer_1 ;
      variable v_st_int1_3 : st_int1 :=
          c_st_int1_1 ;
      variable v_time_3 : time :=
          c_time_1 ;
      variable v_st_phys1_3 : st_phys1 :=
          c_st_phys1_1 ;
      variable v_real_3 : real :=
          c_real_1 ;
      variable v_st_real1_3 : st_real1 :=
          c_st_real1_1 ;
      variable v_st_rec1_3 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2_3 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3_3 : st_rec3 :=
          c_st_rec3_1 ;
      variable v_st_arr1_3 : st_arr1 :=
          c_st_arr1_1 ;
      variable v_st_arr2_3 : st_arr2 :=
          c_st_arr2_1 ;
      variable v_st_arr3_3 : st_arr3 :=
          c_st_arr3_1 ;
--
      variable correct : boolean := true ;
   begin
      ( v_boolean_1
      , v_boolean_2
      , v_boolean_3
      ) := arr_boolean ' (
           (Others => c_boolean_2)) ;
--
      ( v_bit_1
      , v_bit_2
      , v_bit_3
      ) := arr_bit ' (
           (Others => c_bit_2)) ;
--
      ( v_severity_level_1
      , v_severity_level_2
      , v_severity_level_3
      ) := arr_severity_level ' (
           (Others => c_severity_level_2)) ;
--
      ( v_character_1
      , v_character_2
      , v_character_3
      ) := arr_character ' (
           (Others => c_character_2)) ;
--
      ( v_st_enum1_1
      , v_st_enum1_2
      , v_st_enum1_3
      ) := arr_st_enum1 ' (
           (Others => c_st_enum1_2)) ;
--
      ( v_integer_1
      , v_integer_2
      , v_integer_3
      ) := arr_integer ' (
           (Others => c_integer_2)) ;
--
      ( v_st_int1_1
      , v_st_int1_2
      , v_st_int1_3
      ) := arr_st_int1 ' (
           (Others => c_st_int1_2)) ;
--
      ( v_time_1
      , v_time_2
      , v_time_3
      ) := arr_time ' (
           (Others => c_time_2)) ;
--
      ( v_st_phys1_1
      , v_st_phys1_2
      , v_st_phys1_3
      ) := arr_st_phys1 ' (
           (Others => c_st_phys1_2)) ;
--
      ( v_real_1
      , v_real_2
      , v_real_3
      ) := arr_real ' (
           (Others => c_real_2)) ;
--
      ( v_st_real1_1
      , v_st_real1_2
      , v_st_real1_3
      ) := arr_st_real1 ' (
           (Others => c_st_real1_2)) ;
--
      ( v_st_rec1_1
      , v_st_rec1_2
      , v_st_rec1_3
      ) := arr_st_rec1 ' (
           (Others => c_st_rec1_2)) ;
--
      ( v_st_rec2_1
      , v_st_rec2_2
      , v_st_rec2_3
      ) := arr_st_rec2 ' (
           (Others => c_st_rec2_2)) ;
--
      ( v_st_rec3_1
      , v_st_rec3_2
      , v_st_rec3_3
      ) := arr_st_rec3 ' (
           (Others => c_st_rec3_2)) ;
--
      ( v_st_arr1_1
      , v_st_arr1_2
      , v_st_arr1_3
      ) := arr_st_arr1 ' (
           (Others => c_st_arr1_2)) ;
--
      ( v_st_arr2_1
      , v_st_arr2_2
      , v_st_arr2_3
      ) := arr_st_arr2 ' (
           (Others => c_st_arr2_2)) ;
--
      ( v_st_arr3_1
      , v_st_arr3_2
      , v_st_arr3_3
      ) := arr_st_arr3 ' (
           (Others => c_st_arr3_2)) ;
--
--
      correct := correct and
                 v_boolean_1 = c_boolean_2 ;
      correct := correct and
                 v_bit_1 = c_bit_2 ;
      correct := correct and
                 v_severity_level_1 = c_severity_level_2 ;
      correct := correct and
                 v_character_1 = c_character_2 ;
      correct := correct and
                 v_st_enum1_1 = c_st_enum1_2 ;
      correct := correct and
                 v_integer_1 = c_integer_2 ;
      correct := correct and
                 v_st_int1_1 = c_st_int1_2 ;
      correct := correct and
                 v_time_1 = c_time_2 ;
      correct := correct and
                 v_st_phys1_1 = c_st_phys1_2 ;
      correct := correct and
                 v_real_1 = c_real_2 ;
      correct := correct and
                 v_st_real1_1 = c_st_real1_2 ;
      correct := correct and
                 v_st_rec1_1 = c_st_rec1_2 ;
      correct := correct and
                 v_st_rec2_1 = c_st_rec2_2 ;
      correct := correct and
                 v_st_rec3_1 = c_st_rec3_2 ;
      correct := correct and
                 v_st_arr1_1 = c_st_arr1_2 ;
      correct := correct and
                 v_st_arr2_1 = c_st_arr2_2 ;
      correct := correct and
                 v_st_arr3_1 = c_st_arr3_2 ;
--
      correct := correct and
                 v_boolean_2 = c_boolean_2 ;
      correct := correct and
                 v_bit_2 = c_bit_2 ;
      correct := correct and
                 v_severity_level_2 = c_severity_level_2 ;
      correct := correct and
                 v_character_2 = c_character_2 ;
      correct := correct and
                 v_st_enum1_2 = c_st_enum1_2 ;
      correct := correct and
                 v_integer_2 = c_integer_2 ;
      correct := correct and
                 v_st_int1_2 = c_st_int1_2 ;
      correct := correct and
                 v_time_2 = c_time_2 ;
      correct := correct and
                 v_st_phys1_2 = c_st_phys1_2 ;
      correct := correct and
                 v_real_2 = c_real_2 ;
      correct := correct and
                 v_st_real1_2 = c_st_real1_2 ;
      correct := correct and
                 v_st_rec1_2 = c_st_rec1_2 ;
      correct := correct and
                 v_st_rec2_2 = c_st_rec2_2 ;
      correct := correct and
                 v_st_rec3_2 = c_st_rec3_2 ;
      correct := correct and
                 v_st_arr1_2 = c_st_arr1_2 ;
      correct := correct and
                 v_st_arr2_2 = c_st_arr2_2 ;
      correct := correct and
                 v_st_arr3_2 = c_st_arr3_2 ;
--
      correct := correct and
                 v_boolean_3 = c_boolean_2 ;
      correct := correct and
                 v_bit_3 = c_bit_2 ;
      correct := correct and
                 v_severity_level_3 = c_severity_level_2 ;
      correct := correct and
                 v_character_3 = c_character_2 ;
      correct := correct and
                 v_st_enum1_3 = c_st_enum1_2 ;
      correct := correct and
                 v_integer_3 = c_integer_2 ;
      correct := correct and
                 v_st_int1_3 = c_st_int1_2 ;
      correct := correct and
                 v_time_3 = c_time_2 ;
      correct := correct and
                 v_st_phys1_3 = c_st_phys1_2 ;
      correct := correct and
                 v_real_3 = c_real_2 ;
      correct := correct and
                 v_st_real1_3 = c_st_real1_2 ;
      correct := correct and
                 v_st_rec1_3 = c_st_rec1_2 ;
      correct := correct and
                 v_st_rec2_3 = c_st_rec2_2 ;
      correct := correct and
                 v_st_rec3_3 = c_st_rec3_2 ;
      correct := correct and
                 v_st_arr1_3 = c_st_arr1_2 ;
      correct := correct and
                 v_st_arr2_3 = c_st_arr2_2 ;
      correct := correct and
                 v_st_arr3_3 = c_st_arr3_2 ;
--
      test_report ( "ARCH00031.P1" ,
                    "Target of a variable assignment may be a " &
                    "aggregate of simple names" ,
                    correct) ;
   end process P1 ;
--
   P2 :
   process ( Dummy )
      variable correct : boolean := true ;
--
      procedure Proc1 is
      type arr_boolean is
        array (integer range -1 downto - 3 ) of
          boolean ;
      type arr_bit is
        array (integer range -1 downto - 3 ) of
          bit ;
      type arr_severity_level is
        array (integer range -1 downto - 3 ) of
          severity_level ;
      type arr_character is
        array (integer range -1 downto - 3 ) of
          character ;
      type arr_st_enum1 is
        array (integer range -1 downto - 3 ) of
          st_enum1 ;
      type arr_integer is
        array (integer range -1 downto - 3 ) of
          integer ;
      type arr_st_int1 is
        array (integer range -1 downto - 3 ) of
          st_int1 ;
      type arr_time is
        array (integer range -1 downto - 3 ) of
          time ;
      type arr_st_phys1 is
        array (integer range -1 downto - 3 ) of
          st_phys1 ;
      type arr_real is
        array (integer range -1 downto - 3 ) of
          real ;
      type arr_st_real1 is
        array (integer range -1 downto - 3 ) of
          st_real1 ;
      type arr_st_rec1 is
        array (integer range -1 downto - 3 ) of
          st_rec1 ;
      type arr_st_rec2 is
        array (integer range -1 downto - 3 ) of
          st_rec2 ;
      type arr_st_rec3 is
        array (integer range -1 downto - 3 ) of
          st_rec3 ;
      type arr_st_arr1 is
        array (integer range -1 downto - 3 ) of
          st_arr1 ;
      type arr_st_arr2 is
        array (integer range -1 downto - 3 ) of
          st_arr2 ;
      type arr_st_arr3 is
        array (integer range -1 downto - 3 ) of
          st_arr3 ;
--
         variable v_boolean_1 : boolean :=
             c_boolean_1 ;
         variable v_bit_1 : bit :=
             c_bit_1 ;
         variable v_severity_level_1 : severity_level :=
             c_severity_level_1 ;
         variable v_character_1 : character :=
             c_character_1 ;
         variable v_st_enum1_1 : st_enum1 :=
             c_st_enum1_1 ;
         variable v_integer_1 : integer :=
             c_integer_1 ;
         variable v_st_int1_1 : st_int1 :=
             c_st_int1_1 ;
         variable v_time_1 : time :=
             c_time_1 ;
         variable v_st_phys1_1 : st_phys1 :=
             c_st_phys1_1 ;
         variable v_real_1 : real :=
             c_real_1 ;
         variable v_st_real1_1 : st_real1 :=
             c_st_real1_1 ;
         variable v_st_rec1_1 : st_rec1 :=
             c_st_rec1_1 ;
         variable v_st_rec2_1 : st_rec2 :=
             c_st_rec2_1 ;
         variable v_st_rec3_1 : st_rec3 :=
             c_st_rec3_1 ;
         variable v_st_arr1_1 : st_arr1 :=
             c_st_arr1_1 ;
         variable v_st_arr2_1 : st_arr2 :=
             c_st_arr2_1 ;
         variable v_st_arr3_1 : st_arr3 :=
             c_st_arr3_1 ;
--
         variable v_boolean_2 : boolean :=
             c_boolean_1 ;
         variable v_bit_2 : bit :=
             c_bit_1 ;
         variable v_severity_level_2 : severity_level :=
             c_severity_level_1 ;
         variable v_character_2 : character :=
             c_character_1 ;
         variable v_st_enum1_2 : st_enum1 :=
             c_st_enum1_1 ;
         variable v_integer_2 : integer :=
             c_integer_1 ;
         variable v_st_int1_2 : st_int1 :=
             c_st_int1_1 ;
         variable v_time_2 : time :=
             c_time_1 ;
         variable v_st_phys1_2 : st_phys1 :=
             c_st_phys1_1 ;
         variable v_real_2 : real :=
             c_real_1 ;
         variable v_st_real1_2 : st_real1 :=
             c_st_real1_1 ;
         variable v_st_rec1_2 : st_rec1 :=
             c_st_rec1_1 ;
         variable v_st_rec2_2 : st_rec2 :=
             c_st_rec2_1 ;
         variable v_st_rec3_2 : st_rec3 :=
             c_st_rec3_1 ;
         variable v_st_arr1_2 : st_arr1 :=
             c_st_arr1_1 ;
         variable v_st_arr2_2 : st_arr2 :=
             c_st_arr2_1 ;
         variable v_st_arr3_2 : st_arr3 :=
             c_st_arr3_1 ;
--
         variable v_boolean_3 : boolean :=
             c_boolean_1 ;
         variable v_bit_3 : bit :=
             c_bit_1 ;
         variable v_severity_level_3 : severity_level :=
             c_severity_level_1 ;
         variable v_character_3 : character :=
             c_character_1 ;
         variable v_st_enum1_3 : st_enum1 :=
             c_st_enum1_1 ;
         variable v_integer_3 : integer :=
             c_integer_1 ;
         variable v_st_int1_3 : st_int1 :=
             c_st_int1_1 ;
         variable v_time_3 : time :=
             c_time_1 ;
         variable v_st_phys1_3 : st_phys1 :=
             c_st_phys1_1 ;
         variable v_real_3 : real :=
             c_real_1 ;
         variable v_st_real1_3 : st_real1 :=
             c_st_real1_1 ;
         variable v_st_rec1_3 : st_rec1 :=
             c_st_rec1_1 ;
         variable v_st_rec2_3 : st_rec2 :=
             c_st_rec2_1 ;
         variable v_st_rec3_3 : st_rec3 :=
             c_st_rec3_1 ;
         variable v_st_arr1_3 : st_arr1 :=
             c_st_arr1_1 ;
         variable v_st_arr2_3 : st_arr2 :=
             c_st_arr2_1 ;
         variable v_st_arr3_3 : st_arr3 :=
             c_st_arr3_1 ;
--
      begin
         ( v_boolean_1
         , v_boolean_2
         , v_boolean_3
         ) := arr_boolean ' (
              (Others => c_boolean_2)) ;
--
         ( v_bit_1
         , v_bit_2
         , v_bit_3
         ) := arr_bit ' (
              (Others => c_bit_2)) ;
--
         ( v_severity_level_1
         , v_severity_level_2
         , v_severity_level_3
         ) := arr_severity_level ' (
              (Others => c_severity_level_2)) ;
--
         ( v_character_1
         , v_character_2
         , v_character_3
         ) := arr_character ' (
              (Others => c_character_2)) ;
--
         ( v_st_enum1_1
         , v_st_enum1_2
         , v_st_enum1_3
         ) := arr_st_enum1 ' (
              (Others => c_st_enum1_2)) ;
--
         ( v_integer_1
         , v_integer_2
         , v_integer_3
         ) := arr_integer ' (
              (Others => c_integer_2)) ;
--
         ( v_st_int1_1
         , v_st_int1_2
         , v_st_int1_3
         ) := arr_st_int1 ' (
              (Others => c_st_int1_2)) ;
--
         ( v_time_1
         , v_time_2
         , v_time_3
         ) := arr_time ' (
              (Others => c_time_2)) ;
--
         ( v_st_phys1_1
         , v_st_phys1_2
         , v_st_phys1_3
         ) := arr_st_phys1 ' (
              (Others => c_st_phys1_2)) ;
--
         ( v_real_1
         , v_real_2
         , v_real_3
         ) := arr_real ' (
              (Others => c_real_2)) ;
--
         ( v_st_real1_1
         , v_st_real1_2
         , v_st_real1_3
         ) := arr_st_real1 ' (
              (Others => c_st_real1_2)) ;
--
         ( v_st_rec1_1
         , v_st_rec1_2
         , v_st_rec1_3
         ) := arr_st_rec1 ' (
              (Others => c_st_rec1_2)) ;
--
         ( v_st_rec2_1
         , v_st_rec2_2
         , v_st_rec2_3
         ) := arr_st_rec2 ' (
              (Others => c_st_rec2_2)) ;
--
         ( v_st_rec3_1
         , v_st_rec3_2
         , v_st_rec3_3
         ) := arr_st_rec3 ' (
              (Others => c_st_rec3_2)) ;
--
         ( v_st_arr1_1
         , v_st_arr1_2
         , v_st_arr1_3
         ) := arr_st_arr1 ' (
              (Others => c_st_arr1_2)) ;
--
         ( v_st_arr2_1
         , v_st_arr2_2
         , v_st_arr2_3
         ) := arr_st_arr2 ' (
              (Others => c_st_arr2_2)) ;
--
         ( v_st_arr3_1
         , v_st_arr3_2
         , v_st_arr3_3
         ) := arr_st_arr3 ' (
              (Others => c_st_arr3_2)) ;
--
--
         correct := correct and
                    v_boolean_1 = c_boolean_2 ;
         correct := correct and
                    v_bit_1 = c_bit_2 ;
         correct := correct and
                    v_severity_level_1 = c_severity_level_2 ;
         correct := correct and
                    v_character_1 = c_character_2 ;
         correct := correct and
                    v_st_enum1_1 = c_st_enum1_2 ;
         correct := correct and
                    v_integer_1 = c_integer_2 ;
         correct := correct and
                    v_st_int1_1 = c_st_int1_2 ;
         correct := correct and
                    v_time_1 = c_time_2 ;
         correct := correct and
                    v_st_phys1_1 = c_st_phys1_2 ;
         correct := correct and
                    v_real_1 = c_real_2 ;
         correct := correct and
                    v_st_real1_1 = c_st_real1_2 ;
         correct := correct and
                    v_st_rec1_1 = c_st_rec1_2 ;
         correct := correct and
                    v_st_rec2_1 = c_st_rec2_2 ;
         correct := correct and
                    v_st_rec3_1 = c_st_rec3_2 ;
         correct := correct and
                    v_st_arr1_1 = c_st_arr1_2 ;
         correct := correct and
                    v_st_arr2_1 = c_st_arr2_2 ;
         correct := correct and
                    v_st_arr3_1 = c_st_arr3_2 ;
--
         correct := correct and
                    v_boolean_2 = c_boolean_2 ;
         correct := correct and
                    v_bit_2 = c_bit_2 ;
         correct := correct and
                    v_severity_level_2 = c_severity_level_2 ;
         correct := correct and
                    v_character_2 = c_character_2 ;
         correct := correct and
                    v_st_enum1_2 = c_st_enum1_2 ;
         correct := correct and
                    v_integer_2 = c_integer_2 ;
         correct := correct and
                    v_st_int1_2 = c_st_int1_2 ;
         correct := correct and
                    v_time_2 = c_time_2 ;
         correct := correct and
                    v_st_phys1_2 = c_st_phys1_2 ;
         correct := correct and
                    v_real_2 = c_real_2 ;
         correct := correct and
                    v_st_real1_2 = c_st_real1_2 ;
         correct := correct and
                    v_st_rec1_2 = c_st_rec1_2 ;
         correct := correct and
                    v_st_rec2_2 = c_st_rec2_2 ;
         correct := correct and
                    v_st_rec3_2 = c_st_rec3_2 ;
         correct := correct and
                    v_st_arr1_2 = c_st_arr1_2 ;
         correct := correct and
                    v_st_arr2_2 = c_st_arr2_2 ;
         correct := correct and
                    v_st_arr3_2 = c_st_arr3_2 ;
--
         correct := correct and
                    v_boolean_3 = c_boolean_2 ;
         correct := correct and
                    v_bit_3 = c_bit_2 ;
         correct := correct and
                    v_severity_level_3 = c_severity_level_2 ;
         correct := correct and
                    v_character_3 = c_character_2 ;
         correct := correct and
                    v_st_enum1_3 = c_st_enum1_2 ;
         correct := correct and
                    v_integer_3 = c_integer_2 ;
         correct := correct and
                    v_st_int1_3 = c_st_int1_2 ;
         correct := correct and
                    v_time_3 = c_time_2 ;
         correct := correct and
                    v_st_phys1_3 = c_st_phys1_2 ;
         correct := correct and
                    v_real_3 = c_real_2 ;
         correct := correct and
                    v_st_real1_3 = c_st_real1_2 ;
         correct := correct and
                    v_st_rec1_3 = c_st_rec1_2 ;
         correct := correct and
                    v_st_rec2_3 = c_st_rec2_2 ;
         correct := correct and
                    v_st_rec3_3 = c_st_rec3_2 ;
         correct := correct and
                    v_st_arr1_3 = c_st_arr1_2 ;
         correct := correct and
                    v_st_arr2_3 = c_st_arr2_2 ;
         correct := correct and
                    v_st_arr3_3 = c_st_arr3_2 ;
--
      end Proc1 ;
   begin
      Proc1 ;
      test_report ( "ARCH00031.P2" ,
                    "Target of a variable assignment may be a " &
                    "aggregate of simple names" ,
                    correct) ;
   end process P2 ;
--
   P3 :
   process ( Dummy )
      type arr_boolean is
        array (integer range -1 downto - 3 ) of
          boolean ;
      type arr_bit is
        array (integer range -1 downto - 3 ) of
          bit ;
      type arr_severity_level is
        array (integer range -1 downto - 3 ) of
          severity_level ;
      type arr_character is
        array (integer range -1 downto - 3 ) of
          character ;
      type arr_st_enum1 is
        array (integer range -1 downto - 3 ) of
          st_enum1 ;
      type arr_integer is
        array (integer range -1 downto - 3 ) of
          integer ;
      type arr_st_int1 is
        array (integer range -1 downto - 3 ) of
          st_int1 ;
      type arr_time is
        array (integer range -1 downto - 3 ) of
          time ;
      type arr_st_phys1 is
        array (integer range -1 downto - 3 ) of
          st_phys1 ;
      type arr_real is
        array (integer range -1 downto - 3 ) of
          real ;
      type arr_st_real1 is
        array (integer range -1 downto - 3 ) of
          st_real1 ;
      type arr_st_rec1 is
        array (integer range -1 downto - 3 ) of
          st_rec1 ;
      type arr_st_rec2 is
        array (integer range -1 downto - 3 ) of
          st_rec2 ;
      type arr_st_rec3 is
        array (integer range -1 downto - 3 ) of
          st_rec3 ;
      type arr_st_arr1 is
        array (integer range -1 downto - 3 ) of
          st_arr1 ;
      type arr_st_arr2 is
        array (integer range -1 downto - 3 ) of
          st_arr2 ;
      type arr_st_arr3 is
        array (integer range -1 downto - 3 ) of
          st_arr3 ;
--
      variable v_boolean_1 : boolean :=
          c_boolean_1 ;
      variable v_bit_1 : bit :=
          c_bit_1 ;
      variable v_severity_level_1 : severity_level :=
          c_severity_level_1 ;
      variable v_character_1 : character :=
          c_character_1 ;
      variable v_st_enum1_1 : st_enum1 :=
          c_st_enum1_1 ;
      variable v_integer_1 : integer :=
          c_integer_1 ;
      variable v_st_int1_1 : st_int1 :=
          c_st_int1_1 ;
      variable v_time_1 : time :=
          c_time_1 ;
      variable v_st_phys1_1 : st_phys1 :=
          c_st_phys1_1 ;
      variable v_real_1 : real :=
          c_real_1 ;
      variable v_st_real1_1 : st_real1 :=
          c_st_real1_1 ;
      variable v_st_rec1_1 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2_1 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3_1 : st_rec3 :=
          c_st_rec3_1 ;
      variable v_st_arr1_1 : st_arr1 :=
          c_st_arr1_1 ;
      variable v_st_arr2_1 : st_arr2 :=
          c_st_arr2_1 ;
      variable v_st_arr3_1 : st_arr3 :=
          c_st_arr3_1 ;
--
      variable v_boolean_2 : boolean :=
          c_boolean_1 ;
      variable v_bit_2 : bit :=
          c_bit_1 ;
      variable v_severity_level_2 : severity_level :=
          c_severity_level_1 ;
      variable v_character_2 : character :=
          c_character_1 ;
      variable v_st_enum1_2 : st_enum1 :=
          c_st_enum1_1 ;
      variable v_integer_2 : integer :=
          c_integer_1 ;
      variable v_st_int1_2 : st_int1 :=
          c_st_int1_1 ;
      variable v_time_2 : time :=
          c_time_1 ;
      variable v_st_phys1_2 : st_phys1 :=
          c_st_phys1_1 ;
      variable v_real_2 : real :=
          c_real_1 ;
      variable v_st_real1_2 : st_real1 :=
          c_st_real1_1 ;
      variable v_st_rec1_2 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2_2 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3_2 : st_rec3 :=
          c_st_rec3_1 ;
      variable v_st_arr1_2 : st_arr1 :=
          c_st_arr1_1 ;
      variable v_st_arr2_2 : st_arr2 :=
          c_st_arr2_1 ;
      variable v_st_arr3_2 : st_arr3 :=
          c_st_arr3_1 ;
--
      variable v_boolean_3 : boolean :=
          c_boolean_1 ;
      variable v_bit_3 : bit :=
          c_bit_1 ;
      variable v_severity_level_3 : severity_level :=
          c_severity_level_1 ;
      variable v_character_3 : character :=
          c_character_1 ;
      variable v_st_enum1_3 : st_enum1 :=
          c_st_enum1_1 ;
      variable v_integer_3 : integer :=
          c_integer_1 ;
      variable v_st_int1_3 : st_int1 :=
          c_st_int1_1 ;
      variable v_time_3 : time :=
          c_time_1 ;
      variable v_st_phys1_3 : st_phys1 :=
          c_st_phys1_1 ;
      variable v_real_3 : real :=
          c_real_1 ;
      variable v_st_real1_3 : st_real1 :=
          c_st_real1_1 ;
      variable v_st_rec1_3 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2_3 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3_3 : st_rec3 :=
          c_st_rec3_1 ;
      variable v_st_arr1_3 : st_arr1 :=
          c_st_arr1_1 ;
      variable v_st_arr2_3 : st_arr2 :=
          c_st_arr2_1 ;
      variable v_st_arr3_3 : st_arr3 :=
          c_st_arr3_1 ;
--
      variable correct : boolean := true ;
--
      procedure Proc1 is
      begin
         ( v_boolean_1
         , v_boolean_2
         , v_boolean_3
         ) := arr_boolean ' (
              (Others => c_boolean_2)) ;
--
         ( v_bit_1
         , v_bit_2
         , v_bit_3
         ) := arr_bit ' (
              (Others => c_bit_2)) ;
--
         ( v_severity_level_1
         , v_severity_level_2
         , v_severity_level_3
         ) := arr_severity_level ' (
              (Others => c_severity_level_2)) ;
--
         ( v_character_1
         , v_character_2
         , v_character_3
         ) := arr_character ' (
              (Others => c_character_2)) ;
--
         ( v_st_enum1_1
         , v_st_enum1_2
         , v_st_enum1_3
         ) := arr_st_enum1 ' (
              (Others => c_st_enum1_2)) ;
--
         ( v_integer_1
         , v_integer_2
         , v_integer_3
         ) := arr_integer ' (
              (Others => c_integer_2)) ;
--
         ( v_st_int1_1
         , v_st_int1_2
         , v_st_int1_3
         ) := arr_st_int1 ' (
              (Others => c_st_int1_2)) ;
--
         ( v_time_1
         , v_time_2
         , v_time_3
         ) := arr_time ' (
              (Others => c_time_2)) ;
--
         ( v_st_phys1_1
         , v_st_phys1_2
         , v_st_phys1_3
         ) := arr_st_phys1 ' (
              (Others => c_st_phys1_2)) ;
--
         ( v_real_1
         , v_real_2
         , v_real_3
         ) := arr_real ' (
              (Others => c_real_2)) ;
--
         ( v_st_real1_1
         , v_st_real1_2
         , v_st_real1_3
         ) := arr_st_real1 ' (
              (Others => c_st_real1_2)) ;
--
         ( v_st_rec1_1
         , v_st_rec1_2
         , v_st_rec1_3
         ) := arr_st_rec1 ' (
              (Others => c_st_rec1_2)) ;
--
         ( v_st_rec2_1
         , v_st_rec2_2
         , v_st_rec2_3
         ) := arr_st_rec2 ' (
              (Others => c_st_rec2_2)) ;
--
         ( v_st_rec3_1
         , v_st_rec3_2
         , v_st_rec3_3
         ) := arr_st_rec3 ' (
              (Others => c_st_rec3_2)) ;
--
         ( v_st_arr1_1
         , v_st_arr1_2
         , v_st_arr1_3
         ) := arr_st_arr1 ' (
              (Others => c_st_arr1_2)) ;
--
         ( v_st_arr2_1
         , v_st_arr2_2
         , v_st_arr2_3
         ) := arr_st_arr2 ' (
              (Others => c_st_arr2_2)) ;
--
         ( v_st_arr3_1
         , v_st_arr3_2
         , v_st_arr3_3
         ) := arr_st_arr3 ' (
              (Others => c_st_arr3_2)) ;
--
--
      end Proc1 ;
   begin
      Proc1 ;
      correct := correct and
                 v_boolean_1 = c_boolean_2 ;
      correct := correct and
                 v_bit_1 = c_bit_2 ;
      correct := correct and
                 v_severity_level_1 = c_severity_level_2 ;
      correct := correct and
                 v_character_1 = c_character_2 ;
      correct := correct and
                 v_st_enum1_1 = c_st_enum1_2 ;
      correct := correct and
                 v_integer_1 = c_integer_2 ;
      correct := correct and
                 v_st_int1_1 = c_st_int1_2 ;
      correct := correct and
                 v_time_1 = c_time_2 ;
      correct := correct and
                 v_st_phys1_1 = c_st_phys1_2 ;
      correct := correct and
                 v_real_1 = c_real_2 ;
      correct := correct and
                 v_st_real1_1 = c_st_real1_2 ;
      correct := correct and
                 v_st_rec1_1 = c_st_rec1_2 ;
      correct := correct and
                 v_st_rec2_1 = c_st_rec2_2 ;
      correct := correct and
                 v_st_rec3_1 = c_st_rec3_2 ;
      correct := correct and
                 v_st_arr1_1 = c_st_arr1_2 ;
      correct := correct and
                 v_st_arr2_1 = c_st_arr2_2 ;
      correct := correct and
                 v_st_arr3_1 = c_st_arr3_2 ;
--
      correct := correct and
                 v_boolean_2 = c_boolean_2 ;
      correct := correct and
                 v_bit_2 = c_bit_2 ;
      correct := correct and
                 v_severity_level_2 = c_severity_level_2 ;
      correct := correct and
                 v_character_2 = c_character_2 ;
      correct := correct and
                 v_st_enum1_2 = c_st_enum1_2 ;
      correct := correct and
                 v_integer_2 = c_integer_2 ;
      correct := correct and
                 v_st_int1_2 = c_st_int1_2 ;
      correct := correct and
                 v_time_2 = c_time_2 ;
      correct := correct and
                 v_st_phys1_2 = c_st_phys1_2 ;
      correct := correct and
                 v_real_2 = c_real_2 ;
      correct := correct and
                 v_st_real1_2 = c_st_real1_2 ;
      correct := correct and
                 v_st_rec1_2 = c_st_rec1_2 ;
      correct := correct and
                 v_st_rec2_2 = c_st_rec2_2 ;
      correct := correct and
                 v_st_rec3_2 = c_st_rec3_2 ;
      correct := correct and
                 v_st_arr1_2 = c_st_arr1_2 ;
      correct := correct and
                 v_st_arr2_2 = c_st_arr2_2 ;
      correct := correct and
                 v_st_arr3_2 = c_st_arr3_2 ;
--
      correct := correct and
                 v_boolean_3 = c_boolean_2 ;
      correct := correct and
                 v_bit_3 = c_bit_2 ;
      correct := correct and
                 v_severity_level_3 = c_severity_level_2 ;
      correct := correct and
                 v_character_3 = c_character_2 ;
      correct := correct and
                 v_st_enum1_3 = c_st_enum1_2 ;
      correct := correct and
                 v_integer_3 = c_integer_2 ;
      correct := correct and
                 v_st_int1_3 = c_st_int1_2 ;
      correct := correct and
                 v_time_3 = c_time_2 ;
      correct := correct and
                 v_st_phys1_3 = c_st_phys1_2 ;
      correct := correct and
                 v_real_3 = c_real_2 ;
      correct := correct and
                 v_st_real1_3 = c_st_real1_2 ;
      correct := correct and
                 v_st_rec1_3 = c_st_rec1_2 ;
      correct := correct and
                 v_st_rec2_3 = c_st_rec2_2 ;
      correct := correct and
                 v_st_rec3_3 = c_st_rec3_2 ;
      correct := correct and
                 v_st_arr1_3 = c_st_arr1_2 ;
      correct := correct and
                 v_st_arr2_3 = c_st_arr2_2 ;
      correct := correct and
                 v_st_arr3_3 = c_st_arr3_2 ;
--
      test_report ( "ARCH00031.P3" ,
                    "Target of a variable assignment may be a " &
                    "aggregate of simple names" ,
                    correct) ;
   end process P3 ;
--
   P4 :
   process ( Dummy )
      type arr_boolean is
        array (integer range -1 downto - 3 ) of
          boolean ;
      type arr_bit is
        array (integer range -1 downto - 3 ) of
          bit ;
      type arr_severity_level is
        array (integer range -1 downto - 3 ) of
          severity_level ;
      type arr_character is
        array (integer range -1 downto - 3 ) of
          character ;
      type arr_st_enum1 is
        array (integer range -1 downto - 3 ) of
          st_enum1 ;
      type arr_integer is
        array (integer range -1 downto - 3 ) of
          integer ;
      type arr_st_int1 is
        array (integer range -1 downto - 3 ) of
          st_int1 ;
      type arr_time is
        array (integer range -1 downto - 3 ) of
          time ;
      type arr_st_phys1 is
        array (integer range -1 downto - 3 ) of
          st_phys1 ;
      type arr_real is
        array (integer range -1 downto - 3 ) of
          real ;
      type arr_st_real1 is
        array (integer range -1 downto - 3 ) of
          st_real1 ;
      type arr_st_rec1 is
        array (integer range -1 downto - 3 ) of
          st_rec1 ;
      type arr_st_rec2 is
        array (integer range -1 downto - 3 ) of
          st_rec2 ;
      type arr_st_rec3 is
        array (integer range -1 downto - 3 ) of
          st_rec3 ;
      type arr_st_arr1 is
        array (integer range -1 downto - 3 ) of
          st_arr1 ;
      type arr_st_arr2 is
        array (integer range -1 downto - 3 ) of
          st_arr2 ;
      type arr_st_arr3 is
        array (integer range -1 downto - 3 ) of
          st_arr3 ;
--
      variable v_boolean_1 : boolean :=
          c_boolean_1 ;
      variable v_bit_1 : bit :=
          c_bit_1 ;
      variable v_severity_level_1 : severity_level :=
          c_severity_level_1 ;
      variable v_character_1 : character :=
          c_character_1 ;
      variable v_st_enum1_1 : st_enum1 :=
          c_st_enum1_1 ;
      variable v_integer_1 : integer :=
          c_integer_1 ;
      variable v_st_int1_1 : st_int1 :=
          c_st_int1_1 ;
      variable v_time_1 : time :=
          c_time_1 ;
      variable v_st_phys1_1 : st_phys1 :=
          c_st_phys1_1 ;
      variable v_real_1 : real :=
          c_real_1 ;
      variable v_st_real1_1 : st_real1 :=
          c_st_real1_1 ;
      variable v_st_rec1_1 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2_1 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3_1 : st_rec3 :=
          c_st_rec3_1 ;
      variable v_st_arr1_1 : st_arr1 :=
          c_st_arr1_1 ;
      variable v_st_arr2_1 : st_arr2 :=
          c_st_arr2_1 ;
      variable v_st_arr3_1 : st_arr3 :=
          c_st_arr3_1 ;
--
      variable v_boolean_2 : boolean :=
          c_boolean_1 ;
      variable v_bit_2 : bit :=
          c_bit_1 ;
      variable v_severity_level_2 : severity_level :=
          c_severity_level_1 ;
      variable v_character_2 : character :=
          c_character_1 ;
      variable v_st_enum1_2 : st_enum1 :=
          c_st_enum1_1 ;
      variable v_integer_2 : integer :=
          c_integer_1 ;
      variable v_st_int1_2 : st_int1 :=
          c_st_int1_1 ;
      variable v_time_2 : time :=
          c_time_1 ;
      variable v_st_phys1_2 : st_phys1 :=
          c_st_phys1_1 ;
      variable v_real_2 : real :=
          c_real_1 ;
      variable v_st_real1_2 : st_real1 :=
          c_st_real1_1 ;
      variable v_st_rec1_2 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2_2 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3_2 : st_rec3 :=
          c_st_rec3_1 ;
      variable v_st_arr1_2 : st_arr1 :=
          c_st_arr1_1 ;
      variable v_st_arr2_2 : st_arr2 :=
          c_st_arr2_1 ;
      variable v_st_arr3_2 : st_arr3 :=
          c_st_arr3_1 ;
--
      variable v_boolean_3 : boolean :=
          c_boolean_1 ;
      variable v_bit_3 : bit :=
          c_bit_1 ;
      variable v_severity_level_3 : severity_level :=
          c_severity_level_1 ;
      variable v_character_3 : character :=
          c_character_1 ;
      variable v_st_enum1_3 : st_enum1 :=
          c_st_enum1_1 ;
      variable v_integer_3 : integer :=
          c_integer_1 ;
      variable v_st_int1_3 : st_int1 :=
          c_st_int1_1 ;
      variable v_time_3 : time :=
          c_time_1 ;
      variable v_st_phys1_3 : st_phys1 :=
          c_st_phys1_1 ;
      variable v_real_3 : real :=
          c_real_1 ;
      variable v_st_real1_3 : st_real1 :=
          c_st_real1_1 ;
      variable v_st_rec1_3 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2_3 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3_3 : st_rec3 :=
          c_st_rec3_1 ;
      variable v_st_arr1_3 : st_arr1 :=
          c_st_arr1_1 ;
      variable v_st_arr2_3 : st_arr2 :=
          c_st_arr2_1 ;
      variable v_st_arr3_3 : st_arr3 :=
          c_st_arr3_1 ;
--
      variable correct : boolean := true ;
--
      procedure Proc1 (
              v_boolean_2 : inout boolean
            ; v_bit_2 : inout bit
            ; v_severity_level_2 : inout severity_level
            ; v_character_2 : inout character
            ; v_st_enum1_2 : inout st_enum1
            ; v_integer_2 : inout integer
            ; v_st_int1_2 : inout st_int1
            ; v_time_2 : inout time
            ; v_st_phys1_2 : inout st_phys1
            ; v_real_2 : inout real
            ; v_st_real1_2 : inout st_real1
            ; v_st_rec1_2 : inout st_rec1
            ; v_st_rec2_2 : inout st_rec2
            ; v_st_rec3_2 : inout st_rec3
            ; v_st_arr1_2 : inout st_arr1
            ; v_st_arr2_2 : inout st_arr2
            ; v_st_arr3_2 : inout st_arr3
                      )
      is
      begin
         ( v_boolean_1
         , v_boolean_2
         , v_boolean_3
         ) := arr_boolean ' (
              (Others => c_boolean_2)) ;
--
         ( v_bit_1
         , v_bit_2
         , v_bit_3
         ) := arr_bit ' (
              (Others => c_bit_2)) ;
--
         ( v_severity_level_1
         , v_severity_level_2
         , v_severity_level_3
         ) := arr_severity_level ' (
              (Others => c_severity_level_2)) ;
--
         ( v_character_1
         , v_character_2
         , v_character_3
         ) := arr_character ' (
              (Others => c_character_2)) ;
--
         ( v_st_enum1_1
         , v_st_enum1_2
         , v_st_enum1_3
         ) := arr_st_enum1 ' (
              (Others => c_st_enum1_2)) ;
--
         ( v_integer_1
         , v_integer_2
         , v_integer_3
         ) := arr_integer ' (
              (Others => c_integer_2)) ;
--
         ( v_st_int1_1
         , v_st_int1_2
         , v_st_int1_3
         ) := arr_st_int1 ' (
              (Others => c_st_int1_2)) ;
--
         ( v_time_1
         , v_time_2
         , v_time_3
         ) := arr_time ' (
              (Others => c_time_2)) ;
--
         ( v_st_phys1_1
         , v_st_phys1_2
         , v_st_phys1_3
         ) := arr_st_phys1 ' (
              (Others => c_st_phys1_2)) ;
--
         ( v_real_1
         , v_real_2
         , v_real_3
         ) := arr_real ' (
              (Others => c_real_2)) ;
--
         ( v_st_real1_1
         , v_st_real1_2
         , v_st_real1_3
         ) := arr_st_real1 ' (
              (Others => c_st_real1_2)) ;
--
         ( v_st_rec1_1
         , v_st_rec1_2
         , v_st_rec1_3
         ) := arr_st_rec1 ' (
              (Others => c_st_rec1_2)) ;
--
         ( v_st_rec2_1
         , v_st_rec2_2
         , v_st_rec2_3
         ) := arr_st_rec2 ' (
              (Others => c_st_rec2_2)) ;
--
         ( v_st_rec3_1
         , v_st_rec3_2
         , v_st_rec3_3
         ) := arr_st_rec3 ' (
              (Others => c_st_rec3_2)) ;
--
         ( v_st_arr1_1
         , v_st_arr1_2
         , v_st_arr1_3
         ) := arr_st_arr1 ' (
              (Others => c_st_arr1_2)) ;
--
         ( v_st_arr2_1
         , v_st_arr2_2
         , v_st_arr2_3
         ) := arr_st_arr2 ' (
              (Others => c_st_arr2_2)) ;
--
         ( v_st_arr3_1
         , v_st_arr3_2
         , v_st_arr3_3
         ) := arr_st_arr3 ' (
              (Others => c_st_arr3_2)) ;
--
--
      end Proc1 ;
   begin
      Proc1 (
              v_boolean_2
            , v_bit_2
            , v_severity_level_2
            , v_character_2
            , v_st_enum1_2
            , v_integer_2
            , v_st_int1_2
            , v_time_2
            , v_st_phys1_2
            , v_real_2
            , v_st_real1_2
            , v_st_rec1_2
            , v_st_rec2_2
            , v_st_rec3_2
            , v_st_arr1_2
            , v_st_arr2_2
            , v_st_arr3_2
            ) ;
      correct := correct and
                 v_boolean_1 = c_boolean_2 ;
      correct := correct and
                 v_bit_1 = c_bit_2 ;
      correct := correct and
                 v_severity_level_1 = c_severity_level_2 ;
      correct := correct and
                 v_character_1 = c_character_2 ;
      correct := correct and
                 v_st_enum1_1 = c_st_enum1_2 ;
      correct := correct and
                 v_integer_1 = c_integer_2 ;
      correct := correct and
                 v_st_int1_1 = c_st_int1_2 ;
      correct := correct and
                 v_time_1 = c_time_2 ;
      correct := correct and
                 v_st_phys1_1 = c_st_phys1_2 ;
      correct := correct and
                 v_real_1 = c_real_2 ;
      correct := correct and
                 v_st_real1_1 = c_st_real1_2 ;
      correct := correct and
                 v_st_rec1_1 = c_st_rec1_2 ;
      correct := correct and
                 v_st_rec2_1 = c_st_rec2_2 ;
      correct := correct and
                 v_st_rec3_1 = c_st_rec3_2 ;
      correct := correct and
                 v_st_arr1_1 = c_st_arr1_2 ;
      correct := correct and
                 v_st_arr2_1 = c_st_arr2_2 ;
      correct := correct and
                 v_st_arr3_1 = c_st_arr3_2 ;
--
      correct := correct and
                 v_boolean_2 = c_boolean_2 ;
      correct := correct and
                 v_bit_2 = c_bit_2 ;
      correct := correct and
                 v_severity_level_2 = c_severity_level_2 ;
      correct := correct and
                 v_character_2 = c_character_2 ;
      correct := correct and
                 v_st_enum1_2 = c_st_enum1_2 ;
      correct := correct and
                 v_integer_2 = c_integer_2 ;
      correct := correct and
                 v_st_int1_2 = c_st_int1_2 ;
      correct := correct and
                 v_time_2 = c_time_2 ;
      correct := correct and
                 v_st_phys1_2 = c_st_phys1_2 ;
      correct := correct and
                 v_real_2 = c_real_2 ;
      correct := correct and
                 v_st_real1_2 = c_st_real1_2 ;
      correct := correct and
                 v_st_rec1_2 = c_st_rec1_2 ;
      correct := correct and
                 v_st_rec2_2 = c_st_rec2_2 ;
      correct := correct and
                 v_st_rec3_2 = c_st_rec3_2 ;
      correct := correct and
                 v_st_arr1_2 = c_st_arr1_2 ;
      correct := correct and
                 v_st_arr2_2 = c_st_arr2_2 ;
      correct := correct and
                 v_st_arr3_2 = c_st_arr3_2 ;
--
      correct := correct and
                 v_boolean_3 = c_boolean_2 ;
      correct := correct and
                 v_bit_3 = c_bit_2 ;
      correct := correct and
                 v_severity_level_3 = c_severity_level_2 ;
      correct := correct and
                 v_character_3 = c_character_2 ;
      correct := correct and
                 v_st_enum1_3 = c_st_enum1_2 ;
      correct := correct and
                 v_integer_3 = c_integer_2 ;
      correct := correct and
                 v_st_int1_3 = c_st_int1_2 ;
      correct := correct and
                 v_time_3 = c_time_2 ;
      correct := correct and
                 v_st_phys1_3 = c_st_phys1_2 ;
      correct := correct and
                 v_real_3 = c_real_2 ;
      correct := correct and
                 v_st_real1_3 = c_st_real1_2 ;
      correct := correct and
                 v_st_rec1_3 = c_st_rec1_2 ;
      correct := correct and
                 v_st_rec2_3 = c_st_rec2_2 ;
      correct := correct and
                 v_st_rec3_3 = c_st_rec3_2 ;
      correct := correct and
                 v_st_arr1_3 = c_st_arr1_2 ;
      correct := correct and
                 v_st_arr2_3 = c_st_arr2_2 ;
      correct := correct and
                 v_st_arr3_3 = c_st_arr3_2 ;
--
      test_report ( "ARCH00031.P4" ,
                    "Target of a variable assignment may be a " &
                    "aggregate of simple names" ,
                    correct) ;
   end process P4 ;
--
end ARCH00031 ;
--
entity ENT00031_Test_Bench is
end ENT00031_Test_Bench ;
--
architecture ARCH00031_Test_Bench of ENT00031_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00031 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00031_Test_Bench ;
