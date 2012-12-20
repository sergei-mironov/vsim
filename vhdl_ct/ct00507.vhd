-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00507
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    6.3 (1)
--    6.3 (2)
--    6.3 (3)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00507
--    PKG00507/BODY
--    E00000(ARCH00507)
--    ENT00507_Test_Bench(ARCH00507_Test_Bench)
--
-- REVISION HISTORY:
--
--    10-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
package PKG00507 is
   type complex is record
		      re,im : real ;
		   end record ;
   function "+" ( left, right : complex ) return complex ;
end PKG00507 ;

package body PKG00507 is
   function "+"  ( left, right : complex ) return complex is
      variable C : complex ;
   begin
      C.re := left.re + right.re ;    -- these test simple names for 6.3 (1)
      C.im := left.im + right.im ;
      return C ;
   end "+" ;
end PKG00507 ;

use WORK.STANDARD_TYPES.all ;      -- these test "all" for 6.3 (1) and 6.3 (3)
use WORK.PKG00507.all ;
architecture ARCH00507 of E00000 is
   type enum is ( 'a' , 'b', 'c', 'd', 'e' ) ;
begin
   P :
   process
      variable C1 : complex := (2.0, 3.0) ;
      variable C2 : complex := (12.0, 13.0) ;
      constant C3 : complex := (14.0, 16.0) ;
   begin
      test_report ( "ARCH00507" ,
		    "Suffixes of selected names" ,
		    (WORK.PKG00507."+" (C1, C2) = C3) and  -- this tests operator
                                                        -- symbols for 6.3 (1)
		    (C1 + C2 = C3) and
		    (enum'pos(ARCH00507.'c') = 2) -- this tests character
                                             -- literals for 6.3 (1)
                  ) ;
      wait ;
   end process P ;
end ARCH00507 ;

entity ENT00507_Test_Bench is
end ENT00507_Test_Bench ;

architecture ARCH00507_Test_Bench of ENT00507_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00507 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00507_Test_Bench ;

