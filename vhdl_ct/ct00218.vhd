-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00218
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.1 (5)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00218(ARCH00218)
--    ENT00218_Test_Bench(ARCH00218_Test_Bench)
--
-- REVISION HISTORY:
--
--    10-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--    automatically generated
--
use WORK.STANDARD_TYPES.all ;
entity ENT00218 is
   generic (G : integer) ;
   port (
        s_st_arr1_vector : inout st_arr1_vector
        ) ;
--
   constant CG : integer := G+1;
   attribute attr : integer ;
   attribute attr of CG : constant is CG+1;
--
end ENT00218 ;
--
--
architecture ARCH00218 of ENT00218 is
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_st_arr1_vector : chk_sig_type := -1 ;
--
   procedure Proc1 (
        signal s_st_arr1_vector : inout st_arr1_vector
      ; variable counter : inout integer
      ; variable correct : inout boolean
      ; variable savtime : inout time
      ; signal chk_st_arr1_vector : out chk_sig_type
                   )
   is
   begin
      case counter is
         when 0
         =>
            s_st_arr1_vector(1)(1) <= transport
                c_st_arr1_vector_2(1)(1) ;
            s_st_arr1_vector(2)(1 to 2) <= transport
                c_st_arr1_vector_2(2)(1 to 2) after 10 ns ;
            wait until s_st_arr1_vector(2)(1 to 2) =
                       c_st_arr1_vector_2(2)(1 to 2) ;
            Test_Report (
              "ENT00218",
              "Wait statement longest static prefix check",
              ((savtime + 10 ns) = Std.Standard.Now) and
              (s_st_arr1_vector(2)(1 to 2) =
                   c_st_arr1_vector_2(2)(1 to 2) )) ;
--
         when 1
         =>
            s_st_arr1_vector(1)(1) <= transport
                c_st_arr1_vector_1(1)(1) ;
            s_st_arr1_vector(G)(G-1 to G) <= transport
                c_st_arr1_vector_2(G)(G-1 to G) after 10 ns ;
            wait until s_st_arr1_vector(G)(G-1 to G) =
                       c_st_arr1_vector_2(G)(G-1 to G) ;
            Test_Report (
              "ENT00218",
              "Wait statement longest static prefix check",
              ((savtime + 10 ns) = Std.Standard.Now) and
              (s_st_arr1_vector(G)(G-1 to G) =
                   c_st_arr1_vector_2(G)(G-1 to G) )) ;
--
         when 2
         =>
            s_st_arr1_vector(1)(1) <= transport
                c_st_arr1_vector_2(1)(1) ;
            s_st_arr1_vector(CG)(CG-1 to CG) <= transport
                c_st_arr1_vector_2(CG)(CG-1 to CG) after 10 ns ;
            wait until s_st_arr1_vector(CG)(CG-1 to CG) =
                       c_st_arr1_vector_2(CG)(CG-1 to CG) ;
            Test_Report (
              "ENT00218",
              "Wait statement longest static prefix check",
              ((savtime + 10 ns) = Std.Standard.Now) and
              (s_st_arr1_vector(CG)(CG-1 to CG) =
                   c_st_arr1_vector_2(CG)(CG-1 to CG) )) ;
--
         when 3
         =>
            s_st_arr1_vector(1)(1) <= transport
                c_st_arr1_vector_1(1)(1) ;
            s_st_arr1_vector(CG'Attr)(CG'Attr-1 to CG'Attr) <= transport
                c_st_arr1_vector_2(CG'Attr)(CG'Attr-1 to CG'Attr) after 10 ns ;
            wait until s_st_arr1_vector(CG'Attr)(CG'Attr-1 to CG'Attr) =
                       c_st_arr1_vector_2(CG'Attr)(CG'Attr-1 to CG'Attr) ;
            Test_Report (
              "ENT00218",
              "Wait statement longest static prefix check",
              ((savtime + 10 ns) = Std.Standard.Now) and
              (s_st_arr1_vector(CG'Attr)(CG'Attr-1 to CG'Attr) =
                   c_st_arr1_vector_2(CG'Attr)(CG'Attr-1 to CG'Attr) )) ;
--
         when others
         => wait ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_arr1_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end Proc1 ;
--
begin
   P1 :
   process
      variable counter : integer := 0 ;
      variable correct : boolean ;
      variable savtime : time := 0 ns ;
   begin
      Proc1 (
           s_st_arr1_vector
          , counter
          , correct
          , savtime
          , chk_st_arr1_vector
         ) ;
   end process P1 ;
--
   PGEN_CHKP_1 :
   process ( chk_st_arr1_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Wait longest static prefix test completed",
           chk_st_arr1_vector = 3 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
--
end ARCH00218 ;
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00218_Test_Bench is
end ENT00218_Test_Bench ;
--
--
architecture ARCH00218_Test_Bench of ENT00218_Test_Bench is
begin
   L1:
   block
   signal s_st_arr1_vector : st_arr1_vector
     := c_st_arr1_vector_1 ;
--
      component UUT
         generic (G : integer) ;
         port (
              s_st_arr1_vector : inout st_arr1_vector
              ) ;
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00218 ( ARCH00218 ) ;
   begin
      CIS1 : UUT
         generic map (lowb+2)
         port map (
              s_st_arr1_vector
              )
      ;
   end block L1 ;
end ARCH00218_Test_Bench ;
