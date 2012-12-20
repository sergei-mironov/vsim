-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00312
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.2.2 (5)
--    7.2.2 (7)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00312)
--    ENT00312_Test_Bench(ARCH00312_Test_Bench)
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
architecture ARCH00312 of E00000 is
begin
   process
      subtype str_1 is string ( 1 downto 3 ) ;
      subtype str_2 is string ( 10 downto 3 ) ;
      subtype str_3 is string ( 5 to 10 ) ;
      type int_arr is array ( integer range <> ) of integer ;
      subtype int_arr_1 is int_arr (1 to 4) ;
      subtype int_arr_2 is int_arr (-3 to 4) ;
      type matrix is array ( integer range <> , bit range <>) of integer ;
      subtype arr_1 is matrix ( 1 to 2 , '0' downto '0' ) ; -- do not match
                                                            -- in successive
							    -- indices
      subtype arr_2 is matrix ( 1 to 1 , '1' downto '0' ) ;
      subtype arr_3 is matrix ( 0 to 1 , '1' downto '1' ) ;
      variable str1 : str_1 ;
      variable str2 : str_2 ;
      variable str3 : str_3 ;
      variable int_arr1 : int_arr_1 ;
      variable int_arr2 : int_arr_2 ;
      variable arr1 : arr_1 ;
      variable arr2 : arr_2 ;
      variable arr3 : arr_3 ;
      variable bool : boolean ;
   begin
      str2 := "abcdefgh" ;
      str3 := "abcdef" ;
      int_arr1 := (1, 2, 3, 4) ;
      int_arr2 := (-3, -2, -1, 0, 1, 2, 3, 4) ;
      arr1(1, '0') := 0 ;
      arr1(2, '0') := 0 ;
      arr2(1, '1') := 0 ;
      arr2(1, '0') := 0 ;
      arr3(0, '1') := 0 ;
      arr3(1, '1') := 0 ;
      bool := str1 < str2
          and str3 < str2
          and str3 /= str2
          and str2(3 to 5) < str3  -- MG SLICE BUG; FAILED STILL, JTH 5/19/88;
          and str2(10 downto 5) = str3
          and str1 = str1
          and str2 > str1
          and str2 >= str3
          ;
      bool := bool
          and not (int_arr1 = int_arr2)
          and int_arr1 > int_arr2
          and int_arr2 <= int_arr1
          and int_arr2 = (-3, -2, -1, 0, 1, 2, 3, 4)
          and not ( int_arr1 <= int_arr2)
          and int_arr1 >= int_arr2
          and int_arr2 < int_arr1
          ;
      bool := bool
          and arr1  = arr2
          and arr1  = arr3
          ;
      arr3(1, '1') := 1 ;
      bool := bool and arr1 /= arr3 ;
      test_report ( "ARCH00312" ,
		    "Array operands need not have same length for relational"
                    & " operators" ,
		    bool ) ;
      wait ;
   end process ;
end ARCH00312 ;

entity ENT00312_Test_Bench is
end ENT00312_Test_Bench ;

architecture ARCH00312_Test_Bench of ENT00312_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00312 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00312_Test_Bench ;
