-- NEED RESULT: ARCH00033.P1: Target of a variable assignment may be a aggregate of indexed names passed
-- NEED RESULT: ARCH00033.P2: Target of a variable assignment may be a aggregate of indexed names passed
-- NEED RESULT: ARCH00033.P3: Target of a variable assignment may be a aggregate of indexed names passed
-- NEED RESULT: ARCH00033.P4: Target of a variable assignment may be a aggregate of indexed names passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00033
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
--    E00000(ARCH00033)
--    ENT00033_Test_Bench(ARCH00033_Test_Bench)
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
architecture ARCH00033 of E00000 is
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
      variable v_st_rec3_1 : st_rec3 :=
          c_st_rec3_1 ;
      variable v_st_arr1_1 : st_arr1 :=
          c_st_arr1_1 ;
      variable v_st_arr2_1 : st_arr2 :=
          c_st_arr2_1 ;
      variable v_st_arr3_1 : st_arr3 :=
          c_st_arr3_1 ;
--
      variable v_st_rec3_2 : st_rec3 :=
          c_st_rec3_1 ;
      variable v_st_arr1_2 : st_arr1 :=
          c_st_arr1_1 ;
      variable v_st_arr2_2 : st_arr2 :=
          c_st_arr2_1 ;
      variable v_st_arr3_2 : st_arr3 :=
          c_st_arr3_1 ;
--
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
      (
        v_st_rec3_1.f3(st_arr2'Left(1),st_arr2'Left(2))
      , v_st_rec3_2.f3(st_arr2'Left(1),st_arr2'Left(2))
      , v_st_rec3_3.f3(st_arr2'Left(1),st_arr2'Left(2))
      ) :=
           arr_st_arr1 ' (
           (others => c_st_rec3_2.f3(st_arr2'Right(1),st_arr2'Right(2) ))) ;
