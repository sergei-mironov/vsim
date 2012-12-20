-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00473
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    5.1 (3)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00473
--    ENT00473(ARCH00473)
--    ENT00473_1(ARCH00473_1)
--    ENT00473_Test_Bench(ARCH00473_Test_Bench)
--    CONF00473
--
-- REVISION HISTORY:
--
--     6-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
package PKG00473 is
   attribute Attr : boolean ;
   attribute Attr of all : package is True ;
end PKG00473 ;

use WORK.STANDARD_TYPES.all, WORK.PKG00473.all ;
entity ENT00473 is
   generic ( G : Integer := 0 ) ;
   port ( P : in Real := 0.0 ) ;

   attribute Attr of ENT00473 : entity is True ;
   attribute Attr of G : constant is True ;
   attribute Attr of all : signal is True ; -- Associated with P

end ENT00473 ;

architecture ARCH00473 of ENT00473 is

   attribute Attr of ARCH00473 : architecture is True ;

   procedure Proc ( constant C : Time := 0 ns ;
		    signal S : in Severity_Level := Note ;
		    variable V : inout boolean ) is
      attribute Attr of C : constant is True ;
      attribute Attr of others : signal is True ; -- Associated with S
      attribute Attr of all : variable is True ;  -- Associated with V
   begin
      V := V and C'Attr and S'Attr and V'Attr;
   end Proc ;

   attribute Attr of Proc : procedure is True ;

   function Func ( constant C : Time := 0 ns ;
		   signal S : in Severity_Level := Note ) return boolean is
      attribute Attr of C : constant is True ;
      attribute Attr of others : signal is True ; -- Associated with S
   begin
      return C'Attr and S'Attr ;
   end Func ;
   attribute Attr of Func : function is True ;

   type T is ( e1, e2, e3 ) ;
   attribute Attr of T : type is True ;

   subtype ST is T range e1 to e2 ;
   attribute Attr of ST : subtype is True ;

   constant C : boolean := false ;
   attribute Attr of C : constant is True ;

   signal S : Integer := -1 ;
   attribute Attr of S : signal is True ;

   component Comp
      generic ( G : in Severity_Level ) ;
      port ( P : in Time ) ;
   end component ;
   attribute Attr of Comp : component is True ;

   signal S_severity_level : Severity_level := Note ;

begin
   L :
   block ( S /= 1 )
      generic ( BG : in Integer := 1 ) ;
      port ( BP : in Integer ) ;
      port map ( S ) ;

      attribute Attr of BG : constant is True ;
      attribute Attr of BP, Guard : signal is True ;

   begin
      process ( S )
	 variable correct : boolean := true ;
         attribute Attr of correct : variable is True ;
      begin
         test_report ( "ARCH00473" ,
		       "Entity class of 'package' is allowed" ,
		       WORK.PKG00473'Attr ) ;

         test_report ( "ARCH00473" ,
		       "Entity class of 'entity' is allowed" ,
		       ENT00473'Attr ) ;

         test_report ( "ARCH00473" ,
		       "Entity classes of 'constant' and 'signal' are allowed "&
                       "for Interface ports and generics" ,
		       G'Attr and P'Attr ) ;

         test_report ( "ARCH00473" ,
		       "Entity class of 'architecture' is allowed" ,
		       ARCH00473'Attr ) ;

         Proc (S => S_severity_level, V => correct) ;
         test_report ( "ARCH00473" ,
		       "Entity classes of 'constant', 'signal', and variable "&
                       "are allowed for procedure parameters" ,
		       correct ) ;

         test_report ( "ARCH00473" ,
		       "Entity class of 'procedure' is allowed" ,
		       Proc'Attr ) ;

         correct := Func (S => S_severity_level) ;
         test_report ( "ARCH00473" ,
		       "Entity classes of 'constant' and 'signal' "&
                       "are allowed for function parameters" ,
		       correct ) ;

         test_report ( "ARCH00473" ,
		       "Entity class of 'function' is allowed" ,
		       Func'Attr ) ;

         test_report ( "ARCH00473" ,
		       "Entity class of 'type' is allowed" ,
		       T'Attr ) ;

         test_report ( "ARCH00473" ,
		       "Entity class of 'subtype' is allowed" ,
		       ST'Attr ) ;

         test_report ( "ARCH00473" ,
		       "Entity class of 'constant' is allowed "&
                       "for declared constants" ,
		       C'Attr ) ;

         test_report ( "ARCH00473" ,
		       "Entity class of 'signal' is allowed "&
                       "for declared signals" ,
		       S'Attr ) ;

         test_report ( "ARCH00473" ,
		       "Entity class of 'component' is allowed" ,
		       Comp'Attr ) ;

         test_report ( "ARCH00473" ,
		       "Entity classes of 'constant' and 'signal' are allowed "&
                       "for Block ports and generics" ,
		       BG'Attr and BP'Attr ) ;

         test_report ( "ARCH00473" ,
		       "Entity class of 'signal' is allowed "&
                       "for implicitly declared signal GUARD" ,
		       GUARD'Attr ) ;

         test_report ( "ARCH00473" ,
		       "Entity class of 'variable' is allowed "&
                       "for declared variables" ,
		       correct'Attr ) ;

      end process ;
   end block L ;
end ARCH00473 ;

entity ENT00473_1 is
   generic ( G : in boolean := false ) ;  -- CONF00473'Attr will be passed in
end ENT00473_1 ;

use WORK.Standard_Types.Test_Report ;
architecture ARCH00473_1 of ENT00473_1 is
begin
   process
   begin
         test_report ( "ARCH00473" ,
		       "Entity class of 'configuration' is allowed" ,
		       G ) ;

         wait ;
   end process ;
end ARCH00473_1 ;

entity ENT00473_Test_Bench is
end ENT00473_Test_Bench ;

architecture ARCH00473_Test_Bench of ENT00473_Test_Bench is
begin
   L1:
   block
      component UUT generic ( G : Integer := 0 ) ;
                    port ( P : in Real := 0.0 ) ;
      end component ;
      for CIS1 : UUT use entity WORK.ENT00473 ( ARCH00473 ) ;

      component UUT2
      end component ;

  begin
      CIS1 : UUT
         generic map ( open )
         port map ( open ) ;

      CIS2 : UUT2 ;
   end block L1 ;
end ARCH00473_Test_Bench ;

use WORK.PKG00473.all ;
configuration CONF00473 of WORK.ENT00473_Test_Bench is
   attribute Attr of CONF00473 : configuration is True ;
   for ARCH00473_Test_Bench
      for L1
	 for CIS2 : UUT2
	    use entity WORK.ENT00473_1 ( ARCH00473_1 )
		   generic map ( CONF00473'Attr );
	 end for ;
      end for ;
   end for ;
end CONF00473 ;
