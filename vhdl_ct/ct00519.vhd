-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00519
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
--    ENT00519_1(ARCH00519_1)
--    ENT00519(ARCH00519)
--    ENT00519_Test_Bench(ARCH00519_Test_Bench)
--
-- REVISION HISTORY:
--
--    11-AUG-1987   - initial revision
--    28-NOV-1989   - (ESL) change files to be of mode out
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00519_1 is
   generic ( G : boolean := false ) ;
   port ( P : boolean := false ) ;
end ENT00519_1 ;

architecture ARCH00519_1 of ENT00519_1 is
begin
   process
   begin
      test_report ( "ARCH00519" ,
	            "Declarative region direct visibility test"&
		    "For Component declaration/instantiation" ,
		    P and G ) ;
      wait ;
   end process ;
end ARCH00519_1 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00519 is
   generic ( EntGeneric : boolean := false ) ;
   port ( EntPort : boolean := false ) ;

   function To_Boolean ( p : bit ) return boolean is
   begin
      case p is
         when '0' => return false ;
         when '1' => return true ;
      end case ;
   end To_Boolean ;

   subtype EntSubtype is Bit_Vector (1 to 3) ;
   type EntType is record
		      f1 : boolean ;
		      f2 : EntSubtype ;
		   end record ;

   constant EntCons : EntType := (f1 => EntGeneric,
                                  f2 => EntSubtype'(others => '1')) ;

   signal EntSig : EntSubtype := ('0', EntCons.f2(2), '0') ;
   alias EntAlias : bit is EntSig(2) ;

   type EntFileType is file of boolean ;
   file EntFile : EntFileType is out "ct00519.dat";

   attribute EntAttr : boolean ;
   attribute EntAttr of EntLabel : label is EntCons.f1 ;

   procedure EntProc2 (parm1 : boolean) ;
   procedure EntProc (parm1 : boolean) is
      subtype SubpSubtype is EntSubtype ;
      type SubpType is record
		         f1 : boolean ;
		         f2 : SubpSubtype ;
		      end record ;

      constant SubpCons : EntType := (f1 => EntGeneric,
                                      f2 => EntCons.f2 ) ;

      variable SubpVar : SubpSubtype := SubpCons.f2;
      alias SubpAlias : bit is SubpVar(2) ;

      file SubpFile : EntFileType is out "ct00519.dat";

      attribute EntAttr of SubpLabel : label is EntCons.f1 ;

      variable correct : boolean ;

   begin
      correct := EntGeneric and EntPort and
                 EntCons.f1 and (EntCons.f2 = EntSubtype'(others => '1')) and
                 (EntSig(2) = EntAlias) and
                 EntLabel'EntAttr and

                 (SubpCons = EntCons) and
                 (SubpVar(2) = SubpAlias) and
                 SubpLabel'Entattr ;

      test_report ( "ENT00519.EntProc" ,
	            "Declarative region direct visibility test" ,
		    correct ) ;

      if parm1 then
         EntProc (Not parm1) ;
      end if ;
      SubpLabel : while True loop exit; end loop;
   end EntProc ;
begin
   EntLabel : process begin wait; end process;
end ENT00519 ;

architecture ARCH00519 of ENT00519 is
   component ArchComp
      generic ( G : boolean ) ;
      port ( P : boolean ) ;
   end component ;

   for CIS1 : ArchComp use entity WORK.ENT00519_1 ( ARCH00519_1 );

   subtype ArchSubtype is EntSubtype ;
   type ArchType is record
		      f1 : boolean ;
		      f2 : ArchSubtype ;
		   end record ;

   constant ArchCons : ArchType := (f1 => EntGeneric,
                                    f2 => EntCons.f2) ;

   signal ArchSig : ArchSubtype := ('0', ArchCons.f2(2), '0') ;
   alias ArchAlias : bit is ArchSig(2) ;

   file ArchFile : EntFileType is out "ct00519.dat";

   constant ArchLabel : integer := 1 ;
   attribute EntAttr of ArchLabel : constant is ArchCons.f1 ;

   procedure EntProc2 (parm1 : boolean) is
      subtype SubpSubtype is EntSubtype ;
      type SubpType is record
		         f1 : boolean ;
		         f2 : SubpSubtype ;
		      end record ;

      constant SubpCons : EntType := (f1 => EntGeneric,
                                      f2 => EntCons.f2 ) ;

      variable SubpVar : SubpSubtype := SubpCons.f2;
      alias SubpAlias : bit is SubpVar(2) ;

      file SubpFile : EntFileType is out "ct00519.dat";

      constant SubpLabel : integer := 1 ;
      attribute EntAttr of SubpLabel : Constant is EntCons.f1 ;

      variable correct : boolean ;

   begin
      correct := EntGeneric and EntPort and
                 EntCons.f1 and (EntCons.f2 = EntSubtype'(others => '1')) and
                 (EntSig(2) = EntAlias) and
                 EntLabel'EntAttr and

                 ArchCons.f1 and (ArchCons.f2 = ArchSubtype'(others => '1')) and
                 (ArchSig(2) = ArchAlias) and
                 ArchLabel'EntAttr and

                 (SubpCons = EntCons) and
                 (SubpVar(2) = SubpAlias) and
                 SubpLabel'EntAttr ;

      test_report ( "ENT00519.EntProc2" ,
	            "Declarative region direct visibility test" ,
		    correct ) ;

      if parm1 then
         EntProc2 (Not parm1) ;
      end if ;

   end EntProc2 ;

begin

   CIS1 : ArchComp
             generic map ( G => True )
	     port map ( P => To_Boolean (ArchAlias) ) ;

   L1 :
   block
      component BlkComp
         generic ( G : boolean ) ;
         port ( P : boolean ) ;
      end component ;
      for CIS1 : ArchComp use entity WORK.ENT00519_1 ( ARCH00519_1 );
      for CIS2 : BLKComp  use entity WORK.ENT00519_1 ( ARCH00519_1 );

      subtype BlkSubtype is EntSubtype ;
      type BlkType is record
		         f1 : boolean ;
		         f2 : BlkSubtype ;
		      end record ;

      constant BlkCons : BlkType := (f1 => EntGeneric,
                                     f2 => EntCons.f2) ;

      signal BlkSig : BlkSubtype := ('0', BlkCons.f2(2), '1');
      alias BlkAlias : bit is BlkSig(2) ;

      file BlkFile : EntFileType is out "ct00519.dat";

      constant BlkLabel : integer := 1 ;
      attribute EntAttr of BlkLabel : constant is BlkCons.f1 ;

      procedure BlkProc (parm1 : boolean) is
         subtype SubpSubtype is EntSubtype ;
         type SubpType is record
		            f1 : boolean ;
		            f2 : SubpSubtype ;
		         end record ;

         constant SubpCons : EntType := (f1 => EntGeneric,
                                         f2 => EntCons.f2 ) ;

         variable SubpVar : SubpSubtype := SubpCons.f2;
         alias SubpAlias : bit is SubpVar(2) ;

         file SubpFile : EntFileType is out "ct00519.dat";

         constant SubpLabel : integer := 1 ;
         attribute EntAttr of SubpLabel : Constant is EntCons.f1 ;

         variable correct : boolean ;

      begin
         correct := EntGeneric and EntPort and
                    EntCons.f1 and (EntCons.f2 = EntSubtype'(others => '1')) and
                    (EntSig(2) = EntAlias) and
                    EntLabel'EntAttr and

                    ArchCons.f1 and (ArchCons.f2 = ArchSubtype'(others => '1')) 
                    and (ArchSig(2) = ArchAlias) and
                    ArchLabel'EntAttr and

                    BlkCons.f1 and (BlkCons.f2 = BlkSubtype'(others => '1')) and
                    (BlkSig(2) = BlkAlias) and
                    BlkLabel'EntAttr and

                    (SubpCons = EntCons) and
                    (SubpVar(2) = SubpAlias) and
                    SubpLabel'EntAttr ;

         test_report ( "ENT00519.BlkProc" ,
	               "Declarative region direct visibility test" ,
	  	       correct ) ;

         if parm1 then
            BlkProc (Not parm1) ;
         end if ;

      end BlkProc ;

   begin

      CIS1 : ArchComp
	 generic map ( G => True )
	 port map ( P => To_Boolean (ArchAlias) ) ;

      CIS2 : BlkComp
	 generic map ( G => True )
	 port map ( P => To_Boolean (BlkAlias) ) ;

      process
         subtype PcsSubtype is EntSubtype ;
         type PcsType is record
		            f1 : boolean ;
		            f2 : PcsSubtype ;
		         end record ;

         constant PcsCons : EntType := (f1 => EntGeneric,
                                         f2 => EntCons.f2 ) ;

         variable PcsVar : PcsSubtype := PcsCons.f2 ;
         alias PcsAlias : bit is PcsVar(2) ;

         file PcsFile : EntFileType is out "ct00519.dat";

         constant PcsLabel : integer := 1 ;
         attribute EntAttr of PcsLabel : Constant is EntCons.f1 ;

         variable correct : boolean ;

      begin
         EntProc (True) ;
         EntProc2 (True) ;
         BlkProc (True) ;

         correct := EntGeneric and EntPort and
                    EntCons.f1 and (EntCons.f2 = EntSubtype'(others => '1')) and
                    (EntSig(2) = EntAlias) and
                    EntLabel'EntAttr and

                    ArchCons.f1 and (ArchCons.f2 = ArchSubtype'(others => '1'))
                    and (ArchSig(2) = ArchAlias) and
                    ArchLabel'EntAttr and

                    BlkCons.f1 and (BlkCons.f2 = BlkSubtype'(others => '1')) and
                    (BlkSig(2) = BlkAlias) and
                    BlkLabel'EntAttr and

                    (PcsCons = EntCons) and
                    (PcsVar(2) = PcsAlias) and
                    PcsLabel'EntAttr ;

         test_report ( "ENT00519.Process" ,
	               "Declarative region direct visibility test" ,
	  	       correct ) ;

         wait ;
      end process ;
   end block L1 ;
end ARCH00519 ;

entity ENT00519_Test_Bench is
end ENT00519_Test_Bench ;

architecture ARCH00519_Test_Bench of ENT00519_Test_Bench is
begin
   L1:
   block
      component UUT
         generic ( EntGeneric : boolean ) ;
         port ( EntPort : boolean ) ;
      end component ;

      for CIS1 : UUT use entity WORK.ENT00519 ( ARCH00519 ) ;
      signal Dummy : boolean := True ;
   begin
      CIS1 : UUT
	 generic map ( True )
	 port map ( Dummy ) ;
   end block L1 ;
end ARCH00519_Test_Bench ;
