-- NEED RESULT: ARCH00654: Access types and functions passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00654
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    2.1 (12)        (FOR ACCESS TYPES ONLY; FILES TBD)
--    2.1.1 (13)      (FOR ACCESS TYPES ONLY; FILES TBD)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00654)
--    ENT00654_Test_Bench(ARCH00654_Test_Bench)
--
-- REVISION HISTORY:
--
--    26-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00654 of E00000 is
begin
   P :
   process
      type rec is record
		     i,j : integer ;
		  end record ;
      type acc is access rec ;
      variable b, a : acc ;
      variable i : integer ;

      function f ( a : rec ) return acc is        -- this tests 2.1 (12)
         variable b : acc ;
      begin
         b := new rec ;
         b.all := a ;
	 return b ;
      end f ;
      function g ( a : rec ) return integer is    -- this tests 2.1.1 (13)
      begin
	 return a.i + a.j ;
      end g ;
      procedure pf ( result : out acc ; variable a : inout acc ) is        -- th
      begin
	 result := a ;
      end pf ;
      procedure pg ( result : out integer; variable a : inout acc ) is    -- thi
      begin
	 result := a.i + a.j ;
      end pg ;
   begin
      a := new rec ;
      a.i := 5 ;
      a.j := 7 ;
      pf(b, a) ;
      pg(i, a) ;

      test_report ( "ARCH00654" ,
		    "Access types and functions" ,
		    (f(a.all).all = a.all) and
                    (g(a.all) = 5+7) and b.all = a.all and i = 5+7
                  ) ;
      wait ;
   end process P ;
end ARCH00654 ;
--
entity ENT00654_Test_Bench is
end ENT00654_Test_Bench ;

architecture ARCH00654_Test_Bench of ENT00654_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00654 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00654_Test_Bench ;
--
