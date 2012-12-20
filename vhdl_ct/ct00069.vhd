-- NEED RESULT: ARCH00069.P1_1: Return statement stops execution of a function and defines its result passed
-- NEED RESULT: ARCH00069.P2_1: Return statement stops execution of a function and defines its result passed
-- NEED RESULT: ARCH00069.P3_1: Return statement stops execution of a function and defines its result passed
-- NEED RESULT: ARCH00069.P4_1: Return statement stops execution of a function and defines its result passed
-- NEED RESULT: ARCH00069.P5_1: Return statement stops execution of a function and defines its result passed
-- NEED RESULT: ARCH00069.P6_1: Return statement stops execution of a function and defines its result passed
-- NEED RESULT: ARCH00069.P7_1: Return statement stops execution of a function and defines its result passed
-- NEED RESULT: ARCH00069.P8_1: Return statement stops execution of a function and defines its result passed
-- NEED RESULT: ARCH00069.P9_1: Return statement stops execution of a function and defines its result passed
-- NEED RESULT: ARCH00069.P10_1: Return statement stops execution of a function and defines its result passed
-- NEED RESULT: ARCH00069.P11_1: Return statement stops execution of a function and defines its result passed
-- NEED RESULT: ARCH00069.P12_1: Return statement stops execution of a function and defines its result passed
-- NEED RESULT: ARCH00069.P13_1: Return statement stops execution of a function and defines its result passed
-- NEED RESULT: ARCH00069.P14_1: Return statement stops execution of a function and defines its result passed
-- NEED RESULT: ARCH00069.P15_1: Return statement stops execution of a function and defines its result passed
-- NEED RESULT: ARCH00069.P16_1: Return statement stops execution of a function and defines its result passed
-- NEED RESULT: ARCH00069.P17_1: Return statement stops execution of a function and defines its result passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00069
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.11 (2)
--    8.11 (3)
--    8.11 (4)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00069)
--    ENT00069_Test_Bench(ARCH00069_Test_Bench)
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
architecture ARCH00069 of E00000 is
   signal Dummy : Boolean := false ;
begin
   P1_1 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_boolean : boolean :=
          c_boolean_1 ;
--
      function Func1 (
         constant p_boolean_1,
                  p_boolean_2 : boolean
                      ) return boolean is
      begin
         if p_boolean_1 /= p_boolean_2 then
            return Func1 (p_boolean_2,
                          p_boolean_2) ;
         else
            return p_boolean_2 ;
         end if ;
         test_report ( "ARCH00069.P1_1" ,
                 "Return statement stops execution of a " &
                 "function",
                 false ) ;
      end Func1 ;
--
   begin
      v_boolean :=
        Func1 (c_boolean_1, c_boolean_2) ;
      correct := v_boolean = c_boolean_2 ;
      test_report ( "ARCH00069.P1_1" ,
              "Return statement stops execution of a " &
              "function and defines its result",
              correct ) ;
--
   end process P1_1 ;
--
   P2_1 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_bit : bit :=
          c_bit_1 ;
--
      function Func1 (
         constant p_bit_1,
                  p_bit_2 : bit
                      ) return bit is
      begin
         if p_bit_1 /= p_bit_2 then
            return Func1 (p_bit_2,
                          p_bit_2) ;
         else
            return p_bit_2 ;
         end if ;
         test_report ( "ARCH00069.P2_1" ,
                 "Return statement stops execution of a " &
                 "function",
                 false ) ;
      end Func1 ;
--
   begin
      v_bit :=
        Func1 (c_bit_1, c_bit_2) ;
      correct := v_bit = c_bit_2 ;
      test_report ( "ARCH00069.P2_1" ,
              "Return statement stops execution of a " &
              "function and defines its result",
              correct ) ;
--
   end process P2_1 ;
--
   P3_1 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_severity_level : severity_level :=
          c_severity_level_1 ;
--
      function Func1 (
         constant p_severity_level_1,
                  p_severity_level_2 : severity_level
                      ) return severity_level is
      begin
         if p_severity_level_1 /= p_severity_level_2 then
            return Func1 (p_severity_level_2,
                          p_severity_level_2) ;
         else
            return p_severity_level_2 ;
         end if ;
         test_report ( "ARCH00069.P3_1" ,
                 "Return statement stops execution of a " &
                 "function",
                 false ) ;
      end Func1 ;
