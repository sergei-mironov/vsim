-- NEED RESULT: ARCH00542: Ranges of various signal attributes passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00542
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    14.1 (16)   (MOSTLY TBD)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00542)
--    ENT00542_Test_Bench(ARCH00542_Test_Bench)
--
-- REVISION HISTORY:
--
--    18-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--    THIS IS A STATIC TEST ONLY
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00542 of E00000 is
   signal sig_string : st_string ;
   signal sig_bit_vector : st_bit_vector ;
   signal sig_boolean_vector : st_boolean_vector ;
   signal sig_severity_level_vector : st_severity_level_vector ;
   signal sig_integer_vector : st_integer_vector ;
   signal sig_arr3_vector : st_arr3_vector ;
   signal sig_enum1 : st_enum1 ;
   signal sig_int1 : st_int1 ;
   signal sig_phys1 : st_phys1 ;
   signal sig_real1 : st_real1 ;
   signal sig_rec1 : st_rec1 ;
   signal sig_rec2 : st_rec2 ;
   signal sig_rec3 : st_rec3 ;
   signal sig_arr1 : st_arr1 ;
   signal sig_arr2 : st_arr2 ;
   signal sig_arr3 : st_arr3 ;
   signal sig_bit : bit ;
   signal sig_boolean : boolean ;
   signal sig_character : character ;
   signal sig_integer : integer ;
   signal sig_real : real ;
   signal sig_time : time ;
------   [block_declarative_item]...
begin
   P :
   process
      variable t,u : time ;
      variable a,b,c,d : boolean;
------      [process_declarative_item]...
   begin
      a := sig_string'stable and
           sig_bit_vector'stable and
           sig_boolean_vector'stable and
           sig_severity_level_vector'stable and
           sig_integer_vector'stable and
           sig_arr3_vector'stable and
           sig_enum1'stable and
           sig_int1'stable and
           sig_phys1'stable and
           sig_real1'stable and
           sig_rec1'stable and
           sig_rec2'stable and
           sig_rec3'stable and
           sig_arr1'stable and
           sig_arr2'stable and
           sig_arr3'stable and
           sig_bit'stable and
           sig_boolean'stable and
           sig_character'stable and
           sig_integer'stable and
           sig_real'stable and
           sig_time'stable ;
      b := sig_string'quiet and
           sig_bit_vector'quiet and
           sig_boolean_vector'quiet and
           sig_severity_level_vector'quiet and
           sig_integer_vector'quiet and
           sig_arr3_vector'quiet and
           sig_enum1'quiet and
           sig_int1'quiet and
           sig_phys1'quiet and
           sig_real1'quiet and
           sig_rec1'quiet and
           sig_rec2'quiet and
           sig_rec3'quiet and
           sig_arr1'quiet and
           sig_arr2'quiet and
           sig_arr3'quiet and
           sig_bit'quiet and
           sig_boolean'quiet and
           sig_character'quiet and
           sig_integer'quiet and
           sig_real'quiet and
           sig_time'quiet ;
      c := sig_string'event and
           sig_bit_vector'event and
           sig_boolean_vector'event and
           sig_severity_level_vector'event and
           sig_integer_vector'event and
           sig_arr3_vector'event and
           sig_enum1'event and
           sig_int1'event and
           sig_phys1'event and
           sig_real1'event and
           sig_rec1'event and
           sig_rec2'event and
           sig_rec3'event and
           sig_arr1'event and
           sig_arr2'event and
           sig_arr3'event and
           sig_bit'event and
           sig_boolean'event and
           sig_character'event and
           sig_integer'event and
           sig_real'event and
           sig_time'event ;
      d := sig_string'active and
           sig_bit_vector'active and
           sig_boolean_vector'active and
           sig_severity_level_vector'active and
           sig_integer_vector'active and
           sig_arr3_vector'active and
           sig_enum1'active and
           sig_int1'active and
           sig_phys1'active and
           sig_real1'active and
           sig_rec1'active and
           sig_rec2'active and
           sig_rec3'active and
           sig_arr1'active and
           sig_arr2'active and
           sig_arr3'active and
           sig_bit'active and
           sig_boolean'active and
           sig_character'active and
           sig_integer'active and
           sig_real'active and
           sig_time'active ;
      t := sig_string'last_event +
           sig_bit_vector'last_event +
           sig_boolean_vector'last_event +
           sig_severity_level_vector'last_event +
           sig_integer_vector'last_event +
           sig_arr3_vector'last_event +
           sig_enum1'last_event +
           sig_int1'last_event +
           sig_phys1'last_event +
           sig_real1'last_event +
           sig_rec1'last_event +
           sig_rec2'last_event +
           sig_rec3'last_event +
           sig_arr1'last_event +
           sig_arr2'last_event +
           sig_arr3'last_event +
           sig_bit'last_event +
           sig_boolean'last_event +
           sig_character'last_event +
           sig_integer'last_event +
           sig_real'last_event +
           sig_time'last_event ;
      u := sig_string'last_active +
           sig_bit_vector'last_active +
           sig_boolean_vector'last_active +
           sig_severity_level_vector'last_active +
           sig_integer_vector'last_active +
           sig_arr3_vector'last_active +
           sig_enum1'last_active +
           sig_int1'last_active +
           sig_phys1'last_active +
           sig_real1'last_active +
           sig_rec1'last_active +
           sig_rec2'last_active +
           sig_rec3'last_active +
           sig_arr1'last_active +
           sig_arr2'last_active +
           sig_arr3'last_active +
           sig_bit'last_active +
           sig_boolean'last_active +
           sig_character'last_active +
           sig_integer'last_active +
           sig_real'last_active +
           sig_time'last_active ;
