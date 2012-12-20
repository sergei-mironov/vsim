-- NEED RESULT: ARCH00057.P1: Loop statement without an iteration scheme may be left by a next statement passed
-- NEED RESULT: ARCH00057.P2: Loop statement without an iteration scheme may be left by a exit statement passed
-- NEED RESULT: ARCH00057.P3: Loop statement without an iteration scheme may be left by a return statement passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00057
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.8 (2)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00057)
--    ENT00057_Test_Bench(ARCH00057_Test_Bench)
--
-- REVISION HISTORY:
--
--    02-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00057 of E00000 is
   signal Dummy : Boolean := false ;
begin
   P1 :
   process ( Dummy )
      variable correct : boolean := true ;
      procedure Proc ( variable parm : inout boolean ) is
         variable more : boolean := true ;
      begin
         L0 : while more loop
           more := false ;
         L1 :
         loop
            next L0 ;
            parm := false ;
         end loop L1 ;
         end loop L0 ;
      end Proc ;
--
   begin
      Proc (correct) ;
      test_report ( "ARCH00057.P1" ,
              "Loop statement without an iteration scheme " &
              "may be left by a " &
              "next statement",
              correct ) ;
--
   end process P1 ;
--
   P2 :
   process ( Dummy )
      variable correct : boolean := true ;
      procedure Proc ( variable parm : inout boolean ) is
      begin
         L1 :
         loop
            exit ;
            parm := false ;
         end loop L1 ;
      end Proc ;
--
   begin
      Proc (correct) ;
      test_report ( "ARCH00057.P2" ,
              "Loop statement without an iteration scheme " &
              "may be left by a " &
              "exit statement",
              correct ) ;
--
   end process P2 ;
--
   P3 :
   process ( Dummy )
      variable correct : boolean := true ;
      procedure Proc ( variable parm : inout boolean ) is
      begin
         L1 :
         loop
            return ;
            parm := false ;
         end loop L1 ;
      end Proc ;
--
   begin
      Proc (correct) ;
      test_report ( "ARCH00057.P3" ,
              "Loop statement without an iteration scheme " &
              "may be left by a " &
              "return statement",
              correct ) ;
--
   end process P3 ;
--
--
end ARCH00057 ;
--
entity ENT00057_Test_Bench is
end ENT00057_Test_Bench ;
--
architecture ARCH00057_Test_Bench of ENT00057_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00057 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00057_Test_Bench ;
