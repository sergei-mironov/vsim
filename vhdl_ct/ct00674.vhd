-- NEED RESULT: ARCH00674_1: Generic clause present in component declaration passed
-- NEED RESULT: ARCH00674_2: Port clause present in component declaration passed
-- NEED RESULT: ARCH00674_3: Generic and port clause present in component declaration passed
-- NEED RESULT: ARCH00674_4: Generic and port clause absent in component declaration passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00674
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.5 (1)
--    4.5 (2)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00674(ARCH00674_1)
--    ENT00674(ARCH00674_2)
--    ENT00674(ARCH00674_3)
--    ENT00674(ARCH00674_4)
--    ENT00674_Test_Bench(ARCH00674_Test_Bench)
--
-- REVISION HISTORY:
--
--     1-SEP-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
entity ENT00674 is
   generic ( g1 : integer := 3 ) ;
   port ( s1 : integer := 3 ) ;
end ENT00674 ;

architecture ARCH00674_1 of ENT00674 is
begin
   process
   begin
      test_report ( "ARCH00674_1" ,
		    "Generic clause present in component declaration" ,
		    s1 = 3 and g1 = 3 ) ;
      wait ;
   end process ;
end ARCH00674_1 ;
--
architecture ARCH00674_2 of ENT00674 is
begin
   process
   begin
      test_report ( "ARCH00674_2" ,
		    "Port clause present in component declaration" ,
		    s1 = 3 and g1 = 3 ) ;
      wait ;
   end process ;
end ARCH00674_2 ;
--
architecture ARCH00674_3 of ENT00674 is
begin
   process
   begin
      test_report ( "ARCH00674_3" ,
		    "Generic and port clause present in component declaration" ,
		    s1 = 3 and g1 = 3 ) ;
      wait ;
   end process ;
end ARCH00674_3 ;
--
architecture ARCH00674_4 of ENT00674 is
begin
   process
   begin
      test_report ( "ARCH00674_4" ,
		    "Generic and port clause absent in component declaration" ,
		    s1 = 3 and g1 = 3 ) ;
      wait ;
   end process ;
end ARCH00674_4 ;
--
entity ENT00674_Test_Bench is
end ENT00674_Test_Bench ;

architecture ARCH00674_Test_Bench of ENT00674_Test_Bench is
begin
   L1:
   block
      signal s1 : integer := 3 ;
      component UUT_1
         generic ( g1 : integer ) ;
      end component ;
      component UUT_2
         port ( s1 : integer ) ;
      end component ;
      component UUT_3
         generic ( g1 : integer ) ;
         port ( s1 : integer ) ;
      end component ;
      component UUT_4
      end component ;

      for CIS1 : UUT_1 use entity WORK.ENT00674 ( ARCH00674_1 ) ;
      for CIS2 : UUT_2 use entity WORK.ENT00674 ( ARCH00674_2 ) ;
      for CIS3 : UUT_3 use entity WORK.ENT00674 ( ARCH00674_3 ) ;
      for CIS4 : UUT_4 use entity WORK.ENT00674 ( ARCH00674_4 ) ;
   begin
      CIS1 : UUT_1
          generic map ( 3 );
      CIS2 : UUT_2
          port map ( s1 ) ;
      CIS3 : UUT_3
          generic map ( 3 )
          port map ( s1 ) ;
      CIS4 : UUT_4 ;
   end block L1 ;
end ARCH00674_Test_Bench ;
--
