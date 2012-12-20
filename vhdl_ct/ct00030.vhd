-- NEED RESULT: ARCH00030.P1: Target of a variable assignment may be a simple name passed
-- NEED RESULT: ARCH00030.P2: Target of a variable assignment may be a simple name passed
-- NEED RESULT: ARCH00030.P3: Target of a variable assignment may be a simple name passed
-- NEED RESULT: ARCH00030.P4: Target of a variable assignment may be a simple name passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00030
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
--    E00000(ARCH00030)
--    ENT00030_Test_Bench(ARCH00030_Test_Bench)
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
architecture ARCH00030 of E00000 is
   signal Dummy : Boolean := false ;
--
begin
   P1 :
   process ( Dummy )
      variable v_boolean : boolean :=
          c_boolean_1 ;
      variable v_bit : bit :=
          c_bit_1 ;
      variable v_severity_level : severity_level :=
          c_severity_level_1 ;
      variable v_character : character :=
          c_character_1 ;
      variable v_st_enum1 : st_enum1 :=
          c_st_enum1_1 ;
      variable v_integer : integer :=
          c_integer_1 ;
      variable v_st_int1 : st_int1 :=
          c_st_int1_1 ;
      variable v_time : time :=
          c_time_1 ;
      variable v_st_phys1 : st_phys1 :=
          c_st_phys1_1 ;
      variable v_real : real :=
          c_real_1 ;
      variable v_st_real1 : st_real1 :=
          c_st_real1_1 ;
      variable v_st_rec1 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3 : st_rec3 :=
          c_st_rec3_1 ;
      variable v_st_arr1 : st_arr1 :=
          c_st_arr1_1 ;
      variable v_st_arr2 : st_arr2 :=
          c_st_arr2_1 ;
      variable v_st_arr3 : st_arr3 :=
          c_st_arr3_1 ;
--
      variable correct : boolean := true ;
   begin
      v_boolean := c_boolean_2 ;
      v_bit := c_bit_2 ;
      v_severity_level := c_severity_level_2 ;
      v_character := c_character_2 ;
      v_st_enum1 := c_st_enum1_2 ;
      v_integer := c_integer_2 ;
      v_st_int1 := c_st_int1_2 ;
      v_time := c_time_2 ;
      v_st_phys1 := c_st_phys1_2 ;
      v_real := c_real_2 ;
      v_st_real1 := c_st_real1_2 ;
      v_st_rec1 := c_st_rec1_2 ;
      v_st_rec2 := c_st_rec2_2 ;
      v_st_rec3 := c_st_rec3_2 ;
      v_st_arr1 := c_st_arr1_2 ;
      v_st_arr2 := c_st_arr2_2 ;
      v_st_arr3 := c_st_arr3_2 ;
--
      correct := correct and
                 v_boolean = c_boolean_2 ;
      correct := correct and
                 v_bit = c_bit_2 ;
      correct := correct and
                 v_severity_level = c_severity_level_2 ;
      correct := correct and
                 v_character = c_character_2 ;
      correct := correct and
                 v_st_enum1 = c_st_enum1_2 ;
      correct := correct and
                 v_integer = c_integer_2 ;
      correct := correct and
                 v_st_int1 = c_st_int1_2 ;
      correct := correct and
                 v_time = c_time_2 ;
      correct := correct and
                 v_st_phys1 = c_st_phys1_2 ;
      correct := correct and
                 v_real = c_real_2 ;
      correct := correct and
                 v_st_real1 = c_st_real1_2 ;
      correct := correct and
                 v_st_rec1 = c_st_rec1_2 ;
      correct := correct and
                 v_st_rec2 = c_st_rec2_2 ;
      correct := correct and
                 v_st_rec3 = c_st_rec3_2 ;
      correct := correct and
                 v_st_arr1 = c_st_arr1_2 ;
      correct := correct and
                 v_st_arr2 = c_st_arr2_2 ;
      correct := correct and
                 v_st_arr3 = c_st_arr3_2 ;
--
      test_report ( "ARCH00030.P1" ,
                    "Target of a variable assignment may be a " &
                    "simple name" ,
                    correct) ;
   end process P1 ;
