-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00521
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.3.2.2 (12)
--    7.3.2.2 (13)
--    7.3.2.2 (16)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00521
--    ENT00521(ARCH00521)
--    ENT00521_Test_Bench(ARCH00521_Test_Bench)
--
-- REVISION HISTORY:
--
--    12-AUG-1987   - initial revision
--    11-APR-1988   - JW: Test was really bogus.
--
-- NOTES:
--
--    self-checking
--
package PKG00521 is
   type rec_1 is record
		    f1 : integer ;
		    f2 : boolean ;
		 end record ;
   subtype brange is integer range 4 downto 0 ;
   subtype crange is integer range 1 downto 1 ;
   subtype drange is integer range 0 to 2 ;
   subtype rev_integer is integer range integer'right downto integer'left ;
   type arr_1 is array ( boolean range <> , rev_integer range <> )
      of rec_1 ;
   type time_matrix is array ( integer range <> , rev_integer range <> )
      of time ;
   type bit_matrix is array ( rev_integer range <> , integer range <> )
      of bit ;
   type bit_arr_vec is array ( rev_integer range <> ) of bit_vector
       ( 0 to 2 ) ;
end PKG00521 ;

use WORK.STANDARD_TYPES.all ;
use WORK.PKG00521.all ;
entity ENT00521 is
   generic (
             g_arr_1 : arr_1 ;
	     g_time_matrix : time_matrix ;
	     g_bit_matrix : bit_matrix ;
	     g_bitarr_vec : bit_arr_vec ;
             g_string : string ;
             g_bit_vector : bit_vector
           ) ;
