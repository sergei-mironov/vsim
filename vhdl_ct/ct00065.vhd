-- NEED RESULT: ARCH00065.P1_1: Next with a label and no condition only effects labeled loop passed
-- NEED RESULT: ARCH00065.P1_1: Next with a label and no condition only effects labeled loop passed
-- NEED RESULT: ARCH00065.P1_1: Next statement does not effect outer loop passed
-- NEED RESULT: ARCH00065.P1_2: Next with a label and condition only effects labeled loop passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00065
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.9 (2)
--    8.9 (3)
--    8.9 (4)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00065)
--    ENT00065_Test_Bench(ARCH00065_Test_Bench)
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
architecture ARCH00065 of E00000 is
   signal Dummy : Boolean := false ;
begin
   P1_1 :
   process ( Dummy )
      variable correct : boolean ;
      variable counter : integer := 0 ;
   begin
      L1 :
      for i in boolean loop
--
         correct := true ;
         L2 :
         for j in 1 to 3 loop
            next L2 ;
            correct := false ;
         end loop L2 ;
--
         test_report ( "ARCH00065.P1_1" ,
              "Next with a label and no condition only effects " &
              "labeled loop",
              correct ) ;
--
         counter := counter + 1 ;
--
      end loop L1 ;
      correct := counter =
                 (boolean'Pos (boolean'High) -
                  boolean'Pos (boolean'Low) + 1) ;
      test_report ( "ARCH00065.P1_1" ,
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
      variable v_boolean : boolean :=
          c_boolean_1 ;
--
   begin
      L1 :
      while v_boolean /= c_boolean_2 loop
--
         v_boolean := c_boolean_2 ;
         for j in 1 to 3 loop
            next L1 when j = j ;
         end loop ;
--
         counter := counter + 1 ;
--
      end loop L1 ;
--
      correct := counter = 0 ;
      test_report ( "ARCH00065.P1_2" ,
              "Next with a label and condition only effects " &
              "labeled loop",
              correct ) ;
--
   end process P1_2 ;
--
--
end ARCH00065 ;
--
entity ENT00065_Test_Bench is
end ENT00065_Test_Bench ;
--
architecture ARCH00065_Test_Bench of ENT00065_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00065 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00065_Test_Bench ;
