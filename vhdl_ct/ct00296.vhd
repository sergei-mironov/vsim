-- NEED RESULT: ARCH00296: ARRAY TYPES passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00296
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    3.2.1 (1)
--    3.2.1 (2)
--    3.2.1 (3)
--    3.2.1 (4)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00296)
--    ENT00296_Test_Bench(ARCH00296_Test_Bench)
--
-- REVISION HISTORY:
--
--    24-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00296 of E00000 is
   -- the type t_enum1 is from STANDARD_TYPES
   type unconstrained_array is array ( bit range <> ,
                                       boolean range <>,
                                       character range <>,
                                       integer range <>,
                                       t_enum1 range <> )
                                    of integer ;
   subtype constrained_array_0 is unconstrained_array
                                       ( bit range '0' to '1' ,
                                         boolean range false to true,
                                         character range 'a' to 'c',
                                         integer range 1 downto -1,
                                         t_enum1 range t_enum1'left to
                                                       t_enum1'right ) ;
   type constrained_array_1 is array ( bit range '0' to '1' ,
                                       boolean range false to true,
                                       character range 'a' to 'c',
                                       integer range 1 downto -1,
                                       t_enum1 range t_enum1'left to
                                                     t_enum1'right )
                                    of bit ;
   type constrained_array_2 is array ( bit'left to bit'right,
                                             -- '0' to '1' is unresolvable
                                       false to true,
                                       'a' to 'c',
                                       integer (1) downto integer (-1),
                                       t_enum1'left to t_enum1'right )
                                    of boolean ;
begin
   P :
   process
      variable c0 : constrained_array_0 ;
      variable c1 : constrained_array_1 ;
      variable c2 : constrained_array_2 ;
   begin
      for bi in bit range '0' to '1' loop
         for bo in boolean range false to true loop
            for ch in character range 'a' to 'c' loop
               for i in integer range 1 downto -1 loop
                  for e in t_enum1 range t_enum1'left to t_enum1'right loop
                     c0 (bi, bo, ch, i, e) :=  bit'pos(bi) +
                                               boolean'pos(bo) +
                                               character'pos(ch) +
                                               i +
                                               t_enum1'pos(e) ;
                     c1 (bi, bo, ch, i, e) :=  bi ;
                     c2 (bi, bo, ch, i, e) :=  bo xor boolean'val(abs(i)) ;
                  end loop ;
               end loop ;
            end loop ;
         end loop ;
      end loop ;
      test_report ( "ARCH00296" ,
		    "ARRAY TYPES" ,
		    ( c0 ('0', false, 'a', 0, en1) = character'pos('a') ) and
                    ( c0 ('1', true, 'b', 1, en2) = 4 + character'pos('b') ) and
                    ( c1 ('0', true, 'c', -1, en3) = '0' ) and
                    ( c1 ('1', true, 'c', -1, en3) = '1' ) and
                    ( c2 ('1', true, 'c', -1, en3) =  false ) and
                    ( c2 ('1', true, 'c',  1, en3) =  false ) and
                    ( c2 ('1', true, 'c',  0, en3) =  true ) and
                    ( c2 ('1', false, 'c', -1, en3) =  true ) and
                    ( c2 ('1', false, 'c',  1, en3) =  true ) and
                    ( c2 ('1', false, 'c',  0, en3) =  false )
                  ) ;
      wait ;
   end process P ;
end ARCH00296 ;

entity ENT00296_Test_Bench is
end ENT00296_Test_Bench ;

architecture ARCH00296_Test_Bench of ENT00296_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00296 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00296_Test_Bench ;
--
