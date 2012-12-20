-- NEED RESULT: ARCH00271_Test_Bench: No configuration items need appear in block configuration passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00271
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.3.1 (2)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00271(ARCH00271)
--    CONF00271
--    ENT00271_Test_Bench(ARCH00271_Test_Bench)
--
-- REVISION HISTORY:
--
--    20-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
entity ENT00271 is
   generic ( g3 : integer ) ;
   port ( s3 : out integer ) ;
end ENT00271 ;

architecture ARCH00271 of ENT00271 is
begin
   P00271 :
   process
   begin
      s3 <= g3;
      wait ;
   end process P00271 ;
end ARCH00271 ;

configuration CONF00271 of WORK.ENT00271 is
   for ARCH00271
   end for ;
end CONF00271 ;

entity ENT00271_Test_Bench is
end ENT00271_Test_Bench ;

use WORK.STANDARD_TYPES.all ;
architecture ARCH00271_Test_Bench of ENT00271_Test_Bench is
begin
   L1:
   block
      constant c1 : integer := 5 ;
      signal s1 : integer := 0 ;

      component UUT
      end component ;

      for CIS1 : UUT use configuration WORK.CONF00271
	    generic map ( c1 )
	    port map ( s1 ) ;
   begin
      CIS1 : UUT ;
      process (s1)
      begin
	 if s1 = c1 then
	    test_report ( "ARCH00271_Test_Bench" ,
			  "No configuration items need appear in block"
			   & " configuration" ,
			  true ) ;
	 end if ;
      end process ;
   end block L1 ;
end ARCH00271_Test_Bench ;
