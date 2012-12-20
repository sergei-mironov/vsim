-- NEED RESULT: ARCH00245: Functions may return any predefined type passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00245
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    2.1 (6)
--    2.1 (13)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00245)
--    ENT00245_Test_Bench(ARCH00245_Test_Bench)
--
-- REVISION HISTORY:
--
--    15-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00245 of E00000 is
   function bit_func ( x : bit) return bit is
   begin
      return x;
   end bit_func ;
   function bit_vector_func ( x : bit_vector) return bit_vector is
   begin
      return x;
   end bit_vector_func ;
   function boolean_func ( x : boolean) return boolean is
   begin
      return x;
   end boolean_func ;
   function character_func ( x : character) return character is
   begin
      return x;
   end character_func ;
   function integer_func ( x : integer) return integer is
   begin
      return x;
   end integer_func ;
   function real_func ( x : real) return real is
   begin
      return x;
   end real_func ;
   function string_func ( x : string) return string is  -- this tests 2.1 (13)
   begin
      return x;
   end string_func ;
   function time_func ( x : time) return time is
   begin
      return x;
   end time_func ;
begin
   P :
   process
      variable v : bit_vector (1 to 3) ;
   begin
      v(1) := '0';
      v(2) := '1';
      v(3) := '0';
      test_report ( "ARCH00245" ,
		    "Functions may return any predefined type" ,
		    (bit_func('1') = '1') and
		    (bit_vector_func(v) = v) and
		    (boolean_func(true) = true) and
		    (character_func('X') = 'X') and
		    (integer_func(6) = 6) and
		    (real_func(3.14159) = 3.14159) and
		    (string_func("qwertyuiop") = "qwertyuiop") and
		    (time_func(2 ns) = 2 ns)
                  ) ;
      wait ;
   end process P ;
end ARCH00245 ;

entity ENT00245_Test_Bench is
end ENT00245_Test_Bench ;

architecture ARCH00245_Test_Bench of ENT00245_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00245 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00245_Test_Bench ;

