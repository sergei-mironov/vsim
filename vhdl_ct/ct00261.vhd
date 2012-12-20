-- NEED RESULT: ARCH00261_1: Component declaration and configuration spec allowed in architecture statement part passed
-- NEED RESULT: ARCH00261: Subprogram decl and subprogram body and type, subtype constant, signal, initialization spec, alias decl ,attribute decl and attribute spec in architecture statement part passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00261
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.2.1 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00261)
--    ENT00261_1(ARCH00261_1)
--    ENT00261_Test_Bench(ARCH00261_Test_Bench)
--
-- REVISION HISTORY:
--
--    16-JUL-1987   - initial revision
--    16-JUN-1988   - (KLM) changed t1 from range 1 to 5 to range 1 to 11
--                          changed type of parameter p1 from st1 to t1
--                          added wait statements to ends of processes
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00261 of E00000 is
   type t1 is range 1 to 11 ;
   subtype st1 is t1 range 5 downto 1 ;
   constant c1 : st1 := 1 ;
   signal s1 : st1 := 5;
   alias a1 : st1 is s1 ;
   attribute at1 : boolean ;
   attribute at1 of c1 : constant is true ;
   function f1 ( p1 : t1 ) return boolean ;
   function f1 ( p1 : t1 ) return boolean is
   begin
      return p1 = 11 ;
   end f1 ;
begin
   process
   begin
      test_report ( "ARCH00261" ,
		    "Subprogram decl and subprogram body and type, subtype"
                    & " constant, signal, initialization spec, alias decl"
                    & " ,attribute decl and attribute spec in"
                    & " architecture statement part" ,
		    f1(c1 + s1 + a1) and c1'at1) ;
      wait;
   end process ;
end ARCH00261 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00261_1 is
end ENT00261_1 ;

architecture ARCH00261_1 of ENT00261_1 is
   component comp1
   end component ;
   for CIS : comp1 use entity WORK.E00000 ( ARCH00261 ) ;
begin
   CIS : comp1 ;
   process
   begin
      test_report ( "ARCH00261_1" ,
		    "Component declaration and configuration spec allowed in"
                    & " architecture statement part" ,
		    true ) ;
      wait;
   end process ;
end ARCH00261_1 ;

entity ENT00261_Test_Bench is
end ENT00261_Test_Bench ;

architecture ARCH00261_Test_Bench of ENT00261_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00261_1 ( ARCH00261_1 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00261_Test_Bench ;
