-- NEED RESULT: ARCH00270: Use clause may appear in a block configuration passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00270
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.3.1 (1)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00270
--    ENT00270(ARCH00270)
--    ENT00270_1(ARCH00270_1)
--    CONF00270
--    ENT00270_Test_Bench(ARCH00270_Test_Bench)
--
-- REVISION HISTORY:
--
--    20-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
package PKG00270 is
   constant g5 : integer := 6 ;
end PKG00270 ;

entity ENT00270 is
   generic ( g3 : integer ) ;
   port ( s3 : out integer ) ;
end ENT00270 ;

architecture ARCH00270 of ENT00270 is
   component COMP1
   end component ;
begin
   C1 : COMP1;
end ARCH00270 ;

entity ENT00270_1 is
   generic ( g1 : integer ) ;
   port ( s1 : out integer ) ;
begin
end ENT00270_1 ;

architecture ARCH00270_1 of ENT00270_1 is
begin
   s1 <= g1 ;
end ARCH00270_1 ;

use WORK.PKG00270 ;
configuration CONF00270 of WORK.ENT00270 is
   for ARCH00270
      use PKG00270.all ;
      for C1 : COMP1
	 use entity WORK.ENT00270_1 ( ARCH00270_1 )
		generic map ( g5 )
                port map ( s3 ) ;
      end for ;
   end for ;
end CONF00270 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00270_Test_Bench is
end ENT00270_Test_Bench ;

architecture ARCH00270_Test_Bench of ENT00270_Test_Bench is
begin
   L1:
   block
      constant c1 : integer := 5 ;
      signal s1 : integer ;

      component UUT
      end component ;

      for CIS1 : UUT use configuration WORK.CONF00270
	    generic map ( c1 )
	    port map ( s1 ) ;
   begin
      CIS1 : UUT ;
      P00270 :
      process ( s1 )
      begin
         if s1 = 6 then
            test_report ( "ARCH00270" ,
  	  	          "Use clause may appear in a block configuration" ,
		          true ) ;
         end if ;
      end process P00270 ;
   end block L1 ;
end ARCH00270_Test_Bench ;
