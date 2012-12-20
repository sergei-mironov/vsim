-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00288
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.2.1 (1)
--    7.2.1 (9)
--    7.2.1 (10)
--    7.2.1 (11)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00288(ARCH00288)
--    ENT00288_Test_Bench(ARCH00288_Test_Bench)
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
entity ENT00288 is
   generic ( bit1, bit2 : bit ;
             bool1, bool2 : boolean ) ;
   port ( locally_static_correct_1, locally_static_correct_2 :
                    out boolean := false ;
	  dynamic_correct_1, dynamic_correct_2 : out boolean := false ) ;
end ENT00288 ;

architecture ARCH00288 of ENT00288 is
   signal sbit1, sbit2 : bit := '0' ;
   signal sboolean1, sboolean2 : boolean := false ;
   constant answer : boolean := true ;
begin
   sbit2 <=  '1' ;
   sboolean2 <=  true ;
-- bit
   g1: if (((bit1 and bit1) = '0') and
       ((bit1 and bit2) = '0') and
       ((bit2 and bit1) = '0') and
       ((bit2 and bit2) = '1') and
       ((bit1 or bit1) = '0') and
       ((bit1 or bit2) = '1') and
       ((bit2 or bit1) = '1') and
       ((bit2 or bit2) = '1') and
       ((bit1 nand bit1) = '1') and
       ((bit1 nand bit2) = '1') and
       ((bit2 nand bit1) = '1') and
       ((bit2 nand bit2) = '0') and
       ((bit1 nor bit1) = '1') and
       ((bit1 nor bit2) = '0') and
       ((bit2 nor bit1) = '0') and
       ((bit2 nor bit2) = '0') and
       ((bit1 xor bit1) = '0') and
       ((bit1 xor bit2) = '1') and
       ((bit2 xor bit1) = '1') and
       ((bit2 xor bit2) = '0') and
       ((not bit1) = '1') and
       ((not bit2) = '0')  ) generate
      process ( sbit2 )
	 variable bool : boolean ;
      begin
         if sbit2 = '1' then
	    bool := true ;
	    case bool is
	       when ( answer = (
                    ((c_bit_1 and c_bit_1) = '0') and
		    ((c_bit_1 and c_bit_2) = '0') and
		    ((c_bit_2 and c_bit_1) = '0') and
		    ((c_bit_2 and c_bit_2) = '1') and
		    ((c_bit_1 or c_bit_1) = '0') and
		    ((c_bit_1 or c_bit_2) = '1') and
		    ((c_bit_2 or c_bit_1) = '1') and
		    ((c_bit_2 or c_bit_2) = '1') and
		    ((c_bit_1 nand c_bit_1) = '1') and
		    ((c_bit_1 nand c_bit_2) = '1') and
		    ((c_bit_2 nand c_bit_1) = '1') and
		    ((c_bit_2 nand c_bit_2) = '0') and
		    ((c_bit_1 nor c_bit_1) = '1') and
		    ((c_bit_1 nor c_bit_2) = '0') and
		    ((c_bit_2 nor c_bit_1) = '0') and
		    ((c_bit_2 nor c_bit_2) = '0') and
		    ((c_bit_1 xor c_bit_1) = '0') and
		    ((c_bit_1 xor c_bit_2) = '1') and
		    ((c_bit_2 xor c_bit_1) = '1') and
		    ((c_bit_2 xor c_bit_2) = '0') and
		    ((not c_bit_1) = '1') and
		    ((not c_bit_2) = '0') ) ) =>
	          locally_static_correct_1 <= true ;
	       when others =>
	          locally_static_correct_1 <= false ;
	    end case ;
            dynamic_correct_1 <=
                    ((sbit1 and sbit1) = '0') and
		    ((sbit1 and sbit2) = '0') and
		    ((sbit2 and sbit1) = '0') and
		    ((sbit2 and sbit2) = '1') and
		    ((sbit1 or sbit1) = '0') and
		    ((sbit1 or sbit2) = '1') and
		    ((sbit2 or sbit1) = '1') and
		    ((sbit2 or sbit2) = '1') and
		    ((sbit1 nand sbit1) = '1') and
		    ((sbit1 nand sbit2) = '1') and
		    ((sbit2 nand sbit1) = '1') and
		    ((sbit2 nand sbit2) = '0') and
		    ((sbit1 nor sbit1) = '1') and
		    ((sbit1 nor sbit2) = '0') and
		    ((sbit2 nor sbit1) = '0') and
		    ((sbit2 nor sbit2) = '0') and
		    ((sbit1 xor sbit1) = '0') and
		    ((sbit1 xor sbit2) = '1') and
		    ((sbit2 xor sbit1) = '1') and
		    ((sbit2 xor sbit2) = '0') and
		    ((not sbit1) = '1') and
		    ((not sbit2) = '0') ;
         end if ;
      end process ;
   end generate ;
