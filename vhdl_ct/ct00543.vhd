-- NEED RESULT: ARCH00543: Predefined attribute visibility test passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00543
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    10.3 (10)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00543
--    PKG00543/BODY
--    ENT00543_Test_Bench(ARCH00543_Test_Bench)
--
-- REVISION HISTORY:
--
--    19-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
package PKG00543 is -- Note: Names not denoting predefined attributes will
                    --       be in lower case

   type base is (B1, B2, B3, B4, B5, B6) ;
   subtype left is base range B1 to B3;
   subtype right is base range B3 to B5;
   constant high : base := base'BASE'HIGH;
   constant low :  left := left'LEFT;
   constant pos :  INTEGER := base'POS (right'LEFT) ;

   Function pred return BOOLEAN ;
end PKG00543 ;

package body PKG00543 is
   Function pred return BOOLEAN is
   begin
       return ( (low = base'BASE'LOW) and
                (base'PRED (base'BASE'HIGH) = right'RIGHT) and
                (pos = base'POS (left'LEFT) + 2) and
                (right'BASE'POS (high) = 5)
              ) ;
   end pred ;
end PKG00543 ;

use WORK.STANDARD_TYPES.all ;
use WORK.PKG00543.all ;
entity ENT00543_Test_Bench is
end ENT00543_Test_Bench ;

architecture ARCH00543_Test_Bench of ENT00543_Test_Bench is
begin
   process
   begin
      test_report ( "ARCH00543" ,
		    "Predefined attribute visibility test" ,
		    pred ) ;
      wait ;
   end process ;
end ARCH00543_Test_Bench ;
--
