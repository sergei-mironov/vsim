-- NEED RESULT: ARCH00524.B1: Selected name overcomes hiding by homograph passed
-- NEED RESULT: ARCH00524.B2: Selected name overcomes hiding by homograph passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00524
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    10.3 (3)
--    10.3 (5)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00524_1
--    PKG00524_2
--    E00000(ARCH00524)
--    ENT00524_Test_Bench(ARCH00524_Test_Bench)
--
-- REVISION HISTORY:
--
--    14-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
package PKG00524_1 is
   type A is range 1 to 5;
   type B is range 1.0 to 10.0;
   type C is (C1, C2, C3) ;
end PKG00524_1;

package PKG00524_2 is
   subtype A is CHARACTER range '1' to  '5';
   constant C : A := '4';
end PKG00524_2;

use WORK.STANDARD_TYPES.all, WORK.PKG00524_1.all, WORK.PKG00524_2.all;
architecture ARCH00524 of E00000 is
begin
   B1 :
   block
      constant F : boolean := true;
   begin
       process
          variable B : integer := 5;
          variable D : WORK.PKG00524_1.B := 2.3;
             -- selected name overcomes hiding by homograph
          constant Q : WORK.PKG00524_1.C := C2;
       begin
           test_report ( "ARCH00524.B1" ,
			 "Selected name overcomes hiding by homograph" ,
			 (B = 5) and
                         (D = 2.3) and
                         (Q = c2) ) ;
           wait ;
       end process;

       B2 :
       block
          constant F : bit := '1';
          constant G : boolean := B1.F;
             -- selected name overcomes hiding by homograph
          constant H : WORK.PKG00524_2.A := WORK.PKG00524_2.C;
             -- selected name overcomes hiding by homograph
          signal S : WORK.PKG00524_1.A := 3 ;
             -- selected name overcomes hiding by homograph
       begin
          process
          begin
             test_report ( "ARCH00524.B2" ,
			   "Selected name overcomes hiding by homograph" ,
			   (F = '1') and G and
                           (H = '4') and
                           (S = 3) ) ;
             wait ;
          end process;
       end block B2 ;
   end block B1 ;
end ARCH00524 ;

entity ENT00524_Test_Bench is
end ENT00524_Test_Bench ;

architecture ARCH00524_Test_Bench of ENT00524_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00524 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00524_Test_Bench ;
