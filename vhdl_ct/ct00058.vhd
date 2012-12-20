-- NEED RESULT: ARCH00058.P1: While condition in loop is evaluated prior to execution of loop body passed
-- NEED RESULT: ARCH00058.P2: While condition in loop is evaluated prior to execution of loop body passed
-- NEED RESULT: ARCH00058.P3: While condition in loop is evaluated prior to execution of loop body passed
-- NEED RESULT: ARCH00058.P4: While condition in loop is evaluated prior to execution of loop body passed
-- NEED RESULT: ARCH00058.P5: While condition in loop is evaluated prior to execution of loop body passed
-- NEED RESULT: ARCH00058.P6: While condition in loop is evaluated prior to execution of loop body passed
-- NEED RESULT: ARCH00058.P7: While condition in loop is evaluated prior to execution of loop body passed
-- NEED RESULT: ARCH00058.P8: While condition in loop is evaluated prior to execution of loop body passed
-- NEED RESULT: ARCH00058.P9: While condition in loop is evaluated prior to execution of loop body passed
-- NEED RESULT: ARCH00058.P10: While condition in loop is evaluated prior to execution of loop body passed
-- NEED RESULT: ARCH00058.P11: While condition in loop is evaluated prior to execution of loop body passed
-- NEED RESULT: ARCH00058.P12: While condition in loop is evaluated prior to execution of loop body passed
-- NEED RESULT: ARCH00058.P13: While condition in loop is evaluated prior to execution of loop body passed
-- NEED RESULT: ARCH00058.P14: While condition in loop is evaluated prior to execution of loop body passed
-- NEED RESULT: ARCH00058.P15: While condition in loop is evaluated prior to execution of loop body passed
-- NEED RESULT: ARCH00058.P16: While condition in loop is evaluated prior to execution of loop body passed
-- NEED RESULT: ARCH00058.P17: While condition in loop is evaluated prior to execution of loop body passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00058
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.8 (3)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00058)
--    ENT00058_Test_Bench(ARCH00058_Test_Bench)
--
-- REVISION HISTORY:
--
--    02-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00058 of E00000 is
   signal Dummy : Boolean := false ;
begin
   P1 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_boolean : boolean :=
          c_boolean_1 ;
--
   begin
      L1 :
      while v_boolean /= c_boolean_1 loop
         correct := false ;
         v_boolean := c_boolean_2 ;
      end loop L1 ;
      test_report ( "ARCH00058.P1" ,
              "While condition in loop is evaluated prior to " &
              "execution of loop body",
              correct ) ;
--
   end process P1 ;
--
   P2 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_bit : bit :=
          c_bit_1 ;
--
   begin
      L1 :
      while v_bit /= c_bit_1 loop
         correct := false ;
         v_bit := c_bit_2 ;
      end loop L1 ;
      test_report ( "ARCH00058.P2" ,
              "While condition in loop is evaluated prior to " &
              "execution of loop body",
              correct ) ;
--
   end process P2 ;
--
   P3 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_severity_level : severity_level :=
          c_severity_level_1 ;
--
   begin
      L1 :
      while v_severity_level /= c_severity_level_1 loop
         correct := false ;
         v_severity_level := c_severity_level_2 ;
      end loop L1 ;
      test_report ( "ARCH00058.P3" ,
              "While condition in loop is evaluated prior to " &
              "execution of loop body",
              correct ) ;
--
   end process P3 ;
--
   P4 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_character : character :=
          c_character_1 ;
--
   begin
      L1 :
      while v_character /= c_character_1 loop
         correct := false ;
         v_character := c_character_2 ;
      end loop L1 ;
      test_report ( "ARCH00058.P4" ,
              "While condition in loop is evaluated prior to " &
              "execution of loop body",
              correct ) ;
--
   end process P4 ;
--
   P5 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_st_enum1 : st_enum1 :=
          c_st_enum1_1 ;
--
   begin
      L1 :
      while v_st_enum1 /= c_st_enum1_1 loop
         correct := false ;
         v_st_enum1 := c_st_enum1_2 ;
      end loop L1 ;
      test_report ( "ARCH00058.P5" ,
              "While condition in loop is evaluated prior to " &
              "execution of loop body",
              correct ) ;
--
   end process P5 ;
--
   P6 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_integer : integer :=
          c_integer_1 ;
--
   begin
      L1 :
      while v_integer /= c_integer_1 loop
         correct := false ;
         v_integer := c_integer_2 ;
      end loop L1 ;
      test_report ( "ARCH00058.P6" ,
              "While condition in loop is evaluated prior to " &
              "execution of loop body",
              correct ) ;
--
   end process P6 ;
--
   P7 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_st_int1 : st_int1 :=
          c_st_int1_1 ;
