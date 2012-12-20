-- NEED RESULT: ARCH00593: Resolution functions may appear in subtype indications  used in signal and non-signal declaration passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00593
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.2 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00593)
--    ENT00593_Test_Bench(ARCH00593_Test_Bench)
--
-- REVISION HISTORY:
--
--    26-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00593 of E00000 is
    subtype rst_integer is bf_integer integer ;
    signal s_integer : bf_integer integer := c_integer_1;

    subtype rst_arr1 is bf_arr1 t_arr1 (lowb to highb) ;
    signal s_arr1 : rst_arr1 := c_st_arr1_1;

    subtype rst_rec2 is bf_rec2 st_rec2 ;
    signal s_rec2 : rst_rec2 := c_t_rec2_1;

    signal toggle : boolean := false ;
begin
   process
      variable v_integer : bf_integer integer := 1 ;
      variable v_arr1 : rst_arr1 ;
      variable v_rec2 : rst_rec2 ;
   begin
      v_integer := v_integer + 1 ;
      s_integer <= v_integer ;

      for i in lowb to highb loop
	 v_arr1(i) := st_int1 ( i + 10) ;
      end loop ;
      s_arr1 <= v_arr1(lowb to highb) ;

      v_rec2 := (true, (1, 10 ns, false, 1.0), 2 fs) ;
      s_rec2 <= v_rec2 ;
      toggle <= true ;
      wait ;
   end process ;
   process
      variable v_integer : rst_integer := 2 ;
      variable v_arr1 : bf_arr1 t_arr1 (highb downto lowb) ;
      variable v_rec2 : rst_rec2 ;
   begin
      v_integer := v_integer + 1 ;
      s_integer <= v_integer ;

      for i in lowb to highb loop
	 v_arr1(i) := st_int1 ( i + 10) ;
      end loop ;
      s_arr1 <= v_arr1(highb downto lowb) ;

      v_rec2 := (false, (2, 15 ns, true, 2.0), 3 fs) ;
      s_rec2 <= v_rec2 ;
      wait ;
   end process ;
   process ( s_integer, s_arr1, s_rec2 )
   begin
      if toggle then
	 test_report ( "ARCH00593" ,
		       "Resolution functions may appear in subtype indications "
                       & " used in signal and non-signal declaration" ,
		       s_integer = 5 and
                       s_arr1 = st_arr1'(others => st_int1 ( highb+lowb+20)) and
                       s_rec2 = (true, (3, 25 ns, true, 3.0), 5 fs) ) ;
      end if ;
   end process ;
end ARCH00593 ;
--
entity ENT00593_Test_Bench is
end ENT00593_Test_Bench ;

architecture ARCH00593_Test_Bench of ENT00593_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00593 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00593_Test_Bench ;
--
