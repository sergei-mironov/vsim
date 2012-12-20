-- NEED RESULT: ARCH00262: All tests of Sections 2.5 & 2.6  passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00262
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    2.5 (1)
--    2.5 (2)
--    2.5 (3)
--    2.5 (4)
--    2.6 (1)
--    2.6 (2)
--    2.6 (3)
--    2.6 (4)
--
-- DESIGN UNIT ORDERING:
--
--    package_with_all_declaratives
--    empty_package
--    empty_package/BODY
--    package_with_no_body
--    package_with_deferred_constant
--    package_with_deferred_constant/BODY
--    package_with_all_declaratives_in_body
--    package_with_all_declaratives_in_body/BODY
--    E00000(ARCH00262)
--    ENT00262_Test_Bench(ARCH00262_Test_Bench)
--
-- REVISION HISTORY:
--
--    16-JUL-1987   - initial revision
--    16-JUN-1988   - (KLM) changed host file names of file objects
--    28-NOV-1989   - (ESL) changed files to be of mode out
--
-- NOTES:
--
--    self-checking
--
--    2.6 (4) (deferred constants) is checked for formal parameters only,
--    since it is not clear whether they can be used for local generics and
--    local ports, as the test objective states.
--
--

-- the following package shows that all valid declaratives can be put into
-- a package  2.5 (1)
package package_with_all_declaratives is
   procedure proc ( x,y : integer ) ;                   -- subprogram dcl
   type this_type is ( x1, x2, x3 ) ;                   -- type dcl
   subtype this_subtype is this_type range x1 to x2 ;   -- subtype dcl
   constant c : this_subtype := x2 ;                    -- constant dcl
   signal s : this_type := x3 ;                         -- signal dcl
   type ft is file of this_type ;
   file f : ft is out "CT00262.DAT" ;                   -- file dcl
   alias t : this_type is s ;                           -- alais dcl
   component comp                                       -- component dcl
   end component ;
   attribute attr : this_type ;                         -- attribute dcl
   attribute attr of all : signal is x3 ;               -- attribute spec
   disconnect all : this_type after 1 ns ;              -- disconnection spec
   use WORK.STANDARD_TYPES ;                                       -- use clause
   use STANDARD_TYPES.all ;                             -- use clause
end package_with_all_declaratives ;

-- the following package shows that no declaratives need be given 2.5(2), 2.6(3)
-- and that the name after the "end" keyword is optional  2.5(3), 2.6(1)
package empty_package is
end ;
package body empty_package is
end empty_package ;

-- the following package shows that no body is needed if there are no
-- subprogram declarations or deferred constants   2.5 (4)
use work.empty_package;
package package_with_no_body is
   type this_type is ( x1, x2, x3 ) ;                   -- type dcl
   subtype this_subtype is this_type range x1 to x2 ;   -- subtype dcl
   constant c : this_subtype := x2 ;                    -- constant dcl
   signal s : this_type := x3 ;                         -- signal dcl
   type ft is file of this_type ;
   file f : ft is out "CT00262.DAT" ;                   -- file dcl
   alias t : this_type is s ;                           -- alais dcl
   component comp                                       -- component dcl
   end component ;
   attribute attr : this_type ;                         -- attribute dcl
   attribute attr of all : signal is x3 ;               -- attribute spec
   disconnect all : this_type after 1 ns ;              -- disconnection spec
   use empty_package.all ;                              -- use clause
end package_with_no_body ;

package package_with_deferred_constant  is
   constant k : integer;
   function f ( i : integer;
                j : integer := k) return integer;      -- this tests 2.6 (4)
end package_with_deferred_constant ;
package body package_with_deferred_constant  is
   constant k : integer := 8;
   function f ( i : integer;
                j : integer := k) return integer is
   begin
      return i*j ;
   end f;
end package_with_deferred_constant ;


-- the following package shows that all valid declaratives can be put into
-- a package body  2.6 (2)
package package_with_all_declaratives_in_body is
   constant cc : bit := '1' ;                  -- constant dcl
end package_with_all_declaratives_in_body ;
package body package_with_all_declaratives_in_body is
   procedure pp ( a,b,c : bit ) ;              -- subprogram dcl
   procedure pp ( a,b,c : bit ) is             -- subprogram body
   begin
   end pp ;
   type tt is ( tt1, tt2, tt3 ) ;              -- type dcl
   subtype tt_sub is tt range tt1 to tt2 ;     -- subtype dcl
   type fft is file of bit ;
   file ff : fft is out "CT00262.DAT" ;        -- file dcl
   alias cc_alias : bit is cc ;                -- alias dcl
   use work.empty_package.all;                 -- use clause
end package_with_all_declaratives_in_body ;

use WORK.STANDARD_TYPES.all ;
use work.package_with_no_body.all ;
use work.package_with_all_declaratives_in_body.all ;
use work.package_with_deferred_constant.all ;
architecture ARCH00262 of E00000 is
begin
   P :
   process
      variable v : this_type := x2 ;
   begin
      test_report ( "ARCH00262" ,
		    "All tests of Sections 2.5 & 2.6 " ,
		    (v = c) and
                    (cc = '1') and
                    (work.package_with_deferred_constant.f(20) = 20*8)
                  ) ;
      wait ;
   end process P ;
end ARCH00262 ;

entity ENT00262_Test_Bench is
end ENT00262_Test_Bench ;

architecture ARCH00262_Test_Bench of ENT00262_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00262 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00262_Test_Bench ;

