-- NEED RESULT: ARCH00664: Ports on blocks and entities of mode 'linkage' may appear as an actual corresponding to an interface object of mode linkage passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00664
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    4.3.3 (20)
--    4.3.3.1 (1)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00664(ARCH00664)
--    ENT00664_Test_Bench(ARCH00664_Test_Bench)
--
-- REVISION HISTORY:
--
--    26-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00664 is
   port ( Pt1 : linkage Integer ) ;

end ENT00664 ;
--
architecture ARCH00664 of ENT00664 is
   function To_Integer ( P : Real ) return Integer is
   begin
      if P = -1.0 then
	 return -1 ;
      else
	 return -2 ;
      end if ;
   end To_Integer ;

   function To_Real ( P : Integer ) return Real is
   begin
      if P = -1 then
	 return -1.0 ;
      else
	 return -2.0 ;
      end if ;
   end To_Real ;

begin
   L1 :
   block
      port ( Pt1 : linkage Real ) ;
      port map ( To_Integer(Pt1) => To_Real(Pt1) ) ;  -- Check block 'linkage' p
   begin
      BP1 :
      process
      begin
         wait ;
      end process BP1 ;

   end block L1 ;
end ARCH00664 ;
--
use WORK.STANDARD_TYPES.all;
entity ENT00664_Test_Bench is
end ENT00664_Test_Bench ;

architecture ARCH00664_Test_Bench of ENT00664_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      signal S1 : Integer := -2 ;

      for CIS1 : UUT use entity WORK.ENT00664 ( ARCH00664 )
                            port map ( S1 ) ;  -- Check entity 'linkage' port
   begin

      CIS1 : UUT ;

      process
      begin
	 test_report ( "ARCH00664" ,
		       "Ports on blocks and entities "&
                       "of mode 'linkage' may appear as an actual "&
                       "corresponding to an interface object of "&
                       "mode linkage" ,
		       S1 = -2 ) ;
	 wait ;
      end process ;
   end block L1 ;
end ARCH00664_Test_Bench ;
--
