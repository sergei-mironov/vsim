-- NEED RESULT: ARCH00509: Default initialization for drivers of subtype T is T'Left passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00509
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    5.2 (4)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00509)
--    ENT00509_Test_Bench(ARCH00509_Test_Bench)
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
architecture ARCH00509 of E00000 is
   subtype sml is integer range 1 to 10 ;
   type rec is record
      f1 : boolean ;
      f2 : sml ;
   end record ;

   type T1 is array ( Integer range <> ) of rec ;
   subtype ST1 is T1 ( 1 to 3 ) ;

   type rec2 is record
      f1 : ST1 ;
      f2 : Real ;
   end record ;

   signal S1 : rec ;
   signal S2 : ST1 ;
   signal S3 : rec2 ;
   signal S4 : boolean ;
   signal S5 : integer ;
   signal S6 : Real ;

begin
   process
   begin
      test_report ( "ARCH00509" ,
		    "Default initialization for drivers of subtype T "&
                    "is T'Left",
                    (s1.f1 = boolean'Left) and (s1.f2 = 1) and

                    (s2(1).f1 = boolean'Left) and (s2(1).f2 = 1) and
                    (s2(2).f1 = boolean'Left) and (s2(2).f2 = 1) and
                    (s2(3).f1 = boolean'Left) and (s2(3).f2 = 1) and

                    (s3.f1(1).f1 = boolean'Left) and (s3.f1(1).f2 = 1) and
                    (s3.f1(2).f1 = boolean'Left) and (s3.f1(2).f2 = 1) and
                    (s3.f1(3).f1 = boolean'Left) and (s3.f1(3).f2 = 1) and
                    (s3.f2 = Real'Left) and

                    (s4 = boolean'Left) and
                    (s5 = integer'Left) and
                    (s6 = Real'Left) );
      wait ;
   end process ;
end ARCH00509 ;

entity ENT00509_Test_Bench is
end ENT00509_Test_Bench ;

architecture ARCH00509_Test_Bench of ENT00509_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00509 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00509_Test_Bench ;
