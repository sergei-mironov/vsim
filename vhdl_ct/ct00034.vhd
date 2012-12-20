-- NEED RESULT: ARCH00034.P1: Target of a variable assignment may be a slice passed
-- NEED RESULT: ARCH00034.P2: Target of a variable assignment may be a slice passed
-- NEED RESULT: ARCH00034.P3: Target of a variable assignment may be a slice passed
-- NEED RESULT: ARCH00034.P4: Target of a variable assignment may be a slice passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00034
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
--    E00000(ARCH00034)
--    ENT00034_Test_Bench(ARCH00034_Test_Bench)
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
architecture ARCH00034 of E00000 is
   signal Dummy : Boolean := false ;
--
begin
   P1 :
   process ( Dummy )
      variable v_st_boolean_vector : st_boolean_vector :=
          c_st_boolean_vector_1 ;
      variable v_st_bit_vector : st_bit_vector :=
          c_st_bit_vector_1 ;
      variable v_st_severity_level_vector : st_severity_level_vector :=
          c_st_severity_level_vector_1 ;
      variable v_st_string : st_string :=
          c_st_string_1 ;
      variable v_st_enum1_vector : st_enum1_vector :=
          c_st_enum1_vector_1 ;
      variable v_st_integer_vector : st_integer_vector :=
          c_st_integer_vector_1 ;
      variable v_st_int1_vector : st_int1_vector :=
          c_st_int1_vector_1 ;
      variable v_st_time_vector : st_time_vector :=
          c_st_time_vector_1 ;
      variable v_st_phys1_vector : st_phys1_vector :=
          c_st_phys1_vector_1 ;
      variable v_st_real_vector : st_real_vector :=
          c_st_real_vector_1 ;
      variable v_st_real1_vector : st_real1_vector :=
          c_st_real1_vector_1 ;
      variable v_st_rec1_vector : st_rec1_vector :=
          c_st_rec1_vector_1 ;
      variable v_st_rec2_vector : st_rec2_vector :=
          c_st_rec2_vector_1 ;
      variable v_st_rec3_vector : st_rec3_vector :=
          c_st_rec3_vector_1 ;
      variable v_st_arr1_vector : st_arr1_vector :=
          c_st_arr1_vector_1 ;
      variable v_st_arr2_vector : st_arr2_vector :=
          c_st_arr2_vector_1 ;
      variable v_st_arr3_vector : st_arr3_vector :=
          c_st_arr3_vector_1 ;
--
      variable correct : boolean := true ;
   begin
      v_st_boolean_vector(lowb+1 to highb-1) :=
          c_st_boolean_vector_2(lowb+1 to highb-1) ;
      v_st_bit_vector(lowb+1 to highb-1) :=
          c_st_bit_vector_2(lowb+1 to highb-1) ;
      v_st_severity_level_vector(lowb+1 to highb-1) :=
          c_st_severity_level_vector_2(lowb+1 to highb-1) ;
      v_st_string(lowb+1 to highb-1) :=
          c_st_string_2(lowb+1 to highb-1) ;
      v_st_enum1_vector(lowb+1 to highb-1) :=
          c_st_enum1_vector_2(lowb+1 to highb-1) ;
      v_st_integer_vector(lowb+1 to highb-1) :=
          c_st_integer_vector_2(lowb+1 to highb-1) ;
      v_st_int1_vector(lowb+1 to highb-1) :=
          c_st_int1_vector_2(lowb+1 to highb-1) ;
      v_st_time_vector(lowb+1 to highb-1) :=
          c_st_time_vector_2(lowb+1 to highb-1) ;
      v_st_phys1_vector(lowb+1 to highb-1) :=
          c_st_phys1_vector_2(lowb+1 to highb-1) ;
      v_st_real_vector(lowb+1 to highb-1) :=
          c_st_real_vector_2(lowb+1 to highb-1) ;
      v_st_real1_vector(lowb+1 to highb-1) :=
          c_st_real1_vector_2(lowb+1 to highb-1) ;
      v_st_rec1_vector(lowb+1 to highb-1) :=
          c_st_rec1_vector_2(lowb+1 to highb-1) ;
      v_st_rec2_vector(lowb+1 to highb-1) :=
          c_st_rec2_vector_2(lowb+1 to highb-1) ;
      v_st_rec3_vector(lowb+1 to highb-1) :=
          c_st_rec3_vector_2(lowb+1 to highb-1) ;
      v_st_arr1_vector(lowb+1 to highb-1) :=
          c_st_arr1_vector_2(lowb+1 to highb-1) ;
      v_st_arr2_vector(lowb+1 to highb-1) :=
          c_st_arr2_vector_2(lowb+1 to highb-1) ;
      v_st_arr3_vector(lowb+1 to highb-1) :=
          c_st_arr3_vector_2(lowb+1 to highb-1) ;
