-- NEED RESULT: ARCH00287: 'Abs' does not require parentheses around argument passed
-- NEED RESULT: ARCH00287: 'Not' does not require parentheses around argument passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00287
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.1 (2)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00287)
--    ENT00287_Test_Bench(ARCH00287_Test_Bench)
--
-- REVISION HISTORY:
--
--    22-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00287 of E00000 is
begin
   P00287 :
   process
      variable bool1 : boolean := false ;
      function fbool1 return boolean is
      begin
	 return false ;
      end fbool1 ;
      variable int1 : integer := -4 ;
      function fint1 ( pint : integer ) return integer is
      begin
	 return - pint ;
      end fint1 ;
   begin
      if abs int1 = 4 and
         abs 2 = 2 and
         abs fint1 (-10) = 10 and
         abs integer'(fint1(10)) = 10 and
         abs integer (fint1(3)) = 3 then
	 test_report ( "ARCH00287" ,
		       "'Abs' does not require parentheses around argument" ,
		       true ) ;
      end if ;
      test_report ( "ARCH00287" ,
		    "'Not' does not require parentheses around argument" ,
		    not bool1 and
                    not false and
                    not fbool1 and
                    not boolean'(fbool1) and
                    not boolean' (fbool1) ) ;
      wait ;
   end process P00287 ;
end ARCH00287 ;

entity ENT00287_Test_Bench is
end ENT00287_Test_Bench ;

architecture ARCH00287_Test_Bench of ENT00287_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00287 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00287_Test_Bench ;
