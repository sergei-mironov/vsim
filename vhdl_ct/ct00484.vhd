-- NEED RESULT: ARCH00484: Function parameters of standard types or locally static size passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00484
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    2.1.1 (6)
--    2.1.1 (7)
--    2.1.1 (9)
--    2.1.1 (12)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00484)
--    ENT00484_Test_Bench(ARCH00484_Test_Bench)
--
-- REVISION HISTORY:
--
--     7-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00484 of E00000 is
begin
   P :
   process

      -- this will test 2.1.1 (6) and 2.1.1 (12)
      function f_1 ( bi : bit ;
		     bv : bit_vector ;  -- this tests 2.1.1 (12)
                     bo : boolean ;
                     c : character ;
                     i : integer ;
                     r : real ;
                     s : string ;
                     t : time) return integer is
	 variable n : integer := 0 ;
      begin
	 if bi = '1' then
	    n := n + 1 ;
	 end if ;
	 if bv(2) = '0' then
	    n := n + 1 ;
	 end if ;
	 if bo = true then
	    n := n + 1 ;
	 end if ;
 	 if c = '!' then
	    n := n + 1 ;
	 end if ;
	 if i = 100 then
	    n := n + 1 ;
	 end if ;
	 if r = 100.0 then
	    n := n + 1 ;
	 end if ;
	 if s(2) = 'a' then
	    n := n + 1 ;
	 end if ;
	 if t = 100 ns then
	    n := n + 1 ;
	 end if ;
	 return n ;
      end f_1 ;

      -- this will test 2.1.1 (7)
      -- (the various types are in STANDARD_TYPES)
      function f_2 ( t_en : t_enum1 ;
 		     st_en : st_enum1 ;
                     t_in : t_int1 ;
                     st_in : st_int1 ;
                     t_ph : t_phys1 ;
                     st_ph : st_phys1 ;
                     t_re : t_real1 ;
                     st_re : st_real1 ) return integer is
	 variable n : integer := 0 ;
      begin
	 if t_en = en2 then
	    n := n + 1 ;
	 end if ;
	 if st_en = en3 then
	    n := n + 1 ;
	 end if ;
	 if t_in = 10 then
	    n := n + 1 ;
	 end if ;
 	 if st_in = 12 then
	    n := n + 1 ;
	 end if ;
	 if t_ph = phys1_3 then
	    n := n + 1 ;
	 end if ;
	 if st_ph = phys1_4 then
	    n := n + 1 ;
	 end if ;
	 if t_re = 10.0 then
	    n := n + 1 ;
	 end if ;
	 if st_re = 12.0 then
	    n := n + 1 ;
	 end if ;
	 return n ;
      end f_2 ;

      -- this will test 2.1.1 (9)
      -- (the various types are in STANDARD_TYPES)
      function f_3 ( t_ar : t_arr1 ;  -- this tests 2.1.1 (12) again
 		     st_ar : st_arr1 ;
                     t_r1 : t_rec1 ;
                     t_r3 : t_rec3 ) return integer is
	 variable n : integer := 0 ;
      begin
	 if t_ar(2) = c_st_int1_1 then
	    n := n + 1 ;
	 end if ;
	 if st_ar(2) = c_st_int1_2 then
	    n := n + 1 ;
	 end if ;
	 if t_r1.f2 = c_time_1 then
	    n := n + 1 ;
	 end if ;
 	 if t_r3.f1 = c_boolean_1 then
	    n := n + 1 ;
	 end if ;
	 return n ;
      end f_3 ;

      variable b_vect : bit_vector (0 to 2) ;

   begin
      b_vect(0) := '0' ;
      b_vect(1) := '1' ;
      b_vect(2) := '0' ;
      test_report ( "ARCH00484" ,
	      "Function parameters of standard types or locally static size" ,
	      (f_1('1', b_vect, true, '!', 100, 100.0, "cat", 100 ns) = 8) and
              (f_2(en2, en3, 10, 12, phys1_3, phys1_4, 10.0, 12.0) = 8) and
              (f_3(c_st_arr1_1, c_st_arr1_2, c_t_rec1_1, c_t_rec3_1) = 4)
                  ) ;
      wait ;
   end process P ;
end ARCH00484 ;

entity ENT00484_Test_Bench is
end ENT00484_Test_Bench ;

architecture ARCH00484_Test_Bench of ENT00484_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00484 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00484_Test_Bench ;