--
      correct := correct and
                 v_st_boolean_vector(lowb+1 to highb-1) =
                 c_st_boolean_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_bit_vector(lowb+1 to highb-1) =
                 c_st_bit_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_severity_level_vector(lowb+1 to highb-1) =
                 c_st_severity_level_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_string(lowb+1 to highb-1) =
                 c_st_string_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_enum1_vector(lowb+1 to highb-1) =
                 c_st_enum1_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_integer_vector(lowb+1 to highb-1) =
                 c_st_integer_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_int1_vector(lowb+1 to highb-1) =
                 c_st_int1_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_time_vector(lowb+1 to highb-1) =
                 c_st_time_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_phys1_vector(lowb+1 to highb-1) =
                 c_st_phys1_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_real_vector(lowb+1 to highb-1) =
                 c_st_real_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_real1_vector(lowb+1 to highb-1) =
                 c_st_real1_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_rec1_vector(lowb+1 to highb-1) =
                 c_st_rec1_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_rec2_vector(lowb+1 to highb-1) =
                 c_st_rec2_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_rec3_vector(lowb+1 to highb-1) =
                 c_st_rec3_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_arr1_vector(lowb+1 to highb-1) =
                 c_st_arr1_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_arr2_vector(lowb+1 to highb-1) =
                 c_st_arr2_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_arr3_vector(lowb+1 to highb-1) =
                 c_st_arr3_vector_2(lowb+1 to highb-1) ;
--
      test_report ( "ARCH00034.P1" ,
                    "Target of a variable assignment may be a " &
                    "slice" ,
                    correct) ;
   end process P1 ;
--
   P2 :
   process ( Dummy )
      variable correct : boolean := true ;
--
      procedure Proc1 is
         variable v_st_boolean_vector : st_boolean_vector :=
             c_st_boolean_vector_1 ;
         variable v_st_bit_vector : st_bit_vector :=
             c_st_bit_vector_1 ;
         variable v_st_severity_level_vector : st_severity_level_vector :=
             c_st_severity_level_vector_1 ;
         variable v_st_string : st_string :=
             c_st_string_1 ;
         variable v_st_enum1_vector : st_enum1_vector :=
             c_st_enum1_vector_1 ;
         variable v_st_integer_vector : st_integer_vector :=
             c_st_integer_vector_1 ;
         variable v_st_int1_vector : st_int1_vector :=
             c_st_int1_vector_1 ;
         variable v_st_time_vector : st_time_vector :=
             c_st_time_vector_1 ;
         variable v_st_phys1_vector : st_phys1_vector :=
             c_st_phys1_vector_1 ;
         variable v_st_real_vector : st_real_vector :=
             c_st_real_vector_1 ;
         variable v_st_real1_vector : st_real1_vector :=
             c_st_real1_vector_1 ;
         variable v_st_rec1_vector : st_rec1_vector :=
             c_st_rec1_vector_1 ;
         variable v_st_rec2_vector : st_rec2_vector :=
             c_st_rec2_vector_1 ;
         variable v_st_rec3_vector : st_rec3_vector :=
             c_st_rec3_vector_1 ;
         variable v_st_arr1_vector : st_arr1_vector :=
             c_st_arr1_vector_1 ;
         variable v_st_arr2_vector : st_arr2_vector :=
             c_st_arr2_vector_1 ;
         variable v_st_arr3_vector : st_arr3_vector :=
             c_st_arr3_vector_1 ;
