-- NEED RESULT: ARCH00546: Architectural library name visibility test failed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00546
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    10.3 (11)
--    10.3 (13)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00546(ARCH00546)
--    ENT00546_Test_Bench(ARCH00546_Test_Bench)
--    CONF00546
--
-- REVISION HISTORY:
--
--    19-AUG-1987   - initial revision
--    19-JAN-1987   - replaced selected name WORK.ARCH00546 with simple
--                    name ARCH00546
--
-- NOTES:
--
--    self-checking
--
--
entity ENT00546 is
   generic ( G : Integer := 0 ) ;
   port ( P1 : in Boolean ; P2 : out Boolean ) ;
end ENT00546 ;
--
architecture ARCH00546 of ENT00546 is
begin
   process (P1)
   begin
      P2 <= transport Not P1 ;
   end process ;
end ARCH00546 ;
--
entity ENT00546_Test_Bench is
end ENT00546_Test_Bench ;
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00546_Test_Bench of ENT00546_Test_Bench is
   signal S1, S2 : boolean := false ;
   signal S3 : boolean := true ;

   component Comp1
      generic ( G : Integer := 0 ) ;
      port ( P1 : in boolean ;  P2 : out boolean ) ;
   end component ;
   for CIS1 : Comp1 use entity WORK.ENT00546 ( ARCH00546 );
      -- reference in binding indication

   component Comp2
      port ( P1 : in boolean ;  P2 : out boolean ) ;
   end component ;

begin
   CIS1 : Comp1
      generic map ( open )
      port map ( S1, S2 ) ;

   Blk :
   block
   begin
      CIS1 : Comp2
         port map ( S2, S3 ) ;
   end block Blk ;

   process
   begin
      wait for 10 ns ;
      test_report ( "ARCH00546" ,
		    "Architectural library name visibility test" ,
		    (Not S1) and S2 and (Not S3) ) ;
      wait ;
   end process ;
end ARCH00546_Test_Bench ;
--
configuration CONF00546 of WORK.ENT00546_Test_Bench is
   for ARCH00546_Test_Bench  -- reference in a configuration
      for Blk
	 for CIS1 : Comp2
	    use entity WORK.ENT00546 ( ARCH00546 )
                          -- reference in a binding indication
		   generic map ( G => open )
		   port map ( P1, P2 ) ;
	 end for ;
      end for ;
   end for ;
end CONF00546 ;
--

