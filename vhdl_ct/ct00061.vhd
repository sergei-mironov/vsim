-- NEED RESULT: ARCH00061.P1: Body of 'for' loop is executed once for each value in the discrete range passed
-- NEED RESULT: ARCH00061.P2: Body of 'for' loop is executed once for each value in the discrete range passed
-- NEED RESULT: ARCH00061.P3: Body of 'for' loop is executed once for each value in the discrete range passed
-- NEED RESULT: ARCH00061.P4: Body of 'for' loop is executed once for each value in the discrete range passed
-- NEED RESULT: ARCH00061.P5: Body of 'for' loop is executed once for each value in the discrete range passed
-- NEED RESULT: ARCH00061.P6: Body of 'for' loop is executed once for each value in the discrete range passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00061
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.8 (6)
--    8.8 (8)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00061)
--    ENT00061_Test_Bench(ARCH00061_Test_Bench)
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
architecture ARCH00061 of E00000 is
   signal Dummy : Boolean := false ;
begin
   P1 :
   process ( Dummy )
      variable correct : boolean ;
      variable count : integer := 0 ;
--
      procedure Proc1 (
          lowb, highb : boolean ;
          counter : inout integer
                      ) is
      begin
         L1 :
         for i in lowb to highb loop
            counter := counter + 1 ;
         end loop L1 ;
      end Proc1 ;
--
   begin
      Proc1 (boolean'Low, boolean'High, count) ;
      correct := count =
                 (boolean'Pos (boolean'High) -
                  boolean'Pos (boolean'Low) + 1) ;
      test_report ( "ARCH00061.P1" ,
              "Body of 'for' loop is executed once " &
              "for each value in the discrete range",
              correct ) ;
--
   end process P1 ;
--
   P2 :
   process ( Dummy )
      variable correct : boolean ;
      variable count : integer := 0 ;
--
      procedure Proc1 (
          lowb, highb : bit ;
          counter : inout integer
                      ) is
      begin
         L1 :
         for i in lowb to highb loop
            counter := counter + 1 ;
         end loop L1 ;
      end Proc1 ;
--
   begin
      Proc1 (bit'Low, bit'High, count) ;
      correct := count =
                 (bit'Pos (bit'High) -
                  bit'Pos (bit'Low) + 1) ;
      test_report ( "ARCH00061.P2" ,
              "Body of 'for' loop is executed once " &
              "for each value in the discrete range",
              correct ) ;
--
   end process P2 ;
--
   P3 :
   process ( Dummy )
      variable correct : boolean ;
      variable count : integer := 0 ;
--
      procedure Proc1 (
          lowb, highb : severity_level ;
          counter : inout integer
                      ) is
      begin
         L1 :
         for i in lowb to highb loop
            counter := counter + 1 ;
         end loop L1 ;
      end Proc1 ;
--
   begin
      Proc1 (severity_level'Low, severity_level'High, count) ;
      correct := count =
                 (severity_level'Pos (severity_level'High) -
                  severity_level'Pos (severity_level'Low) + 1) ;
      test_report ( "ARCH00061.P3" ,
              "Body of 'for' loop is executed once " &
              "for each value in the discrete range",
              correct ) ;
--
   end process P3 ;
--
   P4 :
   process ( Dummy )
      variable correct : boolean ;
      variable count : integer := 0 ;
--
      procedure Proc1 (
          lowb, highb : character ;
          counter : inout integer
                      ) is
      begin
         L1 :
         for i in lowb to highb loop
            counter := counter + 1 ;
         end loop L1 ;
      end Proc1 ;
--
   begin
      Proc1 (character'Low, character'High, count) ;
      correct := count =
                 (character'Pos (character'High) -
                  character'Pos (character'Low) + 1) ;
      test_report ( "ARCH00061.P4" ,
              "Body of 'for' loop is executed once " &
              "for each value in the discrete range",
              correct ) ;
--
   end process P4 ;
--
   P5 :
   process ( Dummy )
      variable correct : boolean ;
      variable count : integer := 0 ;
--
      procedure Proc1 (
          lowb, highb : st_enum1 ;
          counter : inout integer
                      ) is
      begin
         L1 :
         for i in lowb to highb loop
            counter := counter + 1 ;
         end loop L1 ;
      end Proc1 ;
--
   begin
      Proc1 (st_enum1'Low, st_enum1'High, count) ;
      correct := count =
                 (st_enum1'Pos (st_enum1'High) -
                  st_enum1'Pos (st_enum1'Low) + 1) ;
      test_report ( "ARCH00061.P5" ,
              "Body of 'for' loop is executed once " &
              "for each value in the discrete range",
              correct ) ;
--
   end process P5 ;
--
   P6 :
   process ( Dummy )
      variable correct : boolean ;
      variable count : integer := 0 ;
--
      procedure Proc1 (
          lowb, highb : st_int1 ;
          counter : inout integer
                      ) is
      begin
         L1 :
         for i in lowb to highb loop
            counter := counter + 1 ;
         end loop L1 ;
      end Proc1 ;
--
   begin
      Proc1 (st_int1'Low, st_int1'High, count) ;
      correct := count =
                 (st_int1'Pos (st_int1'High) -
                  st_int1'Pos (st_int1'Low) + 1) ;
      test_report ( "ARCH00061.P6" ,
              "Body of 'for' loop is executed once " &
              "for each value in the discrete range",
              correct ) ;
--
   end process P6 ;
--
--
end ARCH00061 ;
--
entity ENT00061_Test_Bench is
end ENT00061_Test_Bench ;
--
architecture ARCH00061_Test_Bench of ENT00061_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00061 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00061_Test_Bench ;
