-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00496
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.3.2.2 (6)
--    7.3.2.2 (11)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00496(ARCH00496)
--    ENT00496_Test_Bench(ARCH00496_Test_Bench)
--
-- REVISION HISTORY:
--
--    10-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
entity ENT00496 is
   generic (
            constant g_a11 : boolean := false ;
            constant g_a12 : boolean := true ;
            constant g_a21 : integer := 1 ;
            constant g_a22 : integer := 5 ;
            constant g_b11 : integer := 0 ;
            constant g_b12 : integer := 0 ;
            constant g_b21 : integer := -5 ;
            constant g_b22 : integer := -3 ;
            constant g_c1 : integer := 0 ;
            constant g_c2 : integer := 4 ;
            constant g_d1 : integer := 3 ;
            constant g_d2 : integer := 5 ;
             constant g_r1 : integer := 1
             ) ;
--
   type rec_arr is array ( integer range <> ) of boolean ;
   type rec_1 is record
       f1 : integer range - g_r1 to g_r1 ;
--       f2 : rec_arr (-g_r1 to g_r1) ;
       f3, f4 : integer ;
           end record ;
--   constant c_rec_arr : rec_arr (-g_r1 to g_r1) :=
--                                  (true, false, false) ;
--   constant c_rec_1_1 : rec_1 := (1, (true, false, false), 1, 0) ;
--   constant c_rec_1_2 : rec_1 := (0, (true, false, false), 0, 1) ;
   constant c_rec_1_1 : rec_1 := (1, 1, 0) ;
   constant c_rec_1_2 : rec_1 := (0, 0, 1) ;
--
   type arr_1 is array ( boolean range <> , integer range <> )
    of rec_1 ;
   type time_matrix is array ( integer range <> , integer range <> )
    of time ;
--
--
   subtype arange1 is boolean range g_a11 to g_a12 ;
   subtype arange2 is integer range g_a21 to g_a22 ;
   subtype brange1 is integer range g_b11 to g_b12 ;
   subtype brange2 is integer range g_b21 to g_b22 ;
   subtype crange is integer range g_c1 to g_c2 ;
   subtype drange is integer range g_d1 to g_d2 ;
--
   subtype st_arr_1 is arr_1 ( arange1 , arange2 ) ;
   subtype st_time_matrix is time_matrix ( brange1 , brange2 ) ;
   subtype st_bit_vector is bit_vector ( crange ) ;
   subtype st_string is string ( drange ) ;
--
--
end ENT00496 ;
--
architecture ARCH00496 of ENT00496 is
begin
   B1 :
   block
      signal s_arr_1 : st_arr_1 ;
      signal s_time_matrix : st_time_matrix ;
      signal s_bit_vector : st_bit_vector ;
      signal s_string : st_string ;
      signal s_rec_1 : rec_1 ;
      signal toggle : boolean := false ;
      procedure p1 (
            constant d_a11 : boolean := false ;
            constant d_a12 : boolean := true ;
            constant d_a21 : integer := 1 ;
            constant d_a22 : integer := 5 ;
            constant d_b11 : integer := 0 ;
            constant d_b12 : integer := 0 ;
            constant d_b21 : integer := -5 ;
            constant d_b22 : integer := -3 ;
            constant d_c1 : integer := 0 ;
            constant d_c2 : integer := 4 ;
            constant d_d1 : integer := 3 ;
            constant d_d2 : integer := 5 ;
             constant d_r1 : integer := 1
                   ) is
--
         type rec_arr is array ( integer range <> ) of boolean ;
         type rec_1 is record
             f1 : integer range - d_r1 to d_r1 ;
--             f2 : rec_arr (-d_r1 to d_r1) ;
             f3, f4 : integer ;
                 end record ;
--         constant c_rec_arr : rec_arr (-d_r1 to d_r1) :=
--                                        (true, false, false) ;
--         constant c_rec_1_1 : rec_1 := (1, (true, false, false), 1, 0) ;
--         constant c_rec_1_2 : rec_1 := (0, (true, false, false), 0, 1) ;
         constant c_rec_1_1 : rec_1 := (1, 1, 0) ;
         constant c_rec_1_2 : rec_1 := (0, 0, 1) ;
--
         type arr_1 is array ( boolean range <> , integer range <> )
          of rec_1 ;
         type time_matrix is array ( integer range <> , integer range <> )
          of time ;
--
--
         subtype arange1 is boolean range d_a11 to d_a12 ;
         subtype arange2 is integer range d_a21 to d_a22 ;
         subtype brange1 is integer range d_b11 to d_b12 ;
         subtype brange2 is integer range d_b21 to d_b22 ;
         subtype crange is integer range d_c1 to d_c2 ;
         subtype drange is integer range d_d1 to d_d2 ;
--
         subtype st_arr_1 is arr_1 ( arange1 , arange2 ) ;
         subtype st_time_matrix is time_matrix ( brange1 , brange2 ) ;
         subtype st_bit_vector is bit_vector ( crange ) ;
         subtype st_string is string ( drange ) ;
--
         variable v_arr_1 : st_arr_1 ;
         variable v_time_matrix : st_time_matrix ;
         variable v_bit_vector : st_bit_vector ;
         variable v_string : st_string ;
         variable v_rec_1 : rec_1 ;
         variable bool : boolean := true ;
