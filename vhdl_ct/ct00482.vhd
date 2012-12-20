-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00482
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    5.1 (7)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00482)
--    ENT00482_Test_Bench(ARCH00482_Test_Bench)
--
-- REVISION HISTORY:
--
--     7-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00482 of E00000 is

   procedure Proc ;

   procedure Proc ( a : Integer ) is
   begin
      null;
   end Proc ;
   procedure Proc ( a : Real ) ;

   function Func return Integer is
   begin
      return 0;
   end Func;

   function Func return Real is
   begin
      return 0.0;
   end Func ;

   procedure Proc is
   begin
      null;
   end Proc ;

   procedure Proc ( a : Real ) is
   begin
      null;
   end Proc;

   attribute Attr : boolean ;
   attribute Attr of Proc : procedure is false ;
   attribute Attr of Func : function is true ;
begin
   process
   begin
      test_report ( "ARCH00482" ,
		    "An attribute associated on an overloaded subprogram" ,
		    (Not Proc'Attr) and Func'Attr ) ;
      wait ;
   end process ;
end ARCH00482 ;

entity ENT00482_Test_Bench is
end ENT00482_Test_Bench ;

architecture ARCH00482_Test_Bench of ENT00482_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00482 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00482_Test_Bench ;
