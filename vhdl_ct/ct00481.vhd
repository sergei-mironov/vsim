-- NEED RESULT: ARCH00481: 'Others' in an attribute spec applies to all entities of the specified class that have not appeared previously in an attribute spec passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00481
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    5.1 (5)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00481_Test_Bench(ARCH00481_Test_Bench)
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
entity ENT00481_Test_Bench is
   attribute Attr : boolean ;
end ENT00481_Test_Bench ;

architecture ARCH00481_Test_Bench of ENT00481_Test_Bench is
   signal S : Integer := -1 ;
begin
   L1 :
   block ( S /= -1 )
      port ( P : in Integer ) ;
      port map ( S ) ;

      signal Local_S : Real := -0.1 ;

      attribute Attr of Local_S : signal is false ;
      attribute Attr of others : signal is true ;
   begin
      process
      begin
	 test_report ( "ARCH00481" ,
		       "'Others' in an attribute spec applies to " &
                       "all entities of the specified class that have not " &
                       "appeared previously in an attribute spec" ,
		       (Not Local_S'Attr) and
                       GUARD'Attr and
                       P'Attr ) ;
         wait ;
      end process ;
   end block L1 ;
end ARCH00481_Test_Bench ;
