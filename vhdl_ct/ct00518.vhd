-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00518
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    5.2.1.1 (3)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00518(ARCH00518)
--    CONF00518
--    ENT00518_Test_Bench(ARCH00518_Test_Bench)
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
entity ENT00518 is
   generic ( G : boolean ) ;
   port ( P : in  boolean ;
	  Q : out boolean := G) ;
end ENT00518 ;

architecture ARCH00518 of ENT00518 is
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
end ARCH00518 ;

configuration CONF00518 of WORK.ENT00518 is
   for ARCH00518
   end for ;
end CONF00518 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00518_Test_Bench is
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
end ENT00518_Test_Bench ;

architecture ARCH00518_Test_Bench of ENT00518_Test_Bench is
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

      for all : UUT use configuration WORK.CONF00518 ;

   begin
      S(1) <= transport To_Bit (True) after 0 ns ;

      CIS1 : UUT generic map(true)
                 port map (p          => To_Boolean (s1),
                           To_Bit (q) => s2) ;
      CIS2 : UUT generic map(false)
                 port map (p          => To_Boolean (s2),
                           To_Bit (q) => s3) ;
      CIS3 : UUT generic map(true)
                 port map (p          => To_Boolean (s3),
                           To_Bit (q) => s4) ;
      CIS4 : UUT generic map(false)
                 port map (p          => To_Boolean (s4),
                           To_Bit (q) => s5) ;

      Check_It :
      process
      begin
         wait for 100 ns ;
	 test_report ( "ARCH00518" ,
		       "The entity aspect in a configuration spec "&
                       "may be a configuration" ,
		       To_Boolean (s1 and (Not s2) and s3 and
                                   (Not s4) and s5) ) ;
	 wait ;
      end process Check_It ;


   end block L1 ;
end ARCH00518_Test_Bench ;
