-- NEED RESULT: ARCH00311: Operands of relational operators need not be of the same subtype or have same index ranges passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00311
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.2.2 (4)
--    7.2.2 (8)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00311)
--    ENT00311_Test_Bench(ARCH00311_Test_Bench)
--
-- REVISION HISTORY:
--
--    28-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00311 of E00000 is
begin
   process
      subtype bv_1 is bit_vector ( 1 to 5 ) ;
      subtype bv_2 is bit_vector ( 5 downto 1 ) ;
      type matrix is array ( integer range <> , boolean range <> )
           of severity_level ;
      subtype arr_1 is matrix ( 3 downto 1 , false to true ) ;
      subtype arr_2 is matrix ( 1 to 3 , true downto false ) ;
      variable arr1 : arr_1 ;
      variable arr2 : arr_2 ;
      variable bv1 : bv_1 ;
      variable bv2 : bv_2 ;
      subtype int_1 is integer range 1 to 3 ;
      variable int1 : int_1 ;
      variable int2 : integer ;
      variable bool : boolean ;
   begin
      for i in 1 to 5 loop
	 bv1 ( i ) := bit'val(i mod 2) ;
	 bv2 ( i ) := bit'val((i+1) mod 2) ;
      end loop ;
      for i in 3 downto 1 loop
	 for j in boolean loop
	    arr1( i , j ) := severity_level'val((i + boolean'pos(j)) mod 4) ;
	    arr2( i , j ) := severity_level'val
                             ((4 - i + (boolean'pos(j) + 1) mod 2) mod 4);
	 end loop ;
      end loop ;
      int1 := 2 ;
      int2 := -7 ;
      bool := int1 > int2 and int2 <= int1 and int1 >= int1 and int2 = -7
               and int1 /= int2 ;
      bool := bool and bv1 > bv2 and bv1 = B"10101" and bv2 /= B"01011" and
              not (bv1 <= bv2) and bv2 < bv1 and bv2 >= bv2 ;
      bool := bool  and arr1 = arr2 and not (arr1 /= arr2) ;
      test_report ( "ARCH00311" ,
		    "Operands of relational operators need not be of the"
                    & " same subtype or have same index ranges" ,
		    bool ) ;
      wait ;
   end process ;
end ARCH00311 ;

entity ENT00311_Test_Bench is
end ENT00311_Test_Bench ;

architecture ARCH00311_Test_Bench of ENT00311_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00311 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00311_Test_Bench ;
