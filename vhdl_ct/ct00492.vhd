-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00492
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    7.3.2.2 (4)
--    7.3.2.2 (11)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00492(ARCH00492)
--    ENT00492_Test_Bench(ARCH00492_Test_Bench)
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
entity ENT00492 is
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
end ENT00492 ;
--
architecture ARCH00492 of ENT00492 is
begin
   B1 :
   block
      port ( s_arr_1 : st_arr_1 :=
              ( others => (others => c_rec_1_1) ) ;
             s_time_matrix : st_time_matrix :=
              ( others => (others => 15ms) ) ;
             s_bit_vector : st_bit_vector :=
              ( others => '0' ) ;
             s_string : st_string :=
              ( others => 'a' ) ;
             s_rec_1 : rec_1 :=
--              ( f2 => (others => false), others => 0) ) ;
              ( others => 0) ) ;
      port map ( open, open, open, open, open ) ;
--
   begin
      process
         variable bool : boolean := true;
      begin
         for i in 1 to 5 loop
            bool := bool and s_arr_1(false, i) = c_rec_1_1 ;
         end loop ;
         for i in 1 to 5 loop
            bool := bool and s_arr_1(true, i) = c_rec_1_1 ;
         end loop ;
--
         for i in integer'(-5) to -3 loop
            bool := bool and s_time_matrix(0, i) = 15 ms ;
         end loop ;
--
         bool := bool and s_bit_vector = B"00000" ;
--
         bool := bool and s_string = "aaa" ;
--
         bool := bool and s_rec_1.f1 = 0 and s_rec_1.f4 = 0
                      and s_rec_1.f3 = 0 ;
--         bool := bool and s_rec_1.f2(1) = false
--                      and s_rec_1.f2(0) = false and
--                    s_rec_1.f2(-1) = false ;
--
--
         test_report ( "ARCH00492" ,
                       "Aggregates with others choice associated as initial"
                       & " expression of port (generic)" ,
                       bool ) ;
--
         wait ;
      end process ;
   end block B1 ;
end ARCH00492 ;
--
entity ENT00492_Test_Bench is
end ENT00492_Test_Bench ;
--
architecture ARCH00492_Test_Bench of ENT00492_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00492 ( ARCH00492 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00492_Test_Bench ;
