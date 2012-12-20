-- NEED RESULT: PKG00523.PkgProc: Declarative region direct visibility test passed
-- NEED RESULT: PKG00523.PkgProc: Declarative region direct visibility test passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00523
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    10.3 (1)
--    10.3 (2)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00523
--    PKG00523/BODY
--    E00000(ARCH00523)
--    ENT00523_Test_Bench(ARCH00523_Test_Bench)
--
-- REVISION HISTORY:
--
--    14-AUG-1987   - initial revision
--    17-JUN-1988   - (KLM) changed host names of file objects
--    28-NOV-1989   - (ESL) change files to be of mode out
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
package PKG00523 is
   component PkgComp
      generic ( G : boolean ) ;
      port ( P : boolean ) ;
   end component ;

   subtype PkgSubtype is Bit_Vector (1 to 3) ;
   type PkgType is record
		      f1 : boolean ;
		      f2 : PkgSubtype ;
		   end record ;

   constant PkgCons : PkgType := (f1 => True,
                                  f2 => PkgSubtype'(others => '1')) ;

   signal PkgSig : PkgSubtype := (1 to 3 => PkgCons.f2(2)) ;
   alias PkgAlias : bit is PkgSig(2) ;

   type PkgFileType is file of boolean ;
   file PkgFile : PkgFileType is out "ct00523.dat";

   attribute PkgAttr : boolean ;
   attribute PkgAttr of PkgFileType : type is PkgCons.f1 ;

   procedure PkgProc (parm1 : boolean) ;
end PKG00523 ;

package body PKG00523 is

   subtype PkgBSubtype is PkgSubtype ;
   type PkgBType is record
		      f1 : boolean ;
		      f2 : PkgBSubtype ;
		   end record ;

   constant PkgBCons : PkgBType := (f1 => PkgCons.f1,
                                    f2 => PkgBSubtype'(PkgCons.f2)) ;

   alias PkgBAlias : bit is PkgbCons.f2(2) ;

   file PkgBFile : PkgFileType is out "ct00523.dat";

   procedure PkgProc (parm1 : boolean) is
      subtype SubpSubtype is PkgSubtype ;
      type SubpType is record
		         f1 : boolean ;
		         f2 : SubpSubtype ;
		      end record ;

      constant SubpCons : PkgType := (f1 => PkgCons.f1,
                                      f2 => PkgCons.f2 ) ;

      variable SubpVar : SubpSubtype := SubpCons.f2;
      alias SubpAlias : bit is SubpVar(2) ;

      file SubpFile : PkgFileType is out "ct00523.dat";

      attribute PkgAttr of SubpLabel : label is PkgCons.f1 ;

      variable correct : boolean ;

   begin
      SubpLabel : while True loop exit; end loop;
      correct := PkgCons.f1 and (PkgCons.f2 = PkgSubtype'(others => '1')) and
                 (PkgSig(2) = PkgAlias) and
                 PkgFileType'PkgAttr and

                 PkgBCons.f1 and (PkgBCons.f2 = PkgBSubtype'(others => '1')) and
                 (PkgBAlias = PkgbCons.f2(2)) and

                 (SubpCons = PkgCons) and
                 (SubpVar(2) = SubpAlias) and
                 SubpLabel'Pkgattr ;

      test_report ( "PKG00523.PkgProc" ,
	            "Declarative region direct visibility test" ,
		    correct ) ;

      if parm1 then
         PkgProc (Not parm1) ;
      end if ;

   end PkgProc ;
end PKG00523 ;

use WORK.STANDARD_TYPES.all, WORK.PKG00523.all ;
architecture ARCH00523 of E00000 is
begin
   process
   begin
      PkgProc (True) ;
      wait ;
   end process ;
end ARCH00523 ;

entity ENT00523_Test_Bench is
end ENT00523_Test_Bench ;

architecture ARCH00523_Test_Bench of ENT00523_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00523 ) ;
   begin
      CIS1 : UUT;
   end block L1 ;
end ARCH00523_Test_Bench ;
