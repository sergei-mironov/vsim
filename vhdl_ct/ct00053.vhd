-- NEED RESULT: ARCH00053.P1: Case statement with discrete range as choice passed
-- NEED RESULT: ARCH00053.P2: Case statement with subtype indication as choice passed
-- NEED RESULT: ARCH00053.P3: Case statement with discrete range as choice passed
-- NEED RESULT: ARCH00053.P4: Case statement with subtype indication as choice passed
-- NEED RESULT: ARCH00053.P5: Case statement with discrete range as choice passed
-- NEED RESULT: ARCH00053.P6: Case statement with subtype indication as choice passed
-- NEED RESULT: ARCH00053.P7: Case statement with discrete range as choice passed
-- NEED RESULT: ARCH00053.P8: Case statement with subtype indication as choice passed
-- NEED RESULT: ARCH00053.P9: Case statement with discrete range as choice passed
-- NEED RESULT: ARCH00053.P10: Case statement with subtype indication as choice passed
-- NEED RESULT: ARCH00053.P11: Case statement with discrete range as choice passed
-- NEED RESULT: ARCH00053.P12: Case statement with subtype indication as choice passed
-- NEED RESULT: ARCH00053.P13: Case statement with discrete range as choice passed
-- NEED RESULT: ARCH00053.P14: Case statement with subtype indication as choice passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00053
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.7 (6)
--    8.7 (7)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00053)
--    ENT00053_Test_Bench(ARCH00053_Test_Bench)
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
architecture ARCH00053 of E00000 is
   signal Dummy : Boolean := false ;
--
begin
   P1 :
   process ( Dummy )
      variable v_boolean : boolean :=
          c_boolean_1 ;
--
      variable correct : boolean := false;
   begin
      case v_boolean is
         when c_boolean_1 to c_boolean_2
         => correct := true ;
--
         when others
         => correct := false ;
--
      end case ;
      test_report ( "ARCH00053.P1",
                    "Case statement with discrete range as choice",
                     correct) ;
   end process P1 ;
--
   P2 :
   process ( Dummy )
      variable v_boolean : boolean :=
          c_boolean_1 ;
--
      variable correct : boolean := false;
   begin
      case v_boolean is
         when boolean range c_boolean_1 to c_boolean_2
         => correct := true ;
--
         when others
         => correct := false ;
--
      end case ;
      test_report ( "ARCH00053.P2",
                    "Case statement with subtype indication as choice",
                     correct) ;
   end process P2 ;
--
   P3 :
   process ( Dummy )
      variable v_bit : bit :=
          c_bit_1 ;
--
      variable correct : boolean := false;
   begin
      case v_bit is
         when c_bit_1 to c_bit_2
         => correct := true ;
--
         when others
         => correct := false ;
--
      end case ;
      test_report ( "ARCH00053.P3",
                    "Case statement with discrete range as choice",
                     correct) ;
   end process P3 ;
--
   P4 :
   process ( Dummy )
      variable v_bit : bit :=
          c_bit_1 ;
--
      variable correct : boolean := false;
   begin
      case v_bit is
         when bit range c_bit_1 to c_bit_2
         => correct := true ;
--
         when others
         => correct := false ;
--
      end case ;
      test_report ( "ARCH00053.P4",
                    "Case statement with subtype indication as choice",
                     correct) ;
   end process P4 ;
--
   P5 :
   process ( Dummy )
      variable v_severity_level : severity_level :=
          c_severity_level_1 ;
--
      variable correct : boolean := false;
   begin
      case v_severity_level is
         when c_severity_level_1 to c_severity_level_2
         => correct := true ;
--
         when others
         => correct := false ;
--
      end case ;
      test_report ( "ARCH00053.P5",
                    "Case statement with discrete range as choice",
                     correct) ;
   end process P5 ;
--
   P6 :
   process ( Dummy )
      variable v_severity_level : severity_level :=
          c_severity_level_1 ;
--
      variable correct : boolean := false;
   begin
      case v_severity_level is
         when severity_level range c_severity_level_1 to c_severity_level_2
         => correct := true ;
