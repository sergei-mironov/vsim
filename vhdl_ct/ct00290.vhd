-- NEED RESULT: ARCH00290: Physical types passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00290
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    3.1.3 (1)
--    3.1.3 (2)
--    3.1.3 (3)
--    3.1.3 (4)
--    3.1.3 (5)
--    3.1.3 (6)
--    3.1.3 (7)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00290)
--    ENT00290_Test_Bench(ARCH00290_Test_Bench)
--
-- REVISION HISTORY:
--
--    22-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00290 of E00000 is

   -- this tests 3.1.3 (1), 3.1.3 (4), and 3.1.3 (6)
   type physical_integer is range -2147483647 to +2147483647
			       units
				  physical_one ;
			       end units ;

   -- this tests 3.1.3 (2), 3.1.3 (5), and 3.1.3 (7)
   type backward_integer is range +2147483647 downto -2147483647
			       units
				  one ;
 		                  ten = 10 one ;
                                  another_ten = ten ;
                                  ten_tens = 10 ten ;
                                  hundred = 100 one ;
                                  five_tens = 5 ten ;
                                  fifty = 50 one ;
                                  another_fifty = 5 another_ten ;
			       end units ;

   -- these will test 3.1.3 (5)
   type signed_byte is range -128 to +127 ;
   type signed_nibble is range -8 to +7 ;
   type something is range signed_nibble'left to signed_byte'right
  		        units
		           some_one ;
		           some_ten = 10 some_one ;
		        end units ;
begin
   P :
   process
   begin
      test_report ( "ARCH00290" ,
		    "Physical types" ,
		    (physical_integer'pos(physical_one) = 1) and
		    (physical_integer'val(5) = 5 physical_one) and
                    (fifty + another_fifty = hundred) and
                    (2 five_tens = ten_tens) and
                    (some_ten / 5 = 2 some_one)
                  ) ;
      wait ;
   end process P ;
end ARCH00290 ;

entity ENT00290_Test_Bench is
end ENT00290_Test_Bench ;

architecture ARCH00290_Test_Bench of ENT00290_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00290 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00290_Test_Bench ;

