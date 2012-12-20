-- NEED RESULT: ARCH00062.P1: Values of 'for' loop are assigned to the  loop parameter in a left to right order passed
-- NEED RESULT: ARCH00062.P2: Values of 'for' loop are assigned to the  loop parameter in a left to right order passed
-- NEED RESULT: ARCH00062.P3: Values of 'for' loop are assigned to the  loop parameter in a left to right order passed
-- NEED RESULT: ARCH00062.P4: Values of 'for' loop are assigned to the  loop parameter in a left to right order passed
-- NEED RESULT: ARCH00062.P5: Values of 'for' loop are assigned to the  loop parameter in a left to right order passed
-- NEED RESULT: ARCH00062.P6: Values of 'for' loop are assigned to the  loop parameter in a left to right order passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00062
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.8 (7)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00062)
--    ENT00062_Test_Bench(ARCH00062_Test_Bench)
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
architecture ARCH00062 of E00000 is
   signal Dummy : Boolean := false ;
begin
   P1 :
   process ( Dummy )
      variable correct : boolean := false ;
      variable counter : integer := 0 ;
   begin
      L1 :
      for i in c_boolean_1 to
               boolean'Succ(c_boolean_1)
      loop
         if counter = 0 and i = c_boolean_1 then
            correct := true ;
         else
            correct := correct and
                       i = boolean'Succ(c_boolean_1) ;
         end if ;
         counter := counter + 1 ;
      end loop L1 ;
      test_report ( "ARCH00062.P1" ,
              "Values of 'for' loop are assigned to the  " &
              "loop parameter in a left to right order",
              correct and counter = 2) ;
--
   end process P1 ;
--
   P2 :
   process ( Dummy )
      variable correct : boolean := false ;
      variable counter : integer := 0 ;
   begin
      L1 :
      for i in c_bit_1 to
               bit'Succ(c_bit_1)
      loop
         if counter = 0 and i = c_bit_1 then
            correct := true ;
         else
            correct := correct and
                       i = bit'Succ(c_bit_1) ;
         end if ;
         counter := counter + 1 ;
      end loop L1 ;
      test_report ( "ARCH00062.P2" ,
              "Values of 'for' loop are assigned to the  " &
              "loop parameter in a left to right order",
              correct and counter = 2) ;
--
   end process P2 ;
--
   P3 :
   process ( Dummy )
      variable correct : boolean := false ;
      variable counter : integer := 0 ;
   begin
      L1 :
      for i in c_severity_level_1 to
               severity_level'Succ(c_severity_level_1)
      loop
         if counter = 0 and i = c_severity_level_1 then
            correct := true ;
         else
            correct := correct and
                       i = severity_level'Succ(c_severity_level_1) ;
         end if ;
         counter := counter + 1 ;
      end loop L1 ;
      test_report ( "ARCH00062.P3" ,
              "Values of 'for' loop are assigned to the  " &
              "loop parameter in a left to right order",
              correct and counter = 2) ;
--
   end process P3 ;
--
   P4 :
   process ( Dummy )
      variable correct : boolean := false ;
      variable counter : integer := 0 ;
   begin
      L1 :
      for i in c_character_1 to
               character'Succ(c_character_1)
      loop
         if counter = 0 and i = c_character_1 then
            correct := true ;
         else
            correct := correct and
                       i = character'Succ(c_character_1) ;
         end if ;
         counter := counter + 1 ;
      end loop L1 ;
      test_report ( "ARCH00062.P4" ,
              "Values of 'for' loop are assigned to the  " &
              "loop parameter in a left to right order",
              correct and counter = 2) ;
--
   end process P4 ;
--
   P5 :
   process ( Dummy )
      variable correct : boolean := false ;
      variable counter : integer := 0 ;
   begin
      L1 :
      for i in c_t_enum1_1 to
               t_enum1'Succ(c_t_enum1_1)
      loop
         if counter = 0 and i = c_t_enum1_1 then
            correct := true ;
         else
            correct := correct and
                       i = t_enum1'Succ(c_t_enum1_1) ;
         end if ;
         counter := counter + 1 ;
      end loop L1 ;
      test_report ( "ARCH00062.P5" ,
              "Values of 'for' loop are assigned to the  " &
              "loop parameter in a left to right order",
              correct and counter = 2) ;
--
   end process P5 ;
--
   P6 :
   process ( Dummy )
      variable correct : boolean := false ;
      variable counter : integer := 0 ;
   begin
      L1 :
      for i in c_st_int1_1 to
               st_int1'Succ(c_st_int1_1)
      loop
         if counter = 0 and i = c_st_int1_1 then
            correct := true ;
         else
            correct := correct and
                       i = st_int1'Succ(c_st_int1_1) ;
         end if ;
         counter := counter + 1 ;
      end loop L1 ;
      test_report ( "ARCH00062.P6" ,
              "Values of 'for' loop are assigned to the  " &
              "loop parameter in a left to right order",
              correct and counter = 2) ;
--
   end process P6 ;
--
--
end ARCH00062 ;
--
entity ENT00062_Test_Bench is
end ENT00062_Test_Bench ;
--
architecture ARCH00062_Test_Bench of ENT00062_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00062 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00062_Test_Bench ;
