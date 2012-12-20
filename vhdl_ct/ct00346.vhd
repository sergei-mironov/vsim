-- NEED RESULT: ARCH00346: Indexed names passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00346
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    6.4 (1)
--    6.4 (2)
--    6.4 (3)
--    6.4 (4)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00346(ARCH00346)
--    ENT00346_Test_Bench(ARCH00346_Test_Bench)
--
-- REVISION HISTORY:
--
--    30-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
entity ENT00346 is
   generic ( g : integer := 2 ) ;
begin
end ENT00346 ;

architecture ARCH00346 of ENT00346 is
begin
   P :
   process
      function f ( x : integer ) return st_arr1 is
         variable a : st_arr1 := c_st_arr1_2 ;
      begin
	 return a ;
      end f ;
      function "+" ( a,b : st_arr1 )
                                           return st_arr1 is
         variable c : st_arr1 ;
      begin
         for i in st_arr1'range loop
            c(i) := a(i) + b(i) ;
         end loop ;
	 return c ;
      end "+" ;
      variable i1,i2,i3,i4,i5,i6,i7,i8,i9 : t_int1 := 3;
      variable j : integer := 3 ;
      variable b : boolean ;
      variable a : st_arr1 := c_st_arr1_2 ;
      variable r : st_rec3 := c_st_rec3_2 ;
      constant c_integer_2 : integer := 10;
   begin
      i1 := a(1) ;    -- this tests 6.4 (2)
      i2 := a(g-1) ;  -- this tests 6.4 (3)
      i3 := a(j+1) ;  -- this tests 6.4 (4)

      -- these test 6.4 (1)
      i4 := a (1) ;                 -- prefix is a simple name
      i5 := r.f3 (lowb,false) (1);  -- prefix of (lowb,false) is a selected name
                                    -- prefix of (1) is an indexed name
      i6 := a (2 to 4) (j) ;        -- prefix of (j) is a slice name
      i7 := f(j) (1) ;              -- prefix is a function call
      i8 := "+" (a,a) (1) ;         -- prefix of (a,a) is an operator symbol
      i9 := t_int1(a'left(1)) ;     -- prefix is an attribute name

      test_report ( "ARCH00346" ,
		    "Indexed names" ,
		    (i1 = t_int1( c_integer_2 - 1))
                and (i2 = t_int1( c_integer_2 - 1))
                and (i3 = t_int1( c_integer_2 - 1))
                and (i4 = t_int1( c_integer_2 - 1))
                and (i5 = t_int1( c_integer_2 - 1))
                and (i6 = t_int1( c_integer_2 - 1))
                and (i7 = t_int1( c_integer_2 - 1))
                and (i8 = 2*t_int1( c_integer_2 - 1))
                and (i9 = t_int1(lowb))
                  ) ;
      wait ;

   end process P ;
end ARCH00346 ;

entity ENT00346_Test_Bench is
end ENT00346_Test_Bench ;

architecture ARCH00346_Test_Bench of ENT00346_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00346 ( ARCH00346 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00346_Test_Bench ;