--
      begin
         v_arr_1 :=
              ( others => (others => c_rec_1_1) ) ;
         v_time_matrix :=
              ( others => (others => 15ms) ) ;
         v_bit_vector :=
              ( others => '0' ) ;
         v_string :=
              ( others => 'a' ) ;
         v_rec_1 :=
--              ( f2 => (others => false), others => 0) ;
              ( others => 0) ;
         for i in 1 to 5 loop
            bool := bool and v_arr_1(false, i) = c_rec_1_1 ;
         end loop ;
         for i in 1 to 5 loop
            bool := bool and v_arr_1(true, i) = c_rec_1_1 ;
         end loop ;
--
         for i in integer'(-5) to -3 loop
            bool := bool and v_time_matrix(0, i) = 15 ms ;
         end loop ;
--
         bool := bool and v_bit_vector = B"00000" ;
--
         bool := bool and v_string = "aaa" ;
--
         bool := bool and v_rec_1.f1 = 0 and v_rec_1.f4 = 0
                      and v_rec_1.f3 = 0 ;
--         bool := bool and v_rec_1.f2(1) = false
--                      and v_rec_1.f2(0) = false and
--                    v_rec_1.f2(-1) = false ;
--
--
         test_report ( "ARCH00496" ,
                       "Aggregates with others choice in signal assignment"
                       & " (dynamic)" ,
                       bool ) ;
      end p1 ;
--
   begin
      process
         variable v_arr_1 : st_arr_1 ;
         variable v_time_matrix : st_time_matrix ;
         variable v_bit_vector : st_bit_vector ;
         variable v_string : st_string ;
         variable v_rec_1 : rec_1 ;
         variable bool : boolean := true ;
--
      begin
         s_arr_1 <=
              ( others => (others => c_rec_1_1) ) ;
         for i in 2 to 5 loop
             s_arr_1 (false, i) <= c_rec_1_2;
         end loop;
         s_time_matrix <=
              ( others => (others => 5 fs) ) ;
         s_time_matrix (0, -3) <= 10 ns;
         s_bit_vector <=
              ( others => '0' ) ;
         s_bit_vector (g_c1) <= '1';
         s_bit_vector (g_c1+2) <= '1';
         s_string <=
              "ab0" ;
         s_rec_1 <=
--              ( f2 => (others => false), others => 0) ;
              ( others => 0) ;
         s_rec_1.f3 <= 1;
         toggle <= true ;
         v_arr_1 :=
              ( others => (others => c_rec_1_1) ) ;
         v_time_matrix :=
              ( others => (others => 15ms) ) ;
         v_bit_vector :=
              ( others => '0' ) ;
         v_string :=
              ( others => 'a' ) ;
         v_rec_1 :=
--              ( f2 => (others => false), others => 0) ;
              ( others => 0) ;
         for i in 1 to 5 loop
            bool := bool and v_arr_1(false, i) = c_rec_1_1 ;
         end loop ;
         for i in 1 to 5 loop
            bool := bool and v_arr_1(true, i) = c_rec_1_1 ;
         end loop ;
--
         for i in integer'(-5) to -3 loop
            bool := bool and v_time_matrix(0, i) = 15 ms ;
         end loop ;
--
         bool := bool and v_bit_vector = B"00000" ;
--
         bool := bool and v_string = "aaa" ;
--
         bool := bool and v_rec_1.f1 = 0 and v_rec_1.f4 = 0
                      and v_rec_1.f3 = 0 ;
--         bool := bool and v_rec_1.f2(1) = false
--                      and v_rec_1.f2(0) = false and
--                    v_rec_1.f2(-1) = false ;
--
--
         test_report ( "ARCH00496" ,
                       "Aggregates with others choice in signal assignment"
                       & " (globally static)" ,
                       bool ) ;
         wait ;
      end process ;
      process ( toggle )
         variable bool : boolean := true ;
      begin
  if toggle then
            bool := bool and s_arr_1(false, 1) = c_rec_1_1 ;
            for i in 2 to 5 loop
               bool := bool and s_arr_1(false, i) = c_rec_1_2 ;
            end loop ;
            for i in 1 to 5 loop
               bool := bool and s_arr_1(true, i) = c_rec_1_1 ;
            end loop ;
--
            bool := bool and s_time_matrix(0, -3) = 10 ns ;
            for i in integer'(-5) to -4 loop
               bool := bool and s_time_matrix(0, i) = 5 fs ;
            end loop ;
--
            bool := bool and s_bit_vector = B"10100" ;
--
            bool := bool and s_string = "ab0" ;
--
            bool := bool and s_rec_1.f1 = 0 and s_rec_1.f4 = 0
                         and s_rec_1.f3 = 1 ;
--            bool := bool and s_rec_1.f2(1) = true
--                         and s_rec_1.f2(0) = false and
--                       s_rec_1.f2(-1) = false ;
--
--
         test_report ( "ARCH00496" ,
                       "Aggregates with others choice in variable assignment"
                       & " (globally static)" ,
                       bool ) ;
  end if ;
         p1 ( open, open, open, open,
              open, open, open, open,
              open, open, open, open, open ) ;
      end process ;
   end block B1 ;
end ARCH00496 ;
--
entity ENT00496_Test_Bench is
end ENT00496_Test_Bench ;
--
architecture ARCH00496_Test_Bench of ENT00496_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00496 ( ARCH00496 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00496_Test_Bench ;
