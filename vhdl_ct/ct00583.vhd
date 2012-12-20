-- NEED RESULT: ARCH00583: Attribute declarations - scalar generic subtypes with dynamic initial values passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00583
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.4 (5)
--
-- DESIGN UNIT ORDERING:
--
--    GENERIC_STANDARD_TYPES(ARCH00583)
--    ENT00583_Test_Bench(ARCH00583_Test_Bench)
--
-- REVISION HISTORY:
--
--    19-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.test_report ;
--
architecture ARCH00583 of GENERIC_STANDARD_TYPES is
      attribute at_boolean_1 : boolean ;
      attribute at_bit_1 : bit ;
      attribute at_severity_level_1 : severity_level ;
      attribute at_character_1 : character ;
      attribute at_t_enum1_1 : t_enum1 ;
      attribute at_st_enum1_1 : st_enum1 ;
      attribute at_integer_1 : integer ;
      attribute at_t_int1_1 : t_int1 ;
      attribute at_st_int1_1 : st_int1 ;
      attribute at_time_1 : time ;
      attribute at_t_phys1_1 : t_phys1 ;
      attribute at_st_phys1_1 : st_phys1 ;
      attribute at_real_1 : real ;
      attribute at_t_real1_1 : t_real1 ;
      attribute at_st_real1_1 : st_real1 ;
      procedure p2 (
    i_boolean_1, i_boolean_2 : boolean
       := c_boolean_1 ;
    i_bit_1, i_bit_2 : bit
       := c_bit_1 ;
    i_severity_level_1, i_severity_level_2 : severity_level
       := c_severity_level_1 ;
    i_character_1, i_character_2 : character
       := c_character_1 ;
    i_t_enum1_1, i_t_enum1_2 : t_enum1
       := c_t_enum1_1 ;
    i_st_enum1_1, i_st_enum1_2 : st_enum1
       := c_st_enum1_1 ;
    i_integer_1, i_integer_2 : integer
       := c_integer_1 ;
    i_t_int1_1, i_t_int1_2 : t_int1
       := c_t_int1_1 ;
    i_st_int1_1, i_st_int1_2 : st_int1
       := c_st_int1_1 ;
    i_time_1, i_time_2 : time
       := c_time_1 ;
    i_t_phys1_1, i_t_phys1_2 : t_phys1
       := c_t_phys1_1 ;
    i_st_phys1_1, i_st_phys1_2 : st_phys1
       := c_st_phys1_1 ;
    i_real_1, i_real_2 : real
       := c_real_1 ;
    i_t_real1_1, i_t_real1_2 : t_real1
       := c_t_real1_1 ;
    i_st_real1_1, i_st_real1_2 : st_real1
       := c_st_real1_1
                   ) is
         procedure p1 ;
         attribute at_boolean_1 of p1 : procedure is
              i_boolean_1 ;
         attribute at_bit_1 of p1 : procedure is
              i_bit_1 ;
         attribute at_severity_level_1 of p1 : procedure is
              i_severity_level_1 ;
         attribute at_character_1 of p1 : procedure is
              i_character_1 ;
         attribute at_t_enum1_1 of p1 : procedure is
              i_t_enum1_1 ;
         attribute at_st_enum1_1 of p1 : procedure is
              i_st_enum1_1 ;
         attribute at_integer_1 of p1 : procedure is
              i_integer_1 ;
         attribute at_t_int1_1 of p1 : procedure is
              i_t_int1_1 ;
         attribute at_st_int1_1 of p1 : procedure is
              i_st_int1_1 ;
         attribute at_time_1 of p1 : procedure is
              i_time_1 ;
         attribute at_t_phys1_1 of p1 : procedure is
              i_t_phys1_1 ;
         attribute at_st_phys1_1 of p1 : procedure is
              i_st_phys1_1 ;
         attribute at_real_1 of p1 : procedure is
              i_real_1 ;
         attribute at_t_real1_1 of p1 : procedure is
              i_t_real1_1 ;
         attribute at_st_real1_1 of p1 : procedure is
              i_st_real1_1 ;
         procedure p1 is
            variable correct : boolean := true ;
         begin
            correct := correct and p1'at_boolean_1
              = c_boolean_1 ;
            correct := correct and p1'at_bit_1
              = c_bit_1 ;
            correct := correct and p1'at_severity_level_1
              = c_severity_level_1 ;
            correct := correct and p1'at_character_1
              = c_character_1 ;
            correct := correct and p1'at_t_enum1_1
              = c_t_enum1_1 ;
            correct := correct and p1'at_st_enum1_1
              = c_st_enum1_1 ;
            correct := correct and p1'at_integer_1
              = c_integer_1 ;
            correct := correct and p1'at_t_int1_1
              = c_t_int1_1 ;
            correct := correct and p1'at_st_int1_1
              = c_st_int1_1 ;
            correct := correct and p1'at_time_1
              = c_time_1 ;
            correct := correct and p1'at_t_phys1_1
              = c_t_phys1_1 ;
            correct := correct and p1'at_st_phys1_1
              = c_st_phys1_1 ;
            correct := correct and p1'at_real_1
              = c_real_1 ;
            correct := correct and p1'at_t_real1_1
              = c_t_real1_1 ;
            correct := correct and p1'at_st_real1_1
              = c_st_real1_1 ;
            test_report ( "ARCH00583" ,
              "Attribute declarations - scalar generic subtypes"
                          & " with dynamic initial values" ,
            correct) ;
         end p1 ;
      begin
         p1 ;
      end p2 ;
begin
   process
   begin
      p2 ;
      wait ;
   end process ;
end ARCH00583 ;
--
entity ENT00583_Test_Bench is
end ENT00583_Test_Bench ;
--
architecture ARCH00583_Test_Bench of ENT00583_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.GENERIC_STANDARD_TYPES ( ARCH00583 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00583_Test_Bench ;
