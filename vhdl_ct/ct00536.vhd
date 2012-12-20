-- NEED RESULT: ARCH00536: Record type visibility test passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00536
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    10.3 (6)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00536
--    PKG00536/BODY
--    E00000(ARCH00536)
--    ENT00536_Test_Bench(ARCH00536_Test_Bench)
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
package PKG00536 is
   type RE1 is record
      A : INTEGER;
      B : BIT;
    end record;

   type RE2 is record
      A : INTEGER;
      B : BIT;
   end record;

   type RE3 is record
      A : RE1;
      B : RE2;
   end record;

   function F ( A : RE1; B : RE2) return RE3 ;
end PKG00536 ;
--
package body PKG00536 is
   function F ( A : RE1; B : RE2) return RE3 is
      variable RETURN_RECORD : RE3;
   begin
      RETURN_RECORD.A.A  := A.A;
      RETURN_RECORD.A.B  := A.B;
      RETURN_RECORD.B.A  := B.A;
      RETURN_RECORD.B.B  := B.B;
      return RETURN_RECORD;
   end F;
end PKG00536 ;
--
use WORK.STANDARD_TYPES.all, WORK.PKG00536.all ;
architecture ARCH00536 of E00000 is
begin
   process
      variable A : RE3;
      variable B : RE1;
      variable C : RE2;
      variable D : INTEGER;
   begin
      A  :=  (A =>  (A => 3, B => '1') ,
              B  =>  (A => 1, B => '0') ) ;
      B  := A.A;
      C  := A.B;
      D  := WORK.PKG00536.F (A => B, B => C) .A.A;

      test_report ( "ARCH00536" ,
		    "Record type visibility test" ,
		    (B.A = 3) and (B.B = '1') and
                    (C.A = 1) and (C.B = '0') and
                    (D = 3) ) ;

      wait ;
   end process;

end ARCH00536 ;
--
entity ENT00536_Test_Bench is
end ENT00536_Test_Bench ;

architecture ARCH00536_Test_Bench of ENT00536_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00536 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00536_Test_Bench ;
--
