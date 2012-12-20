-- NEED RESULT: ARCH00268: 'All' in an attribute spec applies to all entities of the specified class declared in the same declarative region as the attribute spec passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00268
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    5.1 (6)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00268_Test_Bench(ARCH00268_Test_Bench)
--
-- REVISION HISTORY:
--
--     7-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00268_Test_Bench is
   attribute Attr : boolean ;
end ENT00268_Test_Bench ;

architecture ARCH00268_Test_Bench of ENT00268_Test_Bench is
   signal S : Integer := -1 ;
begin
   L1 :
   block ( S /= -1 )
      port ( P : in Integer ) ;
      port map ( S ) ;

      signal Local_S : Real := -0.1 ;

      attribute Attr of all : signal is true ;
   begin
      process
      begin
	 test_report ( "ARCH00268" ,
		       "'All' in an attribute spec applies to " &
                       "all entities of the specified class declared in " &
                       "the same declarative region as the attribute spec" ,
		       Local_S'Attr and
                       GUARD'Attr and
                       P'Attr ) ;
         wait ;
      end process ;
   end block L1 ;
end ARCH00268_Test_Bench ;
