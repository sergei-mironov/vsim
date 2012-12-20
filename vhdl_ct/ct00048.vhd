-- NEED RESULT: ARCH00048.P1: Implicit array subtype conversion occurs for slices passed
-- NEED RESULT: ARCH00048.P2: Implicit array subtype conversion occurs for slices passed
-- NEED RESULT: ARCH00048.P3: Implicit array subtype conversion occurs for slices passed
-- NEED RESULT: ARCH00048.P4: Implicit array subtype conversion occurs for slices passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00048
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.4 (2)
--    8.4.1 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00048)
--    ENT00048_Test_Bench(ARCH00048_Test_Bench)
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
architecture ARCH00048 of E00000 is
   signal Dummy : Boolean := false ;
--
begin
   P1 :
   process ( Dummy )
      subtype boolean_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype boolean_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype boolean_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_boolean_vector_1 is
                boolean_vector (boolean_vector_range_1) ;
      variable v_st_boolean_vector_1 : st_boolean_vector_1 :=
                 c_st_boolean_vector_1 ;
--
      subtype bit_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype bit_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype bit_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_bit_vector_1 is
                bit_vector (bit_vector_range_1) ;
      variable v_st_bit_vector_1 : st_bit_vector_1 :=
                 c_st_bit_vector_1 ;
--
      subtype severity_level_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype severity_level_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype severity_level_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_severity_level_vector_1 is
                severity_level_vector (severity_level_vector_range_1) ;
      variable v_st_severity_level_vector_1 : st_severity_level_vector_1 :=
                 c_st_severity_level_vector_1 ;
--
      subtype string_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype string_sr_1 is integer
              range lowb+2 to highb ;
      subtype string_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_string_1 is
                string (string_range_1) ;
      variable v_st_string_1 : st_string_1 :=
                 c_st_string_1 ;
--
      subtype enum1_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype enum1_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype enum1_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_enum1_vector_1 is
                enum1_vector (enum1_vector_range_1) ;
      variable v_st_enum1_vector_1 : st_enum1_vector_1 :=
                 c_st_enum1_vector_1 ;
--
      subtype integer_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype integer_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype integer_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_integer_vector_1 is
                integer_vector (integer_vector_range_1) ;
      variable v_st_integer_vector_1 : st_integer_vector_1 :=
                 c_st_integer_vector_1 ;
--
      subtype int1_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype int1_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype int1_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_int1_vector_1 is
                int1_vector (int1_vector_range_1) ;
      variable v_st_int1_vector_1 : st_int1_vector_1 :=
                 c_st_int1_vector_1 ;
--
      subtype time_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype time_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype time_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_time_vector_1 is
                time_vector (time_vector_range_1) ;
      variable v_st_time_vector_1 : st_time_vector_1 :=
                 c_st_time_vector_1 ;
--
      subtype phys1_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype phys1_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype phys1_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_phys1_vector_1 is
                phys1_vector (phys1_vector_range_1) ;
      variable v_st_phys1_vector_1 : st_phys1_vector_1 :=
                 c_st_phys1_vector_1 ;
--
      subtype real_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype real_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype real_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_real_vector_1 is
                real_vector (real_vector_range_1) ;
      variable v_st_real_vector_1 : st_real_vector_1 :=
                 c_st_real_vector_1 ;
--
      subtype real1_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype real1_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype real1_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_real1_vector_1 is
                real1_vector (real1_vector_range_1) ;
      variable v_st_real1_vector_1 : st_real1_vector_1 :=
                 c_st_real1_vector_1 ;
--
      subtype rec1_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype rec1_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype rec1_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_rec1_vector_1 is
                rec1_vector (rec1_vector_range_1) ;
      variable v_st_rec1_vector_1 : st_rec1_vector_1 :=
                 c_st_rec1_vector_1 ;
--
      subtype rec2_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype rec2_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype rec2_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_rec2_vector_1 is
                rec2_vector (rec2_vector_range_1) ;
      variable v_st_rec2_vector_1 : st_rec2_vector_1 :=
                 c_st_rec2_vector_1 ;
--
      subtype rec3_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype rec3_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype rec3_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_rec3_vector_1 is
                rec3_vector (rec3_vector_range_1) ;
      variable v_st_rec3_vector_1 : st_rec3_vector_1 :=
                 c_st_rec3_vector_1 ;
--
      subtype arr1_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype arr1_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype arr1_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_arr1_vector_1 is
                arr1_vector (arr1_vector_range_1) ;
      variable v_st_arr1_vector_1 : st_arr1_vector_1 :=
                 c_st_arr1_vector_1 ;
--
      subtype arr2_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype arr2_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype arr2_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_arr2_vector_1 is
                arr2_vector (arr2_vector_range_1) ;
      variable v_st_arr2_vector_1 : st_arr2_vector_1 :=
                 c_st_arr2_vector_1 ;
--
      subtype arr3_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype arr3_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype arr3_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_arr3_vector_1 is
                arr3_vector (arr3_vector_range_1) ;
      variable v_st_arr3_vector_1 : st_arr3_vector_1 :=
                 c_st_arr3_vector_1 ;
