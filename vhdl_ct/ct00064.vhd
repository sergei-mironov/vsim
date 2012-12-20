-- NEED RESULT: ARCH00064.P1_1: Next with no label or condition only effects innermost (labeled) loop passed
-- NEED RESULT: ARCH00064.P1_1: Next with no label or condition only effects innermost (unlabeled) loop passed
-- NEED RESULT: ARCH00064.P1_1: Next with no label or condition only effects innermost (labeled) loop passed
-- NEED RESULT: ARCH00064.P1_1: Next with no label or condition only effects innermost (unlabeled) loop passed
-- NEED RESULT: ARCH00064.P1_1: Next statement does not effect outer loop passed
-- NEED RESULT: ARCH00064.P1_2: Next with no label only effects innermost (unlabeled) loop passed
-- NEED RESULT: ARCH00064.P1_2: Next with no label only effects innermost (labeled) loop passed
-- NEED RESULT: ARCH00064.P1_2: Next statement does not effect outer loop passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00064
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.9 (1)
--    8.9 (3)
--    8.9 (4)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00064)
--    ENT00064_Test_Bench(ARCH00064_Test_Bench)
--
-- REVISION HISTORY:
--
--    06-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00064 of E00000 is
   signal Dummy : Boolean := false ;
begin
   P1_1 :
   process ( Dummy )
      variable correct : boolean ;
      variable counter : integer := 0 ;
      variable done : boolean := false ;
   begin
      L1 :
      for i in boolean loop
--
         correct := true ;
         L2 :
         for j in 1 to 3 loop
            next ;
            correct := false ;
         end loop L2 ;
--
         test_report ( "ARCH00064.P1_1" ,
              "Next with no label or condition only effects " &
              "innermost (labeled) loop",
              correct ) ;
--
         correct := true ;
         while not done loop
            done := true ;
            next ;
            correct := false ;
         end loop ;
--
         test_report ( "ARCH00064.P1_1" ,
              "Next with no label or condition only effects " &
              "innermost (unlabeled) loop",
              correct ) ;
--
         counter := counter + 1 ;
--
      end loop L1 ;
      correct := counter =
                 (boolean'Pos (boolean'High) -
                  boolean'Pos (boolean'Low) + 1) ;
      test_report ( "ARCH00064.P1_1" ,
              "Next statement does not effect outer " &
              "loop",
              correct ) ;
--
   end process P1_1 ;
--
   P1_2 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable counter : integer := 0 ;
      variable done : boolean := false ;
      variable v_boolean : boolean :=
          c_boolean_1 ;
--
   begin
      L1 :
      while v_boolean /= boolean'High loop
--
         correct := true ;
         for j in 1 to 3 loop
            next when j = j ;
            correct := false ;
         end loop ;
--
         test_report ( "ARCH00064.P1_2" ,
              "Next with no label only effects " &
              "innermost (unlabeled) loop",
              correct ) ;
--
         correct := true ;
         L2 :
         while not done loop
            done := true ;
            next when done = done ;
            correct := false ;
         end loop L2 ;
--
         test_report ( "ARCH00064.P1_2" ,
              "Next with no label only effects " &
              "innermost (labeled) loop",
              correct ) ;
--
         v_boolean :=
           boolean'Succ (v_boolean) ;
         counter := counter + 1 ;
--
      end loop L1 ;
      correct := counter =
                 (boolean'Pos (boolean'High) -
                  boolean'Pos (c_boolean_1) ) ;
      test_report ( "ARCH00064.P1_2" ,
              "Next statement does not effect outer " &
              "loop",
              correct ) ;
--
   end process P1_2 ;
--
--
end ARCH00064 ;
--
entity ENT00064_Test_Bench is
end ENT00064_Test_Bench ;
--
architecture ARCH00064_Test_Bench of ENT00064_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00064 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00064_Test_Bench ;