--
      begin
         v_st_boolean_vector(lowb+1 to highb-1) :=
             c_st_boolean_vector_2(lowb+1 to highb-1) ;
         v_st_bit_vector(lowb+1 to highb-1) :=
             c_st_bit_vector_2(lowb+1 to highb-1) ;
         v_st_severity_level_vector(lowb+1 to highb-1) :=
             c_st_severity_level_vector_2(lowb+1 to highb-1) ;
         v_st_string(lowb+1 to highb-1) :=
             c_st_string_2(lowb+1 to highb-1) ;
         v_st_enum1_vector(lowb+1 to highb-1) :=
             c_st_enum1_vector_2(lowb+1 to highb-1) ;
         v_st_integer_vector(lowb+1 to highb-1) :=
             c_st_integer_vector_2(lowb+1 to highb-1) ;
         v_st_int1_vector(lowb+1 to highb-1) :=
             c_st_int1_vector_2(lowb+1 to highb-1) ;
         v_st_time_vector(lowb+1 to highb-1) :=
             c_st_time_vector_2(lowb+1 to highb-1) ;
         v_st_phys1_vector(lowb+1 to highb-1) :=
             c_st_phys1_vector_2(lowb+1 to highb-1) ;
         v_st_real_vector(lowb+1 to highb-1) :=
             c_st_real_vector_2(lowb+1 to highb-1) ;
         v_st_real1_vector(lowb+1 to highb-1) :=
             c_st_real1_vector_2(lowb+1 to highb-1) ;
         v_st_rec1_vector(lowb+1 to highb-1) :=
             c_st_rec1_vector_2(lowb+1 to highb-1) ;
         v_st_rec2_vector(lowb+1 to highb-1) :=
             c_st_rec2_vector_2(lowb+1 to highb-1) ;
         v_st_rec3_vector(lowb+1 to highb-1) :=
             c_st_rec3_vector_2(lowb+1 to highb-1) ;
         v_st_arr1_vector(lowb+1 to highb-1) :=
             c_st_arr1_vector_2(lowb+1 to highb-1) ;
         v_st_arr2_vector(lowb+1 to highb-1) :=
             c_st_arr2_vector_2(lowb+1 to highb-1) ;
         v_st_arr3_vector(lowb+1 to highb-1) :=
             c_st_arr3_vector_2(lowb+1 to highb-1) ;
