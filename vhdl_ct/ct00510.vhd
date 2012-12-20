-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00510
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    2.1.1 (11)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00510)
--    ENT00510_Test_Bench(ARCH00510_Test_Bench)
--
-- REVISION HISTORY:
--
--    10-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00510 of E00000 is
   procedure proc ( n : in integer ;
		    b : in boolean ;
                    x,y : out t_int1 ) is
      subtype ary is t_arr1 (lowb to n) ;
      type rec is record
		     bo : boolean ;
		     a : ary ;
		  end record ;
      variable rr : rec ;
      function record_func ( n : integer; r : rec ) return t_int1 is
      begin
         if r.bo then
            return r.a(n) ;
         else
            return r.a(n) + 20;
         end if ;
      end record_func ;
      function array_func ( n : integer; a : ary ) return t_int1 is
      begin
         return a(n-1) + a(n) ;
      end array_func ;
   begin
      rr.bo := b ;
      for i in lowb to n loop
	 rr.a(i) := t_int1(i + 10) ;
      end loop ;
      x := record_func(n, rr) ;
      y := array_func(n, rr.a) ;
   end proc ;
begin
   P :
   process
      variable x1,y1,x2,y2 : t_int1 ;
   begin
      proc ( 5, true, x1, y1 ) ;
      proc ( 5, false, x2, y2 ) ;
      test_report ( "ARCH00510" ,
		    "Parameters can be dynamically sized" ,
		    (x1 = 5+10) and
                    (y1 = 4+10 + 5+10) and
                    (x2 = x1+20) and
                    (y2 = y1)
                  ) ;
      wait ;
   end process P ;
end ARCH00510 ;

entity ENT00510_Test_Bench is
end ENT00510_Test_Bench ;

architecture ARCH00510_Test_Bench of ENT00510_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00510 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00510_Test_Bench ;

