-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00468
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.7 (7)
--    9.7 (10)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00468_1(ARCH00468_1)
--    ENT00468(ARCH00468)
--    ENT00468_Test_Bench(ARCH00468_Test_Bench)
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
entity ENT00468_1 is
   generic ( G : Integer ) ;
   port ( P : in Integer ;
	  Q : out Integer ) ;
end ENT00468_1 ;

use WORK.STANDARD_TYPES.all ;
architecture ARCH00468_1 of ENT00468_1 is
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
end ARCH00468_1 ;

use WORK.STANDARD_TYPES.all ;
entity ENT00468 is
   generic ( G1_Low, G1_High : t_enum1 ;
             G2_Low, G2_High : Integer ) ;
end ENT00468 ;

architecture ARCH00468 of ENT00468 is
   component Comp1
      generic ( G : Integer ) ;
      port ( P : in Integer ;
	     Q : out Integer ) ;
   end component ;
   for all : Comp1 use entity WORK.ENT00468_1 ( ARCH00468_1 );

   type Arr_enum1 is array (t_enum1 range G1_Low to G1_High)
          of Integer ;
   signal S_enum1 : Arr_enum1 := Arr_enum1'(others => -1) ;

   subtype t_uint is Integer range G2_Low to G2_High ;
   type Arr_uint is array (t_uint) of Integer ;
   signal S_uint : Arr_uint := Arr_uint'(others => -1) ;

begin
   s_enum1(Arr_enum1'Left) <= transport 0 after 0 ns ;

   For_Gen1 :  -- Null range
   for i in Arr_enum1'Left downto t_enum1'Pred (Arr_enum1'Right) generate
      L1 : Comp1
	 generic map ( t_enum1'Pos (i) )
	 port map ( s_enum1(i), s_enum1(t_enum1'Succ(i)) ) ;

   end generate For_Gen1 ;

   Check_It1 :
   process
   begin
      wait for 30 ns ;
      test_report ( "ARCH00468.Check_It1" ,
		    "Globally static null discrete ranges are permited on "&
                    "generate statements" ,
		    s_enum1 = Arr_enum1 ' (0, -1, -1, -1) ) ;
      wait ;
   end process Check_It1 ;

------------

   s_uint(Arr_uint'Left) <= transport 0 after 0 ns ;

   For_Gen2 :  -- Null Range
   for i in Arr_uint'Left downto t_uint'Pred (Arr_uint'Right) generate
      L2 : Comp1
	 generic map ( t_uint'Pos (i) )
	 port map ( s_uint(i), s_uint(t_uint'Succ(i)) ) ;

   end generate For_Gen2 ;

   Check_It2 :
   process
   begin
      wait for 30 ns ;
      test_report ( "ARCH00468.Check_It2" ,
		    "Globally static null discrete ranges are permited on "&
                    "generate statements" ,
		    s_uint = Arr_uint ' (10 => 0, 11 to 20 => -1) ) ;
      wait ;
   end process Check_It2 ;

end ARCH00468 ;


entity ENT00468_Test_Bench is
end ENT00468_Test_Bench ;

use WORK.STANDARD_TYPES.all ;
architecture ARCH00468_Test_Bench of ENT00468_Test_Bench is
begin
   L1:
   block
      component UUT generic ( G1_Low, G1_High : t_enum1 ;
                              G2_Low, G2_High : Integer ) ;
      end component ;

      for CIS1 : UUT use entity WORK.ENT00468 ( ARCH00468 ) ;
   begin
      CIS1 : UUT generic map ( t_enum1'Low, t_enum1'High,
                               G2_High => 20,
                               G2_Low  => 10 ) ;
   end block L1 ;
end ARCH00468_Test_Bench ;