--
   begin
      v_severity_level :=
        Func1 (c_severity_level_1, c_severity_level_2) ;
      correct := v_severity_level = c_severity_level_2 ;
      test_report ( "ARCH00069.P3_1" ,
              "Return statement stops execution of a " &
              "function and defines its result",
              correct ) ;
--
   end process P3_1 ;
--
   P4_1 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_character : character :=
          c_character_1 ;
--
      function Func1 (
         constant p_character_1,
                  p_character_2 : character
                      ) return character is
      begin
         if p_character_1 /= p_character_2 then
            return Func1 (p_character_2,
                          p_character_2) ;
         else
            return p_character_2 ;
         end if ;
         test_report ( "ARCH00069.P4_1" ,
                 "Return statement stops execution of a " &
                 "function",
                 false ) ;
      end Func1 ;
--
   begin
      v_character :=
        Func1 (c_character_1, c_character_2) ;
      correct := v_character = c_character_2 ;
      test_report ( "ARCH00069.P4_1" ,
              "Return statement stops execution of a " &
              "function and defines its result",
              correct ) ;
--
   end process P4_1 ;
--
   P5_1 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_st_enum1 : st_enum1 :=
          c_st_enum1_1 ;
--
      function Func1 (
         constant p_st_enum1_1,
                  p_st_enum1_2 : st_enum1
                      ) return st_enum1 is
      begin
         if p_st_enum1_1 /= p_st_enum1_2 then
            return Func1 (p_st_enum1_2,
                          p_st_enum1_2) ;
         else
            return p_st_enum1_2 ;
         end if ;
         test_report ( "ARCH00069.P5_1" ,
                 "Return statement stops execution of a " &
                 "function",
                 false ) ;
      end Func1 ;
--
   begin
      v_st_enum1 :=
        Func1 (c_st_enum1_1, c_st_enum1_2) ;
      correct := v_st_enum1 = c_st_enum1_2 ;
      test_report ( "ARCH00069.P5_1" ,
              "Return statement stops execution of a " &
              "function and defines its result",
              correct ) ;
--
   end process P5_1 ;
--
   P6_1 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_integer : integer :=
          c_integer_1 ;
--
      function Func1 (
         constant p_integer_1,
                  p_integer_2 : integer
                      ) return integer is
      begin
         if p_integer_1 /= p_integer_2 then
            return Func1 (p_integer_2,
                          p_integer_2) ;
         else
            return p_integer_2 ;
         end if ;
         test_report ( "ARCH00069.P6_1" ,
                 "Return statement stops execution of a " &
                 "function",
                 false ) ;
      end Func1 ;
--
   begin
      v_integer :=
        Func1 (c_integer_1, c_integer_2) ;
      correct := v_integer = c_integer_2 ;
      test_report ( "ARCH00069.P6_1" ,
              "Return statement stops execution of a " &
              "function and defines its result",
              correct ) ;
--
   end process P6_1 ;
--
   P7_1 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_st_int1 : st_int1 :=
          c_st_int1_1 ;
--
      function Func1 (
         constant p_st_int1_1,
                  p_st_int1_2 : st_int1
                      ) return st_int1 is
      begin
         if p_st_int1_1 /= p_st_int1_2 then
            return Func1 (p_st_int1_2,
                          p_st_int1_2) ;
         else
            return p_st_int1_2 ;
         end if ;
         test_report ( "ARCH00069.P7_1" ,
                 "Return statement stops execution of a " &
                 "function",
                 false ) ;
      end Func1 ;
--
   begin
      v_st_int1 :=
        Func1 (c_st_int1_1, c_st_int1_2) ;
      correct := v_st_int1 = c_st_int1_2 ;
      test_report ( "ARCH00069.P7_1" ,
              "Return statement stops execution of a " &
              "function and defines its result",
              correct ) ;
--
   end process P7_1 ;
--
   P8_1 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_time : time :=
          c_time_1 ;
--
      function Func1 (
         constant p_time_1,
                  p_time_2 : time
                      ) return time is
      begin
         if p_time_1 /= p_time_2 then
            return Func1 (p_time_2,
                          p_time_2) ;
         else
            return p_time_2 ;
         end if ;
         test_report ( "ARCH00069.P8_1" ,
                 "Return statement stops execution of a " &
                 "function",
                 false ) ;
      end Func1 ;
--
   begin
      v_time :=
        Func1 (c_time_1, c_time_2) ;
      correct := v_time = c_time_2 ;
      test_report ( "ARCH00069.P8_1" ,
              "Return statement stops execution of a " &
              "function and defines its result",
              correct ) ;