--
--
      variable correct : boolean := true ;
   begin
      v_st_boolean_vector_1 (boolean_vector_sr_1) :=
        c_st_boolean_vector_2 (boolean_vector_sr_2) ;
      v_st_bit_vector_1 (bit_vector_sr_1) :=
        c_st_bit_vector_2 (bit_vector_sr_2) ;
      v_st_severity_level_vector_1 (severity_level_vector_sr_1) :=
        c_st_severity_level_vector_2 (severity_level_vector_sr_2) ;
      v_st_string_1 (string_sr_1) :=
        c_st_string_2 (string_sr_2) ;
      v_st_enum1_vector_1 (enum1_vector_sr_1) :=
        c_st_enum1_vector_2 (enum1_vector_sr_2) ;
      v_st_integer_vector_1 (integer_vector_sr_1) :=
        c_st_integer_vector_2 (integer_vector_sr_2) ;
      v_st_int1_vector_1 (int1_vector_sr_1) :=
        c_st_int1_vector_2 (int1_vector_sr_2) ;
      v_st_time_vector_1 (time_vector_sr_1) :=
        c_st_time_vector_2 (time_vector_sr_2) ;
      v_st_phys1_vector_1 (phys1_vector_sr_1) :=
        c_st_phys1_vector_2 (phys1_vector_sr_2) ;
      v_st_real_vector_1 (real_vector_sr_1) :=
        c_st_real_vector_2 (real_vector_sr_2) ;
      v_st_real1_vector_1 (real1_vector_sr_1) :=
        c_st_real1_vector_2 (real1_vector_sr_2) ;
      v_st_rec1_vector_1 (rec1_vector_sr_1) :=
        c_st_rec1_vector_2 (rec1_vector_sr_2) ;
      v_st_rec2_vector_1 (rec2_vector_sr_1) :=
        c_st_rec2_vector_2 (rec2_vector_sr_2) ;
      v_st_rec3_vector_1 (rec3_vector_sr_1) :=
        c_st_rec3_vector_2 (rec3_vector_sr_2) ;
      v_st_arr1_vector_1 (arr1_vector_sr_1) :=
        c_st_arr1_vector_2 (arr1_vector_sr_2) ;
      v_st_arr2_vector_1 (arr2_vector_sr_1) :=
        c_st_arr2_vector_2 (arr2_vector_sr_2) ;
      v_st_arr3_vector_1 (arr3_vector_sr_1) :=
        c_st_arr3_vector_2 (arr3_vector_sr_2) ;
--
      correct := correct and
                 v_st_boolean_vector_1 (boolean_vector_sr_1) =
                 c_st_boolean_vector_2 (boolean_vector_sr_2) ;
      correct := correct and
                 v_st_bit_vector_1 (bit_vector_sr_1) =
                 c_st_bit_vector_2 (bit_vector_sr_2) ;
      correct := correct and
                 v_st_severity_level_vector_1 (severity_level_vector_sr_1) =
                 c_st_severity_level_vector_2 (severity_level_vector_sr_2) ;
      correct := correct and
                 v_st_string_1 (string_sr_1) =
                 c_st_string_2 (string_sr_2) ;
      correct := correct and
                 v_st_enum1_vector_1 (enum1_vector_sr_1) =
                 c_st_enum1_vector_2 (enum1_vector_sr_2) ;
      correct := correct and
                 v_st_integer_vector_1 (integer_vector_sr_1) =
                 c_st_integer_vector_2 (integer_vector_sr_2) ;
      correct := correct and
                 v_st_int1_vector_1 (int1_vector_sr_1) =
                 c_st_int1_vector_2 (int1_vector_sr_2) ;
      correct := correct and
                 v_st_time_vector_1 (time_vector_sr_1) =
                 c_st_time_vector_2 (time_vector_sr_2) ;
      correct := correct and
                 v_st_phys1_vector_1 (phys1_vector_sr_1) =
                 c_st_phys1_vector_2 (phys1_vector_sr_2) ;
      correct := correct and
                 v_st_real_vector_1 (real_vector_sr_1) =
                 c_st_real_vector_2 (real_vector_sr_2) ;
      correct := correct and
                 v_st_real1_vector_1 (real1_vector_sr_1) =
                 c_st_real1_vector_2 (real1_vector_sr_2) ;
      correct := correct and
                 v_st_rec1_vector_1 (rec1_vector_sr_1) =
                 c_st_rec1_vector_2 (rec1_vector_sr_2) ;
      correct := correct and
                 v_st_rec2_vector_1 (rec2_vector_sr_1) =
                 c_st_rec2_vector_2 (rec2_vector_sr_2) ;
      correct := correct and
                 v_st_rec3_vector_1 (rec3_vector_sr_1) =
                 c_st_rec3_vector_2 (rec3_vector_sr_2) ;
      correct := correct and
                 v_st_arr1_vector_1 (arr1_vector_sr_1) =
                 c_st_arr1_vector_2 (arr1_vector_sr_2) ;
      correct := correct and
                 v_st_arr2_vector_1 (arr2_vector_sr_1) =
                 c_st_arr2_vector_2 (arr2_vector_sr_2) ;
      correct := correct and
                 v_st_arr3_vector_1 (arr3_vector_sr_1) =
                 c_st_arr3_vector_2 (arr3_vector_sr_2) ;
--
      test_report ( "ARCH00048.P1" ,
                    "Implicit array subtype conversion occurs "&
                    "for slices",
                    correct) ;
   end process P1 ;
--
   P2 :
   process ( Dummy )
      variable correct : boolean := true ;
--
      procedure Proc1 is
         subtype boolean_vector_range_1 is integer
                 range lowb+1 to highb+1 ;
         subtype boolean_vector_sr_1 is integer
                 range lowb+2 to highb ;
         subtype boolean_vector_sr_2 is integer
                 range lowb+1 to highb-1 ;
         subtype st_boolean_vector_1 is
                   boolean_vector (boolean_vector_range_1) ;
         variable v_st_boolean_vector_1 : st_boolean_vector_1 :=
                    c_st_boolean_vector_1 ;
--
         subtype bit_vector_range_1 is integer
                 range lowb+1 to highb+1 ;
         subtype bit_vector_sr_1 is integer
                 range lowb+2 to highb ;
         subtype bit_vector_sr_2 is integer
                 range lowb+1 to highb-1 ;
         subtype st_bit_vector_1 is
                   bit_vector (bit_vector_range_1) ;
         variable v_st_bit_vector_1 : st_bit_vector_1 :=
                    c_st_bit_vector_1 ;
