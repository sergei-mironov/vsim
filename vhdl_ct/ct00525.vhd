-- NEED RESULT: ARCH00525.B1: Selected names are allowed even if directly visible passed
-- NEED RESULT: ARCH00525.B2: Selected names are allowed even if directly visible passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00525
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    10.3 (4)
--    10.3 (5)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00525_1
--    PKG00525_2
--    PKG00525_2/BODY
--    ENT00525(ARCH00525)
--    ENT00525_Test_Bench(ARCH00525_Test_Bench)
--
-- REVISION HISTORY:
--
--    14-AUG-1987   - initial revision
--    28-NOV-1989   - (ESL) remove test where entity name is used as prefix
--
-- NOTES:
--
--    self-checking
--
--
package PKG00525_1 is
   type A1 is range 1 to 5;
   type B1 is range 1.0 to 10.0;
   type CC is (C1, C2, C3) ;
end PKG00525_1;

package PKG00525_2 is
   subtype A is CHARACTER range '1' to '5';
   constant C : PKG00525_2.A := '4';
      -- selected name is also directly visible

   function Func return boolean ;
end PKG00525_2;

package body PKG00525_2 is
   constant CC : A := PKG00525_2.C ;
      -- selected name is also directly visible

   function Func return boolean is
      constant CCC : A := PKG00525_2.C ;
   begin
      Lp :
      for i in True to True loop
         return (CC = C) and
                (Func.CCC = C) and
                (Lp.i) ;
      end loop Lp ;
   end Func ;
end PKG00525_2 ;

entity ENT00525 is
end ENT00525 ;

use WORK.STANDARD_TYPES.all, WORK.PKG00525_1.all, WORK.PKG00525_2.all;
architecture ARCH00525 of ENT00525 is
   constant ArchCons : boolean := True ;
begin
   B1 :
   block
      constant F : boolean := true ;
   begin
       Pcs :
       process
          variable B : integer := 5;
          variable D : WORK.PKG00525_1.B1 := 2.3;
          -- selected name is also directly visible
          constant Q : WORK.PKG00525_1.CC := C2;
          -- selected name is also directly visible
       begin
          test_report ( "ARCH00525.B1" ,
			"Selected names are allowed even if directly visible" ,
			(Pcs.B = 5) and
                        (Pcs.D = 2.3) and
                        (Pcs.Q = WORK.PKG00525_1.C2) and
                        (WORK.PKG00525_2.Func) and
                        (ARCH00525.ArchCons) ) ;
          wait ;
       end process;

      B2 :
      block
	 constant F : bit := '1' ;
         constant G : bit := B1.B2.F;
            -- selected name is also directly visible
         constant H : WORK.PKG00525_2.A := WORK.PKG00525_2.C;
            -- selected name is also directly visible
         signal S : WORK.PKG00525_1.A1 := 3 ;
            -- selected name is also directly visible
      begin
	 process
	 begin
	    test_report ( "ARCH00525.B2" ,
			  "Selected names are allowed even if directly visible" ,
			  (B2.F = '1') and
                          (B1.B2.G = '1') and
                          (B2.H = '4') and
                          (B1.B2.S = 3) );
	    wait ;
	 end process ;
      end block B2 ;
   end block B1 ;
end ARCH00525 ;

entity ENT00525_Test_Bench is
end ENT00525_Test_Bench ;

architecture ARCH00525_Test_Bench of ENT00525_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00525 ( ARCH00525 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00525_Test_Bench ;