--
   end process P8_1 ;
--
   P9_1 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_st_phys1 : st_phys1 :=
          c_st_phys1_1 ;
--
      function Func1 (
         constant p_st_phys1_1,
                  p_st_phys1_2 : st_phys1
                      ) return st_phys1 is
      begin
         if p_st_phys1_1 /= p_st_phys1_2 then
            return Func1 (p_st_phys1_2,
                          p_st_phys1_2) ;
         else
            return p_st_phys1_2 ;
         end if ;
         test_report ( "ARCH00069.P9_1" ,
                 "Return statement stops execution of a " &
                 "function",
                 false ) ;
      end Func1 ;
--
   begin
      v_st_phys1 :=
        Func1 (c_st_phys1_1, c_st_phys1_2) ;
      correct := v_st_phys1 = c_st_phys1_2 ;
      test_report ( "ARCH00069.P9_1" ,
              "Return statement stops execution of a " &
              "function and defines its result",
              correct ) ;
--
   end process P9_1 ;
--
   P10_1 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_real : real :=
          c_real_1 ;
--
      function Func1 (
         constant p_real_1,
                  p_real_2 : real
                      ) return real is
      begin
         if p_real_1 /= p_real_2 then
            return Func1 (p_real_2,
                          p_real_2) ;
         else
            return p_real_2 ;
         end if ;
         test_report ( "ARCH00069.P10_1" ,
                 "Return statement stops execution of a " &
                 "function",
                 false ) ;
      end Func1 ;
--
   begin
      v_real :=
        Func1 (c_real_1, c_real_2) ;
      correct := v_real = c_real_2 ;
      test_report ( "ARCH00069.P10_1" ,
              "Return statement stops execution of a " &
              "function and defines its result",
              correct ) ;
--
   end process P10_1 ;
--
   P11_1 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_st_real1 : st_real1 :=
          c_st_real1_1 ;
--
      function Func1 (
         constant p_st_real1_1,
                  p_st_real1_2 : st_real1
                      ) return st_real1 is
      begin
         if p_st_real1_1 /= p_st_real1_2 then
            return Func1 (p_st_real1_2,
                          p_st_real1_2) ;
         else
            return p_st_real1_2 ;
         end if ;
         test_report ( "ARCH00069.P11_1" ,
                 "Return statement stops execution of a " &
                 "function",
                 false ) ;
      end Func1 ;
--
   begin
      v_st_real1 :=
        Func1 (c_st_real1_1, c_st_real1_2) ;
      correct := v_st_real1 = c_st_real1_2 ;
      test_report ( "ARCH00069.P11_1" ,
              "Return statement stops execution of a " &
              "function and defines its result",
              correct ) ;
--
   end process P11_1 ;
--
   P12_1 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_st_rec1 : st_rec1 :=
          c_st_rec1_1 ;
--
      function Func1 (
         constant p_st_rec1_1,
                  p_st_rec1_2 : st_rec1
                      ) return st_rec1 is
      begin
         if p_st_rec1_1 /= p_st_rec1_2 then
            return Func1 (p_st_rec1_2,
                          p_st_rec1_2) ;
         else
            return p_st_rec1_2 ;
         end if ;
         test_report ( "ARCH00069.P12_1" ,
                 "Return statement stops execution of a " &
                 "function",
                 false ) ;
      end Func1 ;
--
   begin
      v_st_rec1 :=
        Func1 (c_st_rec1_1, c_st_rec1_2) ;
      correct := v_st_rec1 = c_st_rec1_2 ;
      test_report ( "ARCH00069.P12_1" ,
              "Return statement stops execution of a " &
              "function and defines its result",
              correct ) ;
--
   end process P12_1 ;
--
   P13_1 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_st_rec2 : st_rec2 :=
          c_st_rec2_1 ;
--
      function Func1 (
         constant p_st_rec2_1,
                  p_st_rec2_2 : st_rec2
                      ) return st_rec2 is
      begin
         if p_st_rec2_1 /= p_st_rec2_2 then
            return Func1 (p_st_rec2_2,
                          p_st_rec2_2) ;
         else
            return p_st_rec2_2 ;
         end if ;
         test_report ( "ARCH00069.P13_1" ,
                 "Return statement stops execution of a " &
                 "function",
                 false ) ;
      end Func1 ;
