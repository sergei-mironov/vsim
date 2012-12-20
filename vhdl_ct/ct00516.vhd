-- NEED RESULT: ARCH00516: Architecture identifier in an entity aspect is optional failed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00516
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    5.2.1.1 (1)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00516(ARCH00516)
--    ENT00516_Test_Bench(ARCH00516_Test_Bench)
--
-- REVISION HISTORY:
--
--    11-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00516 is
   port ( P : in  boolean ;
	  Q : out boolean ) ;
end ENT00516 ;

architecture ARCH00516 of ENT00516 is
begin
   process ( P )
      variable First_Time : boolean := true ;
   begin
      if First_Time then
	 First_Time := false ;
      else
         Q <= transport Not P after 10 ns ;
      end if ;
   end process ;
end ARCH00516 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00516_Test_Bench is
end ENT00516_Test_Bench ;

architecture ARCH00516_Test_Bench of ENT00516_Test_Bench is
begin
   L1:
   block
      component UUT port (P : in  boolean ;
                          Q : out boolean ) ;
      end component ;

      component UUT2
      end component ;

      signal S : boolean_vector ( 1 to 5 ) := (2|4 => True, others => False);
      alias S1 : boolean is S(1) ;
      alias S2 : boolean is S(2) ;
      alias S3 : boolean is S(3) ;
      alias S4 : boolean is S(4) ;
      alias S5 : boolean is S(5) ;

      for CIS1 : UUT use entity WORK.ENT00516 ( ARCH00516 );

      for CIS2 : UUT use entity WORK.ENT00516 ;

      for CIS3 : UUT2 use entity WORK.ENT00516 ( ARCH00516 )
			     port map ( p => s3,
                                        q => s4 ) ;

      for CIS4 : UUT2 use entity WORK.ENT00516
			     port map ( p => s(4),
                                        q => s(5) ) ;

   begin
      S(1) <= transport True after 0 ns ;

      CIS1 : UUT port map (s1, s2) ;
      CIS2 : UUT port map (s(2), s3) ;
      CIS3 : UUT2;
      CIS4 : UUT2;

      Check_It :
      process
      begin
         wait for 100 ns ;
	 test_report ( "ARCH00516" ,
		       "Architecture identifier in an entity aspect is "&
                       "optional" ,
		       (s1 and (Not s2) and
                        s3 and (Not s4) and s5 )
                     ) ;
	 wait ;
      end process Check_It ;


   end block L1 ;
end ARCH00516_Test_Bench ;
