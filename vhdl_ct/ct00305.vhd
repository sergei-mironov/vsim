-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00305
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.1 (9)
--    9.1 (10)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00305_1(ARCH00305_1)
--    E00000(ARCH00305)
--    ENT00305_Test_Bench(ARCH00305_Test_Bench)
--
-- REVISION HISTORY:
--
--    27-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
entity ENT00305_1 is
   generic ( G : Integer ) ;
   port ( Pout : out Integer := 1 ) ;
end ENT00305_1 ;

architecture ARCH00305_1 of ENT00305_1 is
begin
   Pout <= transport G after 10 ns ;
end ARCH00305_1 ;

use WORK.STANDARD_TYPES.all ;
architecture ARCH00305 of E00000 is
begin
   L1 :
   block
      type T is (e1,e2,e3,e4) ;
      subtype ST is T;

      subtype st_int1 is Integer range 0 to 3 ;
      type UA is array ( Integer range <> ) of T ;
      subtype CA is UA ( st_int1 ) ;

      constant C : st_int1 := st_int1'Low ;  -- e1

      signal SA : CA := (e2, e2, e3, e3) ;
      alias S0 : ST is SA(C) ;
      alias S1 : ST is SA(1) ;
      alias S2 : ST is SA(2) ;
      alias S3 : ST is SA(st_int1'High) ;

      component Comp
	 generic ( G : Integer ) ;
	 port ( Pout : out Integer := 1 ) ;
      end component ;
      for all : Comp use entity WORK.ENT00305_1 ( ARCH00305_1 );

      attribute Attr : boolean ;
      attribute Attr of SA : signal is True ;

      procedure Proc ( Did_Proc : out boolean ) ;

      function To_ST ( constant P : Integer ) return ST is
      begin
	 return ST'Val (P) ;
      end To_ST ;

      procedure Proc ( Did_Proc : out boolean ) is
      begin
         Did_Proc := True ;
      end Proc ;

      signal Check_it, Woke_Up : boolean := false ;

   begin
      A_CIS : Comp
	 generic map ( C )  -- e1
	 port map ( To_ST (Pout) => S1 ) ; -- SA(1)

      A_SigAsg : Check_it <= transport True after 100 ns ;

      A_Process :
      process ( Check_it )
         variable first_time : boolean := true ;
      begin
	 if Not first_time then
	    test_report ( "ARCH00305" ,
			  "Test Completed" ,
			  Woke_Up ) ;
         else
            first_time := false ;
	 end if ;
      end process A_Process ;

      A_Block :
      block
      begin
         P :
         process ( SA )
            variable first_time : boolean := true ;
            variable Did_Proc : boolean := false ;
         begin
   	    if Not first_time then
               Proc (Did_Proc) ;
               test_report ( "ARCH00305" ,
			     "Block declarations/statements test" ,
                             Did_Proc and
			     (SA(0) = e2) and
                             (SA(1) = e1) and
                             (SA(2) = e3) and
                             (SA(3) = e3) ) ;
	       Woke_Up <= transport True ;
            else
               first_time := false ;
	    end if ;
         end process P ;
      end block A_Block ;

      A_Generate :
      for I in 1 to 1 generate
	 process
	 begin
	    test_report ( "ARCH00305" ,
			  "Generate Statement" ,
			  True ) ;
            wait ;
	 end process ;
      end generate A_Generate ;

      A_Assert : assert Not SA'Attr
		   report "Concurrent Assertion Passed"
		   severity Note ;
   end block L1 ;

end ARCH00305 ;


entity ENT00305_Test_Bench is
end ENT00305_Test_Bench ;

architecture ARCH00305_Test_Bench of ENT00305_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00305 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00305_Test_Bench ;
