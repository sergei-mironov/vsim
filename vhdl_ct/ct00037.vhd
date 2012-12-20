-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00037
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
--    E00000(ARCH00037)
--    ENT00037_Test_Bench(ARCH00037_Test_Bench)
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
architecture ARCH00037 of E00000 is
   signal Dummy : Boolean := false ;
--
begin
   P1 :
   process ( Dummy )
      type arr_time is
        array (integer range -1 downto - 3 ) of
          time ;
      type arr_st_rec1 is
        array (integer range -1 downto - 3 ) of
          st_rec1 ;
      type arr_st_rec2 is
        array (integer range -1 downto - 3 ) of
          st_rec2 ;
--
      variable v_st_rec1_1 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2_1 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3_1 : st_rec3 :=
          c_st_rec3_1 ;
--
      variable v_st_rec1_2 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2_2 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3_2 : st_rec3 :=
          c_st_rec3_1 ;
--
      variable v_st_rec1_3 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2_3 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3_3 : st_rec3 :=
          c_st_rec3_1 ;
--
      variable correct : boolean := true ;
   begin
      (
        v_st_rec1_1.f2
      , v_st_rec1_2.f2
      , v_st_rec1_3.f2
      ) :=
           arr_time ' (
           (others => c_st_rec1_2.f2)) ;
--
      (
        v_st_rec2_1.f2
      , v_st_rec2_2.f2
      , v_st_rec2_3.f2
      ) :=
           arr_st_rec1 ' (
           (others => c_st_rec2_2.f2)) ;
--
      (
        v_st_rec3_1.f2
      , v_st_rec3_2.f2
      , v_st_rec3_3.f2
      ) :=
           arr_st_rec2 ' (
           (others => c_st_rec3_2.f2)) ;
--
--
      correct := correct and
                 v_st_rec1_1.f2 =
                 c_st_rec1_2.f2 ;
      correct := correct and
                 v_st_rec2_1.f2 =
                 c_st_rec2_2.f2 ;
      correct := correct and
                 v_st_rec3_1.f2 =
                 c_st_rec3_2.f2 ;
--
      correct := correct and
                 v_st_rec1_2.f2 =
                 c_st_rec1_2.f2 ;
      correct := correct and
                 v_st_rec2_2.f2 =
                 c_st_rec2_2.f2 ;
      correct := correct and
                 v_st_rec3_2.f2 =
                 c_st_rec3_2.f2 ;
--
      correct := correct and
                 v_st_rec1_3.f2 =
                 c_st_rec1_2.f2 ;
      correct := correct and
                 v_st_rec2_3.f2 =
                 c_st_rec2_2.f2 ;
      correct := correct and
                 v_st_rec3_3.f2 =
                 c_st_rec3_2.f2 ;
--
      test_report ( "ARCH00037.P1" ,
                    "Target of a variable assignment may be a " &
                    "aggregate of selected namess" ,
                    correct) ;
   end process P1 ;
--
   P2 :
   process ( Dummy )
      variable correct : boolean := true ;
--
      procedure Proc1 is
      type arr_time is
        array (integer range -1 downto - 3 ) of
          time ;
      type arr_st_rec1 is
        array (integer range -1 downto - 3 ) of
          st_rec1 ;
      type arr_st_rec2 is
        array (integer range -1 downto - 3 ) of
          st_rec2 ;
--
      variable v_st_rec1_1 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2_1 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3_1 : st_rec3 :=
          c_st_rec3_1 ;
--
      variable v_st_rec1_2 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2_2 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3_2 : st_rec3 :=
          c_st_rec3_1 ;
--
      variable v_st_rec1_3 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2_3 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3_3 : st_rec3 :=
          c_st_rec3_1 ;
--
      begin
         (
           v_st_rec1_1.f2
         , v_st_rec1_2.f2
         , v_st_rec1_3.f2
         ) :=
              arr_time ' (
              (others => c_st_rec1_2.f2)) ;
