-- NEED RESULT: ENT00198: Wait statement longest static prefix check passed
-- NEED RESULT: P1: Wait longest static prefix test completed passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00198
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
--    ENT00198(ARCH00198)
--    ENT00198_Test_Bench(ARCH00198_Test_Bench)
--
-- REVISION HISTORY:
--
--    10-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
entity ENT00198 is
   generic (G : integer) ;
   port (
        s_st_int1 : inout st_int1
        ) ;
--
   constant CG : integer := G+1;
   attribute attr : integer ;
   attribute attr of CG : constant is CG+1;
--
end ENT00198 ;
--
--
architecture ARCH00198 of ENT00198 is
   subtype chk_sig_type is integer range -1 to 100 ;
   signal chk_st_int1 : chk_sig_type := -1 ;
--
   procedure Proc1 (
        signal s_st_int1 : inout st_int1
      ; variable counter : inout integer
      ; variable correct : inout boolean
      ; variable savtime : inout time
      ; signal chk_st_int1 : out chk_sig_type
                   )
   is
   begin
      case counter is
         when 0
         =>
            s_st_int1 <= transport
                c_st_int1_2 after 10 ns ;
            wait until s_st_int1 =
                       c_st_int1_2 ;
            Test_Report (
              "ENT00198",
              "Wait statement longest static prefix check",
              ((savtime + 10 ns) = Std.Standard.Now) and
              (s_st_int1 =
                   c_st_int1_2 )) ;
--
         when others
         => wait ;
--
      end case ;
--
      savtime := Std.Standard.Now ;
      counter := counter + 1;
      chk_st_int1 <= transport counter after (1 us - savtime) ;
--
   end Proc1 ;
--
begin
   P1 :
   process
      variable counter : integer := 0 ;
      variable correct : boolean ;
      variable savtime : time := 0 ns;
   begin
      Proc1 (
           s_st_int1
          , counter
          , correct
          , savtime
          , chk_st_int1
         ) ;
   end process P1 ;
--
   PGEN_CHKP_1 :
   process ( chk_st_int1  )
   begin
      if Std.Standard.Now > 0 ns then
         test_report ( "P1" ,
           "Wait longest static prefix test completed",
           chk_st_int1  = 1 ) ;
      end if ;
   end process PGEN_CHKP_1 ;
--
--
end ARCH00198 ;
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00198_Test_Bench is
end ENT00198_Test_Bench ;
--
--
architecture ARCH00198_Test_Bench of ENT00198_Test_Bench is
begin
   L1:
   block
   signal s_st_int1 : st_int1 := c_st_int1_1 ;
--
--
      component UUT
         generic (G : integer) ;
         port (
              s_st_int1 : inout st_int1
              ) ;
      end component ;
--
      for CIS1 : UUT use entity WORK.ENT00198 ( ARCH00198 ) ;
   begin
      CIS1 : UUT
         generic map (lowb+2)
         port map (
              s_st_int1
              )
      ;
   end block L1 ;
end ARCH00198_Test_Bench ;
