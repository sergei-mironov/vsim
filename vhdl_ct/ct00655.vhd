-- NEED RESULT: ARCH00655: (Multiple object) declarations equivalent to multiple (object declarations) (globally static) passed
-- NEED RESULT: ARCH00655: (Multiple object) declarations equivalent to multiple (object declarations) (dynamic) passed
-- NEED RESULT: ARCH00655: (Multiple object) declarations equivalent to multiple (object declarations) (locally static) passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00655
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.1 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00655_1)
--    ENT00655(ARCH00655)
--    ENT00655_Test_Bench(ARCH00655_Test_Bench)
--
-- REVISION HISTORY:
--
--    26-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00655_1 of E00000 is
--
   constant r1 : integer := 1 ;
   constant r2 : integer := 3 ;
   constant c1 : integer := 2 ;
   constant c2 : boolean := false ;
   constant r3 : integer := 2 ;
   constant r4 : integer := 2 ;
   constant c3 : string := "a" ;
   constant c4 : bit_vector := B"0110" ;

   constant cinteger1, cinteger2, cinteger3 : integer range r1 to r2 := c1 ;
   constant cbool1, cbool2, cbool3 : boolean := c2 ;
   constant cstring1, cstring2, cstring3 : string ( r3 to r4 )
                     := c3 ;
   constant cbv1, cbv2, cbv3 : bit_vector := c4 ;
--
   signal sinteger1, sinteger2, sinteger3 : integer range 1 to 3 ;
   signal sbool1, sbool2, sbool3 : boolean ;
   signal sstring1, sstring2, sstring3 : string ( cinteger1 to cinteger2 ) ;
   signal toggle : boolean := false ;
begin
   process
   begin
      sinteger1 <= c1 ;
      sinteger2 <= c1 ;
      sinteger3 <= c1 ;
      sbool1 <= c2 ;
      sbool2 <= c2 ;
      sbool3 <= c2 ;
      sstring1 <= c3 ;
      sstring2 <= c3 ;
      sstring3 <= c3 ;
      toggle <= true ;
      wait ;
   end process ;
   process (toggle)
      variable vinteger1, vinteger2, vinteger3 : integer range 1 to 3
             := 2 ;
      variable vbool1, vbool2, vbool3 : boolean
             := false ;
      variable vstring1, vstring2, vstring3 : string ( cinteger1 to cinteger2 )
             := "a" ;
   begin
      if toggle = true then
         test_report ( "ARCH00655" ,
		    "(Multiple object) declarations equivalent to"
                    & " multiple (object declarations) (locally static)" ,
		    vinteger1 = cinteger1 and cinteger1 = sinteger1
 			and sinteger1 = vinteger2 and
		    vinteger2 = cinteger2 and cinteger2 = sinteger2
			 and sinteger2 = vinteger3 and
		    vinteger3 = cinteger3 and cinteger3 = sinteger3
 			and sinteger3 = vinteger1
                        and vinteger1 = c1 and
		    vbool1 = cbool1 and cbool1 = sbool1
 			and sbool1 = vbool2 and
		    vbool2 = cbool2 and cbool2 = sbool2
			 and sbool2 = vbool3 and
		    vbool3 = cbool3 and cbool3 = sbool3
 			and sbool3 = vbool1
                        and vbool1 = c2 and
		    vstring1 = cstring1 and cstring1 = sstring1
 			and sstring1 = vstring2 and
		    vstring2 = cstring2 and cstring2 = sstring2
			 and sstring2 = vstring3 and
		    vstring3 = cstring3 and cstring3 = sstring3
 			and sstring3 = vstring1
                        and vstring1 = c3 and
		    cbv1 = cbv2 and cbv2 = cbv3 and cbv3 = c4 ) ;
      end if ;
   end process ;
end ARCH00655_1 ;
--
entity ENT00655 is
   generic ( r1 : integer := 1 ;
	     r2 : integer := 3 ;
	     c1 : integer := 2 ;
	     c2 : boolean := false ;
             r3 : integer := 2 ;
	     r4 : integer := 2 ;
	     c3 : string := "a" ;
	     c4 : bit_vector := B"0110" ) ;
end ENT00655 ;

use WORK.STANDARD_TYPES.test_report ;
architecture ARCH00655 of ENT00655 is
--
   constant cinteger1, cinteger2, cinteger3 : integer range r1 to r2 := c1 ;
   constant cbool1, cbool2, cbool3 : boolean := c2 ;
   constant cstring1, cstring2, cstring3 : string ( r3 to r4 )
                     := c3 ;
   constant cbv1, cbv2, cbv3 : bit_vector := c4 ;