--
         when others
         => correct := false ;
--
      end case ;
      test_report ( "ARCH00053.P6",
                    "Case statement with subtype indication as choice",
                     correct) ;
   end process P6 ;
--
   P7 :
   process ( Dummy )
      variable v_character : character :=
          c_character_1 ;
--
      variable correct : boolean := false;
   begin
      case v_character is
         when c_character_1 to c_character_2
         => correct := true ;
--
         when others
         => correct := false ;
--
      end case ;
      test_report ( "ARCH00053.P7",
                    "Case statement with discrete range as choice",
                     correct) ;
   end process P7 ;
--
   P8 :
   process ( Dummy )
      variable v_character : character :=
          c_character_1 ;
--
      variable correct : boolean := false;
   begin
      case v_character is
         when character range c_character_1 to c_character_2
         => correct := true ;
--
         when others
         => correct := false ;
--
      end case ;
      test_report ( "ARCH00053.P8",
                    "Case statement with subtype indication as choice",
                     correct) ;
   end process P8 ;
--
   P9 :
   process ( Dummy )
      variable v_st_enum1 : st_enum1 :=
          c_st_enum1_1 ;
--
      variable correct : boolean := false;
   begin
      case v_st_enum1 is
         when c_st_enum1_1 to c_st_enum1_2
         => correct := true ;
--
         when others
         => correct := false ;
--
      end case ;
      test_report ( "ARCH00053.P9",
                    "Case statement with discrete range as choice",
                     correct) ;
   end process P9 ;
--
   P10 :
   process ( Dummy )
      variable v_st_enum1 : st_enum1 :=
          c_st_enum1_1 ;
--
      variable correct : boolean := false;
   begin
      case v_st_enum1 is
         when st_enum1 range c_st_enum1_1 to c_st_enum1_2
         => correct := true ;
--
         when others
         => correct := false ;
--
      end case ;
      test_report ( "ARCH00053.P10",
                    "Case statement with subtype indication as choice",
                     correct) ;
   end process P10 ;
--
   P11 :
   process ( Dummy )
      variable v_integer : integer :=
          c_integer_1 ;
--
      variable correct : boolean := false;
   begin
      case v_integer is
         when c_integer_1 to c_integer_2
         => correct := true ;
--
         when others
         => correct := false ;
--
      end case ;
      test_report ( "ARCH00053.P11",
                    "Case statement with discrete range as choice",
                     correct) ;
   end process P11 ;
--
   P12 :
   process ( Dummy )
      variable v_integer : integer :=
          c_integer_1 ;
--
      variable correct : boolean := false;
   begin
      case v_integer is
         when integer range c_integer_1 to c_integer_2
         => correct := true ;
--
         when others
         => correct := false ;
--
      end case ;
      test_report ( "ARCH00053.P12",
                    "Case statement with subtype indication as choice",
                     correct) ;
   end process P12 ;
--
   P13 :
   process ( Dummy )
      variable v_st_int1 : st_int1 :=
          c_st_int1_1 ;
--
      variable correct : boolean := false;
   begin
      case v_st_int1 is
         when c_st_int1_1 to c_st_int1_2
         => correct := true ;
--
         when others
         => correct := false ;
--
      end case ;
      test_report ( "ARCH00053.P13",
                    "Case statement with discrete range as choice",
                     correct) ;
   end process P13 ;
--
   P14 :
   process ( Dummy )
      variable v_st_int1 : st_int1 :=
          c_st_int1_1 ;
--
      variable correct : boolean := false;
   begin
      case v_st_int1 is
         when st_int1 range c_st_int1_1 to c_st_int1_2
         => correct := true ;
--
         when others
         => correct := false ;
--
      end case ;
      test_report ( "ARCH00053.P14",
                    "Case statement with subtype indication as choice",
                     correct) ;
   end process P14 ;
--
--
--
end ARCH00053 ;
--
entity ENT00053_Test_Bench is
end ENT00053_Test_Bench ;
--
architecture ARCH00053_Test_Bench of ENT00053_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00053 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00053_Test_Bench ;
