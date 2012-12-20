-- NEED RESULT: ENT00209: Wait statement longest static prefix check passed
-- NEED RESULT: ENT00209: Wait statement longest static prefix check passed
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
--    CT00209
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
--    ENT00209(ARCH00209)
--    ENT00209_Test_Bench(ARCH00209_Test_Bench)
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
entity ENT00209 is
   generic (G : integer) ;
   port (
        s_st_rec3 : inout st_rec3
        ) ;
--
   constant CG : integer := G+1;
   attribute attr : integer ;
   attribute attr of CG : constant is CG+1;
--
end ENT00209 ;
--
--
architecture ARCH00209 of ENT00209 is
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_st_rec3 : chk_sig_type := -1 ;
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
            s_st_rec3.f1 <= transport
                c_st_rec3_2.f1 ;
            s_st_rec3.f2 <= transport
                c_st_rec3_2.f2 after 10 ns ;
            wait until s_st_rec3.f2 =
                       c_st_rec3_2.f2 ;
            Test_Report (
              "ENT00209",
              "Wait statement longest static prefix check",
              ((savtime + 10 ns) = Std.Standard.Now) and
              (s_st_rec3.f2 =
                   c_st_rec3_2.f2 )) ;
--
         when 1
         =>
            s_st_rec3.f1 <= transport
                c_st_rec3_1.f1 ;
            s_st_rec3.f3 <= transport
                c_st_rec3_2.f3 after 10 ns ;
            wait until s_st_rec3.f3 =
                       c_st_rec3_2.f3 ;
            Test_Report (
              "ENT00209",
              "Wait statement longest static prefix check",
              ((savtime + 10 ns) = Std.Standard.Now) and
              (s_st_rec3.f3 =
                   c_st_rec3_2.f3 )) ;
--
         when others
         => wait ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      chk_st_rec3 <= transport counter after (1 us - savtime) ;
      counter := counter + 1;
--
   end process P1 ;
--
   PGEN_CHKP_1 :
   process ( chk_st_rec3 )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Wait longest static prefix test completed",
           chk_st_rec3 = 1 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
--
end ARCH00209 ;
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00209_Test_Bench is
end ENT00209_Test_Bench ;
--
--
architecture ARCH00209_Test_Bench of ENT00209_Test_Bench is
begin
   L1:
   block
   signal s_st_rec3 : st_rec3
     := c_st_rec3_1 ;
--
      component UUT
         generic (G : integer) ;
         port (
              s_st_rec3 : inout st_rec3
              ) ;
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00209 ( ARCH00209 ) ;
   begin
      CIS1 : UUT
         generic map (lowb+2)
         port map (
              s_st_rec3
              )
      ;
   end block L1 ;
end ARCH00209_Test_Bench ;
