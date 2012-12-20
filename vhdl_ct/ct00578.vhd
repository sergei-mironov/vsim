-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00578
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    10.4 (2)
--    11.1 (1)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00578
--    PKG00578/BODY
--    ENT00578(ARCH00578)
--    ENT00578_Test_Bench(ARCH00578_Test_Bench)
--    CONF00578
--
-- REVISION HISTORY:
--
--    20-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
package PKG00578 is
   function F return TIME ;   -- predefined physical type TIME
end PKG00578 ;

package body PKG00578 is
   function F return TIME is
   begin
      return NOW ; -- predefined function NOW
   end F;
end PKG00578 ;

use WORK.PKG00578.all ;
entity ENT00578 is
   generic (G : NATURAL := 0);  -- predefined numeric subtype NATURAL
   port    (P : BIT := '1') ;   -- predefined enumeration type BIT
begin
  assert G < NATURAL'HIGH       -- predefined attribute HIGH
     report "Assert in Entity should never occur -- test failed" ;
end ENT00578 ;

use WORK.STANDARD_TYPES.all;
architecture ARCH00578 of ENT00578 is begin
L_X_1 : block
    subtype ST is BIT_VECTOR (1 to 1) ;  -- predefined array type
    signal S : ST := b"1" ;

begin
    process
    begin
       test_report ( "ARCH00578" ,
		     "Standard is implicitly use'd" ,
		     (G = 1) and
                     (P = '1') and
                     (S = "1") and
                     (F = 0 ns) ) ;
       wait ;
  end process;
end block;
end;

entity ENT00578_Test_Bench is
end ENT00578_Test_Bench ;

architecture ARCH00578_Test_Bench of ENT00578_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00578_Test_Bench ;

configuration CONF00578 of WORK.ENT00578_Test_Bench is
   for ARCH00578_Test_Bench
      for L1
	 for CIS1 : UUT
	    use entity WORK.ENT00578 ( ARCH00578 )
		   generic map ( 1 )
		   port map ( open ) ;
	 end for ;
      end for ;
   end for ;
end CONF00578 ;
