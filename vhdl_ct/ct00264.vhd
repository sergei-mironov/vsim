-- NEED RESULT: ARCH00264: Scalar types passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00264
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    3.1 (1)
--    3.1 (2)
--    3.1 (3)
--    3.1 (4)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00264)
--    ENT00264_Test_Bench(ARCH00264_Test_Bench)
--
-- REVISION HISTORY:
--
--    29-JUL-1987   - initial revision
--    14-JUN-1988 - EL - arrays must be initialized to values within the
--                       element subtype
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00264 of E00000 is

   -- these test 3.1 (1)
   function f ( ary : t_arr1 ) return integer is
   begin
      return ary'right ;
   end f ;

   -- these test 3.1 (2) and 3.1 (3)
   type ascending_range is range 0 to 10 ;
   type descending_range is range 10 downto 0 ;

   -- these test 3.1 (4)
   subtype ascending_subrange is descending_range range 2 to 5 ;
   subtype descending_subrange is ascending_range range 5 downto 2 ;

begin
   P :
   process
      variable ascending_array : t_arr1 (5 to 7) := (10,10,10);
      variable descending_array : t_arr1 (20 downto 17) := (10,10,10,10);
   begin
      test_report ( "ARCH00264" ,
		    "Scalar types" ,
                    (ascending_range'left = 0) and
                    (descending_range'left = 10) and
                    (ascending_subrange'right = 5) and
                    (descending_subrange'right = 2) and
		    (f(ascending_array) = 7) and
		    (f(descending_array) = 17)
                  ) ;
      wait ;
   end process P ;
end ARCH00264 ;

entity ENT00264_Test_Bench is
end ENT00264_Test_Bench ;

architecture ARCH00264_Test_Bench of ENT00264_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00264 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00264_Test_Bench ;

