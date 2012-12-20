-- NEED RESULT: ARCH00293: Index ranges of operands of logical operators may be different passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00293
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.2.1 (3)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00293(ARCH00293)
--    ENT00293_Test_Bench(ARCH00293_Test_Bench)
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
entity ENT00293 is
end ENT00293 ;

architecture ARCH00293 of ENT00293 is
begin
   P00293 :
   process
      subtype t1 is bit_vector ( 1 to 4 ) ;
      subtype t2 is bit_vector ( 21 downto 18 ) ;
      subtype t3 is boolean_vector ( 1 to 4 ) ;
      subtype t4 is boolean_vector ( 21 downto 18 ) ;
      variable bv1 : t1 ;
      variable bv2 : t2 ;
      variable bv3 : t3 ;
      variable bv4 : t4 ;
      variable bool : boolean ;
   begin
      bv1 := ('1', '1', '1', '1') ;
      bv2 := ('0', '0', '0', '0') ;
      bv3 := (true, true, true, true) ;
      bv4 := (false, false, false, false) ;
      bool := ((bv1 and bv2) = bv2) and ((bv3 and bv4) = bv4) ;
      bool := bool and ((bv1 or bv2) = bv1) and ((bv3 or bv4) = bv3) ;
      bool := bool and ((bv1 nor bv2) = bv2) and ((bv3 nor bv4) = bv4) ;
      bool := bool and ((bv1 nand bv2) = bv1) and ((bv3 nand bv4) = bv3) ;
      bool := bool and ((bv1 xor bv2) = bv1) and ((bv3 xor bv4) = bv3) ;
      test_report ( "ARCH00293" ,
		    "Index ranges of operands of logical operators may be"
                    & " different" ,
		    bool ) ;
      wait ;
   end process P00293 ;
end ARCH00293 ;

entity ENT00293_Test_Bench is
end ENT00293_Test_Bench ;

architecture ARCH00293_Test_Bench of ENT00293_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00293 ( ARCH00293 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00293_Test_Bench ;
