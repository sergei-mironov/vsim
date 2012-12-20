-- NEED RESULT: ARCH00276: Mutually nested block and component configurations passed
-- NEED RESULT: ARCH00276: Block configuration optional in component configuration passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00276
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.3.2 (1)
--    1.3.2 (3)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00276(ARCH00276)
--    ENT00276_2(ARCH00276_2)
--    ENT00276_3(ARCH00276_3)
--    ENT00276_4(ARCH00276_4)
--    CONF00276
--    ENT00276_Test_Bench(ARCH00276_Test_Bench)
--
-- REVISION HISTORY:
--
--    21-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
entity ENT00276 is
   generic ( g_character : character ) ;
   port ( s_character : out character ) ;
end ENT00276 ;

architecture ARCH00276 of ENT00276 is
   component COMP1
   end component ;
begin
   CIS1 : COMP1 ;
end ARCH00276 ;

entity ENT00276_2 is
   generic ( g_character : character ) ;
   port ( s_character : out character ) ;
end ENT00276_2 ;

architecture ARCH00276_2 of ENT00276_2 is
   component COMP1
   end component ;
begin
   CIS1 : COMP1 ;
end ARCH00276_2 ;

entity ENT00276_3 is
   generic ( g_character : character ) ;
   port ( s_character : out character ) ;
end ENT00276_3 ;

architecture ARCH00276_3 of ENT00276_3 is
   component COMP1
   end component ;
begin
   CIS1 : COMP1 ;
end ARCH00276_3 ;

entity ENT00276_4 is
   generic ( g_character : character ) ;
   port ( s_character : out character ) ;
end ENT00276_4 ;

architecture ARCH00276_4 of ENT00276_4 is
begin
   s_character <= g_character ;
end ARCH00276_4 ;

configuration CONF00276 of WORK.ENT00276 is
   for ARCH00276
      for CIS1 : COMP1
	 use entity WORK.ENT00276_2 ( ARCH00276_2 )
		generic map ( g_character )
		port map ( s_character ) ;
	 for ARCH00276_2
	    for CIS1 : COMP1
		use entity WORK.ENT00276_3 ( ARCH00276_3 )
		       generic map ( g_character )
		       port map ( s_character ) ;
	       for ARCH00276_3
		  for CIS1 : COMP1
		     use entity WORK.ENT00276_4 ( ARCH00276_4 )
			    generic map ( g_character )
			    port map ( s_character ) ;
		  end for ;
	       end for ;
	    end for ;
	 end for ;
      end for ;
   end for ;
end CONF00276 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00276_Test_Bench is
end ENT00276_Test_Bench ;

architecture ARCH00276_Test_Bench of ENT00276_Test_Bench is
begin
   L1:
   block
      signal s1 : character ;
      constant c1 : character := 'a' ;

      component UUT
      end component ;

      for CIS1 : UUT use configuration WORK.CONF00276
	    generic map ( c1 )
	    port map ( s1 ) ;
   begin
      CIS1 : UUT ;
      P00276 :
      process ( s1 )
      begin
         if s1 = c1 then
	    test_report ( "ARCH00276" ,
		          "Mutually nested block and component configurations" ,
		          true ) ;
	    test_report ( "ARCH00276" ,
		          "Block configuration optional in component"
                          & " configuration" ,
		          true ) ;
         end if ;
      end process ;
   end block L1 ;
end ARCH00276_Test_Bench ;