--
   signal sinteger1, sinteger2, sinteger3 : integer range 1 to 3 ;
   signal sbool1, sbool2, sbool3 : boolean ;
   signal sstring1, sstring2, sstring3 : string ( cinteger1 to cinteger2 ) ;

   signal toggle : boolean := false ;
   procedure p1 (
                  r1 : integer ;
	          r2 : integer ;
 	          c1 : integer ;
	          c2 : boolean ;
                  r3 : integer ;
	          r4 : integer ;
	          c3 : string ;
	          c4 : bit_vector
                ) is
      constant cinteger1, cinteger2, cinteger3 : integer range r1 to r2 := c1 ;
      constant cbool1, cbool2, cbool3 : boolean := c2 ;
      constant cstring1, cstring2, cstring3 : string ( r3 to r4 )
                     := c3 ;
      constant cbv1, cbv2, cbv3 : bit_vector := c4 ;
--
      variable vinteger1, vinteger2, vinteger3 : integer range 1 to 3
             := 2 ;
      variable vbool1, vbool2, vbool3 : boolean
             := false ;
      variable vstring1, vstring2, vstring3 : string ( cinteger1 to cinteger2 )
             := "a" ;
   begin
      test_report ( "ARCH00655" ,
		    "(Multiple object) declarations equivalent to"
                    & " multiple (object declarations) (dynamic)" ,
		    vinteger1 = cinteger1 and cinteger1 = vinteger2 and
		    vinteger2 = cinteger2 and cinteger2 = vinteger3 and
		    vinteger3 = cinteger3 and cinteger2 = vinteger1
                        and vinteger1 = c1 and
		    vbool1 = cbool1 and cbool1 = vbool2 and
		    vbool2 = cbool2 and cbool2 = vbool3 and
		    vbool3 = cbool3 and cbool2 = vbool1
                        and vbool1 = c2 and
		    vstring1 = cstring1 and cstring1 = vstring2 and
		    vstring2 = cstring2 and cstring2 = vstring3 and
		    vstring3 = cstring3 and cstring2 = vstring1
                        and vinteger1 = c1 and
		    cbv1 = cbv2 and cbv2 = cbv3 and cbv3 = c4 ) ;
   end p1 ;
begin
   process
   begin
      sinteger1 <= c1 ;
      sinteger2 <= c1 ;
      sinteger3 <= c1 ;
      sbool1 <= c2 ;
      sbool2 <= c2 ;
      sbool3 <= c2 ;
      sstring1 <= c3 ;
      sstring2 <= c3 ;
      sstring3 <= c3 ;
      toggle <= true ;
      wait ;
   end process ;
   process (toggle)
      variable vinteger1, vinteger2, vinteger3 : integer range 1 to 3
             := 2 ;
      variable vbool1, vbool2, vbool3 : boolean
             := false ;
      variable vstring1, vstring2, vstring3 : string ( cinteger1 to cinteger2 )
             := "a" ;
   begin
      if toggle = true then
         test_report ( "ARCH00655" ,
		    "(Multiple object) declarations equivalent to"
                    & " multiple (object declarations) (globally static)" ,
		    vinteger1 = cinteger1 and cinteger1 = vinteger2 and
		    vinteger2 = cinteger2 and cinteger2 = vinteger3 and
		    vinteger3 = cinteger3 and cinteger2 = vinteger1
                        and vinteger1 = c1 and
		    vbool1 = cbool1 and cbool1 = vbool2 and
		    vbool2 = cbool2 and cbool2 = vbool3 and
		    vbool3 = cbool3 and cbool2 = vbool1
                        and vbool1 = c2 and
		    vstring1 = cstring1 and cstring1 = vstring2 and
		    vstring2 = cstring2 and cstring2 = vstring3 and
		    vstring3 = cstring3 and cstring2 = vstring1
                        and vinteger1 = c1 and
		    cbv1 = cbv2 and cbv2 = cbv3 and cbv3 = c4 ) ;
         p1 ( 1, 3, 2, false, 2, 2, "a", B"0110" ) ;
      end if ;
   end process ;
end ARCH00655 ;
--
entity ENT00655_Test_Bench is
end ENT00655_Test_Bench ;

architecture ARCH00655_Test_Bench of ENT00655_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00655_1 ) ;
      for CIS2 : UUT use entity WORK.ENT00655 ( ARCH00655 ) ;
   begin
      CIS1 : UUT ;
      CIS2 : UUT ;
   end block L1 ;
end ARCH00655_Test_Bench ;
--
