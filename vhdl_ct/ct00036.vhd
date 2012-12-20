-- NEED RESULT: ARCH00036.P1: Target of a variable assignment may be a selected name passed
-- NEED RESULT: ARCH00036.P2: Target of a variable assignment may be a selected name passed
-- NEED RESULT: ARCH00036.P3: Target of a variable assignment may be a selected name passed
-- NEED RESULT: ARCH00036.P4: Target of a variable assignment may be a selected name passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00036
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
--    E00000(ARCH00036)
--    ENT00036_Test_Bench(ARCH00036_Test_Bench)
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
architecture ARCH00036 of E00000 is
   signal Dummy : Boolean := false ;
--
begin
   P1 :
   process ( Dummy )
      variable v_st_rec1 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3 : st_rec3 :=
          c_st_rec3_1 ;
--
      variable correct : boolean := true ;
   begin
      v_st_rec1.f2 := c_st_rec1_2.f2 ;
      v_st_rec2.f2 := c_st_rec2_2.f2 ;
      v_st_rec3.f2 := c_st_rec3_2.f2 ;
--
      correct := correct and
                 v_st_rec1.f2 = c_st_rec1_2.f2 ;
      correct := correct and
                 v_st_rec2.f2 = c_st_rec2_2.f2 ;
      correct := correct and
                 v_st_rec3.f2 = c_st_rec3_2.f2 ;
--
      test_report ( "ARCH00036.P1" ,
                    "Target of a variable assignment may be a " &
                    "selected name" ,
                    correct) ;
   end process P1 ;
--
   P2 :
   process ( Dummy )
      variable correct : boolean := true ;
--
      procedure Proc1 is
         variable v_st_rec1 : st_rec1 :=
             c_st_rec1_1 ;
         variable v_st_rec2 : st_rec2 :=
             c_st_rec2_1 ;
         variable v_st_rec3 : st_rec3 :=
             c_st_rec3_1 ;
--
      begin
         v_st_rec1.f2 := c_st_rec1_2.f2 ;
         v_st_rec2.f2 := c_st_rec2_2.f2 ;
         v_st_rec3.f2 := c_st_rec3_2.f2 ;
--
         correct := correct and
                    v_st_rec1.f2 = c_st_rec1_2.f2 ;
         correct := correct and
                    v_st_rec2.f2 = c_st_rec2_2.f2 ;
         correct := correct and
                    v_st_rec3.f2 = c_st_rec3_2.f2 ;
--
      end Proc1 ;
   begin
      Proc1 ;
      test_report ( "ARCH00036.P2" ,
                    "Target of a variable assignment may be a " &
                    "selected name" ,
                    correct) ;
   end process P2 ;
--
   P3 :
   process ( Dummy )
      variable v_st_rec1 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3 : st_rec3 :=
          c_st_rec3_1 ;
--
      variable correct : boolean := true ;
--
      procedure Proc1 is
      begin
         v_st_rec1.f2 := c_st_rec1_2.f2 ;
         v_st_rec2.f2 := c_st_rec2_2.f2 ;
         v_st_rec3.f2 := c_st_rec3_2.f2 ;
--
      end Proc1 ;
   begin
      Proc1 ;
      correct := correct and
                 v_st_rec1.f2 = c_st_rec1_2.f2 ;
      correct := correct and
                 v_st_rec2.f2 = c_st_rec2_2.f2 ;
      correct := correct and
                 v_st_rec3.f2 = c_st_rec3_2.f2 ;
--
      test_report ( "ARCH00036.P3" ,
                    "Target of a variable assignment may be a " &
                    "selected name" ,
                    correct) ;
   end process P3 ;
--
   P4 :
   process ( Dummy )
      variable v_st_rec1 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3 : st_rec3 :=
          c_st_rec3_1 ;
--
      variable correct : boolean := true ;
--
      procedure Proc1 (
           v_st_rec1 : inout st_rec1
         ; v_st_rec2 : inout st_rec2
         ; v_st_rec3 : inout st_rec3
                      )
      is
      begin
         v_st_rec1.f2 := c_st_rec1_2.f2 ;
         v_st_rec2.f2 := c_st_rec2_2.f2 ;
         v_st_rec3.f2 := c_st_rec3_2.f2 ;
--
      end Proc1 ;
   begin
      Proc1 (
           v_st_rec1
         , v_st_rec2
         , v_st_rec3
            ) ;
      correct := correct and
                 v_st_rec1.f2 = c_st_rec1_2.f2 ;
      correct := correct and
                 v_st_rec2.f2 = c_st_rec2_2.f2 ;
      correct := correct and
                 v_st_rec3.f2 = c_st_rec3_2.f2 ;
--
      test_report ( "ARCH00036.P4" ,
                    "Target of a variable assignment may be a " &
                    "selected name" ,
                    correct) ;
   end process P4 ;
--
end ARCH00036 ;
--
entity ENT00036_Test_Bench is
end ENT00036_Test_Bench ;
--
architecture ARCH00036_Test_Bench of ENT00036_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00036 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00036_Test_Bench ;
