-- NEED RESULT: ARCH00597: Overloading context test -- rule 3 passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00597
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    10.5 (1)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00597
--    ENT00597_Test_Bench(ARCH00597_Test_Bench)
--
-- REVISION HISTORY:
--
--    21-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
package PKG00597 is
   constant B : boolean := true ;
   constant C : real := 10.0 ;
   signal S : integer ;
end PKG00597 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00597_Test_Bench is
   type T is record
		A : bit ;
		B : Time ;
		C : Integer ;
	     end record ;

   signal PKG00597 : T := ('1',0 ns,1) ;

end ENT00597_Test_Bench ;

use WORK.all ;
use WORK.PKG00597;
architecture ARCH00597_Test_Bench of ENT00597_Test_Bench is
begin
   WORK.PKG00597.S <=   -- signal S in package PKG00597
                 transport 2
                 after PKG00597.B ;  -- field B in signal PKG00597

   PKG00597.A <=   -- field A in signal PKG00597
                 transport '0' ;

   g1:
   if WORK.PKG00597.B   -- constant B in PKG00597
   generate
      process
         variable sum : real := 0.0 ;
         variable first : boolean := true ;
      begin
         if first then
           first := false ;
         else
           for i in PKG00597.C to PKG00597.C loop  -- field C in signal PKG00597
              sum := sum + WORK.PKG00597.C ;  -- Constant C in pkg PKG00597
           end loop ;

           test_report ( "ARCH00597" ,
		       "Overloading context test -- rule 3" ,
		       (sum = 10.0) and
                       (WORK.PKG00597.S = 2) and
                       (PKG00597.A = '0') ) ;
           wait ;
         end if ;
         wait on WORK.PKG00597.S ;
      end process ;
   end generate ;

end ARCH00597_Test_Bench ;
--
