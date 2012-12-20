-- NEED RESULT: ARCH00300: Globally static boolean short circuiting passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

-- 
-- TEST NAME: 
-- 
--    CT00300 
-- 
-- AUTHOR: 
-- 
--    A. Wilmot 
-- 
-- TEST OBJECTIVES: 
-- 
--    7.2.1 (6)
--    7.2.1 (7)
-- 
-- DESIGN UNIT ORDERING: 
--
--    ENT00300(ARCH00300)
--    ENT00300_1(ARCH00300_1)
--    ENT00300_Test_Bench(ARCH00300_Test_Bench)
--
-- REVISION HISTORY: 
-- 
--    27-JUL-1987   - initial revision
-- 
-- NOTES:
-- 
--    self-checking
--    this test depends upon constraint checking; if no constraint errors
--    are raised; then the test has passed
-- 
use WORK.STANDARD_TYPES.all ;
entity ENT00300 is
   generic ( g1, g2, g3, g4, g5, g6, g7, g8 : boolean ) ;
end ENT00300 ;

architecture ARCH00300 of ENT00300 is
begin
   P00300 :
   process
   begin
      test_report ( "ARCH00300" ,
		    "Globally static boolean short circuiting" ,
		    g1 and g2 and g3 and g4 and g5 and g6 and g7 and g8 ) ;
      wait ;
   end process P00300 ;
end ARCH00300 ;

entity ENT00300_1 is
   generic (i : integer ) ;
begin
end ENT00300_1 ;

