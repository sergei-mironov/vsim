-- NEED RESULT: ARCH00657: Multiple interface declarations in correct order passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00657
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.1 (2)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00657(ARCH00657)
--    ENT00657_Test_Bench(ARCH00657_Test_Bench)
--
-- REVISION HISTORY:
--
--    27-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
entity ENT00657 is
   generic (
      cinteger1, cinteger2, cinteger3 : integer ;
      cbool1, cbool2, cbool3 : boolean ;
      cstring1, cstring2, cstring3 : string
           ) ;
   port (
      sinteger1, sinteger2, sinteger3 : integer ;
      sbool1, sbool2, sbool3 : boolean ;
      sstring1, sstring2, sstring3 : string
        ) ;
end ENT00657 ;
--
architecture ARCH00657 of ENT00657 is
   procedure p1 (
      constant cinteger1, cinteger2, cinteger3 : integer ;
      constant cbool1, cbool2, cbool3 : boolean ;
      constant cstring1, cstring2, cstring3 : string ;
      variable vinteger1, vinteger2, vinteger3 : inout integer ;
      variable vbool1, vbool2, vbool3 : inout boolean ;
      variable vstring1, vstring2, vstring3 : inout string ;
      signal sinteger1, sinteger2, sinteger3 : integer ;
      signal sbool1, sbool2, sbool3 : boolean ;
      signal sstring1, sstring2, sstring3 : string ;
      variable correct : out boolean
               ) is
   begin
      correct :=
            cinteger1 = 1 and
	    cinteger2 = 2 and
	    cinteger3 = 3 and
	    cbool1 = true and
	    cbool2 = false and
	    cbool3 = true and
	    cstring1 = "aa" and
	    cstring2 = "bb" and
	    cstring3 = "cc" and
	    vinteger1 = 1 and
	    vinteger2 = 2 and
	    vinteger3 = 3 and
	    vbool1 = true and
	    vbool2 = false and
	    vbool3 = true and
	    vstring1 = "aa" and
	    vstring2 = "bb" and
	    vstring3 = "cc" and
	    sinteger1 = 1 and
	    sinteger2 = 2 and
	    sinteger3 = 3 and
	    sbool1 = true and
	    sbool2 = false and
	    sbool3 = true and
       	    sstring1 = "aa" and
	    sstring2 = "bb" and
	    sstring3 = "cc" ;
   end p1 ;
begin
   process
      subtype str is string ( 1 to 2 ) ;
      variable correct : boolean ;
      variable vinteger1 : integer := cinteger1 ;
      variable vinteger2 : integer := cinteger2 ;
      variable vinteger3 : integer := cinteger3 ;
      variable vbool1 : boolean := cbool1 ;
      variable vbool2 : boolean := cbool2 ;
      variable vbool3 : boolean := cbool3 ;
      variable vstring1 : str := cstring1 ;
      variable vstring2 : str := cstring2 ;
      variable vstring3 : str := cstring3 ;
   begin
      p1 (
           cinteger1, cinteger2, cinteger3,
   	   cbool1, cbool2, cbool3,
	   cstring1, cstring2, cstring3,
	   vinteger1, vinteger2, vinteger3,
	   vbool1, vbool2, vbool3,
	   vstring1, vstring2, vstring3,
	   sinteger1, sinteger2, sinteger3,
	   sbool1, sbool2, sbool3,
	   sstring1, sstring2, sstring3,
           correct ) ;

      test_report ( "ARCH00657" ,
		    "Multiple interface declarations in correct order" ,
                    correct ) ;
      wait ;
   end process ;
end ARCH00657 ;
--
entity ENT00657_Test_Bench is
end ENT00657_Test_Bench ;

architecture ARCH00657_Test_Bench of ENT00657_Test_Bench is
   subtype str is string ( 1 to 2 ) ;
   signal sinteger1 : integer := 1 ;
   signal sinteger2 : integer := 2 ;
   signal sinteger3 : integer := 3 ;
   signal sbool1 : boolean := true ;
   signal sbool2 : boolean := false ;
   signal sbool3 : boolean := true ;
   signal sstring1 : str := "aa" ;
   signal sstring2 : str := "bb" ;
   signal sstring3 : str := "cc" ;
begin
   L1:
   block
      component UUT
         generic (
		   cinteger1, cinteger2, cinteger3 : integer ;
		   cbool1, cbool2, cbool3 : boolean ;
		   cstring1, cstring2, cstring3 : string
                 ) ;
         port (
                sinteger1, sinteger2, sinteger3 : integer ;
		sbool1, sbool2, sbool3 : boolean ;
		sstring1, sstring2, sstring3 : string
              ) ;
      end component ;

      for CIS1 : UUT use entity WORK.ENT00657 ( ARCH00657 ) ;
   begin
      CIS1 : UUT
	 generic map ( 1, 2, 3, true, false, true, "aa", "bb", "cc" )
	 port map ( sinteger1, sinteger2, sinteger3,
		    sbool1, sbool2, sbool3,
		    sstring1, sstring2, sstring3 ) ;
   end block L1 ;
end ARCH00657_Test_Bench ;
--
