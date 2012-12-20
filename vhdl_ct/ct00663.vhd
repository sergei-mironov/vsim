-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00663
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    14.1 (15)
--    14.1 (18)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00663)
--    ENT00663_Test_Bench(ARCH00663_Test_Bench)
--
-- REVISION HISTORY:
--
--    27-AUG-1987   - initial revision
--
-- NOTES:
--
--    NOT SELF-CHECKING : USES 3 ASSERTION STATEMENTS
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00663 of E00000 is
   signal z : boolean ;
begin
   B1 :
   block
   begin
      z <= true after 1 ns ;
      assert B1'BEHAVIOR and ARCH00663'BEHAVIOR and
             (not B1'STRUCTURE) and (not ARCH00663'STRUCTURE) report
             "ARCH00663 BLOCK B1 : BEHAVIOR/STRUCTURE test failed" ;
   end block B1 ;
   B2 :
   block
   begin
      P :
      process
      begin
         assert B2'BEHAVIOR and ARCH00663'BEHAVIOR and
                (not B2'STRUCTURE) and (not ARCH00663'STRUCTURE) report
                "ARCH00663 BLOCK B2 : BEHAVIOR/STRUCTURE test failed" ;
	 wait ;
      end process P ;
   end block B2 ;
end ARCH00663 ;
--
entity ENT00663_Test_Bench is
end ENT00663_Test_Bench ;

architecture ARCH00663_Test_Bench of ENT00663_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00663 ) ;
   begin
      assert (not L1'BEHAVIOR) and ARCH00663_Test_Bench'STRUCTURE report
                "ARCH00663_Test_Bench : BEHAVIOR/STRUCTURE test failed" ;
      CIS1 : UUT ;
   end block L1 ;
end ARCH00663_Test_Bench ;
--
