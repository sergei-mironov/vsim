-- NEED RESULT: ARCH00277: Binding indication in component configuration is optional passed
-- NEED RESULT: ARCH00277: Component configuration without binding indication and configuration specification can apply to same component instance passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00277
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.3.2 (2)
--    1.3.2 (4)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00277_1(ARCH00277_1)
--    ENT00277(ARCH00277)
--    CONF00277
--    ENT00277_Test_Bench(ARCH00277_Test_Bench)
--
-- REVISION HISTORY:
--
--    21-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
entity ENT00277_1 is
   generic ( g1 : bit ) ;
   port ( s1 : out bit ) ;
end ENT00277_1 ;

architecture ARCH00277_1 of ENT00277_1 is
begin
   s1 <=  g1 ;
end ARCH00277_1 ;

entity ENT00277 is
   generic ( g1 : bit ) ;
   port ( s1 : out bit ) ;
begin
end ENT00277 ;

architecture ARCH00277 of ENT00277 is
   component COMP1
   end component ;
   component COMP2
      generic (g1 : bit ) ;
      port ( s1 : out bit ) ;
   end component ;
   for CIS1 : COMP1 use entity WORK.ENT00277_1 ( ARCH00277_1 )
			   generic map ( g1 )
			   port map ( s1 ) ;
   for CIS2 : COMP2 use entity WORK.ENT00277_1 ( ARCH00277_1 ) ;
   signal s2 : bit ;
   signal s3 : bit ;
begin
   CIS1 : COMP1 ;
   CIS2 : COMP2
      generic map ( g1 )
      port map ( s2 ) ;
   CIS3 : COMP1 ;
end ARCH00277 ;

configuration CONF00277 of WORK.ENT00277 is
   for ARCH00277
      for CIS1 : COMP1
      end for ;
      for CIS2 : COMP2
      end for ;
      for CIS3 : COMP1
	 use entity WORK.ENT00277_1 ( ARCH00277_1 )
		generic map ( g1 )
		port map ( s3 ) ;
      end for ;
   end for ;
end CONF00277 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00277_Test_Bench is
end ENT00277_Test_Bench ;

architecture ARCH00277_Test_Bench of ENT00277_Test_Bench is
begin
   L1:
   block
      signal s1 : bit ;
      constant c1 : bit := '1' ;

      component UUT
         generic ( g1 : bit ) ;
         port ( s1 : out bit ) ;
      end component ;

      for CIS1 : UUT use configuration WORK.CONF00277 ;
   begin
      CIS1 : UUT
	    generic map ( c1 )
	    port map ( s1 ) ;
      P00277 :
      process ( s1 )
      begin
         if s1 = c1 then
	    test_report ( "ARCH00277" ,
		          "Binding indication in component configuration"
                          & " is optional" ,
		          true ) ;
	    test_report ( "ARCH00277" ,
		          "Component configuration without binding indication"
                          & " and configuration specification can apply to"
                          & " same component instance" ,
		          true ) ;
         end if ;
      end process ;
   end block L1 ;
end ARCH00277_Test_Bench ;
