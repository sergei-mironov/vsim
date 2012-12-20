-- NEED RESULT: ARCH00043.P1: Target of a variable assignment may be a selected name prefixed by an indexed name passed
-- NEED RESULT: ARCH00043.P2: Target of a variable assignment may be a selected name prefixed by an indexed name passed
-- NEED RESULT: ARCH00043.P3: Target of a variable assignment may be a selected name prefixed by an indexed name passed
-- NEED RESULT: ARCH00043.P4: Target of a variable assignment may be a selected name prefixed by an indexed name passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00043
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
--    E00000(ARCH00043)
--    ENT00043_Test_Bench(ARCH00043_Test_Bench)
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
architecture ARCH00043 of E00000 is
   signal Dummy : Boolean := false ;
--
begin
   P1 :
   process ( Dummy )
      variable v_st_rec1_vector : st_rec1_vector :=
          c_st_rec1_vector_1 ;
      variable v_st_rec2_vector : st_rec2_vector :=
          c_st_rec2_vector_1 ;
      variable v_st_rec3_vector : st_rec3_vector :=
          c_st_rec3_vector_1 ;
--
      variable correct : boolean := true ;
   begin
      v_st_rec1_vector(lowb).f2 := c_st_rec1_vector_2(lowb).f2 ;
      v_st_rec2_vector(lowb).f2 := c_st_rec2_vector_2(lowb).f2 ;
      v_st_rec3_vector(lowb).f2 := c_st_rec3_vector_2(lowb).f2 ;
--
      correct := correct and
                 v_st_rec1_vector(lowb).f2 = c_st_rec1_vector_2(lowb).f2 ;
      correct := correct and
                 v_st_rec2_vector(lowb).f2 = c_st_rec2_vector_2(lowb).f2 ;
      correct := correct and
                 v_st_rec3_vector(lowb).f2 = c_st_rec3_vector_2(lowb).f2 ;
--
      test_report ( "ARCH00043.P1" ,
                    "Target of a variable assignment may be a " &
                    "selected name prefixed by an indexed name" ,
                    correct) ;
   end process P1 ;
--
   P2 :
   process ( Dummy )
      variable correct : boolean := true ;
--
      procedure Proc1 is
         variable v_st_rec1_vector : st_rec1_vector :=
             c_st_rec1_vector_1 ;
         variable v_st_rec2_vector : st_rec2_vector :=
             c_st_rec2_vector_1 ;
         variable v_st_rec3_vector : st_rec3_vector :=
             c_st_rec3_vector_1 ;
--
      begin
         v_st_rec1_vector(lowb).f2 := c_st_rec1_vector_2(lowb).f2 ;
         v_st_rec2_vector(lowb).f2 := c_st_rec2_vector_2(lowb).f2 ;
         v_st_rec3_vector(lowb).f2 := c_st_rec3_vector_2(lowb).f2 ;
--
         correct := correct and
                    v_st_rec1_vector(lowb).f2 = c_st_rec1_vector_2(lowb).f2 ;
         correct := correct and
                    v_st_rec2_vector(lowb).f2 = c_st_rec2_vector_2(lowb).f2 ;
         correct := correct and
                    v_st_rec3_vector(lowb).f2 = c_st_rec3_vector_2(lowb).f2 ;
--
      end Proc1 ;
   begin
      Proc1 ;
      test_report ( "ARCH00043.P2" ,
                    "Target of a variable assignment may be a " &
                    "selected name prefixed by an indexed name" ,
                    correct) ;
   end process P2 ;
--
   P3 :
   process ( Dummy )
      variable v_st_rec1_vector : st_rec1_vector :=
          c_st_rec1_vector_1 ;
      variable v_st_rec2_vector : st_rec2_vector :=
          c_st_rec2_vector_1 ;
      variable v_st_rec3_vector : st_rec3_vector :=
          c_st_rec3_vector_1 ;
--
      variable correct : boolean := true ;
--
      procedure Proc1 is
      begin
         v_st_rec1_vector(lowb).f2 := c_st_rec1_vector_2(lowb).f2 ;
         v_st_rec2_vector(lowb).f2 := c_st_rec2_vector_2(lowb).f2 ;
         v_st_rec3_vector(lowb).f2 := c_st_rec3_vector_2(lowb).f2 ;
--
      end Proc1 ;
   begin
      Proc1 ;
      correct := correct and
                 v_st_rec1_vector(lowb).f2 = c_st_rec1_vector_2(lowb).f2 ;
      correct := correct and
                 v_st_rec2_vector(lowb).f2 = c_st_rec2_vector_2(lowb).f2 ;
      correct := correct and
                 v_st_rec3_vector(lowb).f2 = c_st_rec3_vector_2(lowb).f2 ;
--
      test_report ( "ARCH00043.P3" ,
                    "Target of a variable assignment may be a " &
                    "selected name prefixed by an indexed name" ,
                    correct) ;
   end process P3 ;
--
   P4 :
   process ( Dummy )
      variable v_st_rec1_vector : st_rec1_vector :=
          c_st_rec1_vector_1 ;
      variable v_st_rec2_vector : st_rec2_vector :=
          c_st_rec2_vector_1 ;
      variable v_st_rec3_vector : st_rec3_vector :=
          c_st_rec3_vector_1 ;
--
      variable correct : boolean := true ;
--
      procedure Proc1 (
           v_st_rec1_vector : inout st_rec1_vector
         ; v_st_rec2_vector : inout st_rec2_vector
         ; v_st_rec3_vector : inout st_rec3_vector
                      )
      is
      begin
         v_st_rec1_vector(lowb).f2 := c_st_rec1_vector_2(lowb).f2 ;
         v_st_rec2_vector(lowb).f2 := c_st_rec2_vector_2(lowb).f2 ;
         v_st_rec3_vector(lowb).f2 := c_st_rec3_vector_2(lowb).f2 ;
--
      end Proc1 ;
   begin
      Proc1 (
           v_st_rec1_vector
         , v_st_rec2_vector
         , v_st_rec3_vector
            ) ;
      correct := correct and
                 v_st_rec1_vector(lowb).f2 = c_st_rec1_vector_2(lowb).f2 ;
      correct := correct and
                 v_st_rec2_vector(lowb).f2 = c_st_rec2_vector_2(lowb).f2 ;
      correct := correct and
                 v_st_rec3_vector(lowb).f2 = c_st_rec3_vector_2(lowb).f2 ;
--
      test_report ( "ARCH00043.P4" ,
                    "Target of a variable assignment may be a " &
                    "selected name prefixed by an indexed name" ,
                    correct) ;
   end process P4 ;
--
end ARCH00043 ;
--
entity ENT00043_Test_Bench is
end ENT00043_Test_Bench ;
--
architecture ARCH00043_Test_Bench of ENT00043_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00043 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00043_Test_Bench ;
