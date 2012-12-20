-- NEED RESULT: ARCH00506: 'Others' test in an initialization spec passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00506
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    5.2 (2)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00506)
--    ENT00506_Test_Bench(ARCH00506_Test_Bench)
--
-- REVISION HISTORY:
--
--    10-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00506 of E00000 is
   signal s1, s3 : boolean := True ;
   signal s2 : boolean := false ;

   type TYPE1 is array ( Integer range <> ) of boolean ;
   subtype ST1 is TYPE1 ( 1 to 10 ) ;
   signal sa : ST1 := (true, false, others => true) ;
   alias sa2 : boolean is sa(2) ;

   subtype ST2 is boolean range False to True ;
   signal t1, t2 : ST2 := false ;


begin
   process
   begin
      test_report ( "ARCH00506" ,
		    "'Others' test in an initialization spec" ,
		    s1 and (Not s2) and s3 and
                    sa(1) and (Not sa(2)) and sa(3) and
                    sa(4) and sa(5) and sa(6) and sa(7) and
                    sa(8) and sa(9) and sa(10) and
                    (Not t1) and (Not t2) ) ;
      wait ;
   end process ;
end ARCH00506 ;

entity ENT00506_Test_Bench is
end ENT00506_Test_Bench ;

architecture ARCH00506_Test_Bench of ENT00506_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00506 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00506_Test_Bench ;
