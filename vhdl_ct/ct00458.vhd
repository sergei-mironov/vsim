-- NEED RESULT: ARCH00458: Globally static condition is allowed in a generate condition passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00458
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.7 (4)
--    9.7 (9)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00458_1(ARCH00458_1)
--    ENT00458(ARCH00458)
--    ENT00458_Test_Bench(ARCH00458_Test_Bench)
--
-- REVISION HISTORY:
--
--     5-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
entity ENT00458_1 is
   generic ( G : Integer ) ;
   port ( P : in Integer ;
	  Q : out Integer ) ;
end ENT00458_1 ;

use WORK.STANDARD_TYPES.all ;
architecture ARCH00458_1 of ENT00458_1 is
begin
   process ( P )
      variable First_Time : boolean := True ;
   begin
      if First_Time then
	 First_Time := False ;
      else
	 Q <= transport (P + G) after 5 ns ;
      end if ;
   end process ;
end ARCH00458_1 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00458 is
   generic ( G : st_boolean_vector ;
             J : Integer ) ;
end ENT00458 ;

architecture ARCH00458 of ENT00458 is
   component Comp1
      generic ( G : Integer ) ;
      port ( P : in Integer ;
	     Q : out Integer ) ;
   end component ;

   for others : Comp1 use entity WORK.ENT00458_1 ( ARCH00458_1 );

   type SigArr is array ( Integer range 1 to 6 ) of Integer ;
   signal S : SigArr := (others => -1) ;
   alias S1 : Integer is S(1) ;
   alias S2 : Integer is S(2) ;
   alias S3 : Integer is S(3) ;
   alias S4 : Integer is S(4) ;
   alias S5 : Integer is S(5) ;
   alias S6 : Integer is S(6) ;

begin
   s1 <= transport 0 after 0 ns ;

   For_Gen :
   for i in 1 to 4 generate
      LAB1 : Comp1
	 generic map ( i )
	 port map ( s(i), s(i+1) ) ;

   end generate For_Gen ;

   If_Gen :
   if G(J) generate
      LAB2 : Comp1
	 generic map ( 5 )
	 port map ( s5, s6 ) ;
   end generate If_Gen ;

   Check_It :
   process
      variable correct : boolean := True;
      variable sum : Integer := 0 ;
   begin
      wait for 30 ns ;
      for i in SigArr'range ( 1 ) loop
	 correct := correct and (S(i) = sum) ;
	 sum := sum + i ;
      end loop ;
      test_report ( "ARCH00458" ,
		    "Globally static condition is allowed in a " &
		    "generate condition" ,
		    correct ) ;
      wait ;
   end process Check_It ;
end ARCH00458 ;


entity ENT00458_Test_Bench is
end ENT00458_Test_Bench ;

use WORK.STANDARD_TYPES.all ;
architecture ARCH00458_Test_Bench of ENT00458_Test_Bench is
begin
   L1:
   block
      component UUT generic ( G : st_boolean_vector ;
                              J : Integer ) ;
      end component ;

      for CIS1 : UUT use entity WORK.ENT00458 ( ARCH00458 ) ;
   begin
      CIS1 : UUT generic map ( st_boolean_vector'(lowb+1 => True,
                                                  others => False),
                               lowb+1 ) ;
   end block L1 ;
end ARCH00458_Test_Bench ;
