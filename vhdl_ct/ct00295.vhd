-- NEED RESULT: ARCH00295: Bit short circuiting results passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
-- TEST NAME:
--
--    CT00295
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
--    E00000(ARCH00295)
--    ENT00295_Test_Bench(ARCH00295_Test_Bench)
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
architecture ARCH00295 of E00000 is
begin
   P00295 :
   process
      variable vbit : bit;
      variable bit0 : bit := '0';
      variable bit1 : bit := '1';
      variable bool : boolean := true ;
      function do_not_evaluate return bit is
      begin
	 test_report ( "ARCH00295" ,
		       "Bit short circuiting correct" ,
		       false ) ;
	 return '0' ;
      end do_not_evaluate ;
   begin
      vbit := bit0 and (do_not_evaluate and do_not_evaluate) ;
      bool := bool and vbit = '0' ;

      vbit := (bit0 and do_not_evaluate) and do_not_evaluate ;
      bool := bool and vbit = '0' ;

      vbit := bit1 and (bit0 and do_not_evaluate) ;
      bool := bool and vbit = '0' ;

      vbit := (bit1 and bit0) and do_not_evaluate ;
      bool := bool and vbit = '0' ;

      vbit := bit1 and (bit1 and bit0) ;
      bool := bool and vbit = '0' ;

      vbit := (bit1 and bit1) and bit0 ;
      bool := bool and vbit = '0' ;

      vbit := bit1 and (bit1 and bit1) ;
      bool := bool and vbit = '1' ;

      vbit := (bit1 and bit1) and bit1 ;
      bool := bool and vbit = '1' ;

      vbit := bit0 or (bit0 or bit0) ;
      bool := bool and vbit = '0' ;

      vbit := (bit0 or bit0) or bit0 ;
      bool := bool and vbit = '0' ;

      vbit := bit0 or (bit0 or bit1) ;
      bool := bool and vbit = '1' ;

      vbit := (bit0 or bit0) or bit1 ;
      bool := bool and vbit = '1' ;

      vbit := bit0 or (bit1 or do_not_evaluate) ;
      bool := bool and vbit = '1' ;

      vbit := (bit0 or bit1) or do_not_evaluate ;
      bool := bool and vbit = '1' ;

      vbit := bit1 or (do_not_evaluate or do_not_evaluate) ;
      bool := bool and vbit = '1' ;

      vbit := (bit1 or do_not_evaluate) or do_not_evaluate ;
      bool := bool and vbit = '1' ;

      vbit := bit0 or (bit0 and do_not_evaluate) ;
      bool := bool and vbit = '0' ;

      vbit := (bit0 or bit0) and do_not_evaluate ;
      bool := bool and vbit = '0' ;

      vbit := bit0 or (bit1 and bit0) ;
      bool := bool and vbit = '0' ;

      vbit := (bit0 or bit1) and bit0 ;
      bool := bool and vbit = '0' ;

      vbit := bit0 or (bit1 and bit1) ;
      bool := bool and vbit = '1' ;

      vbit := (bit0 or bit1) and bit1 ;
      bool := bool and vbit = '1' ;

      vbit := bit1 or (do_not_evaluate and do_not_evaluate) ;
      bool := bool and vbit = '1' ;

      vbit := (bit1 or do_not_evaluate) and bit0 ;
      bool := bool and vbit = '0' ;

      vbit := (bit1 or do_not_evaluate) and bit1 ;
      bool := bool and vbit = '1' ;

      vbit := bit0 and (do_not_evaluate or do_not_evaluate) ;
      bool := bool and vbit = '0' ;

      vbit := (bit0 and do_not_evaluate) or bit0 ;
      bool := bool and vbit = '0' ;

      vbit := (bit0 and do_not_evaluate) or bit1 ;
      bool := bool and vbit = '1' ;

      vbit := bit1 and (bit0 or bit0) ;
      bool := bool and vbit = '0' ;

      vbit := (bit1 and bit0) or bit0 ;
      bool := bool and vbit = '0' ;

      vbit := bit1 and (bit0 or bit1) ;
      bool := bool and vbit = '1' ;

      vbit := (bit1 and bit0) or bit1 ;
      bool := bool and vbit = '1' ;

      vbit := bit1 and (bit1 or do_not_evaluate) ;
      bool := bool and vbit = '1' ;

      vbit := (bit1 and bit1) or do_not_evaluate ;
      bool := bool and vbit = '1' ;

      vbit := bit0 nand (do_not_evaluate nand do_not_evaluate) ;
      bool := bool and vbit = '1' ;

      vbit := bit1 nand (bit0 nand do_not_evaluate) ;
      bool := bool and vbit = '0' ;

      vbit := bit1 nand (bit1 nand bit0) ;
      bool := bool and vbit = '0' ;

      vbit := (bit1 nand bit1) nand bit0 ;
      bool := bool and vbit = '1' ;

      vbit := bit1 nand (bit1 nand bit1) ;
      bool := bool and vbit = '1' ;

      vbit := (bit1 nand bit1) nand bit1 ;
      bool := bool and vbit = '1' ;

      vbit := bit0 nor (bit0 nor bit0) ;
      bool := bool and vbit = '0' ;

      vbit := (bit0 nor bit0) nor bit0 ;
      bool := bool and vbit = '0' ;

      vbit := bit0 nor (bit0 nor bit1) ;
      bool := bool and vbit = '1' ;

      vbit := (bit0 nor bit0) nor bit1 ;
      bool := bool and vbit = '0' ;

      vbit := bit0 nor (bit1 nor do_not_evaluate) ;
      bool := bool and vbit = '1' ;

      vbit := bit0 nor (bit0 nand do_not_evaluate) ;
      bool := bool and vbit = '0' ;

      vbit := bit0 nor (bit1 nand bit0) ;
      bool := bool and vbit = '0' ;

      vbit := (bit0 nor bit1) nand bit0 ;
      bool := bool and vbit = '1' ;

      vbit := bit0 nor (bit1 nand bit1) ;
      bool := bool and vbit = '1' ;

      vbit := (bit0 nor bit1) nand bit1 ;
      bool := bool and vbit = '1' ;

      vbit := bit1 nor (do_not_evaluate nand do_not_evaluate) ;
      bool := bool and vbit = '0' ;

      vbit := (bit1 nor do_not_evaluate) nand bit0 ;
      bool := bool and vbit = '1' ;

      vbit := (bit1 nor do_not_evaluate) nand bit1 ;
      bool := bool and vbit = '1' ;

      vbit := bit0 nand (do_not_evaluate nor do_not_evaluate) ;
      bool := bool and vbit = '1' ;

      vbit := (bit0 nand do_not_evaluate) nor bit0 ;
      bool := bool and vbit = '0' ;

      vbit := (bit0 nand do_not_evaluate) nor bit1 ;
      bool := bool and vbit = '0' ;

      vbit := bit1 nand (bit0 nor bit0) ;
      bool := bool and vbit = '0' ;

      vbit := (bit1 nand bit0) nor bit0 ;
      bool := bool and vbit = '0' ;

      vbit := bit1 nand (bit0 nor bit1) ;
      bool := bool and vbit = '1' ;

      vbit := (bit1 nand bit0) nor bit1 ;
      bool := bool and vbit = '0' ;

      vbit := bit1 nand (bit1 nor do_not_evaluate) ;
      bool := bool and vbit = '1' ;

      test_report ( "ARCH00295" ,
		    "Bit short circuiting results" ,
		    bool ) ;
      wait ;
    end process P00295 ;
end ARCH00295 ;

entity ENT00295_Test_Bench is
end ENT00295_Test_Bench ;

architecture ARCH00295_Test_Bench of ENT00295_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00295 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00295_Test_Bench ;

