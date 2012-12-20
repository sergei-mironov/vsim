-- NEED RESULT: ARCH00599: Index constraints passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00599
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    3.2.1.1 (13)
--    3.2.1.1 (14)
--    3.2.1.1 (15)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00599(ARCH00599)
--    ENT00599_Test_Bench(ARCH00599_Test_Bench)
--
-- REVISION HISTORY:
--
--    21-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES ; use STANDARD_TYPES.all ;
entity ENT00599 is
   generic ( g1 : integer := 2;
             g2 : integer := 5) ;
end ENT00599 ;
--
architecture ARCH00599 of ENT00599 is
begin
   P :
   process
      variable a1 : STANDARD_TYPES.t_arr1 (31 downto 0) ;   -- 3.2.1.1 (13)
      variable a2 : STANDARD_TYPES.t_arr1 (g2 downto g1) ;  -- 3.2.1.1 (14)
      function f ( lo, hi : integer ) return integer is
         variable v : STANDARD_TYPES.t_arr1 (lo to hi) ;    -- 3.2.1.1 (15)
      begin
	 return 256*v'high + v'low ;
      end f ;
   begin
      test_report ( "ARCH00599" ,
		    "Index constraints" ,
		    (a1'left = 31) and
		    (a1'right = 0) and
		    (a2'left = 5) and
		    (a2'right = 2) and
		    (f(2,5) = 256*5+2)
                  ) ;
      wait ;
   end process P ;
end ARCH00599 ;
--
entity ENT00599_Test_Bench is
end ENT00599_Test_Bench ;

architecture ARCH00599_Test_Bench of ENT00599_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00599 ( ARCH00599 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00599_Test_Bench ;
--
