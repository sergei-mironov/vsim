-- NEED RESULT: ENT00223: Wait statement longest static prefix check passed
-- NEED RESULT: ENT00223: Wait statement longest static prefix check passed
-- NEED RESULT: ENT00223: Wait statement longest static prefix check passed
-- NEED RESULT: ENT00223: Wait statement longest static prefix check passed
-- NEED RESULT: P1: Wait longest static prefix test completed passed
-------------------------------------------------------------------------------
 --
 --    Copyright (c) 1989 by Intermetrics, Inc.
 --                All rights reserved.
 --
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00223
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
--    ENT00223(ARCH00223)
--    ENT00223_Test_Bench(ARCH00223_Test_Bench)
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
entity ENT00223 is
   generic (G : integer) ;
--
   constant CG : integer := G+1;
   attribute attr : integer ;
   attribute attr of CG : constant is CG+1;
--
end ENT00223 ;
--
--
architecture ARCH00223 of ENT00223 is
   signal s_st_rec3_vector : st_rec3_vector
     := c_st_rec3_vector_1 ;
--
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_st_rec3_vector : chk_sig_type := -1 ;
--
begin
   P1 :
   process
      variable counter : integer := 0 ;
      variable correct : boolean ;
      variable savtime : time := 0 ns ;
   begin
      case counter is
         when 0
         =>
            s_st_rec3_vector(1).f1 <= transport
                c_st_rec3_vector_2(1).f1 ;
            s_st_rec3_vector(2).f2 <= transport
                c_st_rec3_vector_2(2).f2 after 10 ns ;
            wait until s_st_rec3_vector(2).f2 =
                       c_st_rec3_vector_2(2).f2 ;
            Test_Report (
              "ENT00223",
              "Wait statement longest static prefix check",
              ((savtime + 10 ns) = Std.Standard.Now) and
              (s_st_rec3_vector(2).f2 =
                   c_st_rec3_vector_2(2).f2 )) ;
--
         when 1
         =>
            s_st_rec3_vector(1).f1 <= transport
                c_st_rec3_vector_1(1).f1 ;
            s_st_rec3_vector(G).f2 <= transport
                c_st_rec3_vector_2(G).f2 after 10 ns ;
            wait until s_st_rec3_vector(G).f2 =
                       c_st_rec3_vector_2(G).f2 ;
            Test_Report (
              "ENT00223",
              "Wait statement longest static prefix check",
              ((savtime + 10 ns) = Std.Standard.Now) and
              (s_st_rec3_vector(G).f2 =
                   c_st_rec3_vector_2(G).f2 )) ;
--
         when 2
         =>
            s_st_rec3_vector(1).f1 <= transport
                c_st_rec3_vector_2(1).f1 ;
            s_st_rec3_vector(CG).f2 <= transport
                c_st_rec3_vector_2(CG).f2 after 10 ns ;
            wait until s_st_rec3_vector(CG).f2 =
                       c_st_rec3_vector_2(CG).f2 ;
            Test_Report (
              "ENT00223",
              "Wait statement longest static prefix check",
              ((savtime + 10 ns) = Std.Standard.Now) and
              (s_st_rec3_vector(CG).f2 =
                   c_st_rec3_vector_2(CG).f2 )) ;
--
         when 3
         =>
            s_st_rec3_vector(1).f1 <= transport
                c_st_rec3_vector_1(1).f1 ;
            s_st_rec3_vector(CG'Attr).f2 <= transport
                c_st_rec3_vector_2(CG'Attr).f2 after 10 ns ;
            wait until s_st_rec3_vector(CG'Attr).f2 =
                       c_st_rec3_vector_2(CG'Attr).f2 ;
            Test_Report (
              "ENT00223",
              "Wait statement longest static prefix check",
              ((savtime + 10 ns) = Std.Standard.Now) and
              (s_st_rec3_vector(CG'Attr).f2 =
                   c_st_rec3_vector_2(CG'Attr).f2 )) ;
--
         when others
         => wait ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_rec3_vector <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end process P1 ;
--
   PGEN_CHKP_1 :
   process ( chk_st_rec3_vector )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Wait longest static prefix test completed",
           chk_st_rec3_vector = 3 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
--
end ARCH00223 ;
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00223_Test_Bench is
end ENT00223_Test_Bench ;
--
--
architecture ARCH00223_Test_Bench of ENT00223_Test_Bench is
begin
   L1:
   block
      component UUT
         generic (G : integer) ;
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00223 ( ARCH00223 ) ;
   begin
      CIS1 : UUT
         generic map (lowb+2)
      ;
   end block L1 ;
end ARCH00223_Test_Bench ;
