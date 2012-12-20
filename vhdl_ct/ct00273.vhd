-- NEED RESULT: ARCH00273: Conformance checking passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00273
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    2.7 (1)
--    2.7 (2)
--    2.7 (3)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00273
--    PKG00273/BODY
--    E00000(ARCH00273)
--    ENT00273_Test_Bench(ARCH00273_Test_Bench)
--
-- REVISION HISTORY:
--
--    20-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
package PKG00273 is
   constant k : integer ;
   function func00273 (a : integer ;
   		       b : integer := 123456 ;
                       c : integer := WORK.STANDARD_TYPES.highb) return integer;
end PKG00273 ;

package body PKG00273 is
   constant k : integer -- force a comment here to test objective 2.7 (3)
              := 4 ;
   function func00273  ( a : integer ;
                       -- force a comment here for objective 2.7 (3)
		       b : integer := 123_456 ;  -- insert "_" for objective 2.7 (1)
                       -- omit "STANDARD_TYPES." below for objective 2.7 (2)
                       c : integer := highb) return integer is
   begin
      return a + b + c + k ;
   end func00273  ;
end PKG00273 ;

use WORK.STANDARD_TYPES.test_report;
architecture ARCH00273 of E00000 is
   use WORK.PKG00273.all ;
begin
   P :
   process
   begin
      test_report ( "ARCH00273" ,
		    "Conformance checking" ,
		   func00273 (2) = 2 + 123456 + 4 + WORK.STANDARD_TYPES.highb) ;
      wait ;
   end process P ;
end ARCH00273 ;

entity ENT00273_Test_Bench is
end ENT00273_Test_Bench ;

architecture ARCH00273_Test_Bench of ENT00273_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00273 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00273_Test_Bench ;

