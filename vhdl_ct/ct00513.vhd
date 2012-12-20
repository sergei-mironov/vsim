-- NEED RESULT: ARCH00513: One or many instantiation labels may appear in an instantiation list of a configuration spec passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00513
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    5.2 (1)
--    5.2.1 (1)
--    5.2.1 (2)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00513(ARCH00513)
--    ENT00513_Test_Bench(ARCH00513_Test_Bench)
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
entity ENT00513 is
   generic ( G : boolean ) ;
   port ( P : in  boolean ;
	  Q : out boolean := G) ;
end ENT00513 ;

architecture ARCH00513 of ENT00513 is
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
end ARCH00513 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00513_Test_Bench is
end ENT00513_Test_Bench ;

architecture ARCH00513_Test_Bench of ENT00513_Test_Bench is
begin
   L1:
   block
      component UUT generic ( G : boolean) ;
                    port ( P : in  boolean ;
                           Q : out boolean ) ;
      end component ;

      signal S : boolean_vector ( 1 to 5 ) := (False,True,False,True,False) ;
      alias S1 : boolean is S(1) ;
      alias S2 : boolean is S(2) ;
      alias S3 : boolean is S(3) ;
      alias S4 : boolean is S(4) ;
      alias S5 : boolean is S(5) ;

      for CIS1 : UUT use entity WORK.ENT00513 ( ARCH00513 ) ;
      for CIS2, CIS3, CIS4 : UUT use entity WORK.ENT00513 ( ARCH00513 ) ;

   begin
      S(1) <= transport True after 0 ns ;

      CIS1 : UUT generic map (true) port map (s1, s2) ;
      CIS2 : UUT generic map (false) port map (s2, s3) ;
      CIS3 : UUT generic map (true) port map (s3, s4) ;
      CIS4 : UUT generic map (false) port map (s4, s5) ;

      Check_It :
      process
      begin
         wait for 100 ns ;
	 test_report ( "ARCH00513" ,
		       "One or many instantiation labels may appear "&
                       "in an instantiation list of a configuration spec" ,
		       s1 and (Not s2) and s3 and (Not s4) and s5 ) ;
	 wait ;
      end process Check_It ;


   end block L1 ;
end ARCH00513_Test_Bench ;
