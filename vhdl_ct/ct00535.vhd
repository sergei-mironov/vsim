-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00535
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    14.1 (7)
--    14.1 (8)
--    14.1 (9)
--    14.1 (10)
--    14.1 (11)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00535)
--    ENT00535_Test_Bench(ARCH00535_Test_Bench)
--
-- REVISION HISTORY:
--
--    17-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00535 of E00000 is
begin
   P :
   process
   begin
      test_report ( "ARCH00535" ,
		    "POS, VAL, SUCC, PRED, LEFTOF, RIGHTOF attributes" ,
		    (t_enum1'pos(en2) = 1) and
		    (t_enum1'val(2) = en3) and
		    (t_enum1'succ(en2) = en3) and
		    (t_enum1'pred(en4) = en3) and
		    (t_enum1'leftof(en4) = en3) and
		    (t_enum1'rightof(en1) = en2) and
		    (st_enum1'pos(en2) = 1) and
		    (st_enum1'val(2) = en3) and
		    (st_enum1'succ(en2) = en3) and
		    (st_enum1'pred(en4) = en3) and
		    (st_enum1'leftof(en2) = en3) and
		    (st_enum1'rightof(en2) = en1) and
		    (t_int1'pos(10) = 10) and
		    (t_int1'val(11) = 11) and
		    (t_int1'succ(20) = 21) and
		    (t_int1'pred(30) = 29) and
		    (t_int1'leftof(40) = 39) and
		    (t_int1'rightof(50) = 51) and
		    (st_int1'pos(10) = 10) and
		    (st_int1'val(11) = 11) and
		    (st_int1'succ(20) = 21) and
		    (st_int1'pred(30) = 29) and
		    (st_int1'leftof(40) = 39) and
		    (st_int1'rightof(50) = 51) and
		    (t_phys1'pos(phys1_3) = 100) and
		    (t_phys1'val(10) = phys1_2) and
		    (t_phys1'succ(9 phys1_1) = phys1_2) and
		    (t_phys1'pred(phys1_3) = 99 phys1_1) and
		    (t_phys1'leftof(phys1_3) = 99 phys1_1) and
		    (t_phys1'rightof(9 phys1_1) = phys1_2) and
		    (st_phys1'pos(phys1_3) = 100) and
		    (st_phys1'val(10) = phys1_2) and
		    (st_phys1'succ(9 phys1_1) = phys1_2) and
		    (st_phys1'pred(phys1_3) = 99 phys1_1) and
		    (st_phys1'leftof(phys1_3) = 99 phys1_1) and
		    (st_phys1'rightof(9 phys1_1) = phys1_2) and
                    -- these test 14.1 (10) and 14.1 (11)
		    (st_int1'succ(60) = 61) and
		    (st_int1'pred(8) = 7) and
		    (st_int1'leftof(8) = 7) and
		    (st_int1'rightof(60) = 61)
                  ) ;
      wait ;
   end process P ;
end ARCH00535 ;
--
entity ENT00535_Test_Bench is
end ENT00535_Test_Bench ;

architecture ARCH00535_Test_Bench of ENT00535_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00535 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00535_Test_Bench ;
--
