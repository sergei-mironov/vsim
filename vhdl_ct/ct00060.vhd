-- NEED RESULT: ARCH00060.P1: Body of 'for' loop is executed once for each value in the discrete range passed
-- NEED RESULT: ARCH00060.P2: Body of 'for' loop is executed once for each value in the discrete range passed
-- NEED RESULT: ARCH00060.P3: Body of 'for' loop is executed once for each value in the discrete range passed
-- NEED RESULT: ARCH00060.P4: Body of 'for' loop is executed once for each value in the discrete range passed
-- NEED RESULT: ARCH00060.P5: Body of 'for' loop is executed once for each value in the discrete range passed
-- NEED RESULT: ARCH00060.P6: Body of 'for' loop is executed once for each value in the discrete range passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00060
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.8 (6)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00060)
--    ENT00060_Test_Bench(ARCH00060_Test_Bench)
--
-- REVISION HISTORY:
--
--    06-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00060 of E00000 is
   signal Dummy : Boolean := false ;
begin
   P1 :
   process ( Dummy )
      variable correct : boolean ;
      variable counter : integer := 0 ;
   begin
      L1 :
      for i in boolean loop
         counter := counter + 1 ;
      end loop L1 ;
      correct := counter =
                 (boolean'Pos (boolean'High) -
                  boolean'Pos (boolean'Low) + 1) ;
      test_report ( "ARCH00060.P1" ,
              "Body of 'for' loop is executed once " &
              "for each value in the discrete range",
              correct ) ;
--
   end process P1 ;
--
   P2 :
   process ( Dummy )
      variable correct : boolean ;
      variable counter : integer := 0 ;
   begin
      L1 :
      for i in bit loop
         counter := counter + 1 ;
      end loop L1 ;
      correct := counter =
                 (bit'Pos (bit'High) -
                  bit'Pos (bit'Low) + 1) ;
      test_report ( "ARCH00060.P2" ,
              "Body of 'for' loop is executed once " &
              "for each value in the discrete range",
              correct ) ;
--
   end process P2 ;
--
   P3 :
   process ( Dummy )
      variable correct : boolean ;
      variable counter : integer := 0 ;
   begin
      L1 :
      for i in severity_level loop
         counter := counter + 1 ;
      end loop L1 ;
      correct := counter =
                 (severity_level'Pos (severity_level'High) -
                  severity_level'Pos (severity_level'Low) + 1) ;
      test_report ( "ARCH00060.P3" ,
              "Body of 'for' loop is executed once " &
              "for each value in the discrete range",
              correct ) ;
--
   end process P3 ;
--
   P4 :
   process ( Dummy )
      variable correct : boolean ;
      variable counter : integer := 0 ;
   begin
      L1 :
      for i in character loop
         counter := counter + 1 ;
      end loop L1 ;
      correct := counter =
                 (character'Pos (character'High) -
                  character'Pos (character'Low) + 1) ;
      test_report ( "ARCH00060.P4" ,
              "Body of 'for' loop is executed once " &
              "for each value in the discrete range",
              correct ) ;
--
   end process P4 ;
--
   P5 :
   process ( Dummy )
      variable correct : boolean ;
      variable counter : integer := 0 ;
   begin
      L1 :
      for i in st_enum1 loop
         counter := counter + 1 ;
      end loop L1 ;
      correct := counter =
                 (st_enum1'Pos (st_enum1'High) -
                  st_enum1'Pos (st_enum1'Low) + 1) ;
      test_report ( "ARCH00060.P5" ,
              "Body of 'for' loop is executed once " &
              "for each value in the discrete range",
              correct ) ;
--
   end process P5 ;
--
   P6 :
   process ( Dummy )
      variable correct : boolean ;
      variable counter : integer := 0 ;
   begin
      L1 :
      for i in st_int1 loop
         counter := counter + 1 ;
      end loop L1 ;
      correct := counter =
                 (st_int1'Pos (st_int1'High) -
                  st_int1'Pos (st_int1'Low) + 1) ;
      test_report ( "ARCH00060.P6" ,
              "Body of 'for' loop is executed once " &
              "for each value in the discrete range",
              correct ) ;
--
   end process P6 ;
--
--
end ARCH00060 ;
--
entity ENT00060_Test_Bench is
end ENT00060_Test_Bench ;
--
architecture ARCH00060_Test_Bench of ENT00060_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00060 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00060_Test_Bench ;
