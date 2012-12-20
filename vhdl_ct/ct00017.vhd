-- NEED RESULT: ENT00017: An actual of any mode may be associated with a formal of mode linkage passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00017
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.1.1.2 (1)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00017(ARCH00017)
--    ENT00017_1(ARCH00017_1)
--    ENT00017_Test_Bench(ARCH00017_Test_Bench)
--
-- REVISION HISTORY:
--
--    26-JUN-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
entity ENT00017 is
   port ( SIN, SINOUT, SOUT, SBUFFER, SLINK : linkage boolean ) ;
end ENT00017 ;

architecture ARCH00017 of ENT00017 is
begin
   process
   begin
      test_report ( "ENT00017" ,
		    "An actual of any mode may be associated with a formal" &
                     " of mode linkage" ,
		    true ) ;
      wait ;
   end process ;
end ARCH00017 ;

entity ENT00017_1 is
   port ( SIN : in boolean ;
	  SINOUT : inout boolean ;
          SOUT : out boolean ;
          SBUFFER : buffer boolean ;
          SLINK : linkage boolean ) ;
end ENT00017_1 ;

architecture ARCH00017_1 of ENT00017_1 is
begin
   L1:
   block
      component UUT
      end component ;
      signal SIN, SINOUT, SOUT, SBUFFER, SLINK : boolean ;

      for CIS1 : UUT use entity WORK.ENT00017 ( ARCH00017 )
               port map ( SIN, SINOUT, SOUT, SBUFFER, SLINK ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00017_1 ;

entity ENT00017_Test_Bench is
end ENT00017_Test_Bench ;

architecture ARCH00017_Test_Bench of ENT00017_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      signal SIN, SINOUT, SOUT, SBUFFER, SLINK : boolean ;

      for CIS1 : UUT use entity WORK.ENT00017_1 ( ARCH00017_1 )
               port map ( SIN, SINOUT, SOUT, SBUFFER, SLINK ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00017_Test_Bench ;
