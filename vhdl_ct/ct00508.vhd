-- NEED RESULT: ARCH00508: 'All' test in an initialization spec passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00508
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    5.2 (3)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00508)
--    ENT00508_Test_Bench(ARCH00508_Test_Bench)
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
architecture ARCH00508 of E00000 is
   signal s1, s2, s3 : boolean := True ;

   type rec is record
      f1 : boolean ;
      f2 : integer ;
   end record ;

   type TYPE1 is array ( Integer range <> ) of rec ;
   subtype ST1 is TYPE1 ( 1 to 10 ) ;
   signal sa : ST1 := (others => (true,20)) ;

   subtype ST2 is boolean range False to True ;
   signal t1, t2 : ST2 := False ;


begin
   process
   begin
      test_report ( "ARCH00508" ,
		    "'All' test in an initialization spec" ,
		    s1 and s2 and s3 and

                    sa(1).f1 and sa(2).f1 and sa(3).f1 and
                    sa(4).f1 and sa(5).f1 and sa(6).f1 and
                    sa(7).f1 and sa(8).f1 and sa(9).f1 and sa(10).f1 and

                    sa(1).f2=20 and sa(2).f2=20 and sa(3).f2=20 and
                    sa(4).f2=20 and sa(5).f2=20 and sa(6).f2=20 and
                    sa(7).f2=20 and sa(8).f2=20 and sa(9).f2=20 and
                    sa(10).f2=20 and

                    (Not t1) and (Not t2) ) ;
      wait ;
   end process ;
end ARCH00508 ;

entity ENT00508_Test_Bench is
end ENT00508_Test_Bench ;

architecture ARCH00508_Test_Bench of ENT00508_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00508 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00508_Test_Bench ;
