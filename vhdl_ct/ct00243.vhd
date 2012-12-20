-- NEED RESULT: ARCH00243: Formal parameter list is optional in a subprogram spec passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00243
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    2.1 (1)
--    2.1 (2)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00243)
--    ENT00243_Test_Bench(ARCH00243_Test_Bench)
--
-- REVISION HISTORY:
--
--    14-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00243 of E00000 is

   procedure subprog is
   begin
      null ;
   end subprog ;

   procedure subprog_with_parms (j_in : in integer; j_out : out integer) is
   begin
      j_out := 2*j_in ;
   end subprog_with_parms ;

   function func return integer is
   begin
      return 100 ;
   end func ;

   function func_with_parms (j,k: integer) return integer is
   begin
      return j+k ;
   end func_with_parms ;

begin
   P :
   process
      variable i : integer ;
   begin
      subprog ;
      subprog_with_parms(10, i) ;
      test_report ( "ARCH00243" ,
		    "Formal parameter list is optional in a subprogram spec" ,
		    (i = 2*10) and
                    (func = 100) and
                    (func_with_parms(2,3) = 2+3)
                  ) ;
      wait ;
   end process P ;
end ARCH00243 ;

entity ENT00243_Test_Bench is
end ENT00243_Test_Bench ;

architecture ARCH00243_Test_Bench of ENT00243_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00243 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00243_Test_Bench ;

