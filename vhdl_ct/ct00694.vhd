-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00694
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.3.2 (1)
--    4.3.3.2 (2)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00694
--    PKG00694/BODY
--    ENT00694(ARCH00694)
--    ENT00694_Test_Bench(ARCH00694_Test_Bench)
--
-- REVISION HISTORY:
--
--    08-SEP-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
--
use WORK.STANDARD_TYPES.all ;
package PKG00694 is
   function fintegertointeger ( P : integer ) return integer ;
   function fintegertost_bit_vector ( P : integer ) return st_bit_vector ;
--
   function fst_bit_vectortointeger ( P : st_bit_vector ) return integer ;
   function fst_bit_vectortost_arr3 ( P : st_bit_vector ) return st_arr3 ;
--
   function fst_arr3tost_bit_vector ( P : st_arr3 ) return st_bit_vector ;
   function fst_arr3toboolean ( P : st_arr3 ) return boolean ;
--
   function fbooleantost_arr3 ( P : boolean ) return st_arr3 ;
end PKG00694 ;
--
package body PKG00694 is
   function fintegertointeger ( P : integer ) return integer is
   begin
      if P = c_integer_1 then
         return c_integer_1 ;
      else
         return c_integer_2 ;
      end if ;
   end ;
   function fintegertost_bit_vector ( P : integer ) return st_bit_vector is
   begin
      if P = c_integer_1 then
         return c_st_bit_vector_1 ;
      else
         return c_st_bit_vector_2 ;
      end if ;
   end ;
--
   function fst_bit_vectortointeger ( P : st_bit_vector ) return integer is
   begin
      if P = c_st_bit_vector_1 then
         return c_integer_1 ;
      else
         return c_integer_2 ;
      end if ;
   end ;
   function fst_bit_vectortost_arr3 ( P : st_bit_vector ) return st_arr3 is
   begin
      if P = c_st_bit_vector_1 then
         return c_st_arr3_1 ;
      else
         return c_st_arr3_2 ;
      end if ;
   end ;
--
   function fst_arr3tost_bit_vector ( P : st_arr3 ) return st_bit_vector is
   begin
      if P = c_st_arr3_1 then
         return c_st_bit_vector_1 ;
      else
         return c_st_bit_vector_2 ;
      end if ;
   end ;
   function fst_arr3toboolean ( P : st_arr3 ) return boolean is
   begin
      if P = c_st_arr3_1 then
         return c_boolean_1 ;
      else
         return c_boolean_2 ;
      end if ;
   end ;
--
   function fbooleantost_arr3 ( P : boolean ) return st_arr3 is
   begin
      if P = c_boolean_1 then
         return c_st_arr3_1 ;
      else
         return c_st_arr3_2 ;
      end if ;
   end ;
end PKG00694 ;
--
use WORK.STANDARD_TYPES.all ;
use WORK.PKG00694.all ;
entity ENT00694 is
   port (
          signal s_st_arr3 : in st_arr3 ;
          signal s2_integer : out integer
         ) ;
end ENT00694 ;
--
architecture ARCH00694 of ENT00694 is
   procedure p1 (
                  v_boolean : boolean ;
                  variable v2_integer : out integer
                ) is
      variable correct : boolean := true ;
   begin
      if v_boolean = c_boolean_1 then
         v2_integer := c_integer_1 ;
            test_report ( "ARCH00694" ,
 "Type conversions in assoc. lists with in interface objects" ,
                          correct ) ;
      end if ;
   end p1 ;
begin
   process
      variable v_st_arr3 : st_arr3 ;
      variable v2_integer : integer ;
   begin
      v_st_arr3 := s_st_arr3 ;
      p1 (
            v_boolean =>
            fst_arr3toboolean
             ( v_st_arr3 ) ,
            v2_integer =>
            v2_integer
          ) ;
      s2_integer  <= v2_integer ;
      wait ;
   end process ;
end ARCH00694 ;
--
use WORK.STANDARD_TYPES.all ;
use WORK.PKG00694.all ;
entity ENT00694_Test_Bench is
end ENT00694_Test_Bench ;
--
architecture ARCH00694_Test_Bench of ENT00694_Test_Bench is
begin
   L1:
   block
      signal s_integer : integer := c_integer_1 ;
      signal s2_integer : integer := c_integer_2 ;
      signal toggle : boolean := false ;
      component UUT
         port (
          signal s_st_bit_vector : in st_bit_vector ;
          signal s2_integer : out integer
              ) ;
      end component ;
      for CIS1 : UUT use entity WORK.ENT00694 ( ARCH00694 )
                            port map (
            s_st_arr3 =>
            fst_bit_vectortost_arr3
             ( s_st_bit_vector ) ,
            s2_integer =>
            s2_integer
                                     ) ;
   begin
      toggle <= true ;
      CIS1 : UUT
         port map (
            s_st_bit_vector =>
            fintegertost_bit_vector
             ( s_integer ) ,
            s2_integer =>
            s2_integer
                  ) ;
      process ( s2_integer, s_integer, toggle)
        variable correct : boolean := true ;
      begin
         if toggle then
            correct := correct and s2_integer = c_integer_1 ;
            test_report ( "ARCH00694" ,
 "Type conversions in assoc. lists with in interface objects" ,
                          correct ) ;
         end if ;
      end process ;
   end block L1 ;
end ARCH00694_Test_Bench ;
--
