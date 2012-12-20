-- NEED RESULT: ARCH00480: Multi-dimensional aggregates passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

-- 
-- TEST NAME: 
-- 
--    CT00480 
-- 
-- AUTHOR: 
-- 
--    A. Wilmot 
-- 
-- TEST OBJECTIVES: 
-- 
--    7.3.2.2 (1)
-- 
-- DESIGN UNIT ORDERING: 
--
--    E00000(ARCH00480)
--    ENT00480_Test_Bench(ARCH00480_Test_Bench)
--
-- REVISION HISTORY: 
-- 
--     7-AUG-1987   - initial revision
-- 
-- NOTES:
-- 
--    self-checking
-- 
use WORK.STANDARD_TYPES.all ;
architecture ARCH00480 of E00000 is
begin
   B1 :
   block
      type arr_1 is array ( integer range <> , boolean range <> ,
                           integer range <> ) of string ( 1 to 3 ) ;
   begin
      process
	 variable bool : boolean := true ; 
	 subtype range1 is integer range 1 to 3 ; 
	 subtype range2 is boolean range true downto false ; 
	 subtype range3 is integer range 2 downto 1 ; 
	 subtype st_arr_1 is arr_1 ( range1 , range2 , range3 ) ; 
	 variable v_arr_1, v_arr_2 : st_arr_1 ;
         type t1 is array ( 1 to 3 ) of character ;
         type t2 is array ( false to true ) of character ;
         type t3 is array ( 1 to 2 ) of character ;
         variable char1 : t1 ;
         variable char2 : t2 ;
         variable char3 : t3 ;
      begin
         char1(1) := '1' ; char1(2) := '2' ; char1(3) := '3' ;
         char2(false) := 'f' ; char2(true) := 't' ;
         char3(1) := '1' ; char3(2) := '2' ;
-- named associations
	 v_arr_1 := ( 1 => ( false => ( 1 => ( '1', 'f', '1'),
                                        2 => ( '1', 'f', '2') ),
                             true =>  ( 1 => ( '1', 't', '1'),
                                        2 => ( '1', 't', '2') ) ),
                      2 => ( false => ( 1 => ( '2', 'f', '1'),
                                        2 => ( '2', 'f', '2') ),
                             true =>  ( 1 => ( '2', 't', '1'),
                                        2 => ( '2', 't', '2') ) ),
                      3 => ( false => ( 1 => ( '3', 'f', '1'),
                                        2 => ( '3', 'f', '2') ),
                             true =>  ( 1 => ( '3', 't', '1'),
                                        2 => ( '3', 't', '2') ) ) ) ;
-- positional association
	 v_arr_2 := 
           (           
                       ( 
                         ( 
                           ( char1(1), char2(true), char3(2)),
                           ( char1(1), char2(true), char3(1)) 
                         ),
                         ( 
                           ( char1(1), char2(false), char3(2)),
                           ( char1(1), char2(false), char3(1)) 
                         ) 
                       ),
                       ( 
                         ( 
                           ( char1(2), char2(true), char3(2)),
                           ( char1(2), char2(true), char3(1)) 
                         ),
                         ( 
                           ( char1(2), char2(false), char3(2)),
                           ( char1(2), char2(false), char3(1)) 
                         ) 
                       ),
             others => ( 
                                  ( 
                                    ( char1(3), char2(true), char3(2)),
                                    ( char1(3), char2(true), char3(1)) 
                                  ),
                        others => ( 
                                             ( char1(3), char2(false), char3(2)),
                                   others => ( char1(3), char2(false), char3(1)) 
                                  ) 
                       ) 
           ) ;
	 for i in range1 loop
	    for j in range2 loop
	       for k in range3 loop
		  bool := bool and
                    v_arr_1 (i, j, k) = 
                    char1(i) & char2(j) & char3(k) ;
	       end loop ;
	    end loop ;
	 end loop ;
	 for i in range1 loop
	    for j in range2 loop
	       for k in range3 loop
		  bool := bool and
                    v_arr_2 (i, j, k) = 
                    char1(i) & char2(j) & char3(k) ;
	       end loop ;
	    end loop ;
	 end loop ;
         test_report ( "ARCH00480" ,
		       "Multi-dimensional aggregates" ,
		       bool ) ;
         wait ;
      end process ;
   end block B1 ;
end ARCH00480 ;

entity ENT00480_Test_Bench is
end ENT00480_Test_Bench ;
 
architecture ARCH00480_Test_Bench of ENT00480_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
 
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00480 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00480_Test_Bench ;
