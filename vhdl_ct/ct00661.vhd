-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00661
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    4.3.3 (18)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00661(ARCH00661)
--    ENT00661_Test_Bench(ARCH00661_Test_Bench)
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
entity ENT00661 is
   port ( Pt1 : buffer Integer ) ;

end ENT00661 ;
--
architecture ARCH00661 of ENT00661 is
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
   P1 :
   process ( Pt1 )
      variable First_Time : boolean := True ;
   begin
      if First_Time then
	 First_Time := false ;
      else
	 test_report ( "ARCH00661" ,
		       "Entity formal ports of mode 'buffer' may be read" ,
		       Pt1 = -1 ) ;
      end if ;
   end process P1 ;

   L1 :
   block
      port ( Pt1 : buffer Real := -2.0) ;
      port map ( To_Integer(Pt1) => To_Real(Pt1) ) ;  -- Check block 'buffer' po
   begin
      BP1 :
      process
         variable Var : Integer := -2 ;
      begin
         test_report ( "ARCH00661" ,
		       "Block ports of mode 'buffer' may "&
                       "be read" ,
		       Pt1 = -2.0 ) ;

         Pt1 <= transport -1.0 after 10 ns;

         wait ;
      end process BP1 ;

   end block L1 ;
end ARCH00661 ;
--
use WORK.STANDARD_TYPES.all;
entity ENT00661_Test_Bench is
end ENT00661_Test_Bench ;

architecture ARCH00661_Test_Bench of ENT00661_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      signal S1 : Integer := -2 ;

      for CIS1 : UUT use entity WORK.ENT00661 ( ARCH00661 )
                            port map ( S1 ) ;  -- Check entity 'buffer' port
   begin

      CIS1 : UUT ;

      process
      begin
         wait for 11 ns ;
	 test_report ( "ARCH00661" ,
		       "Ports on blocks and entities "&
                       "of mode 'buffer' may be updated" ,
		       S1 = -1 ) ;
	 wait ;
      end process ;
   end block L1 ;
end ARCH00661_Test_Bench ;
--
