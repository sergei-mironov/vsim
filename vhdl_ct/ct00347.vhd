-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00347
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    6.5 (1)
--    6.5 (2)
--    6.5 (4)
--    6.5 (5)
--    6.5 (6)
--    6.5 (7)
--    6.5 (8)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00347(ARCH00347)
--    ENT00347_Test_Bench(ARCH00347_Test_Bench)
--
-- REVISION HISTORY:
--
--    30-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
entity ENT00347 is
   generic ( g : integer := 5 ) ;
begin
end ENT00347 ;

architecture ARCH00347 of ENT00347 is
   signal s : st_integer_vector := c_st_integer_vector_1 ;
begin
   P :
   process ( s )
      variable a : st_integer_vector := c_st_integer_vector_2 ;
      variable b : st_integer_vector := c_st_integer_vector_1 ;
      variable i1,i2,i3,i4,i5,j : integer := 3 ;
      variable n : integer := 0 ;
   begin
      if n = 0 then
         s (2 to 4) <= a (2 to 4) after 1 ns;          -- this tests 6.5 (1)
         n := 1 ;
      else
         b (2 to 4) := a (2 to 4) ;                    -- this tests 6.5 (2)
         i1 := bf_integer( a(4 to 2)) ; -- this tests 6.5 (4)
         i2 := bf_integer( a(1 downto 2)) ; -- this tests 6.5 (5)
         i3 := bf_integer( a(2 to 4)) ; -- this tests 6.5 (6)
         i4 := bf_integer( a(2 to g)) ; -- this tests 6.5 (7)
         i5 := bf_integer( a(2 to j)) ; -- this tests 6.5 (8)
         test_report ( "ARCH00347" ,
   		       "Slice names" ,
		           (i1 = integer'left)
		       and (i2 = integer'left)
		       and (i3 = 3 * c_integer_2)
		       and (i4 = 4 * c_integer_2)
		       and (i5 = 2 * c_integer_2)

		       and (b(1) = c_integer_1)
		       and (b(2) = c_integer_2)
		       and (b(3) = c_integer_2)
	               and (b(4) = c_integer_2)
	               and (b(5) = c_integer_1)

	               and (s(1) = c_integer_1)
	               and (s(2) = c_integer_2)
	               and (s(3) = c_integer_2)
		       and (s(4) = c_integer_2)
		       and (s(5) = c_integer_1)
                     ) ;
      end if ;
   end process P ;
end ARCH00347 ;

entity ENT00347_Test_Bench is
end ENT00347_Test_Bench ;

architecture ARCH00347_Test_Bench of ENT00347_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00347 ( ARCH00347 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00347_Test_Bench ;

