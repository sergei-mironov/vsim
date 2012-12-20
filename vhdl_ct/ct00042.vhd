-- NEED RESULT: ARCH00042.P1: Target of a variable assignment may be a slice prefixed by an indexed name passed
-- NEED RESULT: ARCH00042.P2: Target of a variable assignment may be a slice prefixed by an indexed name passed
-- NEED RESULT: ARCH00042.P3: Target of a variable assignment may be a slice prefixed by an indexed name passed
-- NEED RESULT: ARCH00042.P4: Target of a variable assignment may be a slice prefixed by an indexed name passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00042
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
--    E00000(ARCH00042)
--    ENT00042_Test_Bench(ARCH00042_Test_Bench)
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
architecture ARCH00042 of E00000 is
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
--
      variable correct : boolean := true ;
   begin
      v_st_rec3_vector(lowb).f3(st_arr2'Left(1),st_arr2'Left(2))
        (lowb+1 to highb-1)
      := c_st_rec3_vector_2(lowb).f3(st_arr2'Right(1),st_arr2'Right(2))
           (lowb+1 to highb-1) ;
--
      v_st_arr1_vector(lowb)(lowb+1 to highb-1)
      := c_st_arr1_vector_2(lowb)(lowb+1 to highb-1) ;
--
      v_st_arr2_vector(lowb)(st_arr2'Left(1),st_arr2'Left(2))
        (lowb+1 to highb-1)
      := c_st_arr2_vector_2(lowb)(st_arr2'Right(1),st_arr2'Right(2))
           (lowb+1 to highb-1) ;
--
--
      correct :=
        correct and
        v_st_rec3_vector(lowb).f3(st_arr2'Left(1),st_arr2'Left(2))
          (lowb+1 to highb-1) =
        c_st_rec3_vector_2(lowb).f3(st_arr2'Right(1),st_arr2'Right(2))
          (lowb+1 to highb-1) ;
--
      correct :=
        correct and
        v_st_arr1_vector(lowb)(lowb+1 to highb-1) =
        c_st_arr1_vector_2(lowb)(lowb+1 to highb-1) ;
--
      correct :=
        correct and
        v_st_arr2_vector(lowb)(st_arr2'Left(1),st_arr2'Left(2))
          (lowb+1 to highb-1) =
        c_st_arr2_vector_2(lowb)(st_arr2'Right(1),st_arr2'Right(2))
          (lowb+1 to highb-1) ;