--
         subtype severity_level_vector_range_1 is integer
                 range lowb+1 to highb+1 ;
         subtype severity_level_vector_sr_1 is integer
                 range lowb+2 to highb ;
         subtype severity_level_vector_sr_2 is integer
                 range lowb+1 to highb-1 ;
         subtype st_severity_level_vector_1 is
                   severity_level_vector (severity_level_vector_range_1) ;
         variable v_st_severity_level_vector_1 : st_severity_level_vector_1 :=
                    c_st_severity_level_vector_1 ;
--
         subtype string_range_1 is integer
                 range lowb+1 to highb+1 ;
         subtype string_sr_1 is integer
                 range lowb+2 to highb ;
         subtype string_sr_2 is integer
                 range lowb+1 to highb-1 ;
         subtype st_string_1 is
                   string (string_range_1) ;
         variable v_st_string_1 : st_string_1 :=
                    c_st_string_1 ;
--
         subtype enum1_vector_range_1 is integer
                 range lowb+1 to highb+1 ;
         subtype enum1_vector_sr_1 is integer
                 range lowb+2 to highb ;
         subtype enum1_vector_sr_2 is integer
                 range lowb+1 to highb-1 ;
         subtype st_enum1_vector_1 is
                   enum1_vector (enum1_vector_range_1) ;
         variable v_st_enum1_vector_1 : st_enum1_vector_1 :=
                    c_st_enum1_vector_1 ;
--
         subtype integer_vector_range_1 is integer
                 range lowb+1 to highb+1 ;
         subtype integer_vector_sr_1 is integer
                 range lowb+2 to highb ;
         subtype integer_vector_sr_2 is integer
                 range lowb+1 to highb-1 ;
         subtype st_integer_vector_1 is
                   integer_vector (integer_vector_range_1) ;
         variable v_st_integer_vector_1 : st_integer_vector_1 :=
                    c_st_integer_vector_1 ;
--
         subtype int1_vector_range_1 is integer
                 range lowb+1 to highb+1 ;
         subtype int1_vector_sr_1 is integer
                 range lowb+2 to highb ;
         subtype int1_vector_sr_2 is integer
                 range lowb+1 to highb-1 ;
         subtype st_int1_vector_1 is
                   int1_vector (int1_vector_range_1) ;
         variable v_st_int1_vector_1 : st_int1_vector_1 :=
                    c_st_int1_vector_1 ;
--
         subtype time_vector_range_1 is integer
                 range lowb+1 to highb+1 ;
         subtype time_vector_sr_1 is integer
                 range lowb+2 to highb ;
         subtype time_vector_sr_2 is integer
                 range lowb+1 to highb-1 ;
         subtype st_time_vector_1 is
                   time_vector (time_vector_range_1) ;
         variable v_st_time_vector_1 : st_time_vector_1 :=
                    c_st_time_vector_1 ;
--
         subtype phys1_vector_range_1 is integer
                 range lowb+1 to highb+1 ;
         subtype phys1_vector_sr_1 is integer
                 range lowb+2 to highb ;
         subtype phys1_vector_sr_2 is integer
                 range lowb+1 to highb-1 ;
         subtype st_phys1_vector_1 is
                   phys1_vector (phys1_vector_range_1) ;
         variable v_st_phys1_vector_1 : st_phys1_vector_1 :=
                    c_st_phys1_vector_1 ;
--
         subtype real_vector_range_1 is integer
                 range lowb+1 to highb+1 ;
         subtype real_vector_sr_1 is integer
                 range lowb+2 to highb ;
         subtype real_vector_sr_2 is integer
                 range lowb+1 to highb-1 ;
         subtype st_real_vector_1 is
                   real_vector (real_vector_range_1) ;
         variable v_st_real_vector_1 : st_real_vector_1 :=
                    c_st_real_vector_1 ;
--
         subtype real1_vector_range_1 is integer
                 range lowb+1 to highb+1 ;
         subtype real1_vector_sr_1 is integer
                 range lowb+2 to highb ;
         subtype real1_vector_sr_2 is integer
                 range lowb+1 to highb-1 ;
         subtype st_real1_vector_1 is
                   real1_vector (real1_vector_range_1) ;
         variable v_st_real1_vector_1 : st_real1_vector_1 :=
                    c_st_real1_vector_1 ;
--
         subtype rec1_vector_range_1 is integer
                 range lowb+1 to highb+1 ;
         subtype rec1_vector_sr_1 is integer
                 range lowb+2 to highb ;
         subtype rec1_vector_sr_2 is integer
                 range lowb+1 to highb-1 ;
         subtype st_rec1_vector_1 is
                   rec1_vector (rec1_vector_range_1) ;
         variable v_st_rec1_vector_1 : st_rec1_vector_1 :=
                    c_st_rec1_vector_1 ;
--
         subtype rec2_vector_range_1 is integer
                 range lowb+1 to highb+1 ;
         subtype rec2_vector_sr_1 is integer
                 range lowb+2 to highb ;
         subtype rec2_vector_sr_2 is integer
                 range lowb+1 to highb-1 ;
         subtype st_rec2_vector_1 is
                   rec2_vector (rec2_vector_range_1) ;
         variable v_st_rec2_vector_1 : st_rec2_vector_1 :=
                    c_st_rec2_vector_1 ;
--
         subtype rec3_vector_range_1 is integer
                 range lowb+1 to highb+1 ;
         subtype rec3_vector_sr_1 is integer
                 range lowb+2 to highb ;
         subtype rec3_vector_sr_2 is integer
                 range lowb+1 to highb-1 ;
         subtype st_rec3_vector_1 is
                   rec3_vector (rec3_vector_range_1) ;
         variable v_st_rec3_vector_1 : st_rec3_vector_1 :=
                    c_st_rec3_vector_1 ;