-- JW: Added default values to ports.
   port (
             p_arr_1 : arr_1 :=
		( true => (1 => (1, true)), false => (1 => (0, false)) ) ;
	     p_time_matrix : time_matrix :=
               ( 0 => (0 => 15 ns, 1=> 15ms, 2 => 15 ps, 3 => 15 fs, 4 => 9 ns),
                 2 => (4 | 3 => 10 ns, 2 => 10 ps, 1 => 10 fs, 0 => 6 ns),
                 1 => (3 => 5 ns, 2 | 1 => 5ms, 0 => 5 fs, 4 => 3 ns) ) ;
	     p_bit_matrix : bit_matrix :=
               ( 4 downto 2 => B"000", 1=> B"010",
                 0 => B"111" ) ;
	     p_bitarr_vec : bit_arr_vec :=
               ( 4 downto 2 => B"000", 1=> B"010",
                 0 => B"111" ) ;
             p_string : string :=
               ( 2 => 'a', 6 => 'c', 1 | 3 to 5 => 'b' ) ;
             p_bit_vector : bit_vector :=
               ( (2 downto 0 => '1') )
        ) ;

   procedure p1 (
             p_arr_1 : arr_1 ;
	     p_time_matrix : time_matrix ;
	     p_bit_matrix : bit_matrix ;
	     p_bitarr_vec : bit_arr_vec ;
             p_string : string ;
             p_bit_vector : bit_vector
                   ) is
      variable correct : boolean := true ;

      subtype rg_arr_11 is boolean range g_arr_1'range(1) ;
      subtype rg_arr_12 is integer range g_arr_1'range(2) ;
      subtype rg_time_matrix1 is integer range g_time_matrix'range(1) ;
      subtype rg_time_matrix2 is integer range g_time_matrix'range(2) ;
      subtype rg_bit_matrix1 is integer range g_bit_matrix'range(1) ;
      subtype rg_bit_matrix2 is integer range g_bit_matrix'range(2) ;
      subtype rg_bitarr_vec1 is integer range g_bitarr_vec'range(1) ;
      subtype rg_string is integer range g_string'range ;
      subtype rg_bit_vector is integer range g_bit_vector'range ;

      subtype rp_arr_11 is boolean range p_arr_1'range(1) ;
      subtype rp_arr_12 is integer range p_arr_1'range(2) ;
      subtype rp_time_matrix1 is integer range p_time_matrix'range(1) ;
      subtype rp_time_matrix2 is integer range p_time_matrix'range(2) ;
      subtype rp_bit_matrix1 is integer range p_bit_matrix'range(1) ;
      subtype rp_bit_matrix2 is integer range p_bit_matrix'range(2) ;
      subtype rp_bitarr_vec1 is integer range p_bitarr_vec'range(1) ;
      subtype rp_string is integer range p_string'range ;
      subtype rp_bit_vector is integer range p_bit_vector'range ;
   begin
      correct := correct and rg_arr_11'left <= rg_arr_11'right ;
      correct := correct and rg_arr_11'left = false and
                             rg_arr_11'right = true ;
      correct := correct and rg_arr_12'right <= rg_arr_12'left ;
      correct := correct and rg_arr_12'left = 1 and
                             rg_arr_12'right = 1 ;

      correct := correct and rg_time_matrix1'left <=
                             rg_time_matrix1'right ;
      correct := correct and rg_time_matrix1'left = 0 and
                             rg_time_matrix1'right = 2 ;
      correct := correct and rg_time_matrix2'right <=
                             rg_time_matrix2'left ;
      correct := correct and rg_time_matrix2'left = 4 and
                             rg_time_matrix2'right = 0 ;

      correct := correct and rg_bit_matrix1'right <=
                             rg_bit_matrix1'left ;
      correct := correct and rg_bit_matrix1'left = 4 and
                             rg_bit_matrix1'right = 0 ;
      correct := correct and rg_bit_matrix2'left <=
                             rg_bit_matrix2'right ;
      correct := correct and rg_bit_matrix2'left = integer'left and
                             rg_bit_matrix2'right = integer'left + 2 ;

      correct := correct and rg_bitarr_vec1'right <=
                             rg_bitarr_vec1'left ;
      correct := correct and rg_bitarr_vec1'left = 4 and
                             rg_bitarr_vec1'right = 0 ;

      correct := correct and rg_string'left <=
                             rg_string'right ;
      correct := correct and rg_string'left = 1 and
                             rg_string'right = 6 ;

      correct := correct and rg_bit_vector'left <=
                             rg_bit_vector'right ;
      correct := correct and rg_bit_vector'left = 0 and
                             rg_bit_vector'right = 2 ;

      correct := correct and rp_arr_11'left <= rp_arr_11'right ;
      correct := correct and rp_arr_11'left = false and
                             rp_arr_11'right = true ;
      correct := correct and rp_arr_12'right <= rp_arr_12'left ;
      correct := correct and rp_arr_12'left = 1 and
                             rp_arr_12'right = 1 ;

      correct := correct and rp_time_matrix1'left <=
                             rp_time_matrix1'right ;
      correct := correct and rp_time_matrix1'left = 0 and
                             rp_time_matrix1'right = 2 ;
      correct := correct and rp_time_matrix2'right <=
                             rp_time_matrix2'left ;
      correct := correct and rp_time_matrix2'left = 4 and
                             rp_time_matrix2'right = 0 ;

      correct := correct and rp_bit_matrix1'right <=
                             rp_bit_matrix1'left ;
      correct := correct and rp_bit_matrix1'left = 4 and
                             rp_bit_matrix1'right = 0 ;
      correct := correct and rp_bit_matrix2'left <=
                             rp_bit_matrix2'right ;
      correct := correct and rp_bit_matrix2'left = integer'left and
                             rp_bit_matrix2'right = integer'left + 2 ;

      correct := correct and rp_bitarr_vec1'right <=
                             rp_bitarr_vec1'left ;
      correct := correct and rp_bitarr_vec1'left = 4 and
                             rp_bitarr_vec1'right = 0 ;

      correct := correct and rp_string'left <=
                             rp_string'right ;
      correct := correct and rp_string'left = 1 and
                             rp_string'right = 6 ;

      correct := correct and rp_bit_vector'left <=
                             rp_bit_vector'right ;
      correct := correct and rp_bit_vector'left = 0 and
                             rp_bit_vector'right = 2 ;

      test_report ( "ARCH00521" ,
		    "Named aggregates associated with unconstrained"
                    & " generics and parameters" ,
		    correct ) ;
   end p1 ;
end ENT00521 ;