--
--
      test_report ( "ARCH00042.P1" ,
                    "Target of a variable assignment may be a " &
                    "slice prefixed by an indexed name" ,
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
--
      begin
         v_st_rec3_vector(lowb).f3(st_arr2'Left(1),st_arr2'Left(2))
           (lowb+1 to highb-1)
         := c_st_rec3_vector_2(lowb).f3(st_arr2'Right(1),st_arr2'Right(2))
              (lowb+1 to highb-1) ;
--
         v_st_arr1_vector(lowb)(lowb+1 to highb-1)
         := c_st_arr1_vector_2(lowb)(lowb+1 to highb-1) ;
--
         v_st_arr2_vector(lowb)(st_arr2'Left(1),st_arr2'Left(2))
           (lowb+1 to highb-1)
         := c_st_arr2_vector_2(lowb)(st_arr2'Right(1),st_arr2'Right(2))
              (lowb+1 to highb-1) ;
--
--
         correct :=
           correct and
           v_st_rec3_vector(lowb).f3(st_arr2'Left(1),st_arr2'Left(2))
             (lowb+1 to highb-1) =
           c_st_rec3_vector_2(lowb).f3(st_arr2'Right(1),st_arr2'Right(2))
             (lowb+1 to highb-1) ;
--
         correct :=
           correct and
           v_st_arr1_vector(lowb)(lowb+1 to highb-1) =
           c_st_arr1_vector_2(lowb)(lowb+1 to highb-1) ;
--
         correct :=
           correct and
           v_st_arr2_vector(lowb)(st_arr2'Left(1),st_arr2'Left(2))
             (lowb+1 to highb-1) =
           c_st_arr2_vector_2(lowb)(st_arr2'Right(1),st_arr2'Right(2))
             (lowb+1 to highb-1) ;
--
--
      end Proc1 ;
   begin
      Proc1 ;
      test_report ( "ARCH00042.P2" ,
                    "Target of a variable assignment may be a " &
                    "slice prefixed by an indexed name" ,
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
--
      variable correct : boolean := true ;
--
      procedure Proc1 is
      begin
         v_st_rec3_vector(lowb).f3(st_arr2'Left(1),st_arr2'Left(2))
           (lowb+1 to highb-1)
         := c_st_rec3_vector_2(lowb).f3(st_arr2'Right(1),st_arr2'Right(2))
              (lowb+1 to highb-1) ;
--
         v_st_arr1_vector(lowb)(lowb+1 to highb-1)
         := c_st_arr1_vector_2(lowb)(lowb+1 to highb-1) ;
--
         v_st_arr2_vector(lowb)(st_arr2'Left(1),st_arr2'Left(2))
           (lowb+1 to highb-1)
         := c_st_arr2_vector_2(lowb)(st_arr2'Right(1),st_arr2'Right(2))
              (lowb+1 to highb-1) ;
--
--
      end Proc1 ;
   begin
      Proc1 ;
      correct :=
        correct and
        v_st_rec3_vector(lowb).f3(st_arr2'Left(1),st_arr2'Left(2))
          (lowb+1 to highb-1) =
        c_st_rec3_vector_2(lowb).f3(st_arr2'Right(1),st_arr2'Right(2))
          (lowb+1 to highb-1) ;
--
      correct :=
        correct and
        v_st_arr1_vector(lowb)(lowb+1 to highb-1) =
        c_st_arr1_vector_2(lowb)(lowb+1 to highb-1) ;
--
      correct :=
        correct and
        v_st_arr2_vector(lowb)(st_arr2'Left(1),st_arr2'Left(2))
          (lowb+1 to highb-1) =
        c_st_arr2_vector_2(lowb)(st_arr2'Right(1),st_arr2'Right(2))
          (lowb+1 to highb-1) ;
--
--
      test_report ( "ARCH00042.P3" ,
                    "Target of a variable assignment may be a " &
                    "slice prefixed by an indexed name" ,
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
--
      variable correct : boolean := true ;
--
      procedure Proc1 (
           v_st_rec3_vector : inout st_rec3_vector
         ; v_st_arr1_vector : inout st_arr1_vector
         ; v_st_arr2_vector : inout st_arr2_vector
                      )
      is
      begin
         v_st_rec3_vector(lowb).f3(st_arr2'Left(1),st_arr2'Left(2))
           (lowb+1 to highb-1)
         := c_st_rec3_vector_2(lowb).f3(st_arr2'Right(1),st_arr2'Right(2))
              (lowb+1 to highb-1) ;
--
         v_st_arr1_vector(lowb)(lowb+1 to highb-1)
         := c_st_arr1_vector_2(lowb)(lowb+1 to highb-1) ;
--
         v_st_arr2_vector(lowb)(st_arr2'Left(1),st_arr2'Left(2))
           (lowb+1 to highb-1)
         := c_st_arr2_vector_2(lowb)(st_arr2'Right(1),st_arr2'Right(2))
              (lowb+1 to highb-1) ;
--
--
      end Proc1 ;
   begin
      Proc1 (
           v_st_rec3_vector
         , v_st_arr1_vector
         , v_st_arr2_vector
            ) ;
      correct :=
        correct and
        v_st_rec3_vector(lowb).f3(st_arr2'Left(1),st_arr2'Left(2))
          (lowb+1 to highb-1) =
        c_st_rec3_vector_2(lowb).f3(st_arr2'Right(1),st_arr2'Right(2))
          (lowb+1 to highb-1) ;
--
      correct :=
        correct and
        v_st_arr1_vector(lowb)(lowb+1 to highb-1) =
        c_st_arr1_vector_2(lowb)(lowb+1 to highb-1) ;
--
      correct :=
        correct and
        v_st_arr2_vector(lowb)(st_arr2'Left(1),st_arr2'Left(2))
          (lowb+1 to highb-1) =
        c_st_arr2_vector_2(lowb)(st_arr2'Right(1),st_arr2'Right(2))
          (lowb+1 to highb-1) ;
--
--
      test_report ( "ARCH00042.P4" ,
                    "Target of a variable assignment may be a " &
                    "slice prefixed by an indexed name" ,
                    correct) ;
   end process P4 ;
--
end ARCH00042 ;
--
entity ENT00042_Test_Bench is
end ENT00042_Test_Bench ;
--
architecture ARCH00042_Test_Bench of ENT00042_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00042 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00042_Test_Bench ;
