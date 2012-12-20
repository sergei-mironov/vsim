-- NEED RESULT: ARCH00699: Formal generics with default expression may be left unassociated in an association list passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00699
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.3.2 (6)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00699(ARCH00699)
--    ENT00699_Test_Bench(ARCH00699_Test_Bench)
--
-- REVISION HISTORY:
--
--    09-SEP-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
entity ENT00699 is
   generic (
             g_integer : integer := 5 ;
             g_boolean : boolean := false ;
             g_st_arr3 : st_arr3 := c_st_arr3_2 ;
             g_st_rec3 : st_rec3 := c_st_rec3_2
          ) ;
end ENT00699 ;
--
architecture ARCH00699 of ENT00699 is
begin
   process
   begin
      test_report ( "ARCH00699" ,
		    "Formal generics with default expression may be left"
                    & " unassociated in an association list",
		    g_integer = 5 and not g_boolean and
                    g_st_arr3 = c_st_arr3_2 and g_st_rec3 = c_st_rec3_1) ;
      wait ;
   end process ;
end ARCH00699 ;
--
use WORK.STANDARD_TYPES.all ;
entity ENT00699_Test_Bench is
end ENT00699_Test_Bench ;
--
architecture ARCH00699_Test_Bench of ENT00699_Test_Bench is
begin
   L1:
   block
      component UUT
         generic (
                   lg_st_rec3 : st_rec3
                 ) ;
      end component ;
      for CIS1 : UUT use entity WORK.ENT00699 ( ARCH00699 )
                            generic map (
                                          g_boolean => false ,
                                          g_st_arr3 => c_st_arr3_2 ,
                                          g_st_rec3 => lg_st_rec3
                                        ) ;
   begin
      CIS1 : UUT
         generic map ( lg_st_rec3 => c_st_rec3_1 ) ;
   end block L1 ;
end ARCH00699_Test_Bench ;
--
