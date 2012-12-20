-- NEED RESULT: ARCH00274: Scope of items in corresponding block extend within corresponding block configuration passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00274
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.3.1 (6)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00274(ARCH00274)
--    ENT00274_1(ARCH00274_1)
--    CONF00274
--    ENT00274_Test_Bench(ARCH00274_Test_Bench)
--
-- REVISION HISTORY:
--
--    17-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
entity ENT00274 is
   generic ( g10, g11, g12 : integer ) ;
   port ( s10, s11, s12 : out integer ) ;
end ENT00274 ;

architecture ARCH00274 of ENT00274 is
   component COMP1
   end component ;
   constant g8 : integer := 8 ;
begin
   C1 : COMP1;
   B1_1 :
   block
   begin
      B2_2 :
      block
      begin
	 CIS1 : COMP1;
      end block B2_2 ;
      B2_3 :
      block
      begin
	 B3_4 :
	 block
	 begin
 	    CIS1 : COMP1;
	 end block B3_4 ;
      end block B2_3 ;
   end block B1_1 ;
end ARCH00274 ;

entity ENT00274_1 is
   generic ( g1 : integer ) ;
   port ( s1 : out integer ) ;
begin
end ENT00274_1 ;

architecture ARCH00274_1 of ENT00274_1 is
begin
   s1 <= g1 ;
end ARCH00274_1 ;

configuration CONF00274 of WORK.ENT00274 is
-- g8 visible all over the place !!!
   for ARCH00274
      for C1 : COMP1
	 use entity WORK.ENT00274_1 ( ARCH00274_1 )
		generic map ( g8 )
                port map ( s10 ) ;
      end for ;
      for B1_1
	 for B2_2
	    for CIS1 : COMP1
	       use entity WORK.ENT00274_1 ( ARCH00274_1 )
  		      generic map ( g8 )
                      port map ( s11 ) ;
	    end for ;
         end for ; -- B2_2 component
	 for B2_3
	    for B3_4
	       for CIS1 : COMP1                        -- 3 deep
		     use entity WORK.ENT00274_1 ( ARCH00274_1 )
  		            generic map ( g8 )
                            port map ( s12 ) ;
	       end for ;
	    end for ; -- B3_4
	 end for ; -- B2_3
      end for ; -- B1_1
   end for ;
end CONF00274 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00274_Test_Bench is
end ENT00274_Test_Bench ;

architecture ARCH00274_Test_Bench of ENT00274_Test_Bench is
begin
   L1:
   block
      constant c1 : integer := 1 ;
      constant c2 : integer := 2 ;
      constant c3 : integer := 3 ;
      signal s1, s2, s3 : integer ;

      component UUT
      end component ;

      for CIS1 : UUT use configuration WORK.CONF00274
	    generic map ( c1, c2, c3 )
	    port map ( s1, s2, s3 ) ;
   begin
      CIS1 : UUT ;
      P00274 :
      process ( s1, s2, s3 )
      begin
         if s1 = 8 and s2 = 8 and s3 = 8 then
            test_report ( "ARCH00274" ,
  	  	          "Scope of items in corresponding block extend"
                          & " within corresponding block configuration" ,
                          true ) ;
         end if ;
      end process P00274 ;
   end block L1 ;
end ARCH00274_Test_Bench ;
