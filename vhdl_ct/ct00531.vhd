-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00531
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.3.4 (1)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00531(ARCH00531)
--    ENT00531_Test_Bench(ARCH00531_Test_Bench)
--
-- REVISION HISTORY:
--
--    17-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
entity ENT00531 is
   generic (
             g1 : integer := -5 ;
	     g2 : integer := 5 ;
             g3 : severity_level := warning ;
	     g4 : severity_level := error
            ) ;
end ENT00531 ;
--
architecture ARCH00531 of ENT00531 is
   constant c1 : integer := -5 ;
   constant c2 : integer := 5 ;
   constant c3 : severity_level := warning ;
   constant c4 : severity_level := error ;
   type rec_1 is record
		    f1 : bit ;
		    f2 : boolean ;
		    f3 : bit_vector ( 0 to 3 ) ;
		 end record ;
   type arr_1 is array ( severity_level range <> , integer range <> ) of rec_1 ;
   subtype c_st1 is integer range c1 to c2 ;
   subtype c_st2 is integer range c2 downto 0 ;
   subtype c_st3 is severity_level range c3 to c4 ;
   subtype c_st4 is severity_level range c4 downto warning ;
   subtype c_st_arr_1 is arr_1 ( c_st3, c_st2 ) ;
--
   subtype g_st1 is integer range c1 to c2 ;
   subtype g_st2 is integer range c2 downto 0 ;
   subtype g_st3 is severity_level range c3 to c4 ;
   subtype g_st4 is severity_level range c4 downto warning ;
   subtype g_st_arr_1 is arr_1 ( g_st3, g_st2 ) ;
begin
   process
      constant c2_1 : g_st1 := g_st1'( g1 + g2 ) ;
      constant c2_2 : g_st2 := g_st2'( g1 + 2 * g2 ) ;
      constant c2_3 : g_st3 := g_st3'( g4 ) ;
      constant c2_4 : g_st4 := g_st4'( severity_level'pred(g4) ) ;
--
      variable v_1 : g_st1 ;
      variable v_2 : g_st2 ;
      variable v_3 : g_st3 ;
      variable v_4 : g_st4 ;
      variable v_rec_1, v_rec_2 : rec_1 ;
      variable v_st_arr_1, v_st_arr_2 : g_st_arr_1 ;

      variable v1 : integer := -5 ;
      variable v2 : integer := 5 ;
      variable v3 : severity_level := warning ;
      variable v4 : severity_level := error ;
      variable bool : boolean := true ;
      variable correct : boolean := true ;
   begin
      v_rec_1.f1 := '1' ;
      v_rec_1.f2 := false ;
      v_rec_1.f3 := B"0101" ;
      v_rec_2 := v_rec_1 ;
      for i in g_st3 loop
	 for j in g_st2 loop
             v_st_arr_1(i, j) := v_rec_1 ;
	 end loop ;
      end loop ;
      v_st_arr_2 := v_st_arr_1 ;

      case bool is
	 when (
                c_st1'( c1 + c2 ) = 0 and
                c_st2'( c1 + 2 * c2 ) = c2 and
                c_st3'( c4 ) = c4 and
                c_st4'( severity_level'pred(c4) ) = c3
               ) =>
	    null ;
	 when others =>
	    correct := false ;
      end case ;
--
      correct := correct and c2_1 = 0 and c2_2 = c2 and c2_3 = c4 and
                   c2_4 = c3 ;
--
      correct := correct and
                c_st1'( v1 + v2 ) = 0 and
                c_st2'( v1 + 2 * v2 ) = v2 and
                c_st3'( v4 ) = v4 and
                c_st_arr_1'( v_st_arr_2 ) = v_st_arr_1 and
                arr_1'( v_st_arr_1 ) = v_st_arr_2 and
                rec_1'( v_rec_1 ) = v_rec_1 ;

      correct := correct and
                g_st1'( v1 + v2 ) = 0 and
                g_st2'( v1 + 2 * v2 ) = v2 and
                g_st3'( v4 ) = v4 and
                g_st4'( severity_level'pred(v4) ) = v3 and
                g_st_arr_1'( v_st_arr_2 ) = v_st_arr_1 ;

      test_report ( "ARCH00531" ,
		    "Qualified expressions (generic and static subtypes)"
                    & " (no aggregates)" ,
		    correct ) ;
      wait ;
   end process ;
end ARCH00531 ;
--
entity ENT00531_Test_Bench is
end ENT00531_Test_Bench ;

architecture ARCH00531_Test_Bench of ENT00531_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00531 ( ARCH00531 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00531_Test_Bench ;
--
