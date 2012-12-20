-- NEED RESULT: ARCH00248: Subprogram declarations and bodies permitted in entityand are visible in architecture passed
-- NEED RESULT: ARCH00248: Types, subtypes, constants, signals,initialization specs permitted in entity and are visible in architecture passed
-- NEED RESULT: ARCH00248: Aliases, attribute decl and spec and use clausesin entity and are visible in architecture passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00248
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.1.2 (1)
--    1.1.2 (3)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00248_1(ARCH00248_1)
--    ENT00248_2(ARCH00248_2)
--    PKG00248
--    ENT00248_3(ARCH00248_3)
--    ENT00248_Test_Bench(ARCH00248_Test_Bench)
--
-- REVISION HISTORY:
--
--    15-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
entity ENT00248_1 is
   procedure p1 ;
   procedure p1 is
   begin
      return ;
   end p1 ;
   function f1 return boolean ;
   function f1 return boolean is
   begin
      return true ;
   end f1 ;
begin
end ENT00248_1 ;

architecture ARCH00248_1 of ENT00248_1 is
begin
   process
   begin
      p1 ;
      test_report ( "ARCH00248" ,
		    "Subprogram declarations and bodies permitted in entity" &
                    "and are visible in architecture",
		    f1 ) ;
      wait ;
   end process ;
end ARCH00248_1 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00248_2 is
   type t1 is (yes, no) ;
   subtype sub1 is t1 range no downto yes ;
   constant c1, c2 : t1 := yes ;
   constant c3, c4 : sub1 := no ;
   signal s1, s2 : t1 := yes ;
   signal s3, s4 : sub1 := no ;
begin
end ENT00248_2 ;

architecture ARCH00248_2 of ENT00248_2 is
begin
   process
      constant c5, c6 : t1 := yes ;
      constant c7, c8 : sub1 := no ;
      variable correct : boolean := true ;
   begin
      correct := correct and c5 = c6 and c7 = c8 and c5 = yes and c7 = no ;
      correct := correct and c1 = c2 and c3 = c4 and c1 = yes and c3 = no ;
      correct := correct and s1 = s2 and s3 = s4 and s1 = yes and s3 = no ;
      test_report ( "ARCH00248" ,
		    "Types, subtypes, constants, signals," &
                      "initialization specs permitted in entity " &
                       "and are visible in architecture",
		    correct ) ;
      wait ;
   end process ;
end ARCH00248_2 ;

package PKG00248 is
   constant c3 : boolean := true ;
end PKG00248 ;

use WORK.STANDARD_TYPES.all ;
use WORK.PKG00248 ;
entity ENT00248_3 is
   constant c1 : boolean := true ;
   alias c2 : boolean is c1 ;
   attribute g : boolean ;
   type t is (t1);
   attribute g of all : type is true ;
   use PKG00248.all ;
begin
end ENT00248_3 ;

architecture ARCH00248_3 of ENT00248_3 is
begin
   process
   begin
      test_report ( "ARCH00248" ,
		    "Aliases, attribute decl and spec and use clauses" &
                     "in entity and are visible in architecture",
		    c1 and c2 and t'g and c3 ) ;
      wait ;
   end process ;
end ARCH00248_3 ;

entity ENT00248_Test_Bench is
end ENT00248_Test_Bench ;

architecture ARCH00248_Test_Bench of ENT00248_Test_Bench is
begin
   L1:
   block
      component UUT1
      end component ;
      component UUT2
      end component ;
      component UUT3
      end component ;

      for CIS1 : UUT1 use entity WORK.ENT00248_1 ( ARCH00248_1 ) ;
      for CIS2 : UUT2 use entity WORK.ENT00248_2 ( ARCH00248_2 ) ;
      for CIS3 : UUT3 use entity WORK.ENT00248_3 ( ARCH00248_3 ) ;
   begin
      CIS1 : UUT1 ;
      CIS2 : UUT2 ;
      CIS3 : UUT3 ;
   end block L1 ;
end ARCH00248_Test_Bench ;
