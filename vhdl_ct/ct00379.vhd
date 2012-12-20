-- NEED RESULT: ARCH00379: Elaboration of a block header failed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00379
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    12.2 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00379)
--    ENT00379_Test_Bench(ARCH00379_Test_Bench)
--
-- REVISION HISTORY:
--
--    31-JUL-1987   - initial revision
--     6-APR-1988   - JW: Initial value on block port was not static
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00379 of E00000 is
begin
  B1 :
  block
      generic ( g1 : integer ;
		g2 : integer := 27 ) ;
      generic map ( g1 => 11 ) ;
      signal s : bit_vector (1 to 32) ;
      constant c : bit_vector (g1 to g2) := B"10101010101010101";  -- JW
  begin
     B :
     block
-- JW:  port ( vec : in bit_vector := s ( g1 to g2 ) ) ;
        port ( vec : in bit_vector := c );                         -- JW
        constant vec_left  : integer := vec'left  ;
        constant vec_right : integer := vec'right ;
     begin
        process
        begin
  	 test_report ( "ARCH00379" ,
  		       "Elaboration of a block header" ,
  		       (vec_left  = 11) and
                         (vec_right = 27)
                       ) ;
           wait ;
        end process ;
     end block B ;
   end block B1 ;
end ARCH00379 ;

entity ENT00379_Test_Bench is
end ENT00379_Test_Bench ;

architecture ARCH00379_Test_Bench of ENT00379_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00379 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00379_Test_Bench ;