--
      (
        v_st_arr1_1(st_arr1'Left)
      , v_st_arr1_2(st_arr1'Left)
      , v_st_arr1_3(st_arr1'Left)
      ) :=
           arr_st_int1 ' (
           (others => c_st_arr1_2(st_arr1'Right))) ;
--
      (
        v_st_arr2_1(st_arr2'Left(1),st_arr2'Left(2))
      , v_st_arr2_2(st_arr2'Left(1),st_arr2'Left(2))
      , v_st_arr2_3(st_arr2'Left(1),st_arr2'Left(2))
      ) :=
           arr_st_arr1 ' (
           (others => c_st_arr2_2(st_arr2'Right(1),st_arr2'Right(2)))) ;
--
      (
        v_st_arr3_1(st_arr3'Left(1),st_arr3'Left(2))
      , v_st_arr3_2(st_arr3'Left(1),st_arr3'Left(2))
      , v_st_arr3_3(st_arr3'Left(1),st_arr3'Left(2))
      ) :=
           arr_st_rec3 ' (
           (others => c_st_arr3_2(st_arr3'Right(1),st_arr3'Right(2)))) ;
--
      correct := correct and
                 v_st_rec3_1.f3(st_arr2'Left(1),st_arr2'Left(2)) =
                 c_st_arr1_2 ;
      correct := correct and
                 v_st_arr1_1(st_arr1'Left) =
                 c_st_int1_2 ;
      correct := correct and
                 v_st_arr2_1(st_arr2'Left(1),st_arr2'Left(2)) =
                 c_st_arr1_2 ;
      correct := correct and
                 v_st_arr3_1(st_arr3'Left(1),st_arr3'Left(2)) =
                 c_st_rec3_2 ;
--
      correct := correct and
                 v_st_rec3_2.f3(st_arr2'Left(1),st_arr2'Left(2)) =
                 c_st_arr1_2 ;
      correct := correct and
                 v_st_arr1_2(st_arr1'Left) =
                 c_st_int1_2 ;
      correct := correct and
                 v_st_arr2_2(st_arr2'Left(1),st_arr2'Left(2)) =
                 c_st_arr1_2 ;
      correct := correct and
                 v_st_arr3_2(st_arr3'Left(1),st_arr3'Left(2)) =
                 c_st_rec3_2 ;
--
      correct := correct and
                 v_st_rec3_3.f3(st_arr2'Left(1),st_arr2'Left(2)) =
                 c_st_arr1_2 ;
      correct := correct and
                 v_st_arr1_3(st_arr1'Left) =
                 c_st_int1_2 ;
      correct := correct and
                 v_st_arr2_3(st_arr2'Left(1),st_arr2'Left(2)) =
                 c_st_arr1_2 ;
      correct := correct and
                 v_st_arr3_3(st_arr3'Left(1),st_arr3'Left(2)) =
                 c_st_rec3_2 ;
--
      test_report ( "ARCH00033.P1" ,
                    "Target of a variable assignment may be a " &
                    "aggregate of indexed names" ,
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
         variable v_st_rec3_1 : st_rec3 :=
             c_st_rec3_1 ;
         variable v_st_arr1_1 : st_arr1 :=
             c_st_arr1_1 ;
         variable v_st_arr2_1 : st_arr2 :=
             c_st_arr2_1 ;
         variable v_st_arr3_1 : st_arr3 :=
             c_st_arr3_1 ;
--
         variable v_st_rec3_2 : st_rec3 :=
             c_st_rec3_1 ;
         variable v_st_arr1_2 : st_arr1 :=
             c_st_arr1_1 ;
         variable v_st_arr2_2 : st_arr2 :=
             c_st_arr2_1 ;
         variable v_st_arr3_2 : st_arr3 :=
             c_st_arr3_1 ;
--
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
         (
           v_st_rec3_1.f3(st_arr2'Left(1),st_arr2'Left(2))
         , v_st_rec3_2.f3(st_arr2'Left(1),st_arr2'Left(2))
         , v_st_rec3_3.f3(st_arr2'Left(1),st_arr2'Left(2))
         ) :=
              arr_st_arr1 ' (
              (others => c_st_rec3_2.f3(st_arr2'Right(1),st_arr2'Right(2) ))) ;
--
         (
           v_st_arr1_1(st_arr1'Left)
         , v_st_arr1_2(st_arr1'Left)
         , v_st_arr1_3(st_arr1'Left)
         ) :=
              arr_st_int1 ' (
              (others => c_st_arr1_2(st_arr1'Right))) ;
--
         (
           v_st_arr2_1(st_arr2'Left(1),st_arr2'Left(2))
         , v_st_arr2_2(st_arr2'Left(1),st_arr2'Left(2))
         , v_st_arr2_3(st_arr2'Left(1),st_arr2'Left(2))
         ) :=
              arr_st_arr1 ' (
              (others => c_st_arr2_2(st_arr2'Right(1),st_arr2'Right(2)))) ;
--
         (
           v_st_arr3_1(st_arr3'Left(1),st_arr3'Left(2))
         , v_st_arr3_2(st_arr3'Left(1),st_arr3'Left(2))
         , v_st_arr3_3(st_arr3'Left(1),st_arr3'Left(2))
         ) :=
              arr_st_rec3 ' (
              (others => c_st_arr3_2(st_arr3'Right(1),st_arr3'Right(2)))) ;
--
         correct := correct and
                    v_st_rec3_1.f3(st_arr2'Left(1),st_arr2'Left(2)) =
                    c_st_arr1_2 ;
         correct := correct and
                    v_st_arr1_1(st_arr1'Left) =
                    c_st_int1_2 ;
         correct := correct and
                    v_st_arr2_1(st_arr2'Left(1),st_arr2'Left(2)) =
                    c_st_arr1_2 ;
         correct := correct and
                    v_st_arr3_1(st_arr3'Left(1),st_arr3'Left(2)) =
                    c_st_rec3_2 ;
--
         correct := correct and
                    v_st_rec3_2.f3(st_arr2'Left(1),st_arr2'Left(2)) =
                    c_st_arr1_2 ;
         correct := correct and
                    v_st_arr1_2(st_arr1'Left) =
                    c_st_int1_2 ;
         correct := correct and
                    v_st_arr2_2(st_arr2'Left(1),st_arr2'Left(2)) =
                    c_st_arr1_2 ;
         correct := correct and
                    v_st_arr3_2(st_arr3'Left(1),st_arr3'Left(2)) =
                    c_st_rec3_2 ;
--
         correct := correct and
                    v_st_rec3_3.f3(st_arr2'Left(1),st_arr2'Left(2)) =
                    c_st_arr1_2 ;
         correct := correct and
                    v_st_arr1_3(st_arr1'Left) =
                    c_st_int1_2 ;
         correct := correct and
                    v_st_arr2_3(st_arr2'Left(1),st_arr2'Left(2)) =
                    c_st_arr1_2 ;
         correct := correct and
                    v_st_arr3_3(st_arr3'Left(1),st_arr3'Left(2)) =
                    c_st_rec3_2 ;
--
      end Proc1 ;
   begin
      Proc1 ;
      test_report ( "ARCH00033.P2" ,
                    "Target of a variable assignment may be a " &
                    "aggregate of indexed names" ,
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
      variable v_st_rec3_1 : st_rec3 :=
          c_st_rec3_1 ;
      variable v_st_arr1_1 : st_arr1 :=
          c_st_arr1_1 ;
      variable v_st_arr2_1 : st_arr2 :=
          c_st_arr2_1 ;
      variable v_st_arr3_1 : st_arr3 :=
          c_st_arr3_1 ;
--
      variable v_st_rec3_2 : st_rec3 :=
          c_st_rec3_1 ;
      variable v_st_arr1_2 : st_arr1 :=
          c_st_arr1_1 ;
      variable v_st_arr2_2 : st_arr2 :=
          c_st_arr2_1 ;
      variable v_st_arr3_2 : st_arr3 :=
          c_st_arr3_1 ;
--
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
         (
           v_st_rec3_1.f3(st_arr2'Left(1),st_arr2'Left(2))
         , v_st_rec3_2.f3(st_arr2'Left(1),st_arr2'Left(2))
         , v_st_rec3_3.f3(st_arr2'Left(1),st_arr2'Left(2))
         ) :=
              arr_st_arr1 ' (
              (others => c_st_rec3_2.f3(st_arr2'Right(1),st_arr2'Right(2) ))) ;
--
         (
           v_st_arr1_1(st_arr1'Left)
         , v_st_arr1_2(st_arr1'Left)
         , v_st_arr1_3(st_arr1'Left)
         ) :=
              arr_st_int1 ' (
              (others => c_st_arr1_2(st_arr1'Right))) ;
--
         (
           v_st_arr2_1(st_arr2'Left(1),st_arr2'Left(2))
         , v_st_arr2_2(st_arr2'Left(1),st_arr2'Left(2))
         , v_st_arr2_3(st_arr2'Left(1),st_arr2'Left(2))
         ) :=
              arr_st_arr1 ' (
              (others => c_st_arr2_2(st_arr2'Right(1),st_arr2'Right(2)))) ;
--
         (
           v_st_arr3_1(st_arr3'Left(1),st_arr3'Left(2))
         , v_st_arr3_2(st_arr3'Left(1),st_arr3'Left(2))
         , v_st_arr3_3(st_arr3'Left(1),st_arr3'Left(2))
         ) :=
              arr_st_rec3 ' (
              (others => c_st_arr3_2(st_arr3'Right(1),st_arr3'Right(2)))) ;
--
      end Proc1 ;
   begin
      Proc1 ;
      correct := correct and
                 v_st_rec3_1.f3(st_arr2'Left(1),st_arr2'Left(2)) =
                 c_st_arr1_2 ;
      correct := correct and
                 v_st_arr1_1(st_arr1'Left) =
                 c_st_int1_2 ;
      correct := correct and
                 v_st_arr2_1(st_arr2'Left(1),st_arr2'Left(2)) =
                 c_st_arr1_2 ;
      correct := correct and
                 v_st_arr3_1(st_arr3'Left(1),st_arr3'Left(2)) =
                 c_st_rec3_2 ;
--
      correct := correct and
                 v_st_rec3_2.f3(st_arr2'Left(1),st_arr2'Left(2)) =
                 c_st_arr1_2 ;
      correct := correct and
                 v_st_arr1_2(st_arr1'Left) =
                 c_st_int1_2 ;
      correct := correct and
                 v_st_arr2_2(st_arr2'Left(1),st_arr2'Left(2)) =
                 c_st_arr1_2 ;
      correct := correct and
                 v_st_arr3_2(st_arr3'Left(1),st_arr3'Left(2)) =
                 c_st_rec3_2 ;
--
      correct := correct and
                 v_st_rec3_3.f3(st_arr2'Left(1),st_arr2'Left(2)) =
                 c_st_arr1_2 ;
      correct := correct and
                 v_st_arr1_3(st_arr1'Left) =
                 c_st_int1_2 ;
      correct := correct and
                 v_st_arr2_3(st_arr2'Left(1),st_arr2'Left(2)) =
                 c_st_arr1_2 ;
      correct := correct and
                 v_st_arr3_3(st_arr3'Left(1),st_arr3'Left(2)) =
                 c_st_rec3_2 ;
--
      test_report ( "ARCH00033.P3" ,
                    "Target of a variable assignment may be a " &
                    "aggregate of indexed names" ,
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
      variable v_st_rec3_1 : st_rec3 :=
          c_st_rec3_1 ;
      variable v_st_arr1_1 : st_arr1 :=
          c_st_arr1_1 ;
      variable v_st_arr2_1 : st_arr2 :=
          c_st_arr2_1 ;
      variable v_st_arr3_1 : st_arr3 :=
          c_st_arr3_1 ;
--
      variable v_st_rec3_2 : st_rec3 :=
          c_st_rec3_1 ;
      variable v_st_arr1_2 : st_arr1 :=
          c_st_arr1_1 ;
      variable v_st_arr2_2 : st_arr2 :=
          c_st_arr2_1 ;
      variable v_st_arr3_2 : st_arr3 :=
          c_st_arr3_1 ;
--
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
              v_st_rec3_2 : inout st_rec3
            ; v_st_arr1_2 : inout st_arr1
            ; v_st_arr2_2 : inout st_arr2
            ; v_st_arr3_2 : inout st_arr3
                      )
      is
      begin
         (
           v_st_rec3_1.f3(st_arr2'Left(1),st_arr2'Left(2))
         , v_st_rec3_2.f3(st_arr2'Left(1),st_arr2'Left(2))
         , v_st_rec3_3.f3(st_arr2'Left(1),st_arr2'Left(2))
         ) :=
              arr_st_arr1 ' (
              (others => c_st_rec3_2.f3(st_arr2'Right(1),st_arr2'Right(2) ))) ;
--
         (
           v_st_arr1_1(st_arr1'Left)
         , v_st_arr1_2(st_arr1'Left)
         , v_st_arr1_3(st_arr1'Left)
         ) :=
              arr_st_int1 ' (
              (others => c_st_arr1_2(st_arr1'Right))) ;
--
         (
           v_st_arr2_1(st_arr2'Left(1),st_arr2'Left(2))
         , v_st_arr2_2(st_arr2'Left(1),st_arr2'Left(2))
         , v_st_arr2_3(st_arr2'Left(1),st_arr2'Left(2))
         ) :=
              arr_st_arr1 ' (
              (others => c_st_arr2_2(st_arr2'Right(1),st_arr2'Right(2)))) ;
--
         (
           v_st_arr3_1(st_arr3'Left(1),st_arr3'Left(2))
         , v_st_arr3_2(st_arr3'Left(1),st_arr3'Left(2))
         , v_st_arr3_3(st_arr3'Left(1),st_arr3'Left(2))
         ) :=
              arr_st_rec3 ' (
              (others => c_st_arr3_2(st_arr3'Right(1),st_arr3'Right(2)))) ;
--
      end Proc1 ;
   begin
      Proc1 (
              v_st_rec3_1
            , v_st_arr1_1
            , v_st_arr2_1
            , v_st_arr3_1
            ) ;
      correct := correct and
                 v_st_rec3_1.f3(st_arr2'Left(1),st_arr2'Left(2)) =
                 c_st_arr1_2 ;
      correct := correct and
                 v_st_arr1_1(st_arr1'Left) =
                 c_st_int1_2 ;
      correct := correct and
                 v_st_arr2_1(st_arr2'Left(1),st_arr2'Left(2)) =
                 c_st_arr1_2 ;
      correct := correct and
                 v_st_arr3_1(st_arr3'Left(1),st_arr3'Left(2)) =
                 c_st_rec3_2 ;
--
      Proc1 (
              v_st_rec3_2
            , v_st_arr1_2
            , v_st_arr2_2
            , v_st_arr3_2
            ) ;
      correct := correct and
                 v_st_rec3_2.f3(st_arr2'Left(1),st_arr2'Left(2)) =
                 c_st_arr1_2 ;
      correct := correct and
                 v_st_arr1_2(st_arr1'Left) =
                 c_st_int1_2 ;
      correct := correct and
                 v_st_arr2_2(st_arr2'Left(1),st_arr2'Left(2)) =
                 c_st_arr1_2 ;
      correct := correct and
                 v_st_arr3_2(st_arr3'Left(1),st_arr3'Left(2)) =
                 c_st_rec3_2 ;
--
      Proc1 (
              v_st_rec3_3
            , v_st_arr1_3
            , v_st_arr2_3
            , v_st_arr3_3
            ) ;
      correct := correct and
                 v_st_rec3_3.f3(st_arr2'Left(1),st_arr2'Left(2)) =
                 c_st_arr1_2 ;
      correct := correct and
                 v_st_arr1_3(st_arr1'Left) =
                 c_st_int1_2 ;
      correct := correct and
                 v_st_arr2_3(st_arr2'Left(1),st_arr2'Left(2)) =
                 c_st_arr1_2 ;
      correct := correct and
                 v_st_arr3_3(st_arr3'Left(1),st_arr3'Left(2)) =
                 c_st_rec3_2 ;
--
      test_report ( "ARCH00033.P4" ,
                    "Target of a variable assignment may be a " &
                    "aggregate of indexed names" ,
                    correct) ;
   end process P4 ;
--
end ARCH00033 ;
--
entity ENT00033_Test_Bench is
end ENT00033_Test_Bench ;
--
architecture ARCH00033_Test_Bench of ENT00033_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00033 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00033_Test_Bench ;