--
         subtype arr1_vector_range_1 is integer
                 range lowb+1 to highb+1 ;
         subtype arr1_vector_sr_1 is integer
                 range lowb+2 to highb ;
         subtype arr1_vector_sr_2 is integer
                 range lowb+1 to highb-1 ;
         subtype st_arr1_vector_1 is
                   arr1_vector (arr1_vector_range_1) ;
         variable v_st_arr1_vector_1 : st_arr1_vector_1 :=
                    c_st_arr1_vector_1 ;
--
         subtype arr2_vector_range_1 is integer
                 range lowb+1 to highb+1 ;
         subtype arr2_vector_sr_1 is integer
                 range lowb+2 to highb ;
         subtype arr2_vector_sr_2 is integer
                 range lowb+1 to highb-1 ;
         subtype st_arr2_vector_1 is
                   arr2_vector (arr2_vector_range_1) ;
         variable v_st_arr2_vector_1 : st_arr2_vector_1 :=
                    c_st_arr2_vector_1 ;
--
         subtype arr3_vector_range_1 is integer
                 range lowb+1 to highb+1 ;
         subtype arr3_vector_sr_1 is integer
                 range lowb+2 to highb ;
         subtype arr3_vector_sr_2 is integer
                 range lowb+1 to highb-1 ;
         subtype st_arr3_vector_1 is
                   arr3_vector (arr3_vector_range_1) ;
         variable v_st_arr3_vector_1 : st_arr3_vector_1 :=
                    c_st_arr3_vector_1 ;
--
--
      begin
         v_st_boolean_vector_1 (boolean_vector_sr_1) :=
           c_st_boolean_vector_2 (boolean_vector_sr_2) ;
         v_st_bit_vector_1 (bit_vector_sr_1) :=
           c_st_bit_vector_2 (bit_vector_sr_2) ;
         v_st_severity_level_vector_1 (severity_level_vector_sr_1) :=
           c_st_severity_level_vector_2 (severity_level_vector_sr_2) ;
         v_st_string_1 (string_sr_1) :=
           c_st_string_2 (string_sr_2) ;
         v_st_enum1_vector_1 (enum1_vector_sr_1) :=
           c_st_enum1_vector_2 (enum1_vector_sr_2) ;
         v_st_integer_vector_1 (integer_vector_sr_1) :=
           c_st_integer_vector_2 (integer_vector_sr_2) ;
         v_st_int1_vector_1 (int1_vector_sr_1) :=
           c_st_int1_vector_2 (int1_vector_sr_2) ;
         v_st_time_vector_1 (time_vector_sr_1) :=
           c_st_time_vector_2 (time_vector_sr_2) ;
         v_st_phys1_vector_1 (phys1_vector_sr_1) :=
           c_st_phys1_vector_2 (phys1_vector_sr_2) ;
         v_st_real_vector_1 (real_vector_sr_1) :=
           c_st_real_vector_2 (real_vector_sr_2) ;
         v_st_real1_vector_1 (real1_vector_sr_1) :=
           c_st_real1_vector_2 (real1_vector_sr_2) ;
         v_st_rec1_vector_1 (rec1_vector_sr_1) :=
           c_st_rec1_vector_2 (rec1_vector_sr_2) ;
         v_st_rec2_vector_1 (rec2_vector_sr_1) :=
           c_st_rec2_vector_2 (rec2_vector_sr_2) ;
         v_st_rec3_vector_1 (rec3_vector_sr_1) :=
           c_st_rec3_vector_2 (rec3_vector_sr_2) ;
         v_st_arr1_vector_1 (arr1_vector_sr_1) :=
           c_st_arr1_vector_2 (arr1_vector_sr_2) ;
         v_st_arr2_vector_1 (arr2_vector_sr_1) :=
           c_st_arr2_vector_2 (arr2_vector_sr_2) ;
         v_st_arr3_vector_1 (arr3_vector_sr_1) :=
           c_st_arr3_vector_2 (arr3_vector_sr_2) ;
--
         correct := correct and
                    v_st_boolean_vector_1 (boolean_vector_sr_1) =
                    c_st_boolean_vector_2 (boolean_vector_sr_2) ;
         correct := correct and
                    v_st_bit_vector_1 (bit_vector_sr_1) =
                    c_st_bit_vector_2 (bit_vector_sr_2) ;
         correct := correct and
                    v_st_severity_level_vector_1 (severity_level_vector_sr_1) =
                    c_st_severity_level_vector_2 (severity_level_vector_sr_2) ;
         correct := correct and
                    v_st_string_1 (string_sr_1) =
                    c_st_string_2 (string_sr_2) ;
         correct := correct and
                    v_st_enum1_vector_1 (enum1_vector_sr_1) =
                    c_st_enum1_vector_2 (enum1_vector_sr_2) ;
         correct := correct and
                    v_st_integer_vector_1 (integer_vector_sr_1) =
                    c_st_integer_vector_2 (integer_vector_sr_2) ;
         correct := correct and
                    v_st_int1_vector_1 (int1_vector_sr_1) =
                    c_st_int1_vector_2 (int1_vector_sr_2) ;
         correct := correct and
                    v_st_time_vector_1 (time_vector_sr_1) =
                    c_st_time_vector_2 (time_vector_sr_2) ;
         correct := correct and
                    v_st_phys1_vector_1 (phys1_vector_sr_1) =
                    c_st_phys1_vector_2 (phys1_vector_sr_2) ;
         correct := correct and
                    v_st_real_vector_1 (real_vector_sr_1) =
                    c_st_real_vector_2 (real_vector_sr_2) ;
         correct := correct and
                    v_st_real1_vector_1 (real1_vector_sr_1) =
                    c_st_real1_vector_2 (real1_vector_sr_2) ;
         correct := correct and
                    v_st_rec1_vector_1 (rec1_vector_sr_1) =
                    c_st_rec1_vector_2 (rec1_vector_sr_2) ;
         correct := correct and
                    v_st_rec2_vector_1 (rec2_vector_sr_1) =
                    c_st_rec2_vector_2 (rec2_vector_sr_2) ;
         correct := correct and
                    v_st_rec3_vector_1 (rec3_vector_sr_1) =
                    c_st_rec3_vector_2 (rec3_vector_sr_2) ;
         correct := correct and
                    v_st_arr1_vector_1 (arr1_vector_sr_1) =
                    c_st_arr1_vector_2 (arr1_vector_sr_2) ;
         correct := correct and
                    v_st_arr2_vector_1 (arr2_vector_sr_1) =
                    c_st_arr2_vector_2 (arr2_vector_sr_2) ;
         correct := correct and
                    v_st_arr3_vector_1 (arr3_vector_sr_1) =
                    c_st_arr3_vector_2 (arr3_vector_sr_2) ;
