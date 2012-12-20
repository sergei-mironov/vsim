-- NEED RESULT: ARCH00015: Associated scalar generics with globally static subtype passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

--
-- TEST NAME:
--
--    CT00015
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.1.1.1 (2)
--    1.1.1.1 (4)
--
-- DESIGN UNIT ORDERING:
--
--    GENERIC_STANDARD_TYPES(ARCH00015)
--    ENT00015_Test_Bench(ARCH00015_Test_Bench)
--
-- REVISION HISTORY:
--
--    26-JUN-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00015 of GENERIC_STANDARD_TYPES is
begin
   L1 :
   block
      generic (
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
            ) ;
      generic map (
          c_boolean_2, c_boolean_2,
          c_bit_2, c_bit_2,
          c_severity_level_2, c_severity_level_2,
          c_character_2, c_character_2,
          c_t_enum1_2, c_t_enum1_2,
          c_st_enum1_2, c_st_enum1_2,
          c_integer_2, c_integer_2,
          c_t_int1_2, c_t_int1_2,
          c_st_int1_2, c_st_int1_2,
          c_time_2, c_time_2,
          c_t_phys1_2, c_t_phys1_2,
          c_st_phys1_2, c_st_phys1_2,
          c_real_2, c_real_2,
          c_t_real1_2, c_t_real1_2,
          c_st_real1_2, c_st_real1_2
            ) ;
   begin
      process
         variable correct : boolean := true ;
      begin
         correct := correct and i_boolean_1 = c_boolean_2
                    and i_boolean_2 = c_boolean_2 ;
         correct := correct and i_bit_1 = c_bit_2
                    and i_bit_2 = c_bit_2 ;
         correct := correct and i_severity_level_1 = c_severity_level_2
                    and i_severity_level_2 = c_severity_level_2 ;
         correct := correct and i_character_1 = c_character_2
                    and i_character_2 = c_character_2 ;
         correct := correct and i_t_enum1_1 = c_t_enum1_2
                    and i_t_enum1_2 = c_t_enum1_2 ;
         correct := correct and i_st_enum1_1 = c_st_enum1_2
                    and i_st_enum1_2 = c_st_enum1_2 ;
         correct := correct and i_integer_1 = c_integer_2
                    and i_integer_2 = c_integer_2 ;
         correct := correct and i_t_int1_1 = c_t_int1_2
                    and i_t_int1_2 = c_t_int1_2 ;
         correct := correct and i_st_int1_1 = c_st_int1_2
                    and i_st_int1_2 = c_st_int1_2 ;
         correct := correct and i_time_1 = c_time_2
                    and i_time_2 = c_time_2 ;
         correct := correct and i_t_phys1_1 = c_t_phys1_2
                    and i_t_phys1_2 = c_t_phys1_2 ;
         correct := correct and i_st_phys1_1 = c_st_phys1_2
                    and i_st_phys1_2 = c_st_phys1_2 ;
         correct := correct and i_real_1 = c_real_2
                    and i_real_2 = c_real_2 ;
         correct := correct and i_t_real1_1 = c_t_real1_2
                    and i_t_real1_2 = c_t_real1_2 ;
         correct := correct and i_st_real1_1 = c_st_real1_2
                    and i_st_real1_2 = c_st_real1_2 ;
         test_report ( "ARCH00015" ,
           "Associated scalar generics with globally static subtype" ,
           correct) ;
         wait ;
      end process ;
   end block L1 ;
end ARCH00015 ;
--
entity ENT00015_Test_Bench is
end ENT00015_Test_Bench ;
architecture ARCH00015_Test_Bench of ENT00015_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
--
      for CIS1 : UUT use entity WORK.GENERIC_STANDARD_TYPES ( ARCH00015 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00015_Test_Bench ;
--