--
         (
           v_st_rec2_1.f2
         , v_st_rec2_2.f2
         , v_st_rec2_3.f2
         ) :=
              arr_st_rec1 ' (
              (others => c_st_rec2_2.f2)) ;
--
         (
           v_st_rec3_1.f2
         , v_st_rec3_2.f2
         , v_st_rec3_3.f2
         ) :=
              arr_st_rec2 ' (
              (others => c_st_rec3_2.f2)) ;
--
--
      correct := correct and
                 v_st_rec1_1.f2 =
                 c_st_rec1_2.f2 ;
      correct := correct and
                 v_st_rec2_1.f2 =
                 c_st_rec2_2.f2 ;
      correct := correct and
                 v_st_rec3_1.f2 =
                 c_st_rec3_2.f2 ;
--
      correct := correct and
                 v_st_rec1_2.f2 =
                 c_st_rec1_2.f2 ;
      correct := correct and
                 v_st_rec2_2.f2 =
                 c_st_rec2_2.f2 ;
      correct := correct and
                 v_st_rec3_2.f2 =
                 c_st_rec3_2.f2 ;
--
      correct := correct and
                 v_st_rec1_3.f2 =
                 c_st_rec1_2.f2 ;
      correct := correct and
                 v_st_rec2_3.f2 =
                 c_st_rec2_2.f2 ;
      correct := correct and
                 v_st_rec3_3.f2 =
                 c_st_rec3_2.f2 ;
--
      end Proc1 ;
   begin
      Proc1 ;
      test_report ( "ARCH00037.P2" ,
                    "Target of a variable assignment may be a " &
                    "aggregate of selected namess" ,
                    correct) ;
   end process P2 ;
--
   P3 :
   process ( Dummy )
      type arr_time is
        array (integer range -1 downto - 3 ) of
          time ;
      type arr_st_rec1 is
        array (integer range -1 downto - 3 ) of
          st_rec1 ;
      type arr_st_rec2 is
        array (integer range -1 downto - 3 ) of
          st_rec2 ;
--
      variable v_st_rec1_1 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2_1 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3_1 : st_rec3 :=
          c_st_rec3_1 ;
--
      variable v_st_rec1_2 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2_2 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3_2 : st_rec3 :=
          c_st_rec3_1 ;
--
      variable v_st_rec1_3 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2_3 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3_3 : st_rec3 :=
          c_st_rec3_1 ;
--
      variable correct : boolean := true ;
--
      procedure Proc1 is
      begin
         (
           v_st_rec1_1.f2
         , v_st_rec1_2.f2
         , v_st_rec1_3.f2
         ) :=
              arr_time ' (
              (others => c_st_rec1_2.f2)) ;
--
         (
           v_st_rec2_1.f2
         , v_st_rec2_2.f2
         , v_st_rec2_3.f2
         ) :=
              arr_st_rec1 ' (
              (others => c_st_rec2_2.f2)) ;
--
         (
           v_st_rec3_1.f2
         , v_st_rec3_2.f2
         , v_st_rec3_3.f2
         ) :=
              arr_st_rec2 ' (
              (others => c_st_rec3_2.f2)) ;
--
--
      end Proc1 ;
   begin
      Proc1 ;
      correct := correct and
                 v_st_rec1_1.f2 =
                 c_st_rec1_2.f2 ;
      correct := correct and
                 v_st_rec2_1.f2 =
                 c_st_rec2_2.f2 ;
      correct := correct and
                 v_st_rec3_1.f2 =
                 c_st_rec3_2.f2 ;
--
      correct := correct and
                 v_st_rec1_2.f2 =
                 c_st_rec1_2.f2 ;
      correct := correct and
                 v_st_rec2_2.f2 =
                 c_st_rec2_2.f2 ;
      correct := correct and
                 v_st_rec3_2.f2 =
                 c_st_rec3_2.f2 ;
