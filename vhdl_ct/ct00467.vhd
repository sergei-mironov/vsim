-- NEED RESULT: ARCH00467.Check_It1: Locally static null discrete ranges are permited on generate statements passed
-- NEED RESULT: ARCH00467.Check_It2: Locally static null discrete ranges are permited on generate statements passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00467
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.7 (6)
--    9.7 (10)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00467_1(ARCH00467_1)
--    ENT00467(ARCH00467)
--    ENT00467_Test_Bench(ARCH00467_Test_Bench)
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
entity ENT00467_1 is
   generic ( G : Integer ) ;
   port ( P : in Integer ;
	  Q : out Integer ) ;
end ENT00467_1 ;

use WORK.STANDARD_TYPES.all ;
architecture ARCH00467_1 of ENT00467_1 is
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
end ARCH00467_1 ;

entity ENT00467 is
   generic ( G : boolean ) ;
end ENT00467 ;

use WORK.STANDARD_TYPES.all ;
architecture ARCH00467 of ENT00467 is
   component Comp1
      generic ( G : Integer ) ;
      port ( P : in Integer ;
	     Q : out Integer ) ;
   end component ;
   for all : Comp1 use entity WORK.ENT00467_1 ( ARCH00467_1 );

   type Arr_enum1 is array (t_enum1 range t_enum1'Low to t_enum1'High)
          of Integer ;
   signal S_enum1 : Arr_enum1 := Arr_enum1'(others => -1) ;

   type t_uint is range 10 to 20 ;
   type Arr_uint is array (t_uint range t_uint'Low to t_uint'High)
          of Integer ;
   signal S_uint : Arr_uint := Arr_uint'(others => -1) ;

begin
   s_enum1(Arr_enum1'Left) <= transport 0 after 0 ns ;

   For_Gen1 :  -- Null Range
   for i in Arr_enum1'Left downto t_enum1'Pred (Arr_enum1'Right) generate
      L1 : Comp1
	 generic map ( t_enum1'Pos (i) )
	 port map ( s_enum1(i), s_enum1(t_enum1'Succ(i)) ) ;

   end generate For_Gen1 ;

   Check_It1 :
   process
   begin
      wait for 30 ns ;
      test_report ( "ARCH00467.Check_It1" ,
		    "Locally static null discrete ranges are permited on "&
                    "generate statements" ,
		    s_enum1 = Arr_enum1'(0, others => -1) );
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
      test_report ( "ARCH00467.Check_It2" ,
		    "Locally static null discrete ranges are permited on "&
                    "generate statements" ,
		    s_uint = Arr_uint'(0, others => -1) );
      wait ;
   end process Check_It2 ;

end ARCH00467 ;


entity ENT00467_Test_Bench is
end ENT00467_Test_Bench ;

architecture ARCH00467_Test_Bench of ENT00467_Test_Bench is
begin
   L1:
   block
      component UUT generic ( G : Boolean ) ;
      end component ;

      for CIS1 : UUT use entity WORK.ENT00467 ( ARCH00467 ) ;
   begin
      CIS1 : UUT generic map ( True ) ;
   end block L1 ;
end ARCH00467_Test_Bench ;
