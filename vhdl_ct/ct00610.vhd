-- 
-- TEST NAME: 
-- 
--    CT00610 
-- 
-- AUTHOR: 
-- 
--    G. Tominovich 
-- 
-- TEST OBJECTIVES: 
-- 
--    9.3 (1)
--    9.3 (2)
-- 
-- DESIGN UNIT ORDERING: 
--
--    PKG00610 
--    PKG00610/BODY
--    ENT00610_Test_Bench(ARCH00610_Test_Bench)
--
-- REVISION HISTORY: 
-- 
--    24-AUG-1987   - initial revision
-- 
-- NOTES:
-- 
--    self-Checking
--
-- 
use WORK.all ;
use STANDARD_TYPES.all ;
package PKG00610 is
   signal Check1, Check2 : Integer := 0 ;

   procedure PROC ( signal called : out integer;
                    constant P      : in integer );
end PKG00610 ;
--
use WORK.all;
package body PKG00610 is
   procedure PROC ( signal   called : out integer;
                    constant P      : in integer ) is
   begin
      called <= P + 1 after 0ns ;
   end PROC ;
end PKG00610 ;
--
use WORK.all ;
use WORK.PKG00610.all ;
use WORK.STANDARD_TYPES.all ;
entity ENT00610_Test_Bench is
end ENT00610_Test_Bench ;
 
use WORK.all;
architecture ARCH00610_Test_Bench of ENT00610_Test_Bench is
begin
   L1:
   block
   begin
      ALab: PROC (Check1, Check1) ;
      process ( Check1 )
         variable First_Time : boolean := True ;
      begin
         if First_Time then
            First_Time := false ;
         else
	    test_report ( "ARCH00610" ,
		          "Concurrent procedure call with no in/inout signal "&
                          "parameters has an implicit wait statement with no "&
                          "sens list" ,
		          Check1 = 1 ) ;
         end if ;
      end process ;

      PROC (Check2, Check2) ;
      process ( Check2 )
         variable First_Time : boolean := True ;
      begin
         if First_Time then
            First_Time := false ;
         else
	    test_report ( "ARCH00610" ,
		          "Concurrent procedure call with no label",
		          Check2 = 1 ) ;
         end if ;
      end process ;
   end block L1 ;
end ARCH00610_Test_Bench ;
--
