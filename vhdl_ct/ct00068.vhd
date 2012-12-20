-- NEED RESULT: ARCH00068.P1_1: Return statement stops execution of a procedure passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00068
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.11 (1)
--    8.11 (4)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00068)
--    ENT00068_Test_Bench(ARCH00068_Test_Bench)
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
architecture ARCH00068 of E00000 is
   signal Dummy : Boolean := false ;
begin
   P1_1 :
   process ( Dummy )
      variable correct : boolean := true ;
--
      procedure Proc1 (
         constant p_boolean : boolean
                      ) is
      begin
         if p_boolean = p_boolean then
            return ;
         else
            return ;
         end if ;
         correct := false ;
      end Proc1 ;
--
   begin
      Proc1 ( c_boolean_1 ) ;
      test_report ( "ARCH00068.P1_1" ,
              "Return statement stops execution of a " &
              "procedure",
              correct ) ;
--
   end process P1_1 ;
--
--
end ARCH00068 ;
--
entity ENT00068_Test_Bench is
end ENT00068_Test_Bench ;
--
architecture ARCH00068_Test_Bench of ENT00068_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00068 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00068_Test_Bench ;
