-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00526
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    10.3 (5)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00526_1
--    PKG00526_2
--    PKG00526_2/BODY
--    ENT00526(ARCH00526)
--    ENT00526_Test_Bench(ARCH00526_Test_Bench)
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
package PKG00526_1 is
   type A1 is range 1 to 5;
   type B1 is range 1.0 to 10.0;
   type CC is (C1, C2, C3) ;
end PKG00526_1;

package PKG00526_2 is
   subtype A is CHARACTER range '1' to '5';
   constant C : PKG00526_2.A := '4';
      -- selected name is also directly visible

   function Func return boolean ;
end PKG00526_2;

package body PKG00526_2 is
   constant CC : A := PKG00526_2.C ;
      -- selected name is also directly visible

   function Func return boolean is
      constant CCC : A := PKG00526_2.C ;
   begin
      Lp :
      for i in True to True loop
         return (CC = C) and
                (Func.CCC = C) and
                (Lp.i) ;
      end loop Lp ;
   end Func ;
end PKG00526_2 ;

entity ENT00526 is
end ENT00526 ;

use WORK.STANDARD_TYPES.all, WORK.PKG00526_1, WORK.PKG00526_2;
architecture ARCH00526 of ENT00526 is
   constant ArchCons : boolean := True ;
   use PKG00526_1."=" ;
   use PKG00526_2."=" ;
begin
   B1 :
   block
      constant F : boolean := true ;
   begin
       Pcs :
       process
          variable B : integer := 5;
          variable D : PKG00526_1.B1 := 2.3;
          constant Q : PKG00526_1.CC := PKG00526_1.C2;
       begin
          test_report ( "ARCH00526.B1" ,
			"Selected names whose suffix is a package are allowed" ,
			(Pcs.B = 5) and
                        (Pcs.D = 2.3) and
                        (Pcs.Q = PKG00526_1.C2) and
                        (PKG00526_2.Func) and
                        (ARCH00526.ArchCons) ) ;
          wait ;
       end process;

      B2 :
      block
	 constant F : bit := '1' ;
         constant G : bit := B1.B2.F;
         constant H : PKG00526_2.A := PKG00526_2.C;
         signal S : PKG00526_1.A1 := 3 ;
      begin
	 process
	 begin
	    test_report ( "ARCH00526.B2" ,
			  "Selected names whose suffix is a package are allowed" ,
			  (B2.F = '1') and
                          (B1.B2.G = '1') and
                          (B2.H = '4') and
                          (B1.B2.S = 3) );
	    wait ;
	 end process ;
      end block B2 ;
   end block B1 ;
end ARCH00526 ;

entity ENT00526_Test_Bench is
end ENT00526_Test_Bench ;

architecture ARCH00526_Test_Bench of ENT00526_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00526 ( ARCH00526 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00526_Test_Bench ;