architecture ARCH00521 of ENT00521 is
begin
   process
      variable correct : boolean := true ;
      subtype rp_arr_11 is boolean range p_arr_1'range(1) ;
      subtype rp_arr_12 is integer range p_arr_1'range(2) ;
      subtype rp_time_matrix1 is integer range p_time_matrix'range(1) ;
      subtype rp_time_matrix2 is integer range p_time_matrix'range(2) ;
      subtype rp_bit_matrix1 is integer range p_bit_matrix'range(1) ;
      subtype rp_bit_matrix2 is integer range p_bit_matrix'range(2) ;
      subtype rp_bitarr_vec1 is integer range p_bitarr_vec'range(1) ;
      subtype rp_string is integer range p_string'range ;
      subtype rp_bit_vector is integer range p_bit_vector'range ;
   begin
      p1 (
               ( true => (1 => (1, true)), false => (1 => (0, false)) ) ,
               ( 0 => (0 => 15 ns, 1=> 15ms, 2 => 15 ps, 3 => 15 fs, 4 => 9 ns),
                 2 => (4 | 3 => 10 ns, 2 => 10 ps, 1 => 10 fs, 0 => 6 ns),
                 1 => (3 => 5 ns, 2 | 1 => 5ms, 0 => 5 fs, 4 => 3 ns) ) ,
               ( 4 downto 2 => B"000", 1=> B"010",
                 0 => B"111" ) ,
               ( 4 downto 2 => B"000", 1=> B"010",
                 0 => B"111" ) ,
               ( 2 => 'a', 6 => 'c', 1 | 3 to 5 => 'b' ) ,
               ( (2 downto 0 => '1') )
         ) ;
      correct := correct and rp_arr_11'left <= rp_arr_11'right ;
      correct := correct and rp_arr_11'left = false and
                             rp_arr_11'right = true ;
      correct := correct and rp_arr_12'right <= rp_arr_12'left ;
      correct := correct and rp_arr_12'left = 1 and
                             rp_arr_12'right = 1 ;

      correct := correct and rp_time_matrix1'left <=
                             rp_time_matrix1'right ;
      correct := correct and rp_time_matrix1'left = 0 and
                             rp_time_matrix1'right = 2 ;
      correct := correct and rp_time_matrix2'right <=
                             rp_time_matrix2'left ;
      correct := correct and rp_time_matrix2'left = 4 and
                             rp_time_matrix2'right = 0 ;

      correct := correct and rp_bit_matrix1'right <=
                             rp_bit_matrix1'left ;
      correct := correct and rp_bit_matrix1'left = 4 and
                             rp_bit_matrix1'right = 0 ;
      correct := correct and rp_bit_matrix2'left <=
                             rp_bit_matrix2'right ;
      correct := correct and rp_bit_matrix2'left = integer'left and
                             rp_bit_matrix2'right = integer'left + 2 ;

      correct := correct and rp_bitarr_vec1'right <=
                             rp_bitarr_vec1'left ;
      correct := correct and rp_bitarr_vec1'left = 4 and
                             rp_bitarr_vec1'right = 0 ;

      correct := correct and rp_string'left <=
                             rp_string'right ;
      correct := correct and rp_string'left = 1 and
                             rp_string'right = 6 ;

      correct := correct and rp_bit_vector'left <=
                             rp_bit_vector'right ;
      correct := correct and rp_bit_vector'left = 0 and
                             rp_bit_vector'right = 2 ;

      test_report ( "ARCH00521" ,
		    "Named aggregates associated with unconstrained"
                    & " signals" ,
		    correct ) ;
      wait ;
   end process ;
end ARCH00521 ;

use WORK.PKG00521.all ;
entity ENT00521_Test_Bench is
end ENT00521_Test_Bench ;

architecture ARCH00521_Test_Bench of ENT00521_Test_Bench is
begin
   L1:
   block
      component UUT
-- JW: Added generic port decls.
        generic (
             g_arr_1 : arr_1 ;
	     g_time_matrix : time_matrix ;
	     g_bit_matrix : bit_matrix ;
	     g_bitarr_vec : bit_arr_vec ;
             g_string : string ;
             g_bit_vector : bit_vector
           ) ;
      end component ;

      for CIS1 : UUT use entity WORK.ENT00521 ( ARCH00521 ) ;
   begin
      CIS1 : UUT
    generic map (
               ( true => (1 => (1, true)), false => (1 => (0, false)) ) ,
               ( 0 => (0 => 15 ns, 1=> 15ms, 2 => 15 ps, 3 => 15 fs, 4 => 9 ns),
                 2 => (4 | 3 => 10 ns, 2 => 10 ps, 1 => 10 fs, 0 => 6 ns),
                 1 => (3 => 5 ns, 2 | 1 => 5ms, 0 => 5 fs, 4 => 3 ns) ) ,
               ( 4 downto 2 => B"000", 1=> B"010",
                 0 => B"111" ) ,
               ( 4 downto 2 => B"000", 1=> B"010",
                 0 => B"111" ) ,
               ( 2 => 'a', 6 => 'c', 1 | 3 to 5 => 'b' ) ,
               ( (2 downto 0 => '1') )
            ) ;
-- JW: Removed port map which was attempting to associate literals with ports.
   end block L1 ;
end ARCH00521_Test_Bench ;
