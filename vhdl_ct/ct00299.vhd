-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

-- 
-- TEST NAME: 
-- 
--    CT00299 
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
--    E00000(ARCH00299)
--    ENT00299_Test_Bench(ARCH00299_Test_Bench)
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
architecture ARCH00299 of E00000 is
begin
   P00299 :
   process
      constant boolean0 : boolean := false ;
      constant boolean1 : boolean := true ; 
      variable bool, bool0 : boolean := true ;
      constant i : integer := 3 ;
   begin
      bool0 := true ;
      case bool0 is
       when (((i /= 3) and ((boolean'val(i) = true) and (boolean'val(i) = true))) = false
         and (((i /= 3) and (boolean'val(i) = true)) and (boolean'val(i) = true)) = false
         and ((i = 3) and ((i /= 3) and (boolean'val(i) = true))) = false
         and (((i = 3) and (i /= 3)) and (boolean'val(i) = true)) = false
         and ((i = 3) and ((i = 3) and (i /= 3))) = false
         and (((i = 3) and (i = 3)) and (i /= 3)) = false
         and ((i = 3) and ((i = 3) and (i = 3))) = true
         and (((i = 3) and (i = 3)) and (i = 3)) = true ) =>
          bool := bool and true ;
       when false =>
          bool := false ;
      end case ;

      bool0 := true ;
      case bool0 is
       when (((i > 3) or ((i > 3) or (i > 3))) = false
        and (((i > 3) or (i > 3)) or (i > 3)) = false
        and ((i > 3) or ((i > 3) or (i <= 3))) = true
        and (((i > 3) or (i > 3)) or (i <= 3)) = true
        and ((i > 3) or ((i <= 3) or (boolean'val(i) = true))) = true
        and (((i > 3) or (i <= 3)) or (boolean'val(i) = true)) = true
        and ((i <= 3) or ((boolean'val(i) = true) or (boolean'val(i) = true))) = true
        and (((i <= 3) or (boolean'val(i) = true)) or (boolean'val(i) = true)) = true ) =>
          bool := bool and true ;
       when false =>
          bool := false ;
      end case ;


      bool0 := true ;
      case bool0 is
       when (((i < 3) or ((i < 3) and (boolean'val(i) = true))) = false
        and (((i < 3) or (i < 3)) and (boolean'val(i) = true)) = false
        and ((i < 3) or ((i >= 3) and (i < 3))) = false
        and (((i < 3) or (i >= 3)) and (i < 3)) = false
        and ((i < 3) or ((i >= 3) and (i >= 3))) = true
        and (((i < 3) or (i >= 3)) and (i >= 3)) = true
        and ((i >= 3) or ((boolean'val(i) = true) and (boolean'val(i) = true))) = true
        and (((i >= 3) or (boolean'val(i) = true)) and (i < 3)) = false
        and (((i >= 3) or (boolean'val(i) = true)) and (i >= 3)) = true ) =>
          bool := bool and true ;
       when false =>
          bool := false ;
      end case ;


      bool0 := true ;
      case bool0 is
       when (((i /= 3) and ((boolean'val(i) = true) or (boolean'val(i) = true))) = false
        and (((i /= 3) and (boolean'val(i) = true)) or (i /= 3)) = false
        and (((i /= 3) and (boolean'val(i) = true)) or (i = 3)) = true
        and ((i = 3) and ((i /= 3) or (i /= 3))) = false
        and (((i = 3) and (i /= 3)) or (i /= 3)) = false
        and ((i = 3) and ((i /= 3) or (i = 3))) = true
        and (((i = 3) and (i /= 3)) or (i = 3)) = true
        and ((i = 3) and ((i = 3) or (boolean'val(i) = true))) = true
        and (((i = 3) and (i = 3)) or (boolean'val(i) = true)) = true ) =>
          bool := bool and true ;
       when false =>
          bool := false ;
      end case ;

--
      bool0 := true ;
      case bool0 is
       when (((i /= 3) nand ((boolean'val(i) = true) nand (boolean'val(i) = true))) = true
        and (((i /= 3) nand (boolean'val(i) = true)) nand (i /= 3)) = true
        and ((i = 3) nand ((i /= 3) nand (boolean'val(i) = true))) = false
        and (((i = 3) nand (i /= 3)) nand (i /= 3)) = true
        and ((i = 3) nand ((i = 3) nand (i /= 3))) = false
        and (((i = 3) nand (i = 3)) nand (i /= 3)) = true
        and ((i = 3) nand ((i = 3) nand (i = 3))) = true
        and (((i = 3) nand (i = 3)) nand (i = 3)) = true ) =>
          bool := bool and true ;
       when false =>
          bool := false ;
      end case ;


      bool0 := true ;
      case bool0 is
       when (((i /= 3) nor ((i /= 3) nor (i /= 3))) = false
        and (((i /= 3) nor (i /= 3)) nor (i /= 3)) = false
        and ((i /= 3) nor ((i /= 3) nor (i = 3))) = true
        and (((i /= 3) nor (i /= 3)) nor (i = 3)) = false
        and ((i /= 3) nor ((i = 3) nor (boolean'val(i) = true))) = true
        and (((i /= 3) nor (i = 3)) nor (i /= 3)) = true
        and ((i = 3) nor ((boolean'val(i) = true) nor (boolean'val(i) = true))) = false
      and (((i = 3) nor (boolean'val(i) = true)) nor (i /= 3)) = true)  =>
          bool := bool and true ;
       when false =>
          bool := false ;
      end case ;


      bool0 := true ;
      case bool0 is
       when (((i /= 3) nor ((i /= 3) nand (boolean'val(i) = true))) = false
        and (((i /= 3) nor (i /= 3)) nand (i = 3)) = false
        and ((i /= 3) nor ((i = 3) nand (i /= 3))) = false
        and (((i /= 3) nor (i = 3)) nand (i /= 3)) = true
        and ((i /= 3) nor ((i = 3) nand (i = 3))) = true
        and (((i /= 3) nor (i = 3)) nand (i = 3)) = true
        and ((i = 3) nor ((boolean'val(i) = true) nand (boolean'val(i) = true))) = false
        and (((i = 3) nor (boolean'val(i) = true)) nand (i /= 3)) = true
        and (((i = 3) nor (boolean'val(i) = true)) nand (i = 3)) = true ) =>
          bool := bool and true ;
       when false =>
          bool := false ;
      end case ;


      bool0 := true ;
      case bool0 is
       when (((i /= 3) nand ((boolean'val(i) = true) nor (boolean'val(i) = true))) = true
        and (((i /= 3) nand (boolean'val(i) = true)) nor (i /= 3)) = false
        and (((i /= 3) nand (boolean'val(i) = true)) nor (i = 3)) = false
        and ((i = 3) nand ((i /= 3) nor (i /= 3))) = false
        and (((i = 3) nand (i /= 3)) nor (i /= 3)) = false
        and ((i = 3) nand ((i /= 3) nor (i = 3))) = true
        and (((i = 3) nand (i /= 3)) nor (i = 3)) = false
        and ((i = 3) nand ((i = 3) nor (boolean'val(i) = true))) = true
        and (((i = 3) nand (i /= 3)) nor (boolean'val(i) = true)) = false ) =>
          bool := bool and true ;
       when false =>
          bool := false ;
      end case ;


      test_report ( "ARCH00299" ,
		    "Locally static boolean short circuiting" ,
		    bool ) ;
      wait ;
    end process P00299 ;
end ARCH00299 ;

entity ENT00299_Test_Bench is
end ENT00299_Test_Bench ;
 
architecture ARCH00299_Test_Bench of ENT00299_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
 
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00299 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00299_Test_Bench ;
