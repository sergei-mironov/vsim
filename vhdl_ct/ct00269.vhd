-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00269
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.3 (2)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00269
--    ENT00269(ARCH00269)
--    ENT00269_1(ARCH00269_1)
--    CONF00269
--    CONF00269_1
--    ENT00269_Test_Bench(ARCH00269_Test_Bench)
--
-- REVISION HISTORY:
--
--    17-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
package PKG00269 is
   attribute has_ending_name : boolean ;
end PKG00269 ;

entity ENT00269 is
   generic ( g3 : integer ) ;
   port ( s3 : out integer ) ;
end ENT00269 ;

architecture ARCH00269 of ENT00269 is
   component COMP1
   end component ;
begin
   C1 : COMP1;
end ARCH00269 ;

entity ENT00269_1 is
   generic ( g1 : integer ) ;
   port ( s1 : out integer ) ;
begin
end ENT00269_1 ;

architecture ARCH00269_1 of ENT00269_1 is
begin
   s1 <= g1 ;
end ARCH00269_1 ;

configuration CONF00269 of WORK.ENT00269 is
   use WORK.PKG00269.all ;
   attribute has_ending_name of CONF00269 : configuration is true ;
   for ARCH00269
      for C1 : COMP1
	 use entity WORK.ENT00269_1 ( ARCH00269_1 )
		generic map ( g3 )
                port map ( s3 ) ;
      end for ;
   end for ;
end CONF00269 ;

configuration CONF00269_1 of WORK.ENT00269 is
   use WORK.PKG00269.has_ending_name ;
   attribute has_ending_name of CONF00269_1 : configuration is false ;
   for ARCH00269
      for C1 : COMP1
	 use entity WORK.ENT00269_1 ( ARCH00269_1 )
		generic map ( g3 )
                port map ( s3 ) ;
      end for ;
   end for ;
end ;

use WORK.PKG00269.all ;
use WORK.STANDARD_TYPES.all ;
entity ENT00269_Test_Bench is
end ENT00269_Test_Bench ;

architecture ARCH00269_Test_Bench of ENT00269_Test_Bench is
begin
   L1:
   block
      constant c1, c2 : integer := 5 ;
      signal s1, s2 : integer ;

      component UUT
      end component ;

      for CIS1 : UUT use configuration WORK.CONF00269
	    generic map ( c1 )
	    port map ( s1 ) ;
      for CIS2 : UUT use configuration WORK.CONF00269_1
	    generic map ( c2 )
	    port map ( s2 ) ;
   begin
      CIS1 : UUT ;
      CIS2 : UUT ;
      P00269 :
      process ( s1, s2 )
      begin
         if s1 = c1 and s2 = c2 then
            test_report ( "ARCH00269" ,
  	  	          "Use clauses and attribute specifications may"
                          & " appear in a configuration declaration" ,
		          WORK.CONF00269'has_ending_name and
                            not (WORK.CONF00269_1'has_ending_name) ) ;
         end if ;
      end process P00269 ;
   end block L1 ;
end ARCH00269_Test_Bench ;