--
         correct := correct and
                    v_st_boolean_vector(lowb+1 to highb-1) =
                    c_st_boolean_vector_2(lowb+1 to highb-1) ;
         correct := correct and
                    v_st_bit_vector(lowb+1 to highb-1) =
                    c_st_bit_vector_2(lowb+1 to highb-1) ;
         correct := correct and
                    v_st_severity_level_vector(lowb+1 to highb-1) =
                    c_st_severity_level_vector_2(lowb+1 to highb-1) ;
         correct := correct and
                    v_st_string(lowb+1 to highb-1) =
                    c_st_string_2(lowb+1 to highb-1) ;
         correct := correct and
                    v_st_enum1_vector(lowb+1 to highb-1) =
                    c_st_enum1_vector_2(lowb+1 to highb-1) ;
         correct := correct and
                    v_st_integer_vector(lowb+1 to highb-1) =
                    c_st_integer_vector_2(lowb+1 to highb-1) ;
         correct := correct and
                    v_st_int1_vector(lowb+1 to highb-1) =
                    c_st_int1_vector_2(lowb+1 to highb-1) ;
         correct := correct and
                    v_st_time_vector(lowb+1 to highb-1) =
                    c_st_time_vector_2(lowb+1 to highb-1) ;
         correct := correct and
                    v_st_phys1_vector(lowb+1 to highb-1) =
                    c_st_phys1_vector_2(lowb+1 to highb-1) ;
         correct := correct and
                    v_st_real_vector(lowb+1 to highb-1) =
                    c_st_real_vector_2(lowb+1 to highb-1) ;
         correct := correct and
                    v_st_real1_vector(lowb+1 to highb-1) =
                    c_st_real1_vector_2(lowb+1 to highb-1) ;
         correct := correct and
                    v_st_rec1_vector(lowb+1 to highb-1) =
                    c_st_rec1_vector_2(lowb+1 to highb-1) ;
         correct := correct and
                    v_st_rec2_vector(lowb+1 to highb-1) =
                    c_st_rec2_vector_2(lowb+1 to highb-1) ;
         correct := correct and
                    v_st_rec3_vector(lowb+1 to highb-1) =
                    c_st_rec3_vector_2(lowb+1 to highb-1) ;
         correct := correct and
                    v_st_arr1_vector(lowb+1 to highb-1) =
                    c_st_arr1_vector_2(lowb+1 to highb-1) ;
         correct := correct and
                    v_st_arr2_vector(lowb+1 to highb-1) =
                    c_st_arr2_vector_2(lowb+1 to highb-1) ;
         correct := correct and
                    v_st_arr3_vector(lowb+1 to highb-1) =
                    c_st_arr3_vector_2(lowb+1 to highb-1) ;
--
      end Proc1 ;
   begin
      Proc1 ;
      test_report ( "ARCH00034.P2" ,
                    "Target of a variable assignment may be a " &
                    "slice" ,
                    correct) ;
   end process P2 ;
--
   P3 :
   process ( Dummy )
      variable v_st_boolean_vector : st_boolean_vector :=
          c_st_boolean_vector_1 ;
      variable v_st_bit_vector : st_bit_vector :=
          c_st_bit_vector_1 ;
      variable v_st_severity_level_vector : st_severity_level_vector :=
          c_st_severity_level_vector_1 ;
      variable v_st_string : st_string :=
          c_st_string_1 ;
      variable v_st_enum1_vector : st_enum1_vector :=
          c_st_enum1_vector_1 ;
      variable v_st_integer_vector : st_integer_vector :=
          c_st_integer_vector_1 ;
      variable v_st_int1_vector : st_int1_vector :=
          c_st_int1_vector_1 ;
      variable v_st_time_vector : st_time_vector :=
          c_st_time_vector_1 ;
      variable v_st_phys1_vector : st_phys1_vector :=
          c_st_phys1_vector_1 ;
      variable v_st_real_vector : st_real_vector :=
          c_st_real_vector_1 ;
      variable v_st_real1_vector : st_real1_vector :=
          c_st_real1_vector_1 ;
      variable v_st_rec1_vector : st_rec1_vector :=
          c_st_rec1_vector_1 ;
      variable v_st_rec2_vector : st_rec2_vector :=
          c_st_rec2_vector_1 ;
      variable v_st_rec3_vector : st_rec3_vector :=
          c_st_rec3_vector_1 ;
      variable v_st_arr1_vector : st_arr1_vector :=
          c_st_arr1_vector_1 ;
      variable v_st_arr2_vector : st_arr2_vector :=
          c_st_arr2_vector_1 ;
      variable v_st_arr3_vector : st_arr3_vector :=
          c_st_arr3_vector_1 ;
--
      variable correct : boolean := true ;