--
      end Proc1 ;
   begin
      Proc1 ;
      test_report ( "ARCH00048.P2" ,
                    "Implicit array subtype conversion occurs "&
                    "for slices",
                    correct) ;
   end process P2 ;
--
   P3 :
   process ( Dummy )
      subtype boolean_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype boolean_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype boolean_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_boolean_vector_1 is
                boolean_vector (boolean_vector_range_1) ;
      variable v_st_boolean_vector_1 : st_boolean_vector_1 :=
                 c_st_boolean_vector_1 ;
--
      subtype bit_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype bit_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype bit_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_bit_vector_1 is
                bit_vector (bit_vector_range_1) ;
      variable v_st_bit_vector_1 : st_bit_vector_1 :=
                 c_st_bit_vector_1 ;
--
      subtype severity_level_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype severity_level_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype severity_level_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_severity_level_vector_1 is
                severity_level_vector (severity_level_vector_range_1) ;
      variable v_st_severity_level_vector_1 : st_severity_level_vector_1 :=
                 c_st_severity_level_vector_1 ;
--
      subtype string_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype string_sr_1 is integer
              range lowb+2 to highb ;
      subtype string_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_string_1 is
                string (string_range_1) ;
      variable v_st_string_1 : st_string_1 :=
                 c_st_string_1 ;
--
      subtype enum1_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype enum1_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype enum1_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_enum1_vector_1 is
                enum1_vector (enum1_vector_range_1) ;
      variable v_st_enum1_vector_1 : st_enum1_vector_1 :=
                 c_st_enum1_vector_1 ;
--
      subtype integer_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype integer_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype integer_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_integer_vector_1 is
                integer_vector (integer_vector_range_1) ;
      variable v_st_integer_vector_1 : st_integer_vector_1 :=
                 c_st_integer_vector_1 ;
--
      subtype int1_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype int1_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype int1_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_int1_vector_1 is
                int1_vector (int1_vector_range_1) ;
      variable v_st_int1_vector_1 : st_int1_vector_1 :=
                 c_st_int1_vector_1 ;
--
      subtype time_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype time_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype time_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_time_vector_1 is
                time_vector (time_vector_range_1) ;
      variable v_st_time_vector_1 : st_time_vector_1 :=
                 c_st_time_vector_1 ;
--
      subtype phys1_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype phys1_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype phys1_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_phys1_vector_1 is
                phys1_vector (phys1_vector_range_1) ;
      variable v_st_phys1_vector_1 : st_phys1_vector_1 :=
                 c_st_phys1_vector_1 ;
--
      subtype real_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype real_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype real_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_real_vector_1 is
                real_vector (real_vector_range_1) ;
      variable v_st_real_vector_1 : st_real_vector_1 :=
                 c_st_real_vector_1 ;
--
      subtype real1_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype real1_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype real1_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_real1_vector_1 is
                real1_vector (real1_vector_range_1) ;
      variable v_st_real1_vector_1 : st_real1_vector_1 :=
                 c_st_real1_vector_1 ;
--
      subtype rec1_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype rec1_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype rec1_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_rec1_vector_1 is
                rec1_vector (rec1_vector_range_1) ;
      variable v_st_rec1_vector_1 : st_rec1_vector_1 :=
                 c_st_rec1_vector_1 ;
--
      subtype rec2_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype rec2_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype rec2_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_rec2_vector_1 is
                rec2_vector (rec2_vector_range_1) ;
      variable v_st_rec2_vector_1 : st_rec2_vector_1 :=
                 c_st_rec2_vector_1 ;
--
      subtype rec3_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype rec3_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype rec3_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_rec3_vector_1 is
                rec3_vector (rec3_vector_range_1) ;
      variable v_st_rec3_vector_1 : st_rec3_vector_1 :=
                 c_st_rec3_vector_1 ;
--
      subtype arr1_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype arr1_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype arr1_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_arr1_vector_1 is
                arr1_vector (arr1_vector_range_1) ;
      variable v_st_arr1_vector_1 : st_arr1_vector_1 :=
                 c_st_arr1_vector_1 ;
--
      subtype arr2_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype arr2_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype arr2_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_arr2_vector_1 is
                arr2_vector (arr2_vector_range_1) ;
      variable v_st_arr2_vector_1 : st_arr2_vector_1 :=
                 c_st_arr2_vector_1 ;
--
      subtype arr3_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype arr3_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype arr3_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_arr3_vector_1 is
                arr3_vector (arr3_vector_range_1) ;
      variable v_st_arr3_vector_1 : st_arr3_vector_1 :=
                 c_st_arr3_vector_1 ;
--
--
      variable correct : boolean := true ;
