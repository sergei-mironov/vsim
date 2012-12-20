-- NEED RESULT: ARCH00298: Dynamic boolean short circuiting results passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00298
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.2.1 (6)
--    7.2.1 (7)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00298)
--    ENT00298_Test_Bench(ARCH00298_Test_Bench)
--
-- REVISION HISTORY:
--
--    24-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00298 of E00000 is
begin
   P00298 :
   process
      variable vboolean, boolean0, boolean1 : boolean ;
      variable bool : boolean := true ;
      function do_not_evaluate return boolean is
      begin
	 test_report ( "ARCH00298" ,
		       "Dynamic boolean short circuiting correct" ,
		       false ) ;
	 return false ;
      end do_not_evaluate ;
   begin
      boolean0 := false ;
      boolean1 := true ;

      vboolean := boolean0 and (do_not_evaluate and do_not_evaluate) ;
      bool := bool and vboolean = false ;

      vboolean := (boolean0 and do_not_evaluate) and do_not_evaluate ;
      bool := bool and vboolean = false ;

      vboolean := boolean1 and (boolean0 and do_not_evaluate) ;
      bool := bool and vboolean = false ;

      vboolean := (boolean1 and boolean0) and do_not_evaluate ;
      bool := bool and vboolean = false ;

      vboolean := boolean1 and (boolean1 and boolean0) ;
      bool := bool and vboolean = false ;

      vboolean := (boolean1 and boolean1) and boolean0 ;
      bool := bool and vboolean = false ;

      vboolean := boolean1 and (boolean1 and boolean1) ;
      bool := bool and vboolean = true ;

      vboolean := (boolean1 and boolean1) and boolean1 ;
      bool := bool and vboolean = true ;

      vboolean := boolean0 or (boolean0 or boolean0) ;
      bool := bool and vboolean = false ;

      vboolean := (boolean0 or boolean0) or boolean0 ;
      bool := bool and vboolean = false ;

      vboolean := boolean0 or (boolean0 or boolean1) ;
      bool := bool and vboolean = true ;

      vboolean := (boolean0 or boolean0) or boolean1 ;
      bool := bool and vboolean = true ;

      vboolean := boolean0 or (boolean1 or do_not_evaluate) ;
      bool := bool and vboolean = true ;

      vboolean := (boolean0 or boolean1) or do_not_evaluate ;
      bool := bool and vboolean = true ;

      vboolean := boolean1 or (do_not_evaluate or do_not_evaluate) ;
      bool := bool and vboolean = true ;

      vboolean := (boolean1 or do_not_evaluate) or do_not_evaluate ;
      bool := bool and vboolean = true ;

      vboolean := boolean0 or (boolean0 and do_not_evaluate) ;
      bool := bool and vboolean = false ;

      vboolean := (boolean0 or boolean0) and do_not_evaluate ;
      bool := bool and vboolean = false ;

      vboolean := boolean0 or (boolean1 and boolean0) ;
      bool := bool and vboolean = false ;

      vboolean := (boolean0 or boolean1) and boolean0 ;
      bool := bool and vboolean = false ;

      vboolean := boolean0 or (boolean1 and boolean1) ;
      bool := bool and vboolean = true ;

      vboolean := (boolean0 or boolean1) and boolean1 ;
      bool := bool and vboolean = true ;

      vboolean := boolean1 or (do_not_evaluate and do_not_evaluate) ;
      bool := bool and vboolean = true ;

      vboolean := (boolean1 or do_not_evaluate) and boolean0 ;
      bool := bool and vboolean = false ;

      vboolean := (boolean1 or do_not_evaluate) and boolean1 ;
      bool := bool and vboolean = true ;

      vboolean := boolean0 and (do_not_evaluate or do_not_evaluate) ;
      bool := bool and vboolean = false ;

      vboolean := (boolean0 and do_not_evaluate) or boolean0 ;
      bool := bool and vboolean = false ;

      vboolean := (boolean0 and do_not_evaluate) or boolean1 ;
      bool := bool and vboolean = true ;

      vboolean := boolean1 and (boolean0 or boolean0) ;
      bool := bool and vboolean = false ;

      vboolean := (boolean1 and boolean0) or boolean0 ;
      bool := bool and vboolean = false ;

      vboolean := boolean1 and (boolean0 or boolean1) ;
      bool := bool and vboolean = true ;

      vboolean := (boolean1 and boolean0) or boolean1 ;
      bool := bool and vboolean = true ;

      vboolean := boolean1 and (boolean1 or do_not_evaluate) ;
      bool := bool and vboolean = true ;

      vboolean := (boolean1 and boolean1) or do_not_evaluate ;
      bool := bool and vboolean = true ;

      vboolean := boolean0 nand (do_not_evaluate nand do_not_evaluate) ;
      bool := bool and vboolean = true ;

      vboolean := boolean1 nand (boolean0 nand do_not_evaluate) ;
      bool := bool and vboolean = false ;

      vboolean := boolean1 nand (boolean1 nand boolean0) ;
      bool := bool and vboolean = false ;

      vboolean := (boolean1 nand boolean1) nand boolean0 ;
      bool := bool and vboolean = true ;

      vboolean := boolean1 nand (boolean1 nand boolean1) ;
      bool := bool and vboolean = true ;

      vboolean := (boolean1 nand boolean1) nand boolean1 ;
      bool := bool and vboolean = true ;

      vboolean := boolean0 nor (boolean0 nor boolean0) ;
      bool := bool and vboolean = false ;

      vboolean := (boolean0 nor boolean0) nor boolean0 ;
      bool := bool and vboolean = false ;

      vboolean := boolean0 nor (boolean0 nor boolean1) ;
      bool := bool and vboolean = true ;

      vboolean := (boolean0 nor boolean0) nor boolean1 ;
      bool := bool and vboolean = false ;

      vboolean := boolean0 nor (boolean1 nor do_not_evaluate) ;
      bool := bool and vboolean = true ;

      vboolean := boolean0 nor (boolean0 nand do_not_evaluate) ;
      bool := bool and vboolean = false ;

      vboolean := boolean0 nor (boolean1 nand boolean0) ;
      bool := bool and vboolean = false ;

      vboolean := (boolean0 nor boolean1) nand boolean0 ;
      bool := bool and vboolean = true ;

      vboolean := boolean0 nor (boolean1 nand boolean1) ;
      bool := bool and vboolean = true ;

      vboolean := (boolean0 nor boolean1) nand boolean1 ;
      bool := bool and vboolean = true ;

      vboolean := boolean1 nor (do_not_evaluate nand do_not_evaluate) ;
      bool := bool and vboolean = false ;

      vboolean := (boolean1 nor do_not_evaluate) nand boolean0 ;
      bool := bool and vboolean = true ;

      vboolean := (boolean1 nor do_not_evaluate) nand boolean1 ;
      bool := bool and vboolean = true ;

      vboolean := boolean0 nand (do_not_evaluate nor do_not_evaluate) ;
      bool := bool and vboolean = true ;

      vboolean := (boolean0 nand do_not_evaluate) nor boolean0 ;
      bool := bool and vboolean = false ;

      vboolean := (boolean0 nand do_not_evaluate) nor boolean1 ;
      bool := bool and vboolean = false ;

      vboolean := boolean1 nand (boolean0 nor boolean0) ;
      bool := bool and vboolean = false ;

      vboolean := (boolean1 nand boolean0) nor boolean0 ;
      bool := bool and vboolean = false ;

      vboolean := boolean1 nand (boolean0 nor boolean1) ;
      bool := bool and vboolean = true ;

      vboolean := (boolean1 nand boolean0) nor boolean1 ;
      bool := bool and vboolean = false ;

      vboolean := boolean1 nand (boolean1 nor do_not_evaluate) ;
      bool := bool and vboolean = true ;

      test_report ( "ARCH00298" ,
		    "Dynamic boolean short circuiting results" ,
		    bool ) ;
      wait ;
    end process P00298 ;
end ARCH00298 ;

entity ENT00298_Test_Bench is
end ENT00298_Test_Bench ;

architecture ARCH00298_Test_Bench of ENT00298_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00298 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00298_Test_Bench ;
