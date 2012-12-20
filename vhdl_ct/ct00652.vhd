-- NEED RESULT: ARCH00652: Subp variable parameters of mode 'out' may be updated passed
-- NEED RESULT: ARCH00652: Ports on blocks and entities along with signal parameters of mode 'out' may be updated passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00652
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    4.3.3 (14)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00652(ARCH00652)
--    ENT00652_Test_Bench(ARCH00652_Test_Bench)
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
entity ENT00652 is
   port ( Pt1 : out Integer ) ;

end ENT00652 ;
--
architecture ARCH00652 of ENT00652 is
   function To_Integer ( P : Real ) return Integer is
   begin
      if P = -1.0 then
	 return -1 ;
      else
	 return -2 ;
      end if ;
   end To_Integer ;

   procedure Proc1 ( variable V : out Integer ) is
   begin
      V := -1 ;
   end Proc1 ;

   procedure Proc2 ( signal S : out Real ) is
   begin
      S <= transport -1.0 after 10 ns ;
   end Proc2 ;

begin
   L1 :
   block
      port ( Pt1 : out Real ) ;
      port map ( To_Integer(Pt1) => Pt1 ) ;  -- Check block 'out' port
   begin
      BP1 :
      process
         variable Var : Integer := -2 ;
      begin
         Proc1 (Var) ;
         test_report ( "ARCH00652" ,
		       "Subp variable parameters of mode 'out' may be updated" ,
		       Var = -1 ) ;

         Proc2 (Pt1) ;  -- Check signal 'out' parameter

         wait ;
      end process BP1 ;

   end block L1 ;
end ARCH00652 ;
--
use WORK.STANDARD_TYPES.all;
entity ENT00652_Test_Bench is
end ENT00652_Test_Bench ;

architecture ARCH00652_Test_Bench of ENT00652_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      signal S1 : Integer := -2 ;

      for CIS1 : UUT use entity WORK.ENT00652 ( ARCH00652 )
                            port map ( S1 ) ;  -- Check entity 'out' port
   begin

      CIS1 : UUT ;

      process
      begin
         wait for 11 ns ;
	 test_report ( "ARCH00652" ,
		       "Ports on blocks and entities along with signal "&
                       "parameters of mode 'out' may be updated" ,
		       S1 = -1 ) ;
	 wait ;
      end process ;
   end block L1 ;
end ARCH00652_Test_Bench ;
--
