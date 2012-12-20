-- NEED RESULT: ARCH00050.P1: If statement with no else or elsif passed
-- NEED RESULT: ARCH00050.P2: If statement with no else passed
-- NEED RESULT: ARCH00050.P3: If statement with else passed
-- NEED RESULT: ARCH00050.P4: If statement with else passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00050
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.6 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00050)
--    ENT00050_Test_Bench(ARCH00050_Test_Bench)
--
-- REVISION HISTORY:
--
--    01-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00050 of E00000 is
   signal Dummy : Boolean := false ;
--
begin
   P1_1 :
   process ( Dummy )
      variable v_integer : integer :=
          c_integer_1 ;
--
      variable correct : boolean := false;
   begin
      if v_integer = c_integer_1 then
         correct := true ;
      end if ;
      test_report ( "ARCH00050.P1",
                    "If statement with no else or elsif",
                     correct) ;
   end process P1_1 ;
--
   P2_1 :
   process ( Dummy )
      variable v_integer : integer :=
          c_integer_1 ;
--
      variable correct : boolean := false;
   begin
      if v_integer = c_integer_1 then
         correct := true ;
      elsif v_integer /= c_integer_1 then
         correct := false ;
      end if ;
      test_report ( "ARCH00050.P2",
                    "If statement with no else",
                     correct) ;
   end process P2_1 ;
--
   P3_1 :
   process ( Dummy )
      variable v_integer : integer :=
          c_integer_1 ;
--
      variable correct : boolean := false;
   begin
      if false then
         correct := false ;
      elsif v_integer /= c_integer_1 then
         correct := false ;
      else
         correct := true ;
      end if ;
      test_report ( "ARCH00050.P3",
                    "If statement with else",
                     correct) ;
   end process P3_1 ;
--
   P4_1 :
   process ( Dummy )
      variable v_integer : integer :=
          c_integer_1 ;
--
      variable correct : boolean := false;
   begin
      if v_integer /= c_integer_1 then
         correct := false ;
      else
         correct := true ;
      end if ;
      test_report ( "ARCH00050.P4",
                    "If statement with else",
                     correct) ;
   end process P4_1 ;
--
--
--
end ARCH00050 ;
--
entity ENT00050_Test_Bench is
end ENT00050_Test_Bench ;
--
architecture ARCH00050_Test_Bench of ENT00050_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00050 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00050_Test_Bench ;
