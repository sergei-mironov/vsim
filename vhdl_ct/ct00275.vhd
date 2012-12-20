-- NEED RESULT: ARCH00275: Don't need to completely specify configuration items in block configurations passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00275
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    1.3.1 (7)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00275_1(ARCH00275_1)
--    ENT00275(ARCH00275)
--    CONF00275
--    ENT00275_Test_Bench(ARCH00275_Test_Bench)
--
-- REVISION HISTORY:
--
--    17-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
entity ENT00275_1 is
   generic ( g1 : integer ) ;
   port ( s1 : out integer ) ;
begin
end ENT00275_1 ;

architecture ARCH00275_1 of ENT00275_1 is
begin
   s1 <= g1 ;
end ARCH00275_1 ;

entity ENT00275 is
   generic ( g10, g11, g12, g13 : integer ) ;
   port ( s10, s11, s12, s13 : out integer ) ;
end ENT00275 ;

architecture ARCH00275 of ENT00275 is
   component COMP1
   end component ;
   for C1 : COMP1  use entity WORK.ENT00275_1 ( ARCH00275_1 )
		        generic map ( g10 )
                        port map ( s10 ) ;
   for CIS1 : COMP1  use entity WORK.ENT00275_1 ( ARCH00275_1 )
		        generic map ( g13 )
                        port map ( s13 ) ;
begin
   C1 : COMP1;
   B1_1 :
   block
   begin
      B2_2 :
      block
         for CIS1 : COMP1  use entity WORK.ENT00275_1 ( ARCH00275_1 )
		              generic map ( g11 )
                              port map ( s11 ) ;
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
   CIS1 : COMP1;
end ARCH00275 ;

configuration CONF00275 of WORK.ENT00275 is
   for ARCH00275
      for C1 : COMP1
      end for ;
      for B1_1
         for B2_3
            for B3_4
	       for CIS1 : COMP1                        -- 3 deep
		     use entity WORK.ENT00275_1 ( ARCH00275_1 )
  		            generic map ( g12 )
                            port map ( s12 ) ;
	       end for ; -- B3_4 component
	    end for ; -- B3_4
	 end for ; -- B2_3
      end for ; -- B1_1
   end for ;
end CONF00275 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00275_Test_Bench is
end ENT00275_Test_Bench ;

architecture ARCH00275_Test_Bench of ENT00275_Test_Bench is
begin
   L1:
   block
      constant c1 : integer := 1 ;
      constant c2 : integer := 2 ;
      constant c3 : integer := 3 ;
      constant c4 : integer := 4 ;
      signal s1, s2, s3, s4 : integer ;

      component UUT
         generic ( g10, g11, g12, g13 : integer ) ;
         port ( s10, s11, s12, s13 : out integer ) ;
      end component ;

      for CIS1 : UUT use configuration WORK.CONF00275 ;
   begin
      CIS1 : UUT
	    generic map ( c1, c2, c3, c4 )
	    port map ( s1, s2, s3, s4 ) ;
      P00275 :
      process ( s1, s2, s3, s4 )
      begin
         if s1 = c1 and s2 = c2 and s3 = c3 and s4 = c4 then
            test_report ( "ARCH00275" ,
  	  	          "Don't need to completely specify configuration items"
                          & " in block configurations" ,
                          true ) ;
         end if ;
      end process P00275 ;
   end block L1 ;
end ARCH00275_Test_Bench ;