--
      procedure Proc1 is
      begin
         v_st_boolean_vector(lowb+1 to highb-1) :=
             c_st_boolean_vector_2(lowb+1 to highb-1) ;
         v_st_bit_vector(lowb+1 to highb-1) :=
             c_st_bit_vector_2(lowb+1 to highb-1) ;
         v_st_severity_level_vector(lowb+1 to highb-1) :=
             c_st_severity_level_vector_2(lowb+1 to highb-1) ;
         v_st_string(lowb+1 to highb-1) :=
             c_st_string_2(lowb+1 to highb-1) ;
         v_st_enum1_vector(lowb+1 to highb-1) :=
             c_st_enum1_vector_2(lowb+1 to highb-1) ;
         v_st_integer_vector(lowb+1 to highb-1) :=
             c_st_integer_vector_2(lowb+1 to highb-1) ;
         v_st_int1_vector(lowb+1 to highb-1) :=
             c_st_int1_vector_2(lowb+1 to highb-1) ;
         v_st_time_vector(lowb+1 to highb-1) :=
             c_st_time_vector_2(lowb+1 to highb-1) ;
         v_st_phys1_vector(lowb+1 to highb-1) :=
             c_st_phys1_vector_2(lowb+1 to highb-1) ;
         v_st_real_vector(lowb+1 to highb-1) :=
             c_st_real_vector_2(lowb+1 to highb-1) ;
         v_st_real1_vector(lowb+1 to highb-1) :=
             c_st_real1_vector_2(lowb+1 to highb-1) ;
         v_st_rec1_vector(lowb+1 to highb-1) :=
             c_st_rec1_vector_2(lowb+1 to highb-1) ;
         v_st_rec2_vector(lowb+1 to highb-1) :=
             c_st_rec2_vector_2(lowb+1 to highb-1) ;
         v_st_rec3_vector(lowb+1 to highb-1) :=
             c_st_rec3_vector_2(lowb+1 to highb-1) ;
         v_st_arr1_vector(lowb+1 to highb-1) :=
             c_st_arr1_vector_2(lowb+1 to highb-1) ;
         v_st_arr2_vector(lowb+1 to highb-1) :=
             c_st_arr2_vector_2(lowb+1 to highb-1) ;
         v_st_arr3_vector(lowb+1 to highb-1) :=
             c_st_arr3_vector_2(lowb+1 to highb-1) ;
--
      end Proc1 ;
   begin
      Proc1 ;
      correct := correct and
                 v_st_boolean_vector(lowb+1 to highb-1) =
                 c_st_boolean_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_bit_vector(lowb+1 to highb-1) =
                 c_st_bit_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_severity_level_vector(lowb+1 to highb-1) =
                 c_st_severity_level_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_string(lowb+1 to highb-1) =
                 c_st_string_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_enum1_vector(lowb+1 to highb-1) =
                 c_st_enum1_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_integer_vector(lowb+1 to highb-1) =
                 c_st_integer_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_int1_vector(lowb+1 to highb-1) =
                 c_st_int1_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_time_vector(lowb+1 to highb-1) =
                 c_st_time_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_phys1_vector(lowb+1 to highb-1) =
                 c_st_phys1_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_real_vector(lowb+1 to highb-1) =
                 c_st_real_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_real1_vector(lowb+1 to highb-1) =
                 c_st_real1_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_rec1_vector(lowb+1 to highb-1) =
                 c_st_rec1_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_rec2_vector(lowb+1 to highb-1) =
                 c_st_rec2_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_rec3_vector(lowb+1 to highb-1) =
                 c_st_rec3_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_arr1_vector(lowb+1 to highb-1) =
                 c_st_arr1_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_arr2_vector(lowb+1 to highb-1) =
                 c_st_arr2_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_arr3_vector(lowb+1 to highb-1) =
                 c_st_arr3_vector_2(lowb+1 to highb-1) ;
--
      test_report ( "ARCH00034.P3" ,
                    "Target of a variable assignment may be a " &
                    "slice" ,
                    correct) ;
   end process P3 ;
