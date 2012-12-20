-- NEED RESULT: ARCH00307: Record types passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00307
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    3.2.2 (1)
--    3.2.2 (2)
--    3.2.2 (3)
--    3.2.2 (4)
--    3.2.2 (5)
--    3.2.2 (6)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00307(ARCH00307)
--    ENT00307_Test_Bench(ARCH00307_Test_Bench)
--
-- REVISION HISTORY:
--
--    27-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
entity ENT00307 is
   generic ( gen1 : integer := 2;
             gen2 : integer := 4) ;
end ENT00307 ;

architecture ARCH00307 of ENT00307 is
   -- this tests 3.2.2 (6)
   function f ( v1, v2 : integer ) return integer is
      type t1 is array (v1 to 10) of boolean;
      type t2 is array (v1 to v2) of bit;
      type t3 is array (1 to v2) of integer;
      type rec is record
                     a1 : t1 ;
                     a2 : t2 ;
                     a3 : t3 ;
	          end record ;
      variable x1 : t1 ;
      variable x2 : t2 ;
      variable x3 : t3 ;
      variable r : rec ;
      variable z : integer := 0 ;
   begin
      for i in v1 to 10 loop
         x1(i) := boolean'val( i mod 2) ;
      end loop ;
      for i in v1 to v2 loop
         if x1(i) then
            x2(i) := '1' ;
         else
            x2(i) := '0' ;
         end if ;
      end loop ;
      for i in 1 to v2 loop
         x3(i) := i ;
      end loop ;
      r.a1 := x1 ;
      r.a2 := x2 ;
      r.a3 := x3 ;
      for i in 1 to v2 loop
         z := z + r.a3(i) ;
      end loop ;
      if (r.a1(v1) = true) or (r.a1(v1+1) = false) then
         return 0 ;
      elsif (r.a2(v1) = '1') or (r.a2(v2) = '0') then
         return 0 ;
      else
         return z ;
      end if ;
   end f ;
begin
   P :
   process
      type t1 is array (1 to 10) of boolean;
      type t2 is array (gen1 to gen2) of bit;
      -- this tests 3.2.2 (1) and 3.2.2 (3)
      type record_with_one_decl is record
				      b : boolean ;
				   end record ;
      variable r_1 : record_with_one_decl ;
      -- this tests 3.2.2 (2)
      type record_with_many_decls is record
				        bi : bit ;
				        bo : boolean ;
				        i  : integer ;
				        c : character ;
				        e : t_enum1 ;
				     end record ;
      variable r_2 : record_with_many_decls ;
      -- this tests 3.2.2 (4)
      type record_with_one_decl_many_elements is record
				                    b1,b2,b3 : boolean ;
				                 end record ;
      variable r_1_2 : record_with_one_decl_many_elements ;
      -- this tests 3.2.2 (5)
      type record_with_array_elements is record
			   	            a1 : t1 ;
				            a2 : t2 ;
				         end record ;
      variable r_2a : record_with_array_elements ;
   begin
      r_1.b  := true ;
      r_2.bi := '1' ;
      r_2.bo := true ;
      r_2.i  := 5 ;
      r_2.c  := 'x' ;
      r_2.e  := en3 ;
      r_1_2.b1 := true ;
      r_1_2.b2 := false ;
      r_1_2.b3 := true ;
      for i in 1 to 10 loop
         r_2a.a1(i) := boolean'val( i mod 2) ;
      end loop ;
      for i in gen1 to gen2 loop
         if r_2a.a1(i) then
            r_2a.a2(i) := '1' ;
         else
            r_2a.a2(i) := '0' ;
         end if ;
      end loop ;
      test_report ( "ARCH00307" ,
		    "Record types" ,
		    (f (2, 3) = 6) and
                    (r_1.b = true ) and
                    (r_2.bi = '1') and
                    (r_2.bo = true) and
                    (r_2.i  = 5) and
                    (r_2.c  = 'x') and
                    (r_2.e  = en3) and
                    (r_1_2.b1 = true) and
                    (r_1_2.b2 = false) and
                    (r_1_2.b3 = true) and
                    (r_2a.a1(1) = true) and
                    (r_2a.a1(2) = false) and
                    (r_2a.a1(9) = true) and
                    (r_2a.a1(10) = false) and
                    (r_2a.a2(gen1) = '0') and
                    (r_2a.a2(gen1+1) = '1') and
                    (r_2a.a2(gen2) = '0')
                  ) ;
      wait ;
   end process P ;
end ARCH00307 ;

entity ENT00307_Test_Bench is
end ENT00307_Test_Bench ;

architecture ARCH00307_Test_Bench of ENT00307_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00307 ( ARCH00307 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00307_Test_Bench ;

