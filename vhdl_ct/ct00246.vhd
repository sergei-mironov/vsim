-- NEED RESULT: ARCH00246: All formal modes and classes are allowed default classes tested passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00246
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    2.1.1 (1)
--    2.1.1 (2)
--    2.1.1 (3)
--    2.1.1 (4)
--    2.1.1 (5)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00246)
--    ENT00246_Test_Bench(ARCH00246_Test_Bench)
--
-- REVISION HISTORY:
--
--    15-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00246 of E00000 is

   signal   s : integer := 25;

   -- the following procedure tests 2.1.1 (2)
   -- it also tests 2.1.1 (1) by assigning variables to the
   -- inout and out parameters
   procedure proc_with_all_formal_modes ( x : in integer;
					  y : inout integer;
					  z : out integer)    is
   begin
      z := y;
      y := x;
   end proc_with_all_formal_modes ;

   -- the following procedure tests 2.1.1 (3)
   procedure proc_with_all_formal_classes ( constant c : integer;
				            variable v : out integer;
					    signal   s : integer) is
   begin
      v := c + s ;
   end proc_with_all_formal_classes ;

   -- the following function tests 2.1.1 (4)
   function func_with_all_formal_modes ( x : in integer) return integer is
   begin
      return x + 1;
   end func_with_all_formal_modes ;

   -- the following function tests 2.1.1 (5)
   function func_with_all_formal_classes ( constant c : integer;
				           signal   s : integer)
                                         return integer is
   begin
      return c + s;
   end func_with_all_formal_classes ;

begin
   P :
   process
      constant c : integer := 101;
      variable v : integer := 150;
      variable w : integer := 200;
      variable x : integer := 300;
      variable y : integer := 400;
      variable z : integer := 500;
   begin
      proc_with_all_formal_modes (x, y, z);
      proc_with_all_formal_classes (c, v, s) ;
      test_report ( "ARCH00246" ,
                    "All formal modes and classes are allowed " &
                    "default classes tested",
                    (func_with_all_formal_modes (w) = w+1) and
                    (func_with_all_formal_classes (c, s) = c+25) and
		    (v = c+25) and
                    (z = 400) and
                    (y = 300) and
                    (x = 300)
                  ) ;
      wait ;
   end process P ;
end ARCH00246 ;

entity ENT00246_Test_Bench is
end ENT00246_Test_Bench ;

architecture ARCH00246_Test_Bench of ENT00246_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00246 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00246_Test_Bench ;

