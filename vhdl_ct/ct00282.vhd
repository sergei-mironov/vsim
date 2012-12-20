-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00282
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.1 (1)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00282(ARCH00282)
--    ENT00282_Test_Bench(ARCH00282_Test_Bench)
--
-- REVISION HISTORY:
--
--    21-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
entity ENT00282 is
   generic ( g1 : boolean ) ;
   port ( locally_static_correct : out boolean := true ;
	  dynamic_correct : out boolean := true ) ;
end ENT00282 ;

architecture ARCH00282 of ENT00282 is
   constant answer : boolean := true ;
   constant c1 : boolean := true ;
   constant c2 : boolean := false ;
   signal s1, s2 : boolean := true ;
begin
   s2 <= false ;
   gen1: if answer = ( c1 and (not c2) and g1 and
                (c2 or (not g1) or c1) and
                (c1 xor c2 xor g1 xor c1 ) ) generate
      process ( s2 )
	 variable bool : boolean ;
      begin
         if not s2 then
	    bool := true ;
            dynamic_correct <= s1 and (not s2) and g1 and
                              (s2 or (not g1) or s1) and
                              (s1 xor s2 xor g1 xor s1 ) ;
	    case bool is
	       when ( answer = ( c1 and (not c2) and true and
                   (c2 or (not true) or c1) and
                   (c1 xor c2 xor true xor c1 ) ) ) =>
	          locally_static_correct <= true ;
	       when others =>
	          locally_static_correct <= false ;
	    end case ;
         end if ;
     end process ;
   end generate ;
end ARCH00282 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00282_Test_Bench is
end ENT00282_Test_Bench ;

architecture ARCH00282_Test_Bench of ENT00282_Test_Bench is
begin
   L1:
   block
      signal locally_static_correct, dynamic_correct : boolean := false ;

      constant c1 : boolean := true ;
      component UUT
         generic ( g1 : boolean ) ;
         port ( locally_static_correct : out boolean := false ;
	        dynamic_correct : out boolean := false ) ;
      end component ;

      for CIS1 : UUT use entity WORK.ENT00282 ( ARCH00282 ) ;
   begin
      CIS1 : UUT
	    generic map ( c1 )
	    port map ( locally_static_correct ,
		       dynamic_correct ) ;
      process ( locally_static_correct, dynamic_correct )
      begin
         if locally_static_correct and dynamic_correct then
	    test_report ( "ARCH00282" ,
		          "And's, or's, xor's in succession" ,
		          true ) ;
	 end if ;
      end process ;
   end block L1 ;
end ARCH00282_Test_Bench ;
