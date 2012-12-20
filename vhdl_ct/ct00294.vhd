-- NEED RESULT: ARCH00294: Type of result is type of left operand for logical operators passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00294
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.2.1 (4)
--    7.2.1 (5)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00294)
--    ENT00294_Test_Bench(ARCH00294_Test_Bench)
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
architecture ARCH00294 of E00000 is
   type tbit is array ( integer range <> ) of bit ;
   subtype tbit1 is tbit ( 1 to 4 ) ;
   subtype tbit2 is tbit ( 5 downto 2 ) ;
   type tboolean is array ( integer range <> ) of boolean ;
   subtype tboolean1 is tboolean ( 1 to 4 ) ;
   subtype tboolean2 is tboolean ( 5 downto 2 ) ;
begin
   P00294 :
   process
      variable bit1_1, bit1_2 : tbit1 ;
      variable bit2_1, bit2_2 : tbit2 ;
      variable boolean1_1, boolean1_2 : tboolean1 ;
      variable boolean2_1, boolean2_2 : tboolean2 ;
      variable vbit : boolean ;
      variable vboolean, bool : boolean := True ;
   begin
      bit1_1 := b"0011" ;
      bit2_1 := ('0', '1', '0', '1') ;
--
      bit1_2 := bit1_1 and bit2_1 ;
      bool := bool and bit1_2 = b"0001" ;
      bit1_2 := bit1_1 or bit2_1 ;
      bool := bool and bit1_2 = b"0111" ;
      bit1_2 := bit1_1 nand bit2_1 ;
      bool := bool and bit1_2 = b"1110" ;
      bit1_2 := bit1_1 nor bit2_1 ;
      bool := bool and bit1_2 = b"1000" ;
      bit1_2 := bit1_1 xor bit2_1 ;
      bool := bool and bit1_2 = b"0110" ;

      bit2_2 := bit2_1 and bit1_1 ;
      bool := bool and bit2_2 = b"0001" ;
      bit2_2 := bit2_1 or bit1_1 ;
      bool := bool and bit2_2 = b"0111" ;
      bit2_2 := bit2_1 nand bit1_1 ;
      bool := bool and bit2_2 = b"1110" ;
      bit2_2 := bit2_1 nor bit1_1 ;
      bool := bool and bit2_2 = b"1000" ;
      bit2_2 := bit2_1 xor bit1_1 ;
      bool := bool and bit2_2 = b"0110" ;

      boolean1_1 := (false, false, true, true) ;
      boolean2_1 := (false, true, false, true) ;
--
      boolean1_2 := boolean1_1 and boolean2_1 ;
      bool := bool and boolean1_2 = (false, false, false, true) ;
      boolean1_2 := boolean1_1 or boolean2_1 ;
      bool := bool and boolean1_2 = (false, true, true, true) ;
      boolean1_2 := boolean1_1 nand boolean2_1 ;
      bool := bool and boolean1_2 = (true, true, true, false) ;
      boolean1_2 := boolean1_1 nor boolean2_1 ;
      bool := bool and boolean1_2 = (true, false, false, false) ;
      boolean1_2 := boolean1_1 xor boolean2_1 ;
      bool := bool and boolean1_2 = (false, true, true, false) ;

      boolean2_2 := boolean2_1 and boolean1_1 ;
      bool := bool and boolean2_2 = (false, false, false, true) ;
      boolean2_2 := boolean2_1 or boolean1_1 ;
      bool := bool and boolean2_2 = (false, true, true, true) ;
      boolean2_2 := boolean2_1 nand boolean1_1 ;
      bool := bool and boolean2_2 = (true, true, true, false) ;
      boolean2_2 := boolean2_1 nor boolean1_1 ;
      bool := bool and boolean2_2 = (true, false, false, false) ;
      boolean2_2 := boolean2_1 xor boolean1_1 ;
      bool := bool and boolean2_2 = (false, true, true, false) ;

      test_report ( "ARCH00294" ,
		    "Type of result is type of left operand for"
                    & " logical operators" ,
		    bool ) ;
      wait ;
   end process P00294 ;
end ARCH00294 ;

entity ENT00294_Test_Bench is
end ENT00294_Test_Bench ;

architecture ARCH00294_Test_Bench of ENT00294_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00294 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00294_Test_Bench ;
