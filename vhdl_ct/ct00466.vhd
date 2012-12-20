-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00466
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.7 (5)
--    9.7 (7)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00466_1(ARCH00466_1)
--    ENT00466(ARCH00466)
--    ENT00466_Test_Bench(ARCH00466_Test_Bench)
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
entity ENT00466_1 is
   generic ( G : Integer ) ;
   port ( P : in Integer ;
	  Q : out Integer ) ;
end ENT00466_1 ;

use WORK.STANDARD_TYPES.all ;
architecture ARCH00466_1 of ENT00466_1 is
begin
   process ( P )
      variable First_Time : boolean := True ;
   begin
      if First_Time then
	 First_Time := False ;
      else
	 Q <= transport (P + G) after 0 ns ;
      end if ;
   end process ;
end ARCH00466_1 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00466 is
   generic ( G1_Low, G1_High : t_enum1 ;
             G2_Low, G2_High : Integer ) ;
end ENT00466 ;

architecture ARCH00466 of ENT00466 is
   component Comp1
      generic ( G : Integer ) ;
      port ( P : in Integer ;
	     Q : out Integer ) ;
   end component ;
   for all : Comp1 use entity WORK.ENT00466_1 ( ARCH00466_1 );

   type Arr_enum1 is array (t_enum1 range G1_Low to G1_High)
          of Integer ;
   signal S_enum1 : Arr_enum1 := Arr_enum1'(others => -1) ;

   subtype t_uint is Integer range G2_Low to G2_High ;
   type Arr_uint is array (t_uint) of Integer ;
   signal S_uint : Arr_uint := Arr_uint'(others => -1) ;

begin
   s_enum1(Arr_enum1'Left) <= transport t_enum1'Pos (Arr_enum1'Left) after 0 ns ;

   For_Gen1 :
   for i in Arr_enum1'Left to t_enum1'Pred (Arr_enum1'Right) generate
      L1 : Comp1
	 generic map ( t_enum1'Pos ( t_enum1'Succ(i)) )
	 port map ( s_enum1(i), s_enum1(t_enum1'Succ(i)) ) ;

   end generate For_Gen1 ;

   Check_It1 :
   process
      variable correct : boolean := True;
      variable sum : Integer := 0 ;
   begin
      wait for 30 ns ;
      for i in Arr_enum1'range ( 1 ) loop
	 sum := sum + t_enum1'Pos (i) ;
	 correct := correct and (S_enum1(i) = sum) ;
      end loop ;
      test_report ( "ARCH00466.Check_It1" ,
		    "Globally static discrete ranges are permited on "&
                    "generate statements" ,
		    correct ) ;
       wait ;
   end process Check_It1 ;

------------

   s_uint(Arr_uint'Left) <= transport t_uint'Pos (Arr_uint'Left) after 0 ns ;

   For_Gen2 :
   for i in Arr_uint'Left to t_uint'Pred (Arr_uint'Right) generate
      L2 : Comp1
	 generic map ( t_uint'Pos ( t_uint'Succ(i)) )
	 port map ( s_uint(i), s_uint(t_uint'Succ(i)) ) ;

   end generate For_Gen2 ;

   Check_It2 :
   process
      variable correct : boolean := True;
      variable sum : Integer := 0 ;
   begin
      wait for 30 ns ;
      for i in Arr_uint'range ( 1 ) loop
	 sum := sum + t_uint'Pos (i) ;
	 correct := correct and (S_uint(i) = sum) ;
      end loop ;
      test_report ( "ARCH00466.Check_It2" ,
		    "Globally static discrete ranges are permited on "&
                    "generate statements" ,
		    correct ) ;
      wait ;
   end process Check_It2 ;

end ARCH00466 ;


entity ENT00466_Test_Bench is
end ENT00466_Test_Bench ;

use WORK.STANDARD_TYPES.all ;
architecture ARCH00466_Test_Bench of ENT00466_Test_Bench is
begin
   L1:
   block
      component UUT generic ( G1_Low, G1_High : t_enum1 ;
                              G2_Low, G2_High : Integer ) ;
      end component ;

      for CIS1 : UUT use entity WORK.ENT00466 ( ARCH00466 ) ;
   begin
      CIS1 : UUT generic map ( t_enum1'Low, t_enum1'High,
                               G2_High => 20,
                               G2_Low  => 10 ) ;
   end block L1 ;
end ARCH00466_Test_Bench ;