--
   P2 :
   process ( Dummy )
      variable correct : boolean := true ;
--
      procedure Proc1 is
         variable v_boolean : boolean :=
             c_boolean_1 ;
         variable v_bit : bit :=
             c_bit_1 ;
         variable v_severity_level : severity_level :=
             c_severity_level_1 ;
         variable v_character : character :=
             c_character_1 ;
         variable v_st_enum1 : st_enum1 :=
             c_st_enum1_1 ;
         variable v_integer : integer :=
             c_integer_1 ;
         variable v_st_int1 : st_int1 :=
             c_st_int1_1 ;
         variable v_time : time :=
             c_time_1 ;
         variable v_st_phys1 : st_phys1 :=
             c_st_phys1_1 ;
         variable v_real : real :=
             c_real_1 ;
         variable v_st_real1 : st_real1 :=
             c_st_real1_1 ;
         variable v_st_rec1 : st_rec1 :=
             c_st_rec1_1 ;
         variable v_st_rec2 : st_rec2 :=
             c_st_rec2_1 ;
         variable v_st_rec3 : st_rec3 :=
             c_st_rec3_1 ;
         variable v_st_arr1 : st_arr1 :=
             c_st_arr1_1 ;
         variable v_st_arr2 : st_arr2 :=
             c_st_arr2_1 ;
         variable v_st_arr3 : st_arr3 :=
             c_st_arr3_1 ;
--
      begin
         v_boolean := c_boolean_2 ;
         v_bit := c_bit_2 ;
         v_severity_level := c_severity_level_2 ;
         v_character := c_character_2 ;
         v_st_enum1 := c_st_enum1_2 ;
         v_integer := c_integer_2 ;
         v_st_int1 := c_st_int1_2 ;
         v_time := c_time_2 ;
         v_st_phys1 := c_st_phys1_2 ;
         v_real := c_real_2 ;
         v_st_real1 := c_st_real1_2 ;
         v_st_rec1 := c_st_rec1_2 ;
         v_st_rec2 := c_st_rec2_2 ;
         v_st_rec3 := c_st_rec3_2 ;
         v_st_arr1 := c_st_arr1_2 ;
         v_st_arr2 := c_st_arr2_2 ;
         v_st_arr3 := c_st_arr3_2 ;
--
         correct := correct and
                    v_boolean = c_boolean_2 ;
         correct := correct and
                    v_bit = c_bit_2 ;
         correct := correct and
                    v_severity_level = c_severity_level_2 ;
         correct := correct and
                    v_character = c_character_2 ;
         correct := correct and
                    v_st_enum1 = c_st_enum1_2 ;
         correct := correct and
                    v_integer = c_integer_2 ;
         correct := correct and
                    v_st_int1 = c_st_int1_2 ;
         correct := correct and
                    v_time = c_time_2 ;
         correct := correct and
                    v_st_phys1 = c_st_phys1_2 ;
         correct := correct and
                    v_real = c_real_2 ;
         correct := correct and
                    v_st_real1 = c_st_real1_2 ;
         correct := correct and
                    v_st_rec1 = c_st_rec1_2 ;
         correct := correct and
                    v_st_rec2 = c_st_rec2_2 ;
         correct := correct and
                    v_st_rec3 = c_st_rec3_2 ;
         correct := correct and
                    v_st_arr1 = c_st_arr1_2 ;
         correct := correct and
                    v_st_arr2 = c_st_arr2_2 ;
         correct := correct and
                    v_st_arr3 = c_st_arr3_2 ;
--
      end Proc1 ;
   begin
      Proc1 ;
      test_report ( "ARCH00030.P2" ,
                    "Target of a variable assignment may be a " &
                    "simple name" ,
                    correct) ;
   end process P2 ;