--
   P4 :
   process ( Dummy )
      variable v_st_boolean_vector : st_boolean_vector :=
          c_st_boolean_vector_1 ;
      variable v_st_bit_vector : st_bit_vector :=
          c_st_bit_vector_1 ;
      variable v_st_severity_level_vector : st_severity_level_vector :=
          c_st_severity_level_vector_1 ;
      variable v_st_string : st_string :=
          c_st_string_1 ;
      variable v_st_enum1_vector : st_enum1_vector :=
          c_st_enum1_vector_1 ;
      variable v_st_integer_vector : st_integer_vector :=
          c_st_integer_vector_1 ;
      variable v_st_int1_vector : st_int1_vector :=
          c_st_int1_vector_1 ;
      variable v_st_time_vector : st_time_vector :=
          c_st_time_vector_1 ;
      variable v_st_phys1_vector : st_phys1_vector :=
          c_st_phys1_vector_1 ;
      variable v_st_real_vector : st_real_vector :=
          c_st_real_vector_1 ;
      variable v_st_real1_vector : st_real1_vector :=
          c_st_real1_vector_1 ;
      variable v_st_rec1_vector : st_rec1_vector :=
          c_st_rec1_vector_1 ;
      variable v_st_rec2_vector : st_rec2_vector :=
          c_st_rec2_vector_1 ;
      variable v_st_rec3_vector : st_rec3_vector :=
          c_st_rec3_vector_1 ;
      variable v_st_arr1_vector : st_arr1_vector :=
          c_st_arr1_vector_1 ;
      variable v_st_arr2_vector : st_arr2_vector :=
          c_st_arr2_vector_1 ;
      variable v_st_arr3_vector : st_arr3_vector :=
          c_st_arr3_vector_1 ;
--
      variable correct : boolean := true ;
--
      procedure Proc1 (
           v_st_boolean_vector : inout st_boolean_vector
         ; v_st_bit_vector : inout st_bit_vector
         ; v_st_severity_level_vector : inout st_severity_level_vector
         ; v_st_string : inout st_string
         ; v_st_enum1_vector : inout st_enum1_vector
         ; v_st_integer_vector : inout st_integer_vector
         ; v_st_int1_vector : inout st_int1_vector
         ; v_st_time_vector : inout st_time_vector
         ; v_st_phys1_vector : inout st_phys1_vector
         ; v_st_real_vector : inout st_real_vector
         ; v_st_real1_vector : inout st_real1_vector
         ; v_st_rec1_vector : inout st_rec1_vector
         ; v_st_rec2_vector : inout st_rec2_vector
         ; v_st_rec3_vector : inout st_rec3_vector
         ; v_st_arr1_vector : inout st_arr1_vector
         ; v_st_arr2_vector : inout st_arr2_vector
         ; v_st_arr3_vector : inout st_arr3_vector
                      )
      is
      begin
         v_st_boolean_vector(lowb+1 to highb-1) :=
             c_st_boolean_vector_2(lowb+1 to highb-1) ;
         v_st_bit_vector(lowb+1 to highb-1) :=
             c_st_bit_vector_2(lowb+1 to highb-1) ;
         v_st_severity_level_vector(lowb+1 to highb-1) :=
             c_st_severity_level_vector_2(lowb+1 to highb-1) ;
         v_st_string(lowb+1 to highb-1) :=
             c_st_string_2(lowb+1 to highb-1) ;
         v_st_enum1_vector(lowb+1 to highb-1) :=
             c_st_enum1_vector_2(lowb+1 to highb-1) ;
         v_st_integer_vector(lowb+1 to highb-1) :=
             c_st_integer_vector_2(lowb+1 to highb-1) ;
         v_st_int1_vector(lowb+1 to highb-1) :=
             c_st_int1_vector_2(lowb+1 to highb-1) ;
         v_st_time_vector(lowb+1 to highb-1) :=
             c_st_time_vector_2(lowb+1 to highb-1) ;
         v_st_phys1_vector(lowb+1 to highb-1) :=
             c_st_phys1_vector_2(lowb+1 to highb-1) ;
         v_st_real_vector(lowb+1 to highb-1) :=
             c_st_real_vector_2(lowb+1 to highb-1) ;
         v_st_real1_vector(lowb+1 to highb-1) :=
             c_st_real1_vector_2(lowb+1 to highb-1) ;
         v_st_rec1_vector(lowb+1 to highb-1) :=
             c_st_rec1_vector_2(lowb+1 to highb-1) ;
         v_st_rec2_vector(lowb+1 to highb-1) :=
             c_st_rec2_vector_2(lowb+1 to highb-1) ;
         v_st_rec3_vector(lowb+1 to highb-1) :=
             c_st_rec3_vector_2(lowb+1 to highb-1) ;
         v_st_arr1_vector(lowb+1 to highb-1) :=
             c_st_arr1_vector_2(lowb+1 to highb-1) ;
         v_st_arr2_vector(lowb+1 to highb-1) :=
             c_st_arr2_vector_2(lowb+1 to highb-1) ;
         v_st_arr3_vector(lowb+1 to highb-1) :=
             c_st_arr3_vector_2(lowb+1 to highb-1) ;