--
   begin
      L1 :
      while v_st_int1 /= c_st_int1_1 loop
         correct := false ;
         v_st_int1 := c_st_int1_2 ;
      end loop L1 ;
      test_report ( "ARCH00058.P7" ,
              "While condition in loop is evaluated prior to " &
              "execution of loop body",
              correct ) ;
--
   end process P7 ;
--
   P8 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_time : time :=
          c_time_1 ;
--
   begin
      L1 :
      while v_time /= c_time_1 loop
         correct := false ;
         v_time := c_time_2 ;
      end loop L1 ;
      test_report ( "ARCH00058.P8" ,
              "While condition in loop is evaluated prior to " &
              "execution of loop body",
              correct ) ;
--
   end process P8 ;
--
   P9 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_st_phys1 : st_phys1 :=
          c_st_phys1_1 ;
--
   begin
      L1 :
      while v_st_phys1 /= c_st_phys1_1 loop
         correct := false ;
         v_st_phys1 := c_st_phys1_2 ;
      end loop L1 ;
      test_report ( "ARCH00058.P9" ,
              "While condition in loop is evaluated prior to " &
              "execution of loop body",
              correct ) ;
--
   end process P9 ;
--
   P10 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_real : real :=
          c_real_1 ;
--
   begin
      L1 :
      while v_real /= c_real_1 loop
         correct := false ;
         v_real := c_real_2 ;
      end loop L1 ;
      test_report ( "ARCH00058.P10" ,
              "While condition in loop is evaluated prior to " &
              "execution of loop body",
              correct ) ;
--
   end process P10 ;
--
   P11 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_st_real1 : st_real1 :=
          c_st_real1_1 ;
--
   begin
      L1 :
      while v_st_real1 /= c_st_real1_1 loop
         correct := false ;
         v_st_real1 := c_st_real1_2 ;
      end loop L1 ;
      test_report ( "ARCH00058.P11" ,
              "While condition in loop is evaluated prior to " &
              "execution of loop body",
              correct ) ;
--
   end process P11 ;
--
   P12 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_st_rec1 : st_rec1 :=
          c_st_rec1_1 ;
--
   begin
      L1 :
      while v_st_rec1 /= c_st_rec1_1 loop
         correct := false ;
         v_st_rec1 := c_st_rec1_2 ;
      end loop L1 ;
      test_report ( "ARCH00058.P12" ,
              "While condition in loop is evaluated prior to " &
              "execution of loop body",
              correct ) ;
--
   end process P12 ;
--
   P13 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_st_rec2 : st_rec2 :=
          c_st_rec2_1 ;
--
   begin
      L1 :
      while v_st_rec2 /= c_st_rec2_1 loop
         correct := false ;
         v_st_rec2 := c_st_rec2_2 ;
      end loop L1 ;
      test_report ( "ARCH00058.P13" ,
              "While condition in loop is evaluated prior to " &
              "execution of loop body",
              correct ) ;
--
   end process P13 ;
--
   P14 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_st_rec3 : st_rec3 :=
          c_st_rec3_1 ;
--
   begin
      L1 :
      while v_st_rec3 /= c_st_rec3_1 loop
         correct := false ;
         v_st_rec3 := c_st_rec3_2 ;
      end loop L1 ;
      test_report ( "ARCH00058.P14" ,
              "While condition in loop is evaluated prior to " &
              "execution of loop body",
              correct ) ;
--
   end process P14 ;
--
   P15 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_st_arr1 : st_arr1 :=
          c_st_arr1_1 ;
--
   begin
      L1 :
      while v_st_arr1 /= c_st_arr1_1 loop
         correct := false ;
         v_st_arr1 := c_st_arr1_2 ;
      end loop L1 ;
      test_report ( "ARCH00058.P15" ,
              "While condition in loop is evaluated prior to " &
              "execution of loop body",
              correct ) ;
--
   end process P15 ;
--
   P16 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_st_arr2 : st_arr2 :=
          c_st_arr2_1 ;
--
   begin
      L1 :
      while v_st_arr2 /= c_st_arr2_1 loop
         correct := false ;
         v_st_arr2 := c_st_arr2_2 ;
      end loop L1 ;
      test_report ( "ARCH00058.P16" ,
              "While condition in loop is evaluated prior to " &
              "execution of loop body",
              correct ) ;
--
   end process P16 ;
--
   P17 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_st_arr3 : st_arr3 :=
          c_st_arr3_1 ;
--
   begin
      L1 :
      while v_st_arr3 /= c_st_arr3_1 loop
         correct := false ;
         v_st_arr3 := c_st_arr3_2 ;
      end loop L1 ;
      test_report ( "ARCH00058.P17" ,
              "While condition in loop is evaluated prior to " &
              "execution of loop body",
              correct ) ;
--
   end process P17 ;
--
--
end ARCH00058 ;
--
entity ENT00058_Test_Bench is
end ENT00058_Test_Bench ;
--
architecture ARCH00058_Test_Bench of ENT00058_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00058 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00058_Test_Bench ;
