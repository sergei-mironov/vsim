-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00601
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    11.1 (1)
--
-- DESIGN UNIT ORDERING:
--
--    N/A
--
-- REVISION HISTORY:
--
--    24-AUG-1987   - initial revision
--
-- NOTES:
--
--    Will be used in conjunction with test ct00607
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00601 of E00000 is
begin
   process
   begin
      test_report ( "ARCH00601" ,
		    "Design units may appear separately in a design file" ,
		    True ) ;
      wait ;
   end process ;
end ARCH00601 ;
--
