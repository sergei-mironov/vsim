-- NEED RESULT: ARCH00272: Configuration item in block configuration may be block or component configuration passed
-- NEED RESULT: ARCH00272: Block specification may be architecture name or block label passed
-- NEED RESULT: ARCH00272: Several configuration item may appear in a block configuration and block configurations may be nested to an arbitrary depth passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00272
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.3.1 (3)
--    1.3.1 (4)
--    1.3.1 (5)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00272(ARCH00272)
--    ENT00272_1(ARCH00272_1)
--    CONF00272
--    ENT00272_Test_Bench(ARCH00272_Test_Bench)
--
-- REVISION HISTORY:
--
--    17-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
entity ENT00272 is
   generic ( g10, g11, g12 : integer ) ;
   port ( s10, s11, s12 : out integer ) ;
end ENT00272 ;

architecture ARCH00272 of ENT00272 is
   component COMP1
   end component ;
begin
   C1 : COMP1;
   B1_1 :
   block
   begin
      B2_2 :
      block
         component COMP1
         end component ;
      begin
	 CIS1 : COMP1;
      end block B2_2 ;
      B2_3 :
      block
      begin
	 B3_4 :
	 block
            component COMP1
            end component ;
	 begin
 	    CIS1 : COMP1;
	 end block B3_4 ;
      end block B2_3 ;
   end block B1_1 ;
end ARCH00272 ;

entity ENT00272_1 is
   generic ( g1 : integer ) ;
   port ( s1 : out integer ) ;
begin
end ENT00272_1 ;

architecture ARCH00272_1 of ENT00272_1 is
begin
   s1 <= g1 ;
end ARCH00272_1 ;

configuration CONF00272 of WORK.ENT00272 is
   for ARCH00272
      for C1 : COMP1
	 use entity WORK.ENT00272_1 ( ARCH00272_1 )
		generic map ( g10 )
                port map ( s10 ) ;
      end for ;
      for B1_1
	 for B2_2
	    for CIS1 : COMP1
	       use entity WORK.ENT00272_1 ( ARCH00272_1 )
  		      generic map ( g11 )
                      port map ( s11 ) ;
            end for ;
         end for ; -- B2_2 component
         for B2_3
            for B3_4
   	       for CIS1 : COMP1                        -- 3 deep
		  use entity WORK.ENT00272_1 ( ARCH00272_1 )
  		            generic map ( g12 )
                            port map ( s12 ) ;
	       end for ;
	    end for ; -- B3_4
         end for ; -- B2_3
      end for ; -- B1_1
   end for ;
end CONF00272 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00272_Test_Bench is
end ENT00272_Test_Bench ;

architecture ARCH00272_Test_Bench of ENT00272_Test_Bench is
begin
   L1:
   block
      constant c1 : integer := 1 ;
      constant c2 : integer := 2 ;
      constant c3 : integer := 3 ;
      signal s1, s2, s3 : integer ;

      component UUT
      end component ;

      for CIS1 : UUT use configuration WORK.CONF00272
	    generic map ( c1, c2, c3 )
	    port map ( s1, s2, s3 ) ;
   begin
      CIS1 : UUT ;
      P00272 :
      process ( s1, s2, s3 )
      begin
         if s1 = c1 and s2 = c2 and s3 = c3 then
            test_report ( "ARCH00272" ,
  	  	          "Configuration item in block configuration may"
                          & " be block or component configuration" ,
                          true ) ;
            test_report ( "ARCH00272" ,
  	  	          "Block specification may be architecture name"
                          & " or block label" ,
                          true ) ;
            test_report ( "ARCH00272" ,
  	  	          "Several configuration item may appear in a block"
                          & " configuration and block configurations may be"
                          & " nested to an arbitrary depth" ,
                          true ) ;
         end if ;
      end process P00272 ;
   end block L1 ;
end ARCH00272_Test_Bench ;