--
      procedure Proc1 is
      begin
         v_st_boolean_vector_1 (boolean_vector_sr_1) :=
           c_st_boolean_vector_2 (boolean_vector_sr_2) ;
         v_st_bit_vector_1 (bit_vector_sr_1) :=
           c_st_bit_vector_2 (bit_vector_sr_2) ;
         v_st_severity_level_vector_1 (severity_level_vector_sr_1) :=
           c_st_severity_level_vector_2 (severity_level_vector_sr_2) ;
         v_st_string_1 (string_sr_1) :=
           c_st_string_2 (string_sr_2) ;
         v_st_enum1_vector_1 (enum1_vector_sr_1) :=
           c_st_enum1_vector_2 (enum1_vector_sr_2) ;
         v_st_integer_vector_1 (integer_vector_sr_1) :=
           c_st_integer_vector_2 (integer_vector_sr_2) ;
         v_st_int1_vector_1 (int1_vector_sr_1) :=
           c_st_int1_vector_2 (int1_vector_sr_2) ;
         v_st_time_vector_1 (time_vector_sr_1) :=
           c_st_time_vector_2 (time_vector_sr_2) ;
         v_st_phys1_vector_1 (phys1_vector_sr_1) :=
           c_st_phys1_vector_2 (phys1_vector_sr_2) ;
         v_st_real_vector_1 (real_vector_sr_1) :=
           c_st_real_vector_2 (real_vector_sr_2) ;
         v_st_real1_vector_1 (real1_vector_sr_1) :=
           c_st_real1_vector_2 (real1_vector_sr_2) ;
         v_st_rec1_vector_1 (rec1_vector_sr_1) :=
           c_st_rec1_vector_2 (rec1_vector_sr_2) ;
         v_st_rec2_vector_1 (rec2_vector_sr_1) :=
           c_st_rec2_vector_2 (rec2_vector_sr_2) ;
         v_st_rec3_vector_1 (rec3_vector_sr_1) :=
           c_st_rec3_vector_2 (rec3_vector_sr_2) ;
         v_st_arr1_vector_1 (arr1_vector_sr_1) :=
           c_st_arr1_vector_2 (arr1_vector_sr_2) ;
         v_st_arr2_vector_1 (arr2_vector_sr_1) :=
           c_st_arr2_vector_2 (arr2_vector_sr_2) ;
         v_st_arr3_vector_1 (arr3_vector_sr_1) :=
           c_st_arr3_vector_2 (arr3_vector_sr_2) ;
--
      end Proc1 ;
   begin
      Proc1 ;
      correct := correct and
                 v_st_boolean_vector_1 (boolean_vector_sr_1) =
                 c_st_boolean_vector_2 (boolean_vector_sr_2) ;
      correct := correct and
                 v_st_bit_vector_1 (bit_vector_sr_1) =
                 c_st_bit_vector_2 (bit_vector_sr_2) ;
      correct := correct and
                 v_st_severity_level_vector_1 (severity_level_vector_sr_1) =
                 c_st_severity_level_vector_2 (severity_level_vector_sr_2) ;
      correct := correct and
                 v_st_string_1 (string_sr_1) =
                 c_st_string_2 (string_sr_2) ;
      correct := correct and
                 v_st_enum1_vector_1 (enum1_vector_sr_1) =
                 c_st_enum1_vector_2 (enum1_vector_sr_2) ;
      correct := correct and
                 v_st_integer_vector_1 (integer_vector_sr_1) =
                 c_st_integer_vector_2 (integer_vector_sr_2) ;
      correct := correct and
                 v_st_int1_vector_1 (int1_vector_sr_1) =
                 c_st_int1_vector_2 (int1_vector_sr_2) ;
      correct := correct and
                 v_st_time_vector_1 (time_vector_sr_1) =
                 c_st_time_vector_2 (time_vector_sr_2) ;
      correct := correct and
                 v_st_phys1_vector_1 (phys1_vector_sr_1) =
                 c_st_phys1_vector_2 (phys1_vector_sr_2) ;
      correct := correct and
                 v_st_real_vector_1 (real_vector_sr_1) =
                 c_st_real_vector_2 (real_vector_sr_2) ;
      correct := correct and
                 v_st_real1_vector_1 (real1_vector_sr_1) =
                 c_st_real1_vector_2 (real1_vector_sr_2) ;
      correct := correct and
                 v_st_rec1_vector_1 (rec1_vector_sr_1) =
                 c_st_rec1_vector_2 (rec1_vector_sr_2) ;
      correct := correct and
                 v_st_rec2_vector_1 (rec2_vector_sr_1) =
                 c_st_rec2_vector_2 (rec2_vector_sr_2) ;
      correct := correct and
                 v_st_rec3_vector_1 (rec3_vector_sr_1) =
                 c_st_rec3_vector_2 (rec3_vector_sr_2) ;
      correct := correct and
                 v_st_arr1_vector_1 (arr1_vector_sr_1) =
                 c_st_arr1_vector_2 (arr1_vector_sr_2) ;
      correct := correct and
                 v_st_arr2_vector_1 (arr2_vector_sr_1) =
                 c_st_arr2_vector_2 (arr2_vector_sr_2) ;
      correct := correct and
                 v_st_arr3_vector_1 (arr3_vector_sr_1) =
                 c_st_arr3_vector_2 (arr3_vector_sr_2) ;
--
      test_report ( "ARCH00048.P3" ,
                    "Implicit array subtype conversion occurs "&
                    "for slices",
                    correct) ;
   end process P3 ;
--
   P4 :
   process ( Dummy )
      subtype boolean_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype boolean_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype boolean_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_boolean_vector_1 is
                boolean_vector (boolean_vector_range_1) ;
      variable v_st_boolean_vector_1 : st_boolean_vector_1 :=
                 c_st_boolean_vector_1 ;
--
      subtype bit_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype bit_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype bit_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_bit_vector_1 is
                bit_vector (bit_vector_range_1) ;
      variable v_st_bit_vector_1 : st_bit_vector_1 :=
                 c_st_bit_vector_1 ;