architecture ARCH00300_1 of ENT00300_1 is
begin
   L1:
   block
      component UUT
 	 generic ( g1, g2, g3, g4, g5, g6, g7, g8 : boolean ) ;
      end component ;

      for CIS1 : UUT use entity WORK.ENT00300 ( ARCH00300 ) ;
   begin
         CIS1 : UUT
	    generic map (
         (((i /= 3) and ((boolean'val(i) = true) and (boolean'val(i) = true))) = false
         and (((i /= 3) and (boolean'val(i) = true)) and (boolean'val(i) = true)) = false
         and ((i = 3) and ((i /= 3) and (boolean'val(i) = true))) = false
         and (((i = 3) and (i /= 3)) and (boolean'val(i) = true)) = false
         and ((i = 3) and ((i = 3) and (i /= 3))) = false
         and (((i = 3) and (i = 3)) and (i /= 3)) = false
         and ((i = 3) and ((i = 3) and (i = 3))) = true
         and (((i = 3) and (i = 3)) and (i = 3)) = true ) ,

         (((i > 3) or ((i > 3) or (i > 3))) = false
         and (((i > 3) or (i > 3)) or (i > 3)) = false
         and ((i > 3) or ((i > 3) or (i <= 3))) = true
         and (((i > 3) or (i > 3)) or (i <= 3)) = true
         and ((i > 3) or ((i <= 3) or (boolean'val(i) = true))) = true
         and (((i > 3) or (i <= 3)) or (boolean'val(i) = true)) = true
         and ((i <= 3) or ((boolean'val(i) = true) or (boolean'val(i) = true))) = true
         and (((i <= 3) or (boolean'val(i) = true)) or (boolean'val(i) = true)) = true ) ,

         (((i < 3) or ((i < 3) and (boolean'val(i) = true))) = false
         and (((i < 3) or (i < 3)) and (boolean'val(i) = true)) = false
         and ((i < 3) or ((i >= 3) and (i < 3))) = false
         and (((i < 3) or (i >= 3)) and (i < 3)) = false
         and ((i < 3) or ((i >= 3) and (i >= 3))) = true
         and (((i < 3) or (i >= 3)) and (i >= 3)) = true
         and ((i >= 3) or ((boolean'val(i) = true) and (boolean'val(i) = true))) = true
         and (((i >= 3) or (boolean'val(i) = true)) and (i < 3)) = false
         and (((i >= 3) or (boolean'val(i) = true)) and (i >= 3)) = true ) ,

         (((i /= 3) and ((boolean'val(i) = true) or (boolean'val(i) = true))) = false
         and (((i /= 3) and (boolean'val(i) = true)) or (i /= 3)) = false
         and (((i /= 3) and (boolean'val(i) = true)) or (i = 3)) = true
         and ((i = 3) and ((i /= 3) or (i /= 3))) = false
         and (((i = 3) and (i /= 3)) or (i /= 3)) = false
         and ((i = 3) and ((i /= 3) or (i = 3))) = true
         and (((i = 3) and (i /= 3)) or (i = 3)) = true
         and ((i = 3) and ((i = 3) or (boolean'val(i) = true))) = true
         and (((i = 3) and (i = 3)) or (boolean'val(i) = true)) = true ) ,


         (((i /= 3) nand ((boolean'val(i) = true) nand (boolean'val(i) = true))) = true
         and ((i = 3) nand ((i /= 3) nand (boolean'val(i) = true))) = false
         and ((i = 3) nand ((i = 3) nand (i /= 3))) = false
         and (((i = 3) nand (i = 3)) nand (i /= 3)) = true
         and ((i = 3) nand ((i = 3) nand (i = 3))) = true
         and (((i = 3) nand (i = 3)) nand (i = 3)) = true ) ,

         (((i /= 3) nor ((i /= 3) nor (i /= 3))) = false
         and (((i /= 3) nor (i /= 3)) nor (i /= 3)) = false
         and ((i /= 3) nor ((i /= 3) nor (i = 3))) = true
         and (((i /= 3) nor (i /= 3)) nor (i = 3)) = false
         and ((i /= 3) nor ((i = 3) nor (boolean'val(i) = true))) = true
         and ((i = 3) nor ((boolean'val(i) = true) nor (boolean'val(i) = true))) = false
         ) ,

         (((i /= 3) nor ((i /= 3) nand (boolean'val(i) = true))) = false
         and ((i /= 3) nor ((i = 3) nand (i /= 3))) = false
         and (((i /= 3) nor (i = 3)) nand (i /= 3)) = true
         and ((i /= 3) nor ((i = 3) nand (i = 3))) = true
         and (((i /= 3) nor (i = 3)) nand (i = 3)) = true
         and ((i = 3) nor ((boolean'val(i) = true) nand (boolean'val(i) = true))) = false
         and (((i = 3) nor (boolean'val(i) = true)) nand (i /= 3)) = true
         and (((i = 3) nor (boolean'val(i) = true)) nand (i = 3)) = true
         ) ,

         (((i /= 3) nand ((boolean'val(i) = true) nor (boolean'val(i) = true))) = true
         and (((i /= 3) nand (boolean'val(i) = true)) nor (i /= 3)) = false
         and (((i /= 3) nand (boolean'val(i) = true)) nor (i = 3)) = false
         and ((i = 3) nand ((i /= 3) nor (i /= 3))) = false
         and (((i = 3) nand (i /= 3)) nor (i /= 3)) = false
         and ((i = 3) nand ((i /= 3) nor (i = 3))) = true
         and (((i = 3) nand (i /= 3)) nor (i = 3)) = false
         and ((i = 3) nand ((i = 3) nor (boolean'val(i) = true))) = true
         )) ;
   end block L1 ;
end ARCH00300_1 ;

entity ENT00300_Test_Bench is
end ENT00300_Test_Bench ;
 
architecture ARCH00300_Test_Bench of ENT00300_Test_Bench is
begin
   L1:
   block
      component UUT
   generic (i : integer ) ;
      end component ;
 
      for CIS1 : UUT use entity WORK.ENT00300_1 ( ARCH00300_1 ) ;
   begin
      CIS1 : UUT
	 generic map ( 3 ) ;
   end block L1 ;
end ARCH00300_Test_Bench ;