--
   P3 :
   process ( Dummy )
      variable v_boolean : boolean :=
          c_boolean_1 ;
      variable v_bit : bit :=
          c_bit_1 ;
      variable v_severity_level : severity_level :=
          c_severity_level_1 ;
      variable v_character : character :=
          c_character_1 ;
      variable v_st_enum1 : st_enum1 :=
          c_st_enum1_1 ;
      variable v_integer : integer :=
          c_integer_1 ;
      variable v_st_int1 : st_int1 :=
          c_st_int1_1 ;
      variable v_time : time :=
          c_time_1 ;
      variable v_st_phys1 : st_phys1 :=
          c_st_phys1_1 ;
      variable v_real : real :=
          c_real_1 ;
      variable v_st_real1 : st_real1 :=
          c_st_real1_1 ;
      variable v_st_rec1 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3 : st_rec3 :=
          c_st_rec3_1 ;
      variable v_st_arr1 : st_arr1 :=
          c_st_arr1_1 ;
      variable v_st_arr2 : st_arr2 :=
          c_st_arr2_1 ;
      variable v_st_arr3 : st_arr3 :=
          c_st_arr3_1 ;
--
      variable correct : boolean := true ;
--
      procedure Proc1 is
      begin
         v_boolean := c_boolean_2 ;
         v_bit := c_bit_2 ;
         v_severity_level := c_severity_level_2 ;
         v_character := c_character_2 ;
         v_st_enum1 := c_st_enum1_2 ;
         v_integer := c_integer_2 ;
         v_st_int1 := c_st_int1_2 ;
         v_time := c_time_2 ;
         v_st_phys1 := c_st_phys1_2 ;
         v_real := c_real_2 ;
         v_st_real1 := c_st_real1_2 ;
         v_st_rec1 := c_st_rec1_2 ;
         v_st_rec2 := c_st_rec2_2 ;
         v_st_rec3 := c_st_rec3_2 ;
         v_st_arr1 := c_st_arr1_2 ;
         v_st_arr2 := c_st_arr2_2 ;
         v_st_arr3 := c_st_arr3_2 ;
--
      end Proc1 ;
   begin
      Proc1 ;
      correct := correct and
                 v_boolean = c_boolean_2 ;
      correct := correct and
                 v_bit = c_bit_2 ;
      correct := correct and
                 v_severity_level = c_severity_level_2 ;
      correct := correct and
                 v_character = c_character_2 ;
      correct := correct and
                 v_st_enum1 = c_st_enum1_2 ;
      correct := correct and
                 v_integer = c_integer_2 ;
      correct := correct and
                 v_st_int1 = c_st_int1_2 ;
      correct := correct and
                 v_time = c_time_2 ;
      correct := correct and
                 v_st_phys1 = c_st_phys1_2 ;
      correct := correct and
                 v_real = c_real_2 ;
      correct := correct and
                 v_st_real1 = c_st_real1_2 ;
      correct := correct and
                 v_st_rec1 = c_st_rec1_2 ;
      correct := correct and
                 v_st_rec2 = c_st_rec2_2 ;
      correct := correct and
                 v_st_rec3 = c_st_rec3_2 ;
      correct := correct and
                 v_st_arr1 = c_st_arr1_2 ;
      correct := correct and
                 v_st_arr2 = c_st_arr2_2 ;
      correct := correct and
                 v_st_arr3 = c_st_arr3_2 ;
--
      test_report ( "ARCH00030.P3" ,
                    "Target of a variable assignment may be a " &
                    "simple name" ,
                    correct) ;
   end process P3 ;
--
   P4 :
   process ( Dummy )
      variable v_boolean : boolean :=
          c_boolean_1 ;
      variable v_bit : bit :=
          c_bit_1 ;
      variable v_severity_level : severity_level :=
          c_severity_level_1 ;
      variable v_character : character :=
          c_character_1 ;
      variable v_st_enum1 : st_enum1 :=
          c_st_enum1_1 ;
      variable v_integer : integer :=
          c_integer_1 ;
      variable v_st_int1 : st_int1 :=
          c_st_int1_1 ;
      variable v_time : time :=
          c_time_1 ;
      variable v_st_phys1 : st_phys1 :=
          c_st_phys1_1 ;
      variable v_real : real :=
          c_real_1 ;
      variable v_st_real1 : st_real1 :=
          c_st_real1_1 ;
      variable v_st_rec1 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3 : st_rec3 :=
          c_st_rec3_1 ;
      variable v_st_arr1 : st_arr1 :=
          c_st_arr1_1 ;
      variable v_st_arr2 : st_arr2 :=
          c_st_arr2_1 ;
      variable v_st_arr3 : st_arr3 :=
          c_st_arr3_1 ;
