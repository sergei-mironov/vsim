-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00533
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    14.1 (2)
--    14.1 (3)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00533)
--    ENT00533_Test_Bench(ARCH00533_Test_Bench)
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
architecture ARCH00533 of E00000 is
begin
   P :
   process
      type ary is array ( integer range <> ) of integer ;
      subtype st_ary is ary (1 to 10) ;
      type rec is record
		     a,b : integer ;
		  end record ;
      subtype st_rec is rec ;
      attribute ary_attr : integer ;
      attribute ary_attr of ary : type is 10 ;
      attribute rec_attr : integer ;
      attribute rec_attr of rec : type is 20 ;
   begin
      test_report ( "ARCH00533" ,
		    "Base attribute" ,
		    (ary'ary_attr = 10) and
		    (rec'rec_attr = 20) and
		    (t_enum1'base'leftof(en2) = en1) and
		    (st_enum1'rightof(en2) = en1) and
		    (st_enum1'base'leftof(en2) = en1) and
		    (t_int1'base'rightof(-1) = 0) and
		    (st_int1'base'leftof(1) = 0)
                  ) ;
      wait ;
   end process P ;
end ARCH00533 ;
--
entity ENT00533_Test_Bench is
end ENT00533_Test_Bench ;

architecture ARCH00533_Test_Bench of ENT00533_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00533 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00533_Test_Bench ;
--
