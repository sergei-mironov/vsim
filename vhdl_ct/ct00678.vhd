-- NEED RESULT: ARCH00678: Subelements of signals are signals passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00678
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.1.2 (3)
--    4.3.1.2 (4)
--    4.3.1.2 (5)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00678
--    PKG00678/BODY
--    E00000(ARCH00678)
--    ENT00678_Test_Bench(ARCH00678_Test_Bench)
--
-- REVISION HISTORY:
--
--     1-SEP-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
package PKG00678 is
   function bf2_arr3 ( to_resolve : arr3_vector ) return st_arr3 ;
   subtype rst2_arr3 is bf2_arr3 st_arr3 ;
end PKG00678 ;

package body PKG00678 is
   function bf2_arr3 ( to_resolve : arr3_vector ) return st_arr3 is
   begin
      return to_resolve(to_resolve'left) ;
   end bf2_arr3 ;
end PKG00678 ;

use WORK.STANDARD_TYPES.all ;
use WORK.PKG00678.all ;
architecture ARCH00678 of E00000 is
   signal s_arr3 : rst2_arr3 ;
   signal toggle : boolean := false ;
begin
   process
      variable v_int : integer  := lowb ;
   begin
      s_arr3 <= c_st_arr3_1 ;
      s_arr3(v_int, false).f1 <= true ;
      s_arr3(v_int, false).f3(lowb, true)(v_int) <= st_int1 (lowb+10) ;
      toggle <= true ;
      wait;
   end process ;
   process
   begin
      s_arr3 <= c_st_arr3_1 ;
      s_arr3(lowb, false).f1 <= true ;
      s_arr3(lowb, false).f3(lowb, true)(lowb) <= st_int1 (lowb + 11) ;
      wait;
   end process ;
   process (toggle)
      variable v_arr3_1, v_arr3_2 : st_arr3 := c_st_arr3_1 ;
   begin
      if toggle then
         v_arr3_1(lowb, false).f1 := true ;
         v_arr3_2(lowb, false).f1 := true ;
         v_arr3_1(lowb, false).f3(lowb, true)(lowb) := st_int1 (lowb + 10) ;
         v_arr3_2(lowb, false).f3(lowb, true)(lowb) := st_int1 (lowb + 11) ;
	 test_report ( "ARCH00678" ,
		       "Subelements of signals are signals" ,
		       v_arr3_1 = s_arr3 or v_arr3_2 = s_arr3 ) ;
      end if ;
   end process ;
end ARCH00678 ;
--
entity ENT00678_Test_Bench is
end ENT00678_Test_Bench ;

architecture ARCH00678_Test_Bench of ENT00678_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00678 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00678_Test_Bench ;
--