--
      subtype severity_level_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype severity_level_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype severity_level_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_severity_level_vector_1 is
                severity_level_vector (severity_level_vector_range_1) ;
      variable v_st_severity_level_vector_1 : st_severity_level_vector_1 :=
                 c_st_severity_level_vector_1 ;
--
      subtype string_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype string_sr_1 is integer
              range lowb+2 to highb ;
      subtype string_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_string_1 is
                string (string_range_1) ;
      variable v_st_string_1 : st_string_1 :=
                 c_st_string_1 ;
--
      subtype enum1_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype enum1_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype enum1_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_enum1_vector_1 is
                enum1_vector (enum1_vector_range_1) ;
      variable v_st_enum1_vector_1 : st_enum1_vector_1 :=
                 c_st_enum1_vector_1 ;
--
      subtype integer_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype integer_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype integer_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_integer_vector_1 is
                integer_vector (integer_vector_range_1) ;
      variable v_st_integer_vector_1 : st_integer_vector_1 :=
                 c_st_integer_vector_1 ;
--
      subtype int1_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype int1_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype int1_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_int1_vector_1 is
                int1_vector (int1_vector_range_1) ;
      variable v_st_int1_vector_1 : st_int1_vector_1 :=
                 c_st_int1_vector_1 ;
--
      subtype time_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype time_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype time_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_time_vector_1 is
                time_vector (time_vector_range_1) ;
      variable v_st_time_vector_1 : st_time_vector_1 :=
                 c_st_time_vector_1 ;
--
      subtype phys1_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype phys1_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype phys1_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_phys1_vector_1 is
                phys1_vector (phys1_vector_range_1) ;
      variable v_st_phys1_vector_1 : st_phys1_vector_1 :=
                 c_st_phys1_vector_1 ;
--
      subtype real_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype real_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype real_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_real_vector_1 is
                real_vector (real_vector_range_1) ;
      variable v_st_real_vector_1 : st_real_vector_1 :=
                 c_st_real_vector_1 ;
--
      subtype real1_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype real1_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype real1_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_real1_vector_1 is
                real1_vector (real1_vector_range_1) ;
      variable v_st_real1_vector_1 : st_real1_vector_1 :=
                 c_st_real1_vector_1 ;
--
      subtype rec1_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype rec1_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype rec1_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_rec1_vector_1 is
                rec1_vector (rec1_vector_range_1) ;
      variable v_st_rec1_vector_1 : st_rec1_vector_1 :=
                 c_st_rec1_vector_1 ;
--
      subtype rec2_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype rec2_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype rec2_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_rec2_vector_1 is
                rec2_vector (rec2_vector_range_1) ;
      variable v_st_rec2_vector_1 : st_rec2_vector_1 :=
                 c_st_rec2_vector_1 ;
--
      subtype rec3_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype rec3_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype rec3_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_rec3_vector_1 is
                rec3_vector (rec3_vector_range_1) ;
      variable v_st_rec3_vector_1 : st_rec3_vector_1 :=
                 c_st_rec3_vector_1 ;
--
      subtype arr1_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype arr1_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype arr1_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_arr1_vector_1 is
                arr1_vector (arr1_vector_range_1) ;
      variable v_st_arr1_vector_1 : st_arr1_vector_1 :=
                 c_st_arr1_vector_1 ;
--
      subtype arr2_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype arr2_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype arr2_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_arr2_vector_1 is
                arr2_vector (arr2_vector_range_1) ;
      variable v_st_arr2_vector_1 : st_arr2_vector_1 :=
                 c_st_arr2_vector_1 ;
--
      subtype arr3_vector_range_1 is integer
              range lowb+1 to highb+1 ;
      subtype arr3_vector_sr_1 is integer
              range lowb+2 to highb ;
      subtype arr3_vector_sr_2 is integer
              range lowb+1 to highb-1 ;
      subtype st_arr3_vector_1 is
                arr3_vector (arr3_vector_range_1) ;
      variable v_st_arr3_vector_1 : st_arr3_vector_1 :=
                 c_st_arr3_vector_1 ;
--
--
      variable correct : boolean := true ;
