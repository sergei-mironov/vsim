-- NEED RESULT: ARCH00527: f3 passed
-- NEED RESULT: ARCH00527: f4 passed
-- NEED RESULT: ARCH00527: f5 passed
-- NEED RESULT: ARCH00527: f6 passed
-- NEED RESULT: ARCH00527: Actual parameter list present in function calls passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00527
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.3.3 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00527)
--    ENT00527_Test_Bench(ARCH00527_Test_Bench)
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
architecture ARCH00527 of E00000 is
   type arr_1 is array ( boolean range <> , integer range <> ) of bit ;
   type arr_2 is array ( integer range <> ) of integer ;
   type rec_1 is record
		    f1 : boolean ;
		    f2 : integer ;
		 end record ;
   subtype st_arr_1 is arr_1 ( true downto false , 1 to 4 ) ;
   subtype st_arr_2 is arr_2 ( -2 to 3 ) ;
begin
   process
      variable correct : boolean := true ;

      function f1 ( p1 : boolean := false ;
		    p2 : integer := 3 ) return boolean is
      begin
	 return p1 ;
      end f1 ;

      function f2 ( p1 : boolean := false ;
		    p2 : integer := 3 ) return integer is
      begin
	 return p2 ;
      end f2 ;

      function f3 ( p1 : boolean := false ;
		    p2 : integer := 3 ) return arr_1 is
         variable v_st_arr_1 : st_arr_1 ;
      begin
         v_st_arr_1(false, 1) := '1' ;
         v_st_arr_1(false, 2) := '0' ;
         v_st_arr_1(false, 3) := '1' ;
         v_st_arr_1(false, 4) := '0' ;
         v_st_arr_1(true, 1) := '0' ;
         v_st_arr_1(true, 2) := '1' ;
         v_st_arr_1(true, 3) := '0' ;
         v_st_arr_1(true, 4) := '1' ;
	 return v_st_arr_1 ;
      end f3 ;

      function f4 ( p1 : boolean := false ;
		    p2 : integer := 3 ) return st_arr_1 is
      begin
	 return (
            ( '0' , '1', '0', '1' ) ,
            ( '1' , '0', '1', '0' )  ) ;
      end f4 ;

      function f5 ( p1 : boolean := false ;
		    p2 : integer := 3 ) return st_arr_2 is
      begin
	 return (-2, -1, 0, 1, 2, 3) ;
      end f5 ;

      function f6 ( p1 : boolean := false ;
		    p2 : integer := 3 ) return rec_1 is
      begin
	 return (p1, p2) ;
      end f6 ;
   begin

      correct :=  correct and
         f3(false, 3)(false, 1) = '1' and
         f3(false, 3)(false, 2) = '0' and
         f3(false, 3)(false, 3) = '1' and
         f3(false, 3)(false, 4) = '0' and
         f3(false, 3)(true, 1) = '0' and
         f3(false, 3)(true, 2) = '1' and
         f3(false, 3)(true, 3) = '0' and
         f3(false, 3)(true, 4) = '1' ;
      test_report ( "ARCH00527" , "f3", correct);

      correct :=  correct and
         f4(false, 3)(false, 1) = '1' and
         f4(false, 3)(false, 2) = '0' and
         f4(false, 3)(false, 3) = '1' and
         f4(false, 3)(false, 4) = '0' and
         f4(false, 3)(true, 1) = '0' and
         f4(false, 3)(true, 2) = '1' and
         f4(false, 3)(true, 3) = '0' and
         f4(false, 3)(true, 4) = '1' ;
      test_report ( "ARCH00527" , "f4", correct);

      correct :=  correct and
         f5(true, 0)(-2 to 3) = (-2, -1, 0, 1, 2, 3) ;
      test_report ( "ARCH00527" , "f5", correct);

      correct :=  correct and
         f6(false, 3).f1 = false and f6(false, 3).f2 = 3 ;
      test_report ( "ARCH00527" , "f6", correct);

      test_report ( "ARCH00527" ,
		    "Actual parameter list present in function calls" ,
		    correct and f1(false, 53) = false and
                    f2(true, 3) = 3 ) ;
      wait ;
   end process ;
end ARCH00527 ;
--
entity ENT00527_Test_Bench is
end ENT00527_Test_Bench ;

architecture ARCH00527_Test_Bench of ENT00527_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00527 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00527_Test_Bench ;
--
