-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00608
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    11.1 (2)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00608)
--    PKG00608
--    PKG00608/BODY
--    ENT00608_Test_Bench(ARCH00608_Test_Bench)
--    CONF00608
--
-- REVISION HISTORY:
--
--    24-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00608 of E00000 is
begin
   process
   begin
      test_report ( "ARCH00608" ,
		    "A context clause may appear before any design unit in a "&
                    "design file" ,
		    True ) ;
      wait ;
   end process ;
end ARCH00608 ;
--
library WORK ;
package PKG00608 is
   procedure Proc ;
end PKG00608 ;
--
library WORK ;
use WORK.STANDARD_TYPES.all ;
package body PKG00608 is
   procedure Proc is
   begin
      null ;
   end Proc ;
end PKG00608 ;
--
library WORK, STD ;
entity ENT00608_Test_Bench is
end ENT00608_Test_Bench ;

use WORK.PKG00608.all ;
architecture ARCH00608_Test_Bench of ENT00608_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00608_Test_Bench ;
--
library WORK ;
use WORK.ENT00608_Test_bench ;
use WORK.E00000 ;
configuration CONF00608 of ENT00608_Test_Bench is
   for ARCH00608_Test_Bench
      for L1
	 for CIS1 : UUT
	    use entity E00000 ( ARCH00608 );
	 end for ;
      end for ;
   end for ;
end CONF00608 ;
--
