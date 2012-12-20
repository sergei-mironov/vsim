-- NEED RESULT: ARCH00041.P1: Target of a variable assignment may be a indexed name prefixed by an indexed name passed
-- NEED RESULT: ARCH00041.P2: Target of a variable assignment may be a indexed name prefixed by an indexed name passed
-- NEED RESULT: ARCH00041.P3: Target of a variable assignment may be a indexed name prefixed by an indexed name passed
-- NEED RESULT: ARCH00041.P4: Target of a variable assignment may be a indexed name prefixed by an indexed name passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00041
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
--    E00000(ARCH00041)
--    ENT00041_Test_Bench(ARCH00041_Test_Bench)
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
architecture ARCH00041 of E00000 is
   signal Dummy : Boolean := false ;
--
begin
   P1 :
   process ( Dummy )
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
      v_st_rec3_vector(lowb).f3(st_arr2'Left(1),st_arr2'Left(2)) :=
        c_st_rec3_vector_2(lowb).f3(st_arr2'Right(1),st_arr2'Right(2)) ;
      v_st_arr1_vector(lowb)(st_arr1'Left) :=
        c_st_arr1_vector_2(lowb)(st_arr1'Right) ;
      v_st_arr2_vector(lowb)(st_arr2'Left(1),st_arr2'Left(2)) :=
        c_st_arr2_vector_2(lowb)(st_arr2'Right(1),st_arr2'Right(2)) ;
      v_st_arr3_vector(lowb)(st_arr3'Left(1),st_arr3'Left(2)) :=
        c_st_arr3_vector_2(lowb)(st_arr3'Right(1),st_arr3'Right(2)) ;
--
      correct :=
        correct and
        v_st_rec3_vector(lowb).f3(st_arr2'Left(1),st_arr2'Left(2)) =
        c_st_arr1_2 ;
--
      correct :=
        correct and
        v_st_arr1_vector(lowb)(st_arr1'Left) =
        c_st_int1_2 ;
--
      correct :=
        correct and
        v_st_arr2_vector(lowb)(st_arr2'Left(1),st_arr2'Left(2)) =
        c_st_arr1_2 ;
--
      correct :=
        correct and
        v_st_arr3_vector(lowb)(st_arr3'Left(1),st_arr3'Left(2)) =
        c_st_rec3_2 ;
--
--
      test_report ( "ARCH00041.P1" ,
                    "Target of a variable assignment may be a " &
                    "indexed name prefixed by an indexed name" ,
                    correct) ;
   end process P1 ;
--
   P2 :
   process ( Dummy )
      variable correct : boolean := true ;
--
      procedure Proc1 is
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
         v_st_rec3_vector(lowb).f3(st_arr2'Left(1),st_arr2'Left(2)) :=
           c_st_rec3_vector_2(lowb).f3(st_arr2'Right(1),st_arr2'Right(2)) ;
         v_st_arr1_vector(lowb)(st_arr1'Left) :=
           c_st_arr1_vector_2(lowb)(st_arr1'Right) ;
         v_st_arr2_vector(lowb)(st_arr2'Left(1),st_arr2'Left(2)) :=
           c_st_arr2_vector_2(lowb)(st_arr2'Right(1),st_arr2'Right(2)) ;
         v_st_arr3_vector(lowb)(st_arr3'Left(1),st_arr3'Left(2)) :=
           c_st_arr3_vector_2(lowb)(st_arr3'Right(1),st_arr3'Right(2)) ;
--
         correct :=
           correct and
           v_st_rec3_vector(lowb).f3(st_arr2'Left(1),st_arr2'Left(2)) =
           c_st_arr1_2 ;
--
         correct :=
           correct and
           v_st_arr1_vector(lowb)(st_arr1'Left) =
           c_st_int1_2 ;
--
         correct :=
           correct and
           v_st_arr2_vector(lowb)(st_arr2'Left(1),st_arr2'Left(2)) =
           c_st_arr1_2 ;
--
         correct :=
           correct and
           v_st_arr3_vector(lowb)(st_arr3'Left(1),st_arr3'Left(2)) =
           c_st_rec3_2 ;
--
--
      end Proc1 ;
   begin
      Proc1 ;
      test_report ( "ARCH00041.P2" ,
                    "Target of a variable assignment may be a " &
                    "indexed name prefixed by an indexed name" ,
                    correct) ;
   end process P2 ;
--
   P3 :
   process ( Dummy )
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
         v_st_rec3_vector(lowb).f3(st_arr2'Left(1),st_arr2'Left(2)) :=
           c_st_rec3_vector_2(lowb).f3(st_arr2'Right(1),st_arr2'Right(2)) ;
         v_st_arr1_vector(lowb)(st_arr1'Left) :=
           c_st_arr1_vector_2(lowb)(st_arr1'Right) ;
         v_st_arr2_vector(lowb)(st_arr2'Left(1),st_arr2'Left(2)) :=
           c_st_arr2_vector_2(lowb)(st_arr2'Right(1),st_arr2'Right(2)) ;
         v_st_arr3_vector(lowb)(st_arr3'Left(1),st_arr3'Left(2)) :=
           c_st_arr3_vector_2(lowb)(st_arr3'Right(1),st_arr3'Right(2)) ;
--
      end Proc1 ;
   begin
      Proc1 ;
      correct :=
        correct and
        v_st_rec3_vector(lowb).f3(st_arr2'Left(1),st_arr2'Left(2)) =
        c_st_arr1_2 ;
--
      correct :=
        correct and
        v_st_arr1_vector(lowb)(st_arr1'Left) =
        c_st_int1_2 ;
--
      correct :=
        correct and
        v_st_arr2_vector(lowb)(st_arr2'Left(1),st_arr2'Left(2)) =
        c_st_arr1_2 ;
--
      correct :=
        correct and
        v_st_arr3_vector(lowb)(st_arr3'Left(1),st_arr3'Left(2)) =
        c_st_rec3_2 ;
--
--
      test_report ( "ARCH00041.P3" ,
                    "Target of a variable assignment may be a " &
                    "indexed name prefixed by an indexed name" ,
                    correct) ;
   end process P3 ;
--
   P4 :
   process ( Dummy )
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
           v_st_rec3_vector : inout st_rec3_vector
         ; v_st_arr1_vector : inout st_arr1_vector
         ; v_st_arr2_vector : inout st_arr2_vector
         ; v_st_arr3_vector : inout st_arr3_vector
                      )
      is
      begin
         v_st_rec3_vector(lowb).f3(st_arr2'Left(1),st_arr2'Left(2)) :=
           c_st_rec3_vector_2(lowb).f3(st_arr2'Right(1),st_arr2'Right(2)) ;
         v_st_arr1_vector(lowb)(st_arr1'Left) :=
           c_st_arr1_vector_2(lowb)(st_arr1'Right) ;
         v_st_arr2_vector(lowb)(st_arr2'Left(1),st_arr2'Left(2)) :=
           c_st_arr2_vector_2(lowb)(st_arr2'Right(1),st_arr2'Right(2)) ;
         v_st_arr3_vector(lowb)(st_arr3'Left(1),st_arr3'Left(2)) :=
           c_st_arr3_vector_2(lowb)(st_arr3'Right(1),st_arr3'Right(2)) ;
--
      end Proc1 ;
   begin
      Proc1 (
           v_st_rec3_vector
         , v_st_arr1_vector
         , v_st_arr2_vector
         , v_st_arr3_vector
            ) ;
      correct :=
        correct and
        v_st_rec3_vector(lowb).f3(st_arr2'Left(1),st_arr2'Left(2)) =
        c_st_arr1_2 ;
--
      correct :=
        correct and
        v_st_arr1_vector(lowb)(st_arr1'Left) =
        c_st_int1_2 ;
--
      correct :=
        correct and
        v_st_arr2_vector(lowb)(st_arr2'Left(1),st_arr2'Left(2)) =
        c_st_arr1_2 ;
--
      correct :=
        correct and
        v_st_arr3_vector(lowb)(st_arr3'Left(1),st_arr3'Left(2)) =
        c_st_rec3_2 ;
--
--
      test_report ( "ARCH00041.P4" ,
                    "Target of a variable assignment may be a " &
                    "indexed name prefixed by an indexed name" ,
                    correct) ;
   end process P4 ;
--
end ARCH00041 ;
--
entity ENT00041_Test_Bench is
end ENT00041_Test_Bench ;
--
architecture ARCH00041_Test_Bench of ENT00041_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00041 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00041_Test_Bench ;
