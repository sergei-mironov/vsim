-- NEED RESULT: ARCH00044.P1: Target of a variable assignment may be a indexed name prefixed by a selected name passed
-- NEED RESULT: ARCH00044.P2: Target of a variable assignment may be a indexed name prefixed by a selected name passed
-- NEED RESULT: ARCH00044.P3: Target of a variable assignment may be a indexed name prefixed by a selected name passed
-- NEED RESULT: ARCH00044.P4: Target of a variable assignment may be a indexed name prefixed by a selected name passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00044
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
--    E00000(ARCH00044)
--    ENT00044_Test_Bench(ARCH00044_Test_Bench)
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
architecture ARCH00044 of E00000 is
   signal Dummy : Boolean := false ;
--
begin
   P1 :
   process ( Dummy )
      variable v_st_rec3 : st_rec3 :=
          c_st_rec3_1 ;
--
      variable correct : boolean := true ;
   begin
      v_st_rec3.f3(st_arr2'Left(1),st_arr2'Left(2)) :=
        c_st_rec3_2.f3(st_arr2'Right(1),st_arr2'Right(2)) ;
--
      correct :=
        correct and
        v_st_rec3.f3(st_arr2'Left(1),st_arr2'Left(2)) =
        c_st_arr1_2 ;
--
      test_report ( "ARCH00044.P1" ,
                    "Target of a variable assignment may be a " &
                    "indexed name prefixed by a selected name" ,
                    correct) ;
   end process P1 ;
--
   P2 :
   process ( Dummy )
      variable correct : boolean := true ;
--
      procedure Proc1 is
         variable v_st_rec3 : st_rec3 :=
             c_st_rec3_1 ;
--
      begin
         v_st_rec3.f3(st_arr2'Left(1),st_arr2'Left(2)) :=
           c_st_rec3_2.f3(st_arr2'Right(1),st_arr2'Right(2)) ;
--
         correct :=
           correct and
           v_st_rec3.f3(st_arr2'Left(1),st_arr2'Left(2)) =
           c_st_arr1_2 ;
--
      end Proc1 ;
   begin
      Proc1 ;
      test_report ( "ARCH00044.P2" ,
                    "Target of a variable assignment may be a " &
                    "indexed name prefixed by a selected name" ,
                    correct) ;
   end process P2 ;
--
   P3 :
   process ( Dummy )
      variable v_st_rec3 : st_rec3 :=
          c_st_rec3_1 ;
--
      variable correct : boolean := true ;
--
      procedure Proc1 is
      begin
         v_st_rec3.f3(st_arr2'Left(1),st_arr2'Left(2)) :=
           c_st_rec3_2.f3(st_arr2'Right(1),st_arr2'Right(2)) ;
--
      end Proc1 ;
   begin
      Proc1 ;
      correct :=
        correct and
        v_st_rec3.f3(st_arr2'Left(1),st_arr2'Left(2)) =
        c_st_arr1_2 ;
--
      test_report ( "ARCH00044.P3" ,
                    "Target of a variable assignment may be a " &
                    "indexed name prefixed by a selected name" ,
                    correct) ;
   end process P3 ;
--
   P4 :
   process ( Dummy )
      variable v_st_rec3 : st_rec3 :=
          c_st_rec3_1 ;
--
      variable correct : boolean := true ;
--
      procedure Proc1 (
           v_st_rec3 : inout st_rec3
                      )
      is
      begin
         v_st_rec3.f3(st_arr2'Left(1),st_arr2'Left(2)) :=
           c_st_rec3_2.f3(st_arr2'Right(1),st_arr2'Right(2)) ;
--
      end Proc1 ;
   begin
      Proc1 (
           v_st_rec3
            ) ;
      correct :=
        correct and
        v_st_rec3.f3(st_arr2'Left(1),st_arr2'Left(2)) =
        c_st_arr1_2 ;
--
      test_report ( "ARCH00044.P4" ,
                    "Target of a variable assignment may be a " &
                    "indexed name prefixed by a selected name" ,
                    correct) ;
   end process P4 ;
--
end ARCH00044 ;
--
entity ENT00044_Test_Bench is
end ENT00044_Test_Bench ;
--
architecture ARCH00044_Test_Bench of ENT00044_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00044 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00044_Test_Bench ;
