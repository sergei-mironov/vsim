-- NEED RESULT: ARCH00477: Functions can return dynamically sized objects passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00477
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    2.1 (11)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00477)
--    ENT00477_Test_Bench(ARCH00477_Test_Bench)
--
-- REVISION HISTORY:
--
--     6-AUG-1987   - initial revision
--    11-DEC-1989   - GDT: added parameter "n" to function record_func to
--                         eliminate global reference.
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00477 of E00000 is

   function array_func ( n,x : integer ) return t_arr1 is
      variable a : t_arr1 (lowb to n) ;
   begin
      for i in lowb to n loop
	 a(i) := st_int1 ( x + i ) ;
      end loop ;
      return a;
   end array_func ;

   procedure proc ( n : in integer ;
		    b : out boolean ;
                    x : out integer ) is
      type rec is record
		     bo : boolean ;
		     a : t_arr1 (lowb to n) ;
		  end record ;
      variable rr : rec ;
      function record_func ( k,n : integer ) return rec is
	 variable r : rec ;
      begin
         r.bo := true ;
	 for i in lowb to n loop
	    r.a(i) := st_int1 ( k + i ) ;
	 end loop ;
	 return r;
      end record_func ;
   begin
      rr := record_func(13, n) ;
      b := rr.bo ;
      x := integer ( rr.a(n-1) ) ;
   end proc ;

begin
   P :
   process
      variable b : boolean;
      variable x : integer;
   begin
      proc (10, b, x) ;
      test_report ( "ARCH00477" ,
		    "Functions can return dynamically sized objects" ,
                    (b = true) and
                    (x = 13+10-1) and
		    (array_func(10,15) (9) = 15+9)
                  ) ;
      wait ;
   end process P ;
end ARCH00477 ;

entity ENT00477_Test_Bench is
end ENT00477_Test_Bench ;

architecture ARCH00477_Test_Bench of ENT00477_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00477 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00477_Test_Bench ;

