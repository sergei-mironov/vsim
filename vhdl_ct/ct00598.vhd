-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00598
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    6.3 (5)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00598)
--    ENT00598_Test_Bench(ARCH00598_Test_Bench)
--
-- REVISION HISTORY:
--
--    21-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES; use STANDARD_TYPES.all ;
architecture ARCH00598 of E00000 is
begin
   P :
   process
      function f ( x : integer ) return STANDARD_TYPES.st_rec3 is
         variable a : STANDARD_TYPES.st_rec3 := c_st_rec3_2 ;
      begin
	 return a ;
      end f ;
      function "+" ( a,b : STANDARD_TYPES.st_rec3 )
                                           return STANDARD_TYPES.st_rec3 is
         variable c : STANDARD_TYPES.st_rec3 ;
      begin
         "+".c := a ;                     -- prefix is an operator symbol
	 return c ;
      end "+" ;
      variable b1,b2,b3,b4,b5 : boolean := c_boolean_1 ;
      variable j : integer := 3 ;
      variable a : STANDARD_TYPES.st_rec3 := c_st_rec3_2;
      variable b : STANDARD_TYPES.st_arr3 := c_st_arr3_2;
      attribute rec_attr : STANDARD_TYPES.st_rec3 ;
      attribute rec_attr of a : variable is c_st_rec3_2 ;
   begin
      b1 := a.f1 ;                        -- prefix is a simple name
      b2 := a.f2.f1 ;                     -- prefix is a selected name
      b3 := b(b'left(1),b'left(2)).f1 ;   -- prefix is an indexed name
      b4 := f(j).f1 ;                     -- prefix is a function call
      b5 := a'rec_attr.f1 ;               -- prefix is an attribute name

      test_report ( "ARCH00598" ,
		    "Prefixes of selected names" ,
		    (b1 = c_boolean_2) and
		    (b2 = c_boolean_2) and
		    (b3 = c_boolean_2) and
		    (b4 = c_boolean_2) and
		    (b5 = c_boolean_2)
                  ) ;
      wait ;
   end process P ;
end ARCH00598 ;
--
entity ENT00598_Test_Bench is
end ENT00598_Test_Bench ;

architecture ARCH00598_Test_Bench of ENT00598_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00598 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00598_Test_Bench ;
--