--
      end Proc1 ;
   begin
      Proc1 (
           v_st_boolean_vector
         , v_st_bit_vector
         , v_st_severity_level_vector
         , v_st_string
         , v_st_enum1_vector
         , v_st_integer_vector
         , v_st_int1_vector
         , v_st_time_vector
         , v_st_phys1_vector
         , v_st_real_vector
         , v_st_real1_vector
         , v_st_rec1_vector
         , v_st_rec2_vector
         , v_st_rec3_vector
         , v_st_arr1_vector
         , v_st_arr2_vector
         , v_st_arr3_vector
            ) ;
      correct := correct and
                 v_st_boolean_vector(lowb+1 to highb-1) =
                 c_st_boolean_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_bit_vector(lowb+1 to highb-1) =
                 c_st_bit_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_severity_level_vector(lowb+1 to highb-1) =
                 c_st_severity_level_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_string(lowb+1 to highb-1) =
                 c_st_string_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_enum1_vector(lowb+1 to highb-1) =
                 c_st_enum1_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_integer_vector(lowb+1 to highb-1) =
                 c_st_integer_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_int1_vector(lowb+1 to highb-1) =
                 c_st_int1_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_time_vector(lowb+1 to highb-1) =
                 c_st_time_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_phys1_vector(lowb+1 to highb-1) =
                 c_st_phys1_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_real_vector(lowb+1 to highb-1) =
                 c_st_real_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_real1_vector(lowb+1 to highb-1) =
                 c_st_real1_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_rec1_vector(lowb+1 to highb-1) =
                 c_st_rec1_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_rec2_vector(lowb+1 to highb-1) =
                 c_st_rec2_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_rec3_vector(lowb+1 to highb-1) =
                 c_st_rec3_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_arr1_vector(lowb+1 to highb-1) =
                 c_st_arr1_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_arr2_vector(lowb+1 to highb-1) =
                 c_st_arr2_vector_2(lowb+1 to highb-1) ;
      correct := correct and
                 v_st_arr3_vector(lowb+1 to highb-1) =
                 c_st_arr3_vector_2(lowb+1 to highb-1) ;
--
      test_report ( "ARCH00034.P4" ,
                    "Target of a variable assignment may be a " &
                    "slice" ,
                    correct) ;
   end process P4 ;
--
end ARCH00034 ;
--
entity ENT00034_Test_Bench is
end ENT00034_Test_Bench ;
--
architecture ARCH00034_Test_Bench of ENT00034_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00034 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00034_Test_Bench ;