-- boolean
   g2: if (((bool1 and bool1) = false) and
       ((bool1 and bool2) = false) and
       ((bool2 and bool1) = false) and
       ((bool2 and bool2) = true) and
       ((bool1 or bool1) = false) and
       ((bool1 or bool2) = true) and
       ((bool2 or bool1) = true) and
       ((bool2 or bool2) = true) and
       ((bool1 nand bool1) = true) and
       ((bool1 nand bool2) = true) and
       ((bool2 nand bool1) = true) and
       ((bool2 nand bool2) = false) and
       ((bool1 nor bool1) = true) and
       ((bool1 nor bool2) = false) and
       ((bool2 nor bool1) = false) and
       ((bool2 nor bool2) = false) and
       ((bool1 xor bool1) = false) and
       ((bool1 xor bool2) = true) and
       ((bool2 xor bool1) = true) and
       ((bool2 xor bool2) = false) and
       ((not bool1) = true) and
       ((not bool2) = false)  ) generate
      process ( sboolean2 )
	 variable bool : boolean ;
      begin
         if sboolean2 then
	    bool := true ;
	    case bool is
	       when ( answer = (
                    ((c_boolean_1 and c_boolean_1) = false) and
		    ((c_boolean_1 and c_boolean_2) = false) and
		    ((c_boolean_2 and c_boolean_1) = false) and
		    ((c_boolean_2 and c_boolean_2) = true) and
		    ((c_boolean_1 or c_boolean_1) = false) and
		    ((c_boolean_1 or c_boolean_2) = true) and
		    ((c_boolean_2 or c_boolean_1) = true) and
		    ((c_boolean_2 or c_boolean_2) = true) and
		    ((c_boolean_1 nand c_boolean_1) = true) and
		    ((c_boolean_1 nand c_boolean_2) = true) and
		    ((c_boolean_2 nand c_boolean_1) = true) and
		    ((c_boolean_2 nand c_boolean_2) = false) and
		    ((c_boolean_1 nor c_boolean_1) = true) and
		    ((c_boolean_1 nor c_boolean_2) = false) and
		    ((c_boolean_2 nor c_boolean_1) = false) and
		    ((c_boolean_2 nor c_boolean_2) = false) and
		    ((c_boolean_1 xor c_boolean_1) = false) and
		    ((c_boolean_1 xor c_boolean_2) = true) and
		    ((c_boolean_2 xor c_boolean_1) = true) and
		    ((c_boolean_2 xor c_boolean_2) = false) and
		    ((not c_boolean_1) = true) and
		    ((not c_boolean_2) = false) ) ) =>
	          locally_static_correct_2 <= true ;
	       when others =>
	          locally_static_correct_2 <= false ;
	    end case ;
            dynamic_correct_2 <= ((sboolean1 and sboolean1) = false) and
		    ((sboolean1 and sboolean2) = false) and
		    ((sboolean2 and sboolean1) = false) and
		    ((sboolean2 and sboolean2) = true) and
		    ((sboolean1 or sboolean1) = false) and
		    ((sboolean1 or sboolean2) = true) and
		    ((sboolean2 or sboolean1) = true) and
		    ((sboolean2 or sboolean2) = true) and
		    ((sboolean1 nand sboolean1) = true) and
		    ((sboolean1 nand sboolean2) = true) and
		    ((sboolean2 nand sboolean1) = true) and
		    ((sboolean2 nand sboolean2) = false) and
		    ((sboolean1 nor sboolean1) = true) and
		    ((sboolean1 nor sboolean2) = false) and
		    ((sboolean2 nor sboolean1) = false) and
		    ((sboolean2 nor sboolean2) = false) and
		    ((sboolean1 xor sboolean1) = false) and
		    ((sboolean1 xor sboolean2) = true) and
		    ((sboolean2 xor sboolean1) = true) and
		    ((sboolean2 xor sboolean2) = false) and
		    ((not sboolean1) = true) and
		    ((not sboolean2) = false) ;
         end if ;
      end process ;
   end generate ;
end ARCH00288 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00288_Test_Bench is
end ENT00288_Test_Bench ;

architecture ARCH00288_Test_Bench of ENT00288_Test_Bench is
begin
   L1:
   block
      signal locally_static_correct_1, dynamic_correct_1 : boolean := false ;
      signal locally_static_correct_2, dynamic_correct_2 : boolean := false ;

      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00288 ( ARCH00288 )
	    generic map ( c_bit_1, c_bit_2,
                          c_boolean_1, c_boolean_2 )
	    port map ( locally_static_correct_1,
                       locally_static_correct_2 ,
		       dynamic_correct_1 ,
                       dynamic_correct_2 ) ;
   begin
      CIS1 : UUT ;
      process ( locally_static_correct_1, locally_static_correct_2,
                dynamic_correct_1, dynamic_correct_2 )
      begin
         if locally_static_correct_1 and dynamic_correct_1 then
	    test_report ( "ARCH00288" ,
		          "Logical operators are correctly predefined"
                          & " for boolean types" ,
		          true ) ;
	 end if ;
         if locally_static_correct_2 and dynamic_correct_2 then
	    test_report ( "ARCH00288" ,
		          "Logical operators are correctly predefined"
                          & " for bit types" ,
		          true ) ;
	 end if ;
      end process ;
   end block L1 ;
end ARCH00288_Test_Bench ;
