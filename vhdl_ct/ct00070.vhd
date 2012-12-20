-- NEED RESULT: ARCH00070.P1_1: Procedure need not have a return statement passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00070
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.11 (5)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00070)
--    ENT00070_Test_Bench(ARCH00070_Test_Bench)
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
architecture ARCH00070 of E00000 is
   signal Dummy : Boolean := false ;
begin
   P1_1 :
   process ( Dummy )
      variable correct : boolean ;
      variable v_boolean : boolean :=
          c_boolean_1 ;
--
--
      procedure Proc1 (
         variable p_boolean : inout boolean
                      ) is
      begin
         if p_boolean = c_boolean_1 then
            p_boolean := c_boolean_2 ;
         end if ;
      end Proc1 ;
--
   begin
      Proc1 ( v_boolean ) ;
      correct := v_boolean = c_boolean_2 ;
      test_report ( "ARCH00070.P1_1" ,
              "Procedure need not have a return statement",
              correct ) ;
--
   end process P1_1 ;
--
--
end ARCH00070 ;
--
entity ENT00070_Test_Bench is
end ENT00070_Test_Bench ;
--
architecture ARCH00070_Test_Bench of ENT00070_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00070 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00070_Test_Bench ;
