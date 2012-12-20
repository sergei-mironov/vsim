-- NEED RESULT: ARCH00266: Configuration declarations may or may not have matching ending name passed
-- NEED RESULT: ARCH00266: Configuration declarations need not have configuration declarative items passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00266
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.3 (1)
--    1.3 (3)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00266(ARCH00266)
--    ENT00266_1(ARCH00266_1)
--    CONF00266
--    CONF00266_1
--    ENT00266_Test_Bench(ARCH00266_Test_Bench)
--
-- REVISION HISTORY:
--
--    17-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
entity ENT00266 is
   generic ( g3 : integer ) ;
   port ( s3 : out integer ) ;
end ENT00266 ;

architecture ARCH00266 of ENT00266 is
   component COMP1
   end component ;
begin
   C1 : COMP1;
end ARCH00266 ;

entity ENT00266_1 is
   generic ( g1 : integer ) ;
   port ( s1 : out integer ) ;
begin
end ENT00266_1 ;

architecture ARCH00266_1 of ENT00266_1 is
begin
   s1 <= g1 ;
end ARCH00266_1 ;

configuration CONF00266 of WORK.ENT00266 is
   for ARCH00266
      for C1 : COMP1
	 use entity WORK.ENT00266_1 ( ARCH00266_1 )
		generic map ( g3 )
                port map ( s3 ) ;
      end for ;
   end for ;
end CONF00266 ;

configuration CONF00266_1 of WORK.ENT00266 is
   for ARCH00266
      for C1 : COMP1
	 use entity WORK.ENT00266_1 ( ARCH00266_1 )
		generic map ( g3 )
                port map ( s3 ) ;
      end for ;
   end for ;
end ;

use WORK.STANDARD_TYPES.all ;
entity ENT00266_Test_Bench is
end ENT00266_Test_Bench ;

architecture ARCH00266_Test_Bench of ENT00266_Test_Bench is
begin
   L1:
   block
      constant c1 : integer := 5 ;
      constant c2 : integer := 5 ;
      signal s1, s2 : integer ;

      component UUT
      end component ;

      for CIS1 : UUT use configuration WORK.CONF00266
	    generic map ( c1 )
	    port map ( s1 ) ;
      for CIS2 : UUT use configuration WORK.CONF00266_1
	    generic map ( c2 )
	    port map ( s2 ) ;
   begin
      CIS1 : UUT ;
      CIS2 : UUT ;
      P00266 :
      process ( s1, s2 )
      begin
         if s1 = c1 and s2 = c2 then
            test_report ( "ARCH00266" ,
  	  	          "Configuration declarations may or may not have"
                          & " matching ending name" ,
		          true ) ;
            test_report ( "ARCH00266" ,
		          "Configuration declarations need not have"
                          & " configuration declarative items" ,
		          true ) ;
      end if ;
   end process P00266 ;
   end block L1 ;
end ARCH00266_Test_Bench ;
