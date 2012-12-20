-- NEED RESULT: ARCH00265: An architecture body need not contain concurrent statements passed
-- 
-- TEST NAME: 
-- 
--    CT00265 
-- 
-- AUTHOR: 
-- 
--    A. Wilmot 
-- 
-- TEST OBJECTIVES: 
-- 
--    1.2.2 (2)
-- 
-- DESIGN UNIT ORDERING: 
--
--    E00000(ARCH00265)
--    ENT00265_Test_Bench(ARCH00265_Test_Bench)
--
-- REVISION HISTORY: 
-- 
--    17-JUL-1987   - initial revision
--    11-DEC-1989   - GDT: added wait stmt to process
-- 
-- NOTES:
-- 
--    self-checking
-- 
use WORK.all ;
use STANDARD_TYPES.all ;
architecture ARCH00265 of E00000 is
begin
end ARCH00265 ;

use WORK.all ;
use STANDARD_TYPES.all ;
entity ENT00265_Test_Bench is
end ENT00265_Test_Bench ;
 
use WORK.all;
architecture ARCH00265_Test_Bench of ENT00265_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
 
      for CIS1 : UUT use entity E00000 ( ARCH00265 ) ;
   begin
      CIS1 : UUT ;
      process
      begin
	 test_report ( "ARCH00265" ,
		       "An architecture body need not contain concurrent"
                       & " statements" ,
		       true ) ;
         wait ;  -- GDT 12-7-89
      end process ;
   end block L1 ;
end ARCH00265_Test_Bench ;
