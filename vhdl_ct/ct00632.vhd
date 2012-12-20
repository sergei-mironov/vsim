-- NEED RESULT: ARCH00632: Index ranges of local generics and ports passed
-- NEED RESULT: ARCH00632: Index ranges of local generics and ports passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00632
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    3.2.1.1 (9)
--    3.2.1.1 (10)
--    3.2.1.1 (11)
--    3.2.1.1 (12)   ??? CONFLICT WITH LRM HERE !!!
--
-- DESIGN UNIT ORDERING:
--
--    ENT00632(ARCH00632)
--    ENT00632_Test_Bench(ARCH00632_Test_Bench)
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
use WORK.STANDARD_TYPES ; use STANDARD_TYPES.all ;
entity ENT00632 is
   generic ( g : STANDARD_TYPES.t_arr1 ) ;
   port ( q : STANDARD_TYPES.t_arr1 ) ;
end ENT00632 ;
--
architecture ARCH00632 of ENT00632 is
begin
   P :
   process
   begin
      test_report ( "ARCH00632" ,
		    "Index ranges of local generics and ports" ,
		    (g'low = st_arr1'low) and
		    (g'high = st_arr1'high) and
		    (g'left = st_arr1'left) and
		    (g'right = st_arr1'right) and
		    (q'low = st_arr1'low) and
		    (q'high = st_arr1'high) and
		    (q'left = st_arr1'left) and
		    (q'right = st_arr1'right)
                  ) ;
      wait ;
   end process P ;
end ARCH00632 ;
--
use WORK.STANDARD_TYPES ; use STANDARD_TYPES.all ;
entity ENT00632_Test_Bench is
end ENT00632_Test_Bench ;

architecture ARCH00632_Test_Bench of ENT00632_Test_Bench is
begin
   L1:
   block
      signal s : STANDARD_TYPES.st_arr1 ;
      component UUT
         generic ( g : STANDARD_TYPES.t_arr1 ) ;
         port ( q : STANDARD_TYPES.t_arr1 ) ;
      end component ;

      for CIS1 : UUT use entity WORK.ENT00632 ( ARCH00632 ) ;

      component UUT2
      end component ;

      -- this will test 3.2.1.1 (9) and 3.2.1.1 (10)
      for CIS2 : UUT2 use entity WORK.ENT00632 ( ARCH00632 )
			     generic map ( c_st_arr1_1 )
			     port map    ( s ) ;
   begin
      -- this will test 3.2.1.1 (11) and 3.2.1.1 (12)
      CIS1 : UUT generic map (g => c_st_arr1_1)
                    port map (q => s) ;

      CIS2 : UUT2 ;
   end block L1 ;
end ARCH00632_Test_Bench ;
--