--
      variable correct : boolean := true ;
--
      procedure Proc1 (
              p_boolean : inout boolean
            ; p_bit : inout bit
            ; p_severity_level : inout severity_level
            ; p_character : inout character
            ; p_st_enum1 : inout st_enum1
            ; p_integer : inout integer
            ; p_st_int1 : inout st_int1
            ; p_time : inout time
            ; p_st_phys1 : inout st_phys1
            ; p_real : inout real
            ; p_st_real1 : inout st_real1
            ; p_st_rec1 : inout st_rec1
            ; p_st_rec2 : inout st_rec2
            ; p_st_rec3 : inout st_rec3
            ; p_st_arr1 : inout st_arr1
            ; p_st_arr2 : inout st_arr2
            ; p_st_arr3 : inout st_arr3
                      )
      is
      begin
         p_boolean := c_boolean_2 ;
         p_bit := c_bit_2 ;
         p_severity_level := c_severity_level_2 ;
         p_character := c_character_2 ;
         p_st_enum1 := c_st_enum1_2 ;
         p_integer := c_integer_2 ;
         p_st_int1 := c_st_int1_2 ;
         p_time := c_time_2 ;
         p_st_phys1 := c_st_phys1_2 ;
         p_real := c_real_2 ;
         p_st_real1 := c_st_real1_2 ;
         p_st_rec1 := c_st_rec1_2 ;
         p_st_rec2 := c_st_rec2_2 ;
         p_st_rec3 := c_st_rec3_2 ;
         p_st_arr1 := c_st_arr1_2 ;
         p_st_arr2 := c_st_arr2_2 ;
         p_st_arr3 := c_st_arr3_2 ;
--
      end Proc1 ;
   begin
      Proc1 (
              v_boolean
            , v_bit
            , v_severity_level
            , v_character
            , v_st_enum1
            , v_integer
            , v_st_int1
            , v_time
            , v_st_phys1
            , v_real
            , v_st_real1
            , v_st_rec1
            , v_st_rec2
            , v_st_rec3
            , v_st_arr1
            , v_st_arr2
            , v_st_arr3
            ) ;
      correct := correct and
                 v_boolean = c_boolean_2 ;
      correct := correct and
                 v_bit = c_bit_2 ;
      correct := correct and
                 v_severity_level = c_severity_level_2 ;
      correct := correct and
                 v_character = c_character_2 ;
      correct := correct and
                 v_st_enum1 = c_st_enum1_2 ;
      correct := correct and
                 v_integer = c_integer_2 ;
      correct := correct and
                 v_st_int1 = c_st_int1_2 ;
      correct := correct and
                 v_time = c_time_2 ;
      correct := correct and
                 v_st_phys1 = c_st_phys1_2 ;
      correct := correct and
                 v_real = c_real_2 ;
      correct := correct and
                 v_st_real1 = c_st_real1_2 ;
      correct := correct and
                 v_st_rec1 = c_st_rec1_2 ;
      correct := correct and
                 v_st_rec2 = c_st_rec2_2 ;
      correct := correct and
                 v_st_rec3 = c_st_rec3_2 ;
      correct := correct and
                 v_st_arr1 = c_st_arr1_2 ;
      correct := correct and
                 v_st_arr2 = c_st_arr2_2 ;
      correct := correct and
                 v_st_arr3 = c_st_arr3_2 ;
--
      test_report ( "ARCH00030.P4" ,
                    "Target of a variable assignment may be a " &
                    "simple name" ,
                    correct) ;
   end process P4 ;
--
end ARCH00030 ;
--
entity ENT00030_Test_Bench is
end ENT00030_Test_Bench ;
--
architecture ARCH00030_Test_Bench of ENT00030_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00030 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00030_Test_Bench ;
