-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00380
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    12.3 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00380)
--    ENT00380_Test_Bench(ARCH00380_Test_Bench)
--
-- REVISION HISTORY:
--
--    31-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00380 of E00000 is
begin
   B :
   block
      type B_enum_type is ( x0, x1 , x2, x3, x4 ) ;
      type B_int_type is range 0 to 15 ;
      constant B_int : B_int_type := B_enum_type'pos (x3) ;
      constant B_enum : B_enum_type := B_enum_type'val (B_int-1) ;
   begin
      process
      begin
	 test_report ( "ARCH00380" ,
		       "Elaboration of a declarative part" ,
		       (B_int = 3) and
		       (B_enum = x2)
                     ) ;
         wait ;
      end process ;
   end block B ;
end ARCH00380 ;

entity ENT00380_Test_Bench is
end ENT00380_Test_Bench ;

architecture ARCH00380_Test_Bench of ENT00380_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00380 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00380_Test_Bench ;

