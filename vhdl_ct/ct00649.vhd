-- NEED RESULT: ARCH00649: The keyword 'Variable' is optional in an interface variable declaration passed
-- NEED RESULT: ARCH00649: The mode and default expression are optional in an interface variable declaration passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00649
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    4.3.3 (9)
--    4.3.3 (10)
--    4.3.3 (11)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00649)
--    ENT00649_Test_Bench(ARCH00649_Test_Bench)
--
-- REVISION HISTORY:
--
--    25-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00649 of E00000 is
   procedure Proc1 (          P1 : inout integer ;
		     variable P2, P3, P4 : inout integer ) is
   begin
      test_report ( "ARCH00649" ,
		    "The keyword 'Variable' is optional in an "&
                    "interface variable declaration" ,
		    (P1 = 1) and
                    (P2 = 2) and
                    (P3 = 3) and
                    (P4 = 4) ) ;
      P1 := 1 ;

   end Proc1 ;

   procedure Proc2 ( P1 : integer ;
		     P2, P3, P4 : in integer ) is
   begin
      test_report ( "ARCH00649" ,
		    "The mode and default expression are optional "&
                    "in an interface variable declaration" ,
		    (P1 = 1) and
                    (P2 = 2) and
                    (P3 = 3) and
                    (P4 = 4) ) ;
   end Proc2 ;
begin
   process
      variable V1 : integer := 1 ;
      variable V2 : integer := 2 ;
      variable V3 : integer := 3 ;
      variable V4 : integer := 4 ;
   begin
      Proc1 ( V1, V2, V3, V4 ) ;
      Proc2 ( V1, V2, V3, V4 ) ;
      wait ;
   end process ;
end ARCH00649 ;
--
entity ENT00649_Test_Bench is
end ENT00649_Test_Bench ;

architecture ARCH00649_Test_Bench of ENT00649_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00649 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00649_Test_Bench ;
--
