-- NEED RESULT: ARCH00059.P1: Body of 'for' loop is not executed when range is null passed
-- NEED RESULT: ARCH00059.P1: Discrete range is evaluated prior to execution of 'for' loop body passed
-- NEED RESULT: ARCH00059.P2: Body of 'for' loop is not executed when range is null passed
-- NEED RESULT: ARCH00059.P2: Discrete range is evaluated prior to execution of 'for' loop body passed
-- NEED RESULT: ARCH00059.P3: Body of 'for' loop is not executed when range is null passed
-- NEED RESULT: ARCH00059.P3: Discrete range is evaluated prior to execution of 'for' loop body passed
-- NEED RESULT: ARCH00059.P4: Body of 'for' loop is not executed when range is null passed
-- NEED RESULT: ARCH00059.P4: Discrete range is evaluated prior to execution of 'for' loop body passed
-- NEED RESULT: ARCH00059.P5: Body of 'for' loop is not executed when range is null passed
-- NEED RESULT: ARCH00059.P5: Discrete range is evaluated prior to execution of 'for' loop body passed
-- NEED RESULT: ARCH00059.P6: Body of 'for' loop is not executed when range is null passed
-- NEED RESULT: ARCH00059.P6: Discrete range is evaluated prior to execution of 'for' loop body passed
-- NEED RESULT: ARCH00059.P7: Body of 'for' loop is not executed when range is null passed
-- NEED RESULT: ARCH00059.P7: Discrete range is evaluated prior to execution of 'for' loop body passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00059
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.8 (4)
--    8.8 (5)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00059)
--    ENT00059_Test_Bench(ARCH00059_Test_Bench)
--
-- REVISION HISTORY:
--
--    01-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00059 of E00000 is
   signal Dummy : Boolean := false ;
begin
   P1 :
   process ( Dummy )
      variable correct : boolean := true ;
   begin
      L1 :
      for i in boolean'Low downto boolean'High loop
         correct := false ;
      end loop L1 ;
      test_report ( "ARCH00059.P1" ,
              "Body of 'for' loop is not executed when " &
              "range is null",
              correct ) ;
--
      L2 :
      for i in boolean'High to boolean'Low loop
         correct := false ;
      end loop L2 ;
      test_report ( "ARCH00059.P1" ,
              "Discrete range is evaluated prior to " &
              "execution of 'for' loop body",
              correct ) ;
--
   end process P1 ;
--
   P2 :
   process ( Dummy )
      variable correct : boolean := true ;
   begin
      L1 :
      for i in bit'Low downto bit'High loop
         correct := false ;
      end loop L1 ;
      test_report ( "ARCH00059.P2" ,
              "Body of 'for' loop is not executed when " &
              "range is null",
              correct ) ;
--
      L2 :
      for i in bit'High to bit'Low loop
         correct := false ;
      end loop L2 ;
      test_report ( "ARCH00059.P2" ,
              "Discrete range is evaluated prior to " &
              "execution of 'for' loop body",
              correct ) ;
--
   end process P2 ;
--
   P3 :
   process ( Dummy )
      variable correct : boolean := true ;
   begin
      L1 :
      for i in severity_level'Low downto severity_level'High loop
         correct := false ;
      end loop L1 ;
      test_report ( "ARCH00059.P3" ,
              "Body of 'for' loop is not executed when " &
              "range is null",
              correct ) ;
--
      L2 :
      for i in severity_level'High to severity_level'Low loop
         correct := false ;
      end loop L2 ;
      test_report ( "ARCH00059.P3" ,
              "Discrete range is evaluated prior to " &
              "execution of 'for' loop body",
              correct ) ;
--
   end process P3 ;
--
   P4 :
   process ( Dummy )
      variable correct : boolean := true ;
   begin
      L1 :
      for i in character'Low downto character'High loop
         correct := false ;
      end loop L1 ;
      test_report ( "ARCH00059.P4" ,
              "Body of 'for' loop is not executed when " &
              "range is null",
              correct ) ;
--
      L2 :
      for i in character'High to character'Low loop
         correct := false ;
      end loop L2 ;
      test_report ( "ARCH00059.P4" ,
              "Discrete range is evaluated prior to " &
              "execution of 'for' loop body",
              correct ) ;
--
   end process P4 ;
--
   P5 :
   process ( Dummy )
      variable correct : boolean := true ;
   begin
      L1 :
      for i in st_enum1'Low downto st_enum1'High loop
         correct := false ;
      end loop L1 ;
      test_report ( "ARCH00059.P5" ,
              "Body of 'for' loop is not executed when " &
              "range is null",
              correct ) ;
--
      L2 :
      for i in st_enum1'High to st_enum1'Low loop
         correct := false ;
      end loop L2 ;
      test_report ( "ARCH00059.P5" ,
              "Discrete range is evaluated prior to " &
              "execution of 'for' loop body",
              correct ) ;
--
   end process P5 ;
--
   P6 :
   process ( Dummy )
      variable correct : boolean := true ;
   begin
      L1 :
      for i in integer'Low downto integer'High loop
         correct := false ;
      end loop L1 ;
      test_report ( "ARCH00059.P6" ,
              "Body of 'for' loop is not executed when " &
              "range is null",
              correct ) ;
--
      L2 :
      for i in integer'High to integer'Low loop
         correct := false ;
      end loop L2 ;
      test_report ( "ARCH00059.P6" ,
              "Discrete range is evaluated prior to " &
              "execution of 'for' loop body",
              correct ) ;
--
   end process P6 ;
--
   P7 :
   process ( Dummy )
      variable correct : boolean := true ;
   begin
      L1 :
      for i in st_int1'Low downto st_int1'High loop
         correct := false ;
      end loop L1 ;
      test_report ( "ARCH00059.P7" ,
              "Body of 'for' loop is not executed when " &
              "range is null",
              correct ) ;
--
      L2 :
      for i in st_int1'High to st_int1'Low loop
         correct := false ;
      end loop L2 ;
      test_report ( "ARCH00059.P7" ,
              "Discrete range is evaluated prior to " &
              "execution of 'for' loop body",
              correct ) ;
--
   end process P7 ;
--
--
end ARCH00059 ;
--
entity ENT00059_Test_Bench is
end ENT00059_Test_Bench ;
--
architecture ARCH00059_Test_Bench of ENT00059_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00059 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00059_Test_Bench ;
