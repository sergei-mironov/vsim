-- NEED RESULT: ARCH00289: Logical operators are correctly predefined for boolean array types passed
-- NEED RESULT: ARCH00289: Logical operators are correctly predefined for bit array types passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00289
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.2.1 (2)
--    7.2.1 (9)
--    7.2.1 (10)
--    7.2.1 (11)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00289(ARCH00289)
--    ENT00289_Test_Bench(ARCH00289_Test_Bench)
--
-- REVISION HISTORY:
--
--    21-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
entity ENT00289 is
   generic ( bit1, bit2 : st_bit_vector ;
             bool1, bool2 : boolean ) ;
   port ( locally_static_correct_1, locally_static_correct_2 : out boolean ;
	  dynamic_correct_1, dynamic_correct_2 : out boolean ) ;
end ENT00289 ;

architecture ARCH00289 of ENT00289 is
   signal sbit1, sbit2 : st_bit_vector := B"10100" ;
   signal sboolean1, sboolean2 : st_boolean_vector ;
   constant answer : boolean := true ;
begin
   sbit2 <=  B"01011" ;
   sboolean1 <=  (true, false, true, false, false);
   sboolean2 <=  (false, true, false, true, true);
-- bit vector
   g1: if (((bit1 and bit1) = B"10100") and
       ((bit1 and bit2) = B"00000") and
       ((bit2 and bit1) = B"00000") and
       ((bit2 and bit2) = B"01011") and
       ((bit1 or bit1) = B"10100") and
       ((bit1 or bit2) = B"11111") and
       ((bit2 or bit1) = B"11111") and
       ((bit2 or bit2) = B"01011") and
       ((bit1 nand bit1) = B"01011") and
       ((bit1 nand bit2) = B"11111") and
       ((bit2 nand bit1) = B"11111") and
       ((bit2 nand bit2) = B"10100") and
       ((bit1 nor bit1) = B"01011") and
       ((bit1 nor bit2) = B"00000") and
       ((bit2 nor bit1) = B"00000") and
       ((bit2 nor bit2) = B"10100") and
       ((bit1 xor bit1) = B"00000") and
       ((bit1 xor bit2) = B"11111") and
       ((bit2 xor bit1) = B"11111") and
       ((bit2 xor bit2) = B"00000") and
       ((not bit1) = bit2) and
       ((not bit2) = bit1)  ) generate
      process ( sbit2 )
	 variable bool : boolean ;
      begin
         if sbit2 = B"01011" then
	          locally_static_correct_1 <= true ;
            dynamic_correct_1 <=
	           ((sbit1 and sbit1) = B"10100") and
	           ((sbit1 and sbit2) = B"00000") and
	           ((sbit2 and sbit1) = B"00000") and
	           ((sbit2 and sbit2) = B"01011") and
	           ((sbit1 or sbit1) = B"10100") and
	           ((sbit1 or sbit2) = B"11111") and
	           ((sbit2 or sbit1) = B"11111") and
	           ((sbit2 or sbit2) = B"01011") and
	           ((sbit1 nand sbit1) = B"01011") and
	           ((sbit1 nand sbit2) = B"11111") and
	           ((sbit2 nand sbit1) = B"11111") and
  	           ((sbit2 nand sbit2) = B"10100") and
	           ((sbit1 nor sbit1) = B"01011") and
	           ((sbit1 nor sbit2) = B"00000") and
	           ((sbit2 nor sbit1) = B"00000") and
	           ((sbit2 nor sbit2) = B"10100") and
	           ((sbit1 xor sbit1) = B"00000") and
  	           ((sbit1 xor sbit2) = B"11111") and
	           ((sbit2 xor sbit1) = B"11111") and
	           ((sbit2 xor sbit2) = B"00000") and
	           ((not sbit1) = sbit2) and
	           ((not sbit2) = sbit1) ;
         end if ;
      end process ;
   end generate ;
-- boolean vector
      process ( sboolean2 )
	 variable bool : boolean ;
         variable true_vector, false_vector : st_boolean_vector ;
      begin
         true_vector := (true, true, true, true, true);
         false_vector :=(false, false, false, false, false);
         if sboolean2 = (false, true, false, true, true) then
	    locally_static_correct_2 <= true ;
            bool := (sboolean1 and sboolean1) = sboolean1 and
		    (sboolean1 and sboolean2) = false_vector and
		    (sboolean2 and sboolean1) = false_vector and
		    (sboolean2 and sboolean2) = sboolean2 and
		    (sboolean1 or sboolean1) = sboolean1 and
		    (sboolean1 or sboolean2) = true_vector ;
            bool := bool and
		    (sboolean2 or sboolean1) = true_vector and
		    (sboolean2 or sboolean2) = sboolean2 and
		    (sboolean1 nand sboolean1) = sboolean2 and
		    (sboolean1 nand sboolean2) = true_vector and
		    (sboolean2 nand sboolean1) = true_vector and
		    (sboolean2 nand sboolean2) = sboolean1 ;
            bool := bool and
		    (sboolean1 nor sboolean1) = sboolean2 and
		    (sboolean1 nor sboolean2) = false_vector and
		    (sboolean2 nor sboolean1) = false_vector and
		    (sboolean2 nor sboolean2) = sboolean1 and
		    (sboolean1 xor sboolean1) = false_vector ;
            bool := bool and
		    (sboolean1 xor sboolean2) = true_vector and
		    (sboolean2 xor sboolean1) = true_vector and
		    (sboolean2 xor sboolean2) = false_vector and
		    ((not sboolean1) = sboolean2) and
		    ((not sboolean2) = sboolean1) ;
            dynamic_correct_2 <= bool ;
         end if ;
      end process ;
end ARCH00289 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00289_Test_Bench is
end ENT00289_Test_Bench ;

architecture ARCH00289_Test_Bench of ENT00289_Test_Bench is
begin
   L1:
   block
      signal locally_static_correct_1, dynamic_correct_1 : boolean := false ;
      signal locally_static_correct_2, dynamic_correct_2 : boolean := false ;
      constant local_c_st_bit_vector_1 : st_bit_vector := B"10100";
      constant local_c_st_bit_vector_2 : st_bit_vector := B"01011";

      component UUT
         generic ( bit1, bit2 : st_bit_vector ;
                   bool1, bool2 : boolean ) ;
         port ( locally_static_correct_1, locally_static_correct_2 :
                           out  boolean := false ;
	        dynamic_correct_1, dynamic_correct_2 : out boolean := false ) ;
      end component ;

      for CIS1 : UUT use entity WORK.ENT00289 ( ARCH00289 ) ;
   begin
      CIS1 : UUT
	    generic map ( local_c_st_bit_vector_1, local_c_st_bit_vector_2,
                          c_boolean_1, c_boolean_2 )
	    port map ( locally_static_correct_1,
                          locally_static_correct_2 ,
			  dynamic_correct_1 ,
                          dynamic_correct_2 ) ;
      process ( locally_static_correct_1, locally_static_correct_2,
                dynamic_correct_1, dynamic_correct_2 )
      begin
         if locally_static_correct_1 and dynamic_correct_1 then
	    test_report ( "ARCH00289" ,
		          "Logical operators are correctly predefined"
                          & " for boolean array types" ,
		          true ) ;
	 end if ;
         if locally_static_correct_2 and dynamic_correct_2 then
	    test_report ( "ARCH00289" ,
		          "Logical operators are correctly predefined"
                          & " for bit array types" ,
		          true ) ;
	 end if ;
      end process ;
   end block L1 ;
end ARCH00289_Test_Bench ;
