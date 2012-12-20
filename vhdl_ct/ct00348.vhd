-- NEED RESULT: ARCH00348: Attribute names passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00348
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    6.6 (1)
--    6.6 (2)
--    6.6 (3)
--    6.6 (4)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00348(ARCH00348)
--    ENT00348_Test_Bench(ARCH00348_Test_Bench)
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
entity ENT00348 is
   generic ( g : integer := 5 ) ;
begin
end ENT00348 ;

architecture ARCH00348 of ENT00348 is
   type array_array is array ( 1 to 4 ) of WORK.STANDARD_TYPES.st_arr1 ;
begin
   P :
   process
      function f ( x : integer ) return WORK.STANDARD_TYPES.st_arr1 is
         variable a : WORK.STANDARD_TYPES.st_arr1 ;
      begin
	 return a ;
      end f ;
      function "+" ( a,b : WORK.STANDARD_TYPES.st_arr1 )
                                           return WORK.STANDARD_TYPES.st_arr1 is
         variable c : WORK.STANDARD_TYPES.st_arr1 ;
      begin
         for i in st_arr1'range loop
            c(i) := a(i) + b(i) ;
         end loop ;
	 return c ;
      end "+" ;
      variable i1,i2,i3,i4,i5,i6,i7,i8,i9,j : integer := 3 ;
      variable b : boolean ;
      variable a1 : WORK.STANDARD_TYPES.st_arr1 := c_st_arr1_2;
      variable a2 : WORK.STANDARD_TYPES.st_arr2 := c_st_arr2_2;
      variable a_a : array_array ;
   begin
      -- these test 6.6 (1)
      i1 := st_arr1'left ;                    -- prefix is a simple name
      i2 := WORK.STANDARD_TYPES.st_arr1'left ;     -- prefix is a selected name
      i3 := a2(1,b)'left ;                    -- prefix is an indexed name
      i4 := a1(2 to 4)'left ;                 -- prefix is a slice name
--    i5 := f(j)'left ;        -- prefix is a function call (not legal)
--    i6 := P."+"'left ;       -- prefix is an operator symbol (not legal)

      i7 := a_a(1)'right ;    -- this tests 6.6 (2)
      i8 := a_a(g-2)'right ;  -- this tests 6.6 (3)
      i9 := a_a(j+1)'right ;  -- this tests 6.6 (4)

      test_report ( "ARCH00348" ,
		    "Attribute names" ,
		    (i1 = lowb) and
		    (i2 = lowb) and
		    (i3 = lowb) and
		    (i4 = 2)    and
--		    (i5 = lowb) and   -- taken out
--		    (i6 = lowb) and   -- taken out
		    (i7 = highb)   and
		    (i8 = highb)   and
		    (i9 = highb)
                  ) ;
      wait ;
   end process P ;
end ARCH00348 ;

entity ENT00348_Test_Bench is
end ENT00348_Test_Bench ;

architecture ARCH00348_Test_Bench of ENT00348_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00348 ( ARCH00348 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00348_Test_Bench ;