--
      correct := correct and
                 v_st_rec1_3.f2 =
                 c_st_rec1_2.f2 ;
      correct := correct and
                 v_st_rec2_3.f2 =
                 c_st_rec2_2.f2 ;
      correct := correct and
                 v_st_rec3_3.f2 =
                 c_st_rec3_2.f2 ;
--
      test_report ( "ARCH00037.P3" ,
                    "Target of a variable assignment may be a " &
                    "aggregate of selected namess" ,
                    correct) ;
   end process P3 ;
--
   P4 :
   process ( Dummy )
      type arr_time is
        array (integer range -1 downto - 3 ) of
          time ;
      type arr_st_rec1 is
        array (integer range -1 downto - 3 ) of
          st_rec1 ;
      type arr_st_rec2 is
        array (integer range -1 downto - 3 ) of
          st_rec2 ;
--
      variable v_st_rec1_1 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2_1 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3_1 : st_rec3 :=
          c_st_rec3_1 ;
--
      variable v_st_rec1_2 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2_2 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3_2 : st_rec3 :=
          c_st_rec3_1 ;
--
      variable v_st_rec1_3 : st_rec1 :=
          c_st_rec1_1 ;
      variable v_st_rec2_3 : st_rec2 :=
          c_st_rec2_1 ;
      variable v_st_rec3_3 : st_rec3 :=
          c_st_rec3_1 ;
--
      variable correct : boolean := true ;
--
      procedure Proc1 (
           v_st_rec1_2 : inout st_rec1
         ; v_st_rec2_2 : inout st_rec2
         ; v_st_rec3_2 : inout st_rec3
                      )
      is
      begin
         (
           v_st_rec1_1.f2
         , v_st_rec1_2.f2
         , v_st_rec1_3.f2
         ) :=
              arr_time ' (
              (others => c_st_rec1_2.f2)) ;
--
         (
           v_st_rec2_1.f2
         , v_st_rec2_2.f2
         , v_st_rec2_3.f2
         ) :=
              arr_st_rec1 ' (
              (others => c_st_rec2_2.f2)) ;
--
         (
           v_st_rec3_1.f2
         , v_st_rec3_2.f2
         , v_st_rec3_3.f2
         ) :=
              arr_st_rec2 ' (
              (others => c_st_rec3_2.f2)) ;
--
--
      end Proc1 ;
   begin
      Proc1 (
           v_st_rec1_2
         , v_st_rec2_2
         , v_st_rec3_2
            ) ;
      correct := correct and
                 v_st_rec1_1.f2 =
                 c_st_rec1_2.f2 ;
      correct := correct and
                 v_st_rec2_1.f2 =
                 c_st_rec2_2.f2 ;
      correct := correct and
                 v_st_rec3_1.f2 =
                 c_st_rec3_2.f2 ;
--
      correct := correct and
                 v_st_rec1_2.f2 =
                 c_st_rec1_2.f2 ;
      correct := correct and
                 v_st_rec2_2.f2 =
                 c_st_rec2_2.f2 ;
      correct := correct and
                 v_st_rec3_2.f2 =
                 c_st_rec3_2.f2 ;
--
      correct := correct and
                 v_st_rec1_3.f2 =
                 c_st_rec1_2.f2 ;
      correct := correct and
                 v_st_rec2_3.f2 =
                 c_st_rec2_2.f2 ;
      correct := correct and
                 v_st_rec3_3.f2 =
                 c_st_rec3_2.f2 ;
--
      test_report ( "ARCH00037.P4" ,
                    "Target of a variable assignment may be a " &
                    "aggregate of selected namess" ,
                    correct) ;
   end process P4 ;
--
end ARCH00037 ;
--
entity ENT00037_Test_Bench is
end ENT00037_Test_Bench ;
--
architecture ARCH00037_Test_Bench of ENT00037_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00037 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00037_Test_Bench ;
