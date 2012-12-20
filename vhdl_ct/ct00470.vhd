-- NEED RESULT: ARCH00470: Generate statements passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00470
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    12.4.2 (1)
--    12.4.2 (2)
--    12.4.2 (3)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00470)
--    ENT00470_Test_Bench(ARCH00470_Test_Bench)
--
-- REVISION HISTORY:
--
--     5-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00470 of E00000 is
   type array_3_13 is array (3 to 13) of natural ;
   signal z : array_3_13 ;
   signal t : natural := 0 ;
begin
   g1:
   for i in 3 to 6 generate
      z(i) <= 2**i ;
   end generate ;
   g2:
   for j in 8 to 12 generate
      g3:
      if j = 9 or j = 11 generate
         z(j) <= 2**j ;
      end generate ;
   end generate ;
   P :
   process ( t )
   begin
      if t = 0 then
	 t <= 1 after 1 ns ;
      else
	 test_report ( "ARCH00470" ,
		       "Generate statements" ,
		       (z(3) =  2**3) and
		       (z(4) =  2**4) and
		       (z(5) =  2**5) and
		       (z(6) =  2**6) and
		       (z(7) =  0) and
		       (z(8) =  0) and
		       (z(9) =  2**9) and
		       (z(10) =  0) and
		       (z(11) =  2**11) and
		       (z(12) =  0) and
		       (z(13) =  0)
                     ) ;
      end if ;
   end process P ;
end ARCH00470 ;

entity ENT00470_Test_Bench is
end ENT00470_Test_Bench ;

architecture ARCH00470_Test_Bench of ENT00470_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00470 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00470_Test_Bench ;

