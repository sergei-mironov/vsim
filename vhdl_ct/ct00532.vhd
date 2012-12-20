-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00532
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
--    ENT00532(ARCH00532)
--    ENT00532_Test_Bench(ARCH00532_Test_Bench)
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
entity ENT00532 is
end ENT00532 ;
--
architecture ARCH00532 of ENT00532 is
   type rec_1 is record
		    f1 : bit ;
		    f2 : boolean ;
		    f3 : bit_vector ( 0 to 3 ) ;
		 end record ;
   type arr_1 is array ( severity_level range <> , integer range <> ) of rec_1 ;
--

   procedure p1 (
                 c1 : integer := -5 ;
                 c2 : integer := 5 ;
                 c3 : severity_level := warning ;
                 c4 : severity_level := error
                ) is
      subtype c_st1 is integer range c1 to c2 ;
      subtype c_st2 is integer range c2 downto 0 ;
      subtype c_st3 is severity_level range c3 to c4 ;
      subtype c_st4 is severity_level range c4 downto warning ;
      subtype c_st_arr_1 is arr_1 ( c_st3, c_st2 ) ;
--
      variable v_1 : c_st1 ;
      variable v_2 : c_st2 ;
      variable v_3 : c_st3 ;
      variable v_4 : c_st4 ;
      variable v_rec_1, v_rec_2 : rec_1 ;
      variable v_st_arr_1, v_st_arr_2 : c_st_arr_1 ;

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
      for i in c_st3 loop
	 for j in c_st2 loop
             v_st_arr_1(i, j) := v_rec_1 ;
	 end loop ;
      end loop ;
      v_st_arr_2 := v_st_arr_1 ;

--
      correct := correct and
                c_st1'( v1 + v2 ) = 0 and
                c_st2'( v1 + 2 * v2 ) = v2 and
                c_st3'( v4 ) = v4 and
                c_st4'( severity_level'pred(v4) ) = v3 and
                c_st_arr_1'( v_st_arr_2 ) = v_st_arr_1 and
                arr_1'( v_st_arr_1 ) = v_st_arr_2 and
                rec_1'( v_rec_1 ) = v_rec_1 ;

      test_report ( "ARCH00532" ,
		    "Qualified expressions (dynamic subtypes)"
                    & " (no aggregates)" ,
		    correct ) ;
      wait ;
   end p1 ;
begin
   process
   begin
      p1 ;
   end process ;
end ARCH00532 ;
--
entity ENT00532_Test_Bench is
end ENT00532_Test_Bench ;

architecture ARCH00532_Test_Bench of ENT00532_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00532 ( ARCH00532 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00532_Test_Bench ;
--