--      sig_string'delayed(1 ns) <= sig_string'last_value;
--      sig_bit_vector'delayed(1 ns) <= sig_bit_vector'last_value;
--      sig_boolean_vector'delayed(1 ns) <= sig_boolean_vector'last_value;
--      sig_severity_level_vector'delayed(1 ns) <=
--                                     sig_severity_level_vector'last_value;
--      sig_integer_vector'delayed(1 ns) <= sig_integer_vector'last_value;
--      sig_arr3_vector'delayed(1 ns) <= sig_arr3_vector'last_value;
--      sig_enum1'delayed(1 ns) <= sig_enum1'last_value;
--      sig_int1'delayed(1 ns) <= sig_int1'last_value;
--      sig_phys1'delayed(1 ns) <= sig_phys1'last_value;
--      sig_real1'delayed(1 ns) <= sig_real1'last_value;
--      sig_rec1'delayed(1 ns) <= sig_rec1'last_value;
--      sig_rec2'delayed(1 ns) <= sig_rec2'last_value;
--      sig_rec3'delayed(1 ns) <= sig_rec3'last_value;
--      sig_arr1'delayed(1 ns) <= sig_arr1'last_value;
--      sig_arr2'delayed(1 ns) <= sig_arr2'last_value;
--      sig_arr3'delayed(1 ns) <= sig_arr3'last_value;
--      sig_bit'delayed(1 ns) <= sig_bit'last_value;
--      sig_boolean'delayed(1 ns) <= sig_boolean'last_value;
--      sig_character'delayed(1 ns) <= sig_character'last_value;
--      sig_integer'delayed(1 ns) <= sig_integer'last_value;
--      sig_real'delayed(1 ns) <= sig_real'last_value;
--      sig_time'delayed(1 ns) <= sig_time'last_value;
      test_report ( "ARCH00542" ,
		    "Ranges of various signal attributes" ,
		    true ) ;
      wait ;
------      [sequential_statement]...
   end process P ;
end ARCH00542 ;
--
entity ENT00542_Test_Bench is
end ENT00542_Test_Bench ;

architecture ARCH00542_Test_Bench of ENT00542_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00542 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00542_Test_Bench ;
--