--
      procedure Proc1 (
           v_st_boolean_vector_1 : inout boolean_vector
         ; v_st_bit_vector_1 : inout bit_vector
         ; v_st_severity_level_vector_1 : inout severity_level_vector
         ; v_st_string_1 : inout string
         ; v_st_enum1_vector_1 : inout enum1_vector
         ; v_st_integer_vector_1 : inout integer_vector
         ; v_st_int1_vector_1 : inout int1_vector
         ; v_st_time_vector_1 : inout time_vector
         ; v_st_phys1_vector_1 : inout phys1_vector
         ; v_st_real_vector_1 : inout real_vector
         ; v_st_real1_vector_1 : inout real1_vector
         ; v_st_rec1_vector_1 : inout rec1_vector
         ; v_st_rec2_vector_1 : inout rec2_vector
         ; v_st_rec3_vector_1 : inout rec3_vector
         ; v_st_arr1_vector_1 : inout arr1_vector
         ; v_st_arr2_vector_1 : inout arr2_vector
         ; v_st_arr3_vector_1 : inout arr3_vector
                      )
      is
      begin
         v_st_boolean_vector_1 (boolean_vector_sr_1) :=
           c_st_boolean_vector_2 (boolean_vector_sr_2) ;
         v_st_bit_vector_1 (bit_vector_sr_1) :=
           c_st_bit_vector_2 (bit_vector_sr_2) ;
         v_st_severity_level_vector_1 (severity_level_vector_sr_1) :=
           c_st_severity_level_vector_2 (severity_level_vector_sr_2) ;
         v_st_string_1 (string_sr_1) :=
           c_st_string_2 (string_sr_2) ;
         v_st_enum1_vector_1 (enum1_vector_sr_1) :=
           c_st_enum1_vector_2 (enum1_vector_sr_2) ;
         v_st_integer_vector_1 (integer_vector_sr_1) :=
           c_st_integer_vector_2 (integer_vector_sr_2) ;
         v_st_int1_vector_1 (int1_vector_sr_1) :=
           c_st_int1_vector_2 (int1_vector_sr_2) ;
         v_st_time_vector_1 (time_vector_sr_1) :=
           c_st_time_vector_2 (time_vector_sr_2) ;
         v_st_phys1_vector_1 (phys1_vector_sr_1) :=
           c_st_phys1_vector_2 (phys1_vector_sr_2) ;
         v_st_real_vector_1 (real_vector_sr_1) :=
           c_st_real_vector_2 (real_vector_sr_2) ;
         v_st_real1_vector_1 (real1_vector_sr_1) :=
           c_st_real1_vector_2 (real1_vector_sr_2) ;
         v_st_rec1_vector_1 (rec1_vector_sr_1) :=
           c_st_rec1_vector_2 (rec1_vector_sr_2) ;
         v_st_rec2_vector_1 (rec2_vector_sr_1) :=
           c_st_rec2_vector_2 (rec2_vector_sr_2) ;
         v_st_rec3_vector_1 (rec3_vector_sr_1) :=
           c_st_rec3_vector_2 (rec3_vector_sr_2) ;
         v_st_arr1_vector_1 (arr1_vector_sr_1) :=
           c_st_arr1_vector_2 (arr1_vector_sr_2) ;
         v_st_arr2_vector_1 (arr2_vector_sr_1) :=
           c_st_arr2_vector_2 (arr2_vector_sr_2) ;
         v_st_arr3_vector_1 (arr3_vector_sr_1) :=
           c_st_arr3_vector_2 (arr3_vector_sr_2) ;
--
      end Proc1 ;
   begin
      Proc1 (
           v_st_boolean_vector_1
         , v_st_bit_vector_1
         , v_st_severity_level_vector_1
         , v_st_string_1
         , v_st_enum1_vector_1
         , v_st_integer_vector_1
         , v_st_int1_vector_1
         , v_st_time_vector_1
         , v_st_phys1_vector_1
         , v_st_real_vector_1
         , v_st_real1_vector_1
         , v_st_rec1_vector_1
         , v_st_rec2_vector_1
         , v_st_rec3_vector_1
         , v_st_arr1_vector_1
         , v_st_arr2_vector_1
         , v_st_arr3_vector_1
            ) ;
      correct := correct and
                 v_st_boolean_vector_1 (boolean_vector_sr_1) =
                 c_st_boolean_vector_2 (boolean_vector_sr_2) ;
      correct := correct and
                 v_st_bit_vector_1 (bit_vector_sr_1) =
                 c_st_bit_vector_2 (bit_vector_sr_2) ;
      correct := correct and
                 v_st_severity_level_vector_1 (severity_level_vector_sr_1) =
                 c_st_severity_level_vector_2 (severity_level_vector_sr_2) ;
      correct := correct and
                 v_st_string_1 (string_sr_1) =
                 c_st_string_2 (string_sr_2) ;
      correct := correct and
                 v_st_enum1_vector_1 (enum1_vector_sr_1) =
                 c_st_enum1_vector_2 (enum1_vector_sr_2) ;
      correct := correct and
                 v_st_integer_vector_1 (integer_vector_sr_1) =
                 c_st_integer_vector_2 (integer_vector_sr_2) ;
      correct := correct and
                 v_st_int1_vector_1 (int1_vector_sr_1) =
                 c_st_int1_vector_2 (int1_vector_sr_2) ;
      correct := correct and
                 v_st_time_vector_1 (time_vector_sr_1) =
                 c_st_time_vector_2 (time_vector_sr_2) ;
      correct := correct and
                 v_st_phys1_vector_1 (phys1_vector_sr_1) =
                 c_st_phys1_vector_2 (phys1_vector_sr_2) ;
      correct := correct and
                 v_st_real_vector_1 (real_vector_sr_1) =
                 c_st_real_vector_2 (real_vector_sr_2) ;
      correct := correct and
                 v_st_real1_vector_1 (real1_vector_sr_1) =
                 c_st_real1_vector_2 (real1_vector_sr_2) ;
      correct := correct and
                 v_st_rec1_vector_1 (rec1_vector_sr_1) =
                 c_st_rec1_vector_2 (rec1_vector_sr_2) ;
      correct := correct and
                 v_st_rec2_vector_1 (rec2_vector_sr_1) =
                 c_st_rec2_vector_2 (rec2_vector_sr_2) ;
      correct := correct and
                 v_st_rec3_vector_1 (rec3_vector_sr_1) =
                 c_st_rec3_vector_2 (rec3_vector_sr_2) ;
      correct := correct and
                 v_st_arr1_vector_1 (arr1_vector_sr_1) =
                 c_st_arr1_vector_2 (arr1_vector_sr_2) ;
      correct := correct and
                 v_st_arr2_vector_1 (arr2_vector_sr_1) =
                 c_st_arr2_vector_2 (arr2_vector_sr_2) ;
      correct := correct and
                 v_st_arr3_vector_1 (arr3_vector_sr_1) =
                 c_st_arr3_vector_2 (arr3_vector_sr_2) ;
--
      test_report ( "ARCH00048.P4" ,
                    "Implicit array subtype conversion occurs "&
                    "for slices",
                    correct) ;
   end process P4 ;
--
end ARCH00048 ;
--
entity ENT00048_Test_Bench is
end ENT00048_Test_Bench ;
--
architecture ARCH00048_Test_Bench of ENT00048_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00048 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00048_Test_Bench ;
