-- NEED RESULT: ARCH00667: Simple, selected, indexed, slice names in alias decl (variables) passed
-- NEED RESULT: ARCH00667: Simple, selected, indexed, slice names in alias decl (variables) passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00667
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.4 (6)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00667(ARCH00667)
--    ENT00667_Test_Bench(ARCH00667_Test_Bench)
--
-- REVISION HISTORY:
--
--    31-AUG-1987   - initial revision
--     4-APR-1988   - JW: procedures moved inside processes so they can assign
--                    to non-parameter signals
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
entity ENT00667 is
   generic ( g_integer : integer := 5 ) ;
end ENT00667 ;

architecture ARCH00667 of ENT00667 is
   signal s_t_arr1 : st_arr1 ;
   signal s_t_rec3 : st_rec3 ;
   signal s_t_arr3 : st_arr3 ;
   signal s_integer : integer ;
   signal toggle : boolean := false ;
   alias s_al1 : integer is s_integer ;
   alias s_al2 : st_rec2 is s_t_rec3.f2 ;
   alias s_al4 : t_arr1 (g_integer downto 1) is s_t_arr1(1 to g_integer) ;
   alias s_al5 : t_int1 is s_t_arr1(g_integer) ;
   alias s_al6 : t_arr1 (g_integer downto 1) is
         s_t_arr3(g_integer, true).f3(lowb, false)(1 to g_integer) ;
   alias s_al7 : t_int1 is s_al6(2) ;
begin
   process
     procedure p1 is
        variable v_integer : integer ;
        variable v_t_rec3 : st_rec3 ;
        variable v_t_arr1 : st_arr1 ;
        variable v_t_arr3 : st_arr3 ;
        alias v_al1 : integer is v_integer ;
        alias v_al2 : st_rec2 is v_t_rec3.f2 ;
        alias v_al4 : t_arr1 (g_integer downto 1) is v_t_arr1(1 to g_integer) ;
        alias v_al5 : t_int1 is v_t_arr1(g_integer) ;
        alias v_al6 : t_arr1 (g_integer downto 1) is
              v_t_arr3(g_integer, true).f3(lowb, false)(1 to g_integer) ;
        alias v_al7 : t_int1 is v_al6(2) ;
        variable correct : boolean := true ;
     begin
        toggle <= true ;
        v_integer := 1 ;
        v_t_rec3.f2.f1 := false ;
        v_t_rec3.f2.f2.f1 := lowb_i2 ;
        v_t_rec3.f2.f2.f2 := 2 ps ;
        v_t_rec3.f2.f2.f3 := true ;
        v_t_rec3.f2.f2.f4 := 2.5 ;
        v_t_rec3.f2.f3 := 1 ns ;
        for i in 1 to 5 loop
           v_t_arr3(5, true).f3(lowb, false)(i) := t_int1(i) + 11 ;
	   v_t_arr1(i) := t_int1(i) + 11 ;
        end loop ;
        correct := correct and v_integer = 1 and
              v_al2.f1 = false and
              v_al2.f2.f1 = lowb_i2 and
              v_al2.f2.f2 = 2 ps and
              v_al2.f2.f3 = true and
              v_al2.f2.f4 = 2.5 and
              v_al2.f3 = 1 ns ;
        correct := correct and v_al4(g_integer downto 3) = (12, 13, 14) and
                   v_al4(2 downto 1) = (15, 16) ;
        correct := correct and v_al5 = 16 ;
        correct := correct and v_al7 = 15 ;
        test_report ( "ARCH00667" ,
		      "Simple, selected, indexed, slice names in alias decl"
                      & " (variables)" ,
		      correct ) ;
        s_integer <= 1 ;
        s_t_rec3.f2.f1 <= false ;
        s_t_rec3.f2.f2.f1 <= lowb_i2 ;
        s_t_rec3.f2.f2.f2 <= 2 ps ;
        s_t_rec3.f2.f2.f3 <= true ;
        s_t_rec3.f2.f2.f4 <= 2.5 ;
        s_t_rec3.f2.f3 <= 1 ns ;
        for i in 1 to 5 loop
           s_t_arr3(5, true).f3(lowb, false)(i) <= t_int1(i) + 11 ;
	   s_t_arr1(i) <= t_int1(i) + 11 ;
        end loop ;
     end p1 ;
   begin -- process
      p1 ;
      wait ;
   end process ;

   process (toggle)
     procedure p2 is
        variable correct : boolean := true ;
     begin
        correct := correct and
              s_al2.f1 = false and
              s_al2.f2.f1 = lowb_i2 and
              s_al2.f2.f2 = 2 ps and
              s_al2.f2.f3 = true and
              s_al2.f2.f4 = 2.5 and
              s_al2.f3 = 1 ns ;
        correct := correct and s_al4(g_integer downto 3) = (12, 13, 14) and
                   s_al4(2 downto 1) = (15, 16) ;
        correct := correct and s_al5 = 16 ;
        correct := correct and s_al7 = 15 ;
        test_report ( "ARCH00667" ,
		      "Simple, selected, indexed, slice names in alias decl"
                      & " (variables)" ,
		      correct ) ;
     end p2 ;
   begin -- process
      if toggle then
         p2 ;
      end if ;
   end process ;

end ARCH00667 ;
--
entity ENT00667_Test_Bench is
end ENT00667_Test_Bench ;

architecture ARCH00667_Test_Bench of ENT00667_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00667 ( ARCH00667 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00667_Test_Bench ;
--
