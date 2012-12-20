-- NEED RESULT: ARCH00538: Function formal parameter visibility test passed
-- NEED RESULT: ARCH00538: Procedure formal parameter visibility test passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00538
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    10.3 (7)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00538_1
--    PKG00538_1/BODY
--    PKG00538_2
--    PKG00538_2/BODY
--    PKG00538_3
--    PKG00538_3/BODY
--    ENT00538_Test_Bench(ARCH00538_Test_Bench)
--
-- REVISION HISTORY:
--
--    18-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--

package PKG00538_1 is
   procedure P ( A : INTEGER; B : BIT; C : inout INTEGER) ;
end PKG00538_1;

package body PKG00538_1 is
   procedure P ( A : INTEGER; B : BIT; C : inout INTEGER) is
   begin
      if B = '1' then
        -- formal used following parameter declaration

         P ( A => A, B => '0', C => C);
         -- formal used following parameter declaration
         -- formal used in association in call to subprogram

      elsif A > 0 then
         -- formal used following parameter declaration

         P ( A => A - 1, B => '0', C => C);
         -- formal used following parameter declaration
         -- formal used in association in call to subprogram

         C := C + 1;
         -- formal used following parameter declaration

      else
         C := A;
         -- formal used following parameter declaration
      end if;
   end P;
end PKG00538_1;

package PKG00538_2 is
   function F ( R : REAL) return REAL ;
end PKG00538_2;

package body PKG00538_2 is
   function F ( R : REAL) return REAL is
   begin
      if R > 0.0 then
      -- formal used following parameter declaration

         return R * F(R=> R-1.0);
         -- formal used following parameter declaration
         -- formal used in association in call to subprogram

      else
         return 1.0;
      end if;
   end F;
end PKG00538_2;

use WORK.PKG00538_1.all, WORK.PKG00538_2.all, WORK.STANDARD_TYPES.all ;
package PKG00538_3 is
   procedure D ;
end PKG00538_3;

package body PKG00538_3 is
   procedure D is
      variable E : INTEGER := 100 ;
      variable G : REAL;
   begin
      G := F(R => 4.0);
      -- formal used in association in call to subprogram

      test_report ( "ARCH00538" ,
		    "Function formal parameter visibility test" ,
		    (G = 24.0) ) ;

      P ( A => 5, B => '1', C => E);
      -- formal used in association in call to subprogram

      test_report ( "ARCH00538" ,
		    "Procedure formal parameter visibility test" ,
		    (E = 5) ) ;
   end D;
end PKG00538_3;

use WORK.PKG00538_3.all ;
entity ENT00538_Test_Bench is
end ENT00538_Test_Bench ;

architecture ARCH00538_Test_Bench of ENT00538_Test_Bench is
begin
   L1:
   block
   begin
      process
      begin
         WORK.PKG00538_3.D ;
         wait ;
      end process ;
   end block L1 ;
end ARCH00538_Test_Bench ;
--
