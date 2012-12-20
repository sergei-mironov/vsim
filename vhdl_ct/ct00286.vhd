-- NEED RESULT: ARCH00286: Integer types and predefined integer types passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00286
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    3.1.2 (1)
--    3.1.2 (2)
--    3.1.2 (3)
--    3.1.2.1 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00286)
--    ENT00286_Test_Bench(ARCH00286_Test_Bench)
--
-- REVISION HISTORY:
--
--    22-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00286 of E00000 is

   -- these will test 3.1.2 (2)
   type negative_integers is range -2147483647 to 0 ;
   type positive_integers is range 0 to +2147483647 ;
   type      all_integers is range -2147483647 to +2147483647 ;

   -- this tests 3.1.2 (3)
   type backward_integers is range +2147483647 downto -2147483647 ;

   -- these will test 3.1.2 (1)
   type signed_byte is range -128 to +127 ;
   type signed_nibble is range -8 to +7 ;
   type signed_something is range signed_nibble'left to signed_byte'right ;
begin
   P :
   process
   begin
      test_report ( "ARCH00286" ,
		    "Integer types and predefined integer types" ,
		    (negative_integers'left  = -2147483647) and
		    (negative_integers'right = 0) and
		    (positive_integers'left  = 0) and
		    (positive_integers'right = +2147483647) and
		    (all_integers'left  = -2147483647) and
		    (all_integers'right = +2147483647) and
		    (backward_integers'left  = +2147483647) and
		    (backward_integers'right = -2147483647) and
		    (signed_byte'left  = -128) and
		    (signed_byte'right = +127) and
		    (signed_nibble'left  = -8) and
		    (signed_nibble'right = +7) and
		    (signed_something'left  = -8) and
		    (signed_something'right = +127) and
		    (integer'left  <= -2147483647) and   -- test 3.1.2.1 (1)
		    (integer'right >= +2147483647)
                  ) ;
      wait ;
   end process P ;
end ARCH00286 ;

entity ENT00286_Test_Bench is
end ENT00286_Test_Bench ;

architecture ARCH00286_Test_Bench of ENT00286_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00286 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00286_Test_Bench ;