--
   begin
      v_st_rec2 :=
        Func1 (c_st_rec2_1, c_st_rec2_2) ;
      correct := v_st_rec2 = c_st_rec2_2 ;
      test_report ( "ARCH00069.P13_1" ,
              "Return statement stops execution of a " &
              "function and defines its result",
              correct ) ;
--
   end process P13_1 ;
--
   P14_1 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_st_rec3 : st_rec3 :=
          c_st_rec3_1 ;
--
      function Func1 (
         constant p_st_rec3_1,
                  p_st_rec3_2 : st_rec3
                      ) return st_rec3 is
      begin
         if p_st_rec3_1 /= p_st_rec3_2 then
            return Func1 (p_st_rec3_2,
                          p_st_rec3_2) ;
         else
            return p_st_rec3_2 ;
         end if ;
         test_report ( "ARCH00069.P14_1" ,
                 "Return statement stops execution of a " &
                 "function",
                 false ) ;
      end Func1 ;
--
   begin
      v_st_rec3 :=
        Func1 (c_st_rec3_1, c_st_rec3_2) ;
      correct := v_st_rec3 = c_st_rec3_2 ;
      test_report ( "ARCH00069.P14_1" ,
              "Return statement stops execution of a " &
              "function and defines its result",
              correct ) ;
--
   end process P14_1 ;
--
   P15_1 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_st_arr1 : st_arr1 :=
          c_st_arr1_1 ;
--
      function Func1 (
         constant p_st_arr1_1,
                  p_st_arr1_2 : st_arr1
                      ) return st_arr1 is
      begin
         if p_st_arr1_1 /= p_st_arr1_2 then
            return Func1 (p_st_arr1_2,
                          p_st_arr1_2) ;
         else
            return p_st_arr1_2 ;
         end if ;
         test_report ( "ARCH00069.P15_1" ,
                 "Return statement stops execution of a " &
                 "function",
                 false ) ;
      end Func1 ;
--
   begin
      v_st_arr1 :=
        Func1 (c_st_arr1_1, c_st_arr1_2) ;
      correct := v_st_arr1 = c_st_arr1_2 ;
      test_report ( "ARCH00069.P15_1" ,
              "Return statement stops execution of a " &
              "function and defines its result",
              correct ) ;
--
   end process P15_1 ;
--
   P16_1 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_st_arr2 : st_arr2 :=
          c_st_arr2_1 ;
--
      function Func1 (
         constant p_st_arr2_1,
                  p_st_arr2_2 : st_arr2
                      ) return st_arr2 is
      begin
         if p_st_arr2_1 /= p_st_arr2_2 then
            return Func1 (p_st_arr2_2,
                          p_st_arr2_2) ;
         else
            return p_st_arr2_2 ;
         end if ;
         test_report ( "ARCH00069.P16_1" ,
                 "Return statement stops execution of a " &
                 "function",
                 false ) ;
      end Func1 ;
--
   begin
      v_st_arr2 :=
        Func1 (c_st_arr2_1, c_st_arr2_2) ;
      correct := v_st_arr2 = c_st_arr2_2 ;
      test_report ( "ARCH00069.P16_1" ,
              "Return statement stops execution of a " &
              "function and defines its result",
              correct ) ;
--
   end process P16_1 ;
--
   P17_1 :
   process ( Dummy )
      variable correct : boolean := true ;
      variable v_st_arr3 : st_arr3 :=
          c_st_arr3_1 ;
--
      function Func1 (
         constant p_st_arr3_1,
                  p_st_arr3_2 : st_arr3
                      ) return st_arr3 is
      begin
         if p_st_arr3_1 /= p_st_arr3_2 then
            return Func1 (p_st_arr3_2,
                          p_st_arr3_2) ;
         else
            return p_st_arr3_2 ;
         end if ;
         test_report ( "ARCH00069.P17_1" ,
                 "Return statement stops execution of a " &
                 "function",
                 false ) ;
      end Func1 ;
--
   begin
      v_st_arr3 :=
        Func1 (c_st_arr3_1, c_st_arr3_2) ;
      correct := v_st_arr3 = c_st_arr3_2 ;
      test_report ( "ARCH00069.P17_1" ,
              "Return statement stops execution of a " &
              "function and defines its result",
              correct ) ;
--
   end process P17_1 ;
--
--
end ARCH00069 ;
--
entity ENT00069_Test_Bench is
end ENT00069_Test_Bench ;
--
architecture ARCH00069_Test_Bench of ENT00069_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00069 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00069_Test_Bench ;
