-- NEED RESULT: ARCH00596: Direction of subtype with range is that of range passed
-- NEED RESULT: ARCH00596: Direction of subtype without range is that of underlying type passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00596
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.2 (7)
--    4.2 (8)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00596)
--    ENT00596_Test_Bench(ARCH00596_Test_Bench)
--
-- REVISION HISTORY:
--
--    26-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00596 of E00000 is
begin
   process
      subtype s0 is integer ;
      subtype s1 is integer range -10 downto -20 ;
      subtype s2 is integer range 10 to 20 ;
      subtype s3 is t_enum1 ;
      subtype s4 is t_enum1 range en2 downto en1 ;
      subtype s5 is t_enum1 range en1 to en2 ;
      type t6 is range 5 downto 1 ;
      subtype s6 is t6 ;
   begin
      test_report ( "ARCH00596" ,
		    "Direction of subtype with range is that of range" ,
		    s1'left > s1'right and
		    s2'left < s2'right and
		    s4'left > s4'right and
		    s5'left < s5'right ) ;
      test_report ( "ARCH00596" ,
		    "Direction of subtype without range is that of"
                    & " underlying type" ,
		    s0'left < s0'right and
		    s3'left < s3'right and
                    s6'left > s6'right ) ;
      wait ;
   end process ;
end ARCH00596 ;
--
entity ENT00596_Test_Bench is
end ENT00596_Test_Bench ;

architecture ARCH00596_Test_Bench of ENT00596_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00596 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00596_Test_Bench ;
--
