-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00682
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.3.5 (2)
--    7.3.5 (4)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00682)
--    ENT00682_Test_Bench(ARCH00682_Test_Bench)
--
-- REVISION HISTORY:
--
--     7-SEP-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00682 of E00000 is
   type int1 is range -10 to 10 ;
   type arr1 is array ( int1 range <> ) of bit_vector ( 0 to 3 ) ;
   type arr2 is array ( integer range <> ) of bit_vector ( 0 to 3 ) ;
begin
   process
      subtype st_arr1 is arr1 ( -5 to 5 ) ;
      subtype st_arr2 is arr2 ( -5 to 5 ) ;
      variable v_arr1_1, v_arr1_2, v_arr1_3 : st_arr1 ;
      variable v_arr2_1, v_arr2_2, v_arr2_3 : st_arr2 ;
      variable correct : boolean := True ;
      procedure p1 ( p_arr1 : arr1 ;
		     p_arr2 : arr2 ) is
      begin
         correct := correct and p_arr1 = v_arr1_2 and
                  p_arr2 = v_arr2_2 ;
         test_report ( "ARCH00682" ,
  		       "Conversion to unconstrained array converts"
                       & " takes constraint from converted bounds" ,
		       correct ) ;
      end p1 ;
   begin
      v_arr1_1 := (others => B"0101") ;
      v_arr2_1 := (others => B"1010") ;
      v_arr1_2 := (others => B"1010") ;
      v_arr2_2 := (others => B"0101") ;

      v_arr1_3 := st_arr1 ( v_arr2_1 ) ;
      v_arr2_3 := st_arr2 ( v_arr1_1 ) ;
      correct := correct and v_arr1_3 = v_arr1_2 and
                  v_arr2_3 = v_arr2_2 ;
      test_report ( "ARCH00682" ,
		    "Conversion between array types with different index"
                    & " types" ,
		    correct ) ;

      p1 ( arr1 ( v_arr2_1 ) , arr2 ( v_arr1_1 )) ;
      wait ;
   end process ;
end ARCH00682 ;
--
entity ENT00682_Test_Bench is
end ENT00682_Test_Bench ;

architecture ARCH00682_Test_Bench of ENT00682_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00682 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00682_Test_Bench ;
--
