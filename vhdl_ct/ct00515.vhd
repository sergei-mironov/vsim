-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00515
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    5.2 (3)
--    5.2.1 (1)
--    5.2.1 (2)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00515(ARCH00515)
--    ENT00515_Test_Bench(ARCH00515_Test_Bench)
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
entity ENT00515 is
   generic ( G : boolean ) ;
   port ( P : in  boolean ;
	  Q : out boolean := G) ;
end ENT00515 ;

architecture ARCH00515 of ENT00515 is
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
end ARCH00515 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00515_Test_Bench is
   function To_Bit ( p : boolean ) return bit is
   begin
      case p is
         when false => return '0' ;
         when true  => return '1' ;
      end case ;
   end To_Bit ;

   function To_Boolean ( p : bit ) return boolean is
   begin
      case p is
         when '0' => return false ;
         when '1' => return true ;
      end case ;
   end To_Boolean ;
end ENT00515_Test_Bench ;

architecture ARCH00515_Test_Bench of ENT00515_Test_Bench is
begin
   L1:
   block
      component UUT generic ( G : boolean ) ;
                    port ( P : in  boolean ;
                           Q : out boolean ) ;
      end component ;

      signal S : bit_vector ( 1 to 5 ) 
         := (2|4 => To_Bit(True), others => To_Bit(False)) ;
      alias S1 : bit is S(1) ;
      alias S2 : bit is S(2) ;
      alias S3 : bit is S(3) ;
      alias S4 : bit is S(4) ;
      alias S5 : bit is S(5) ;

      for all : UUT use entity WORK.ENT00515 ( ARCH00515 ) ;

   begin
      S(1) <= transport To_Bit (True) after 0 ns ;

      CIS1 : UUT generic map ( true )
                 port map (p          => To_Boolean (s1),
                           To_Bit (q) => s2) ;
      CIS2 : UUT generic map ( false )
                 port map (p          => To_Boolean (s2),
                           To_Bit (q) => s3) ;
      CIS3 : UUT generic map ( true )
                 port map (p          => To_Boolean (s3),
                           To_Bit (q) => s4) ;
      CIS4 : UUT generic map ( false )
                 port map (p          => To_Boolean (s4),
                           To_Bit (q) => s5) ;

      Check_It :
      process
      begin
         wait for 100 ns ;
	 test_report ( "ARCH00515" ,
		       "All applies to each instance of the component" ,
		       To_Boolean (s1 and (Not s2) and s3
                                   and (Not s4) and s5
                                  )
                     ) ;
	 wait ;
      end process Check_It ;


   end block L1 ;
end ARCH00515_Test_Bench ;
