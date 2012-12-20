-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00494
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.3.2.2 (5)
--    7.3.2.2 (11)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00494(ARCH00494)
--    ENT00494_Test_Bench(ARCH00494_Test_Bench)
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
entity ENT00494 is
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
   constant r1 : integer := 1 ;
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
end ENT00494 ;
--
architecture ARCH00494 of ENT00494 is
begin
   B1 :
   block
--
      function f_arr_1 return st_arr_1 is
      begin
  return  ( others => (others => c_rec_1_1) ) ;
      end f_arr_1 ;
      function f_time_matrix return st_time_matrix is
      begin
  return
                      (others => (others => 15ms) ) ;
      end f_time_matrix ;
      function f_bit_vector return st_bit_vector is
      begin
  return
                    ( others => '0' ) ;
      end f_bit_vector ;
      function f_string return st_string is
      begin
  return
                    ( others => 'a' ) ;
      end f_string ;
      function f_rec_1 return rec_1 is
      begin
  return
--                    ( f2 => (others => false), others => 0)  ;
                    ( others => 0)  ;
      end f_rec_1 ;
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
--                f2 : rec_arr (-d_r1 to d_r1) ;
                f3, f4 : integer ;
                    end record ;
--            constant c_rec_arr : rec_arr (-d_r1 to d_r1) :=
--                                           (true, false, false) ;
--            constant c_rec_1_1 : rec_1 := (1, (true, false, false), 1, 0) ;
--            constant c_rec_1_2 : rec_1 := (0, (true, false, false), 0, 1) ;
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
         variable bool : boolean := true ;
         function f_arr_1 return st_arr_1 is
         begin
        return  ( others => (others => c_rec_1_1) ) ;
         end f_arr_1 ;
         function f_time_matrix return st_time_matrix is
         begin
     return
                         (others => (others => 15ms) ) ;
         end f_time_matrix ;
         function f_bit_vector return st_bit_vector is
         begin
     return
                    ( others => '0' ) ;
         end f_bit_vector ;
         function f_string return st_string is
         begin
     return
                    ( others => 'a' ) ;
         end f_string ;
         function f_rec_1 return rec_1 is
         begin
     return
--                    ( f2 => (others => false), others => 0) ;
                    ( others => 0) ;
         end f_rec_1 ;
      begin
         for i in 1 to 5 loop
            bool := bool and p1.f_arr_1(false, i) = c_rec_1_1 ;
         end loop ;
         for i in 1 to 5 loop
            bool := bool and p1.f_arr_1(true, i) = c_rec_1_1 ;
         end loop ;
--
         for i in integer'(-5) to -3 loop
            bool := bool and p1.f_time_matrix(0, i) = 15 ms ;
         end loop ;
--
         bool := bool and p1.f_bit_vector = B"00000" ;
--
         bool := bool and p1.f_string = "aaa" ;
--
         bool := bool and p1.f_rec_1.f1 = 0 and p1.f_rec_1.f4 = 0
                      and p1.f_rec_1.f3 = 0 ;
--         bool := bool and p1.f_rec_1.f2(1) = false
--                      and p1.f_rec_1.f2(0) = false and
--                    p1.f_rec_1.f2(-1) = false ;
--
--
         test_report ( "ARCH00494" ,
                       "Aggregates with others choice associated with function"
                       & " return (dynamic static)" ,
                       bool ) ;
      end p1 ;
   begin
      process
         variable bool : boolean := true ;
      begin
         for i in 1 to 5 loop
            bool := bool and f_arr_1(false, i) = c_rec_1_1 ;
         end loop ;
         for i in 1 to 5 loop
            bool := bool and f_arr_1(true, i) = c_rec_1_1 ;
         end loop ;
--
         for i in integer'(-5) to -3 loop
            bool := bool and f_time_matrix(0, i) = 15 ms ;
         end loop ;
--
         bool := bool and f_bit_vector = B"00000" ;
--
         bool := bool and f_string = "aaa" ;
--
         bool := bool and f_rec_1.f1 = 0 and f_rec_1.f4 = 0
                      and f_rec_1.f3 = 0 ;
--         bool := bool and f_rec_1.f2(1) = false
--                      and f_rec_1.f2(0) = false and
--                    f_rec_1.f2(-1) = false ;
--
--
         test_report ( "ARCH00494" ,
                       "Aggregates with others choice associated with function"
                       & " return (globally static)" ,
                       bool ) ;
         p1 ( open, open, open, open,
              open, open, open, open,
              open, open, open, open, open ) ;
         wait ;
      end process ;
   end block B1 ;
end ARCH00494 ;
--
entity ENT00494_Test_Bench is
end ENT00494_Test_Bench ;
--
architecture ARCH00494_Test_Bench of ENT00494_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00494 ( ARCH00494 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00494_Test_Bench ;
