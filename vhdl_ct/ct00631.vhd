-- NEED RESULT: ARCH00631: Index constraints passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00631
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    3.2.1.1 (4)
--    3.2.1.1 (5)
--    3.2.1.1 (6)
--    3.2.1.1 (7)
--    3.2.1.1 (8)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00631)
--    ENT00631_Test_Bench(ARCH00631_Test_Bench)
--
-- REVISION HISTORY:
--
--    24-AUG-1987   - initial revision
--    18-JAN-1987   - removed refs to predefined attributes on func calls
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES; use STANDARD_TYPES.all ;
architecture ARCH00631 of E00000 is
begin
   P :
   process
      constant c : STANDARD_TYPES.t_arr1 := c_st_arr1_1 ;
      variable v : integer ;
      attribute a : STANDARD_TYPES.t_arr1 ;
      attribute a of v : variable is c_st_arr1_1 ;
      type array_access is access STANDARD_TYPES.t_arr1 ;
      variable ptr : array_access ;
      variable low1, high1, left1, right1,
               low2, high2, left2, right2 : integer := 9999 ;
      variable st : STANDARD_TYPES.st_arr1 := c_st_arr1_1 ;
      subtype t_100 is STANDARD_TYPES.t_arr1
                               (100+st_arr1'left to 100+st_arr1'right) ;
      variable t : t_100 := c_st_arr1_1 ;
      procedure proc_with_unconstrained_array ( a : in STANDARD_TYPES.t_arr1 ;
		                                lo,hi,lft,rght : out integer )
                                           is
      begin
	 lo := a'low ;
         hi := a'high ;
         lft := a'left ;
         rght := a'right ;
      end proc_with_unconstrained_array ;
      procedure proc_with_constrained_array ( a : in STANDARD_TYPES.st_arr1 ;
		                              lo,hi,lft,rght : out integer )
                                           is
      begin
	 lo := a'low ;
         hi := a'high ;
         lft := a'left ;
         rght := a'right ;
      end proc_with_constrained_array ;
   begin
      proc_with_unconstrained_array ( st, low1, high1, left1, right1 ) ;
      proc_with_constrained_array   (  t, low2, high2, left2, right2 ) ;
      ptr := new t_arr1(1 to 10) ;
      test_report ( "ARCH00631" ,
		    "Index constraints" ,
		    (c'low = st_arr1'low) and      -- these test 3.2.1.1 (4)
		    (c'high = st_arr1'high) and
		    (c'left = st_arr1'left) and
		    (c'right = st_arr1'right) and
--		    (v'a'low = st_arr1'low) and    -- these test 3.2.1.1 (5)
--		    (v'a'high = st_arr1'high) and
--		    (v'a'left = st_arr1'left) and
--		    (v'a'right = st_arr1'right) and
		    (ptr.all'low = 1) and          -- these test 3.2.1.1 (6)
		    (ptr.all'high = 10) and
		    (ptr.all'left = 1) and
		    (ptr.all'right = 10) and
		    (low1 = st_arr1'low) and       -- these test 3.2.1.1 (8)
		    (high1 = st_arr1'high) and
		    (left1 = st_arr1'left) and
		    (right1 = st_arr1'right) and
		    (low2 = st_arr1'low) and       -- these test 3.2.1.1 (7)
		    (high2 = st_arr1'high) and
		    (left2 = st_arr1'left) and
		    (right2 = st_arr1'right)
                  ) ;
      wait ;
   end process P ;
end ARCH00631 ;
--
entity ENT00631_Test_Bench is
end ENT00631_Test_Bench ;

architecture ARCH00631_Test_Bench of ENT00631_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00631 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00631_Test_Bench ;
--
