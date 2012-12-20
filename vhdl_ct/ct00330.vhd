-- NEED RESULT: ARCH00330_Test_Bench: Component may be instantiated more than once passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00330
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.6 (2)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00330_1(ARCH00330_1)
--    ENT00330_2(ARCH00330_2)
--    ENT00330_Test_Bench(ARCH00330_Test_Bench)
--
-- REVISION HISTORY:
--
--    30-JUL-1987   - initial revision
--    22-JUN-1988   - (KLM) added initialization expression for port Q in
--                    entities ENT00330_1 and ENT00330_2
--
-- NOTES:
--
--    self-checking
--
--
entity ENT00330_1 is
   generic ( G : Integer := 2 ) ;
   port ( P : in Integer := 1 ;
	  Q : out Integer := 1 ) ;
end ENT00330_1 ;

architecture ARCH00330_1 of ENT00330_1 is
begin
   P1 :
   process ( P )
      variable First_Time : boolean := True ;
   begin
      if First_Time then
	 First_Time := False ;
      else
         Q <= transport P*G after 10 ns ;
      end if ;
   end process P1 ;
end ARCH00330_1 ;

entity ENT00330_2 is
   generic ( G : REAL := 2.0 ) ;
   port ( P : in REAL := 1.0 ;
	  Q : out REAL := 1.0 ) ;
end ENT00330_2 ;

architecture ARCH00330_2 of ENT00330_2 is
begin
   P1 :
   process ( P )
      variable First_Time : boolean := True ;
   begin
      if First_Time then
	 First_Time := False ;
      else
         Q <= transport P*G after 10 ns ;
      end if ;
   end process P1 ;
end ARCH00330_2 ;

entity ENT00330_Test_Bench is
end ENT00330_Test_Bench ;

use WORK.STANDARD_TYPES.all ;
architecture ARCH00330_Test_Bench of ENT00330_Test_Bench is
begin
   L1:
   block
      function To_Int ( P : in Real ) return Integer is
         variable exp : Integer := 0 ;
         variable val, tempr : Real ;
         variable Result, tempi : Integer := 0 ;
      begin
         val := abs P ;
	 while val >= 10.0  loop
	    exp := exp + 1 ;
            val := val / 10.0 ;
	 end loop ;

	 loop
	    if val < 1.0 then
               tempi := 0 ;
	       tempr := 0.0 ;
	    elsif val < 2.0 then
               tempi := 1 ;
	       tempr := 1.0 ;
	    elsif val < 3.0 then
               tempi := 2 ;
	       tempr := 2.0 ;
	    elsif val < 4.0 then
               tempi := 3 ;
	       tempr := 3.0 ;
	    elsif val < 5.0 then
               tempi := 4 ;
	       tempr := 4.0 ;
	    elsif val < 6.0 then
               tempi := 5 ;
	       tempr := 5.0 ;
	    elsif val < 7.0 then
               tempi := 6 ;
	       tempr := 6.0 ;
	    elsif val < 8.0 then
               tempi := 7 ;
	       tempr := 7.0 ;
	    elsif val < 9.0 then
               tempi := 8 ;
	       tempr := 8.0 ;
	    else
               tempi := 9 ;
	       tempr := 9.0 ;
	    end if ;

            result := result*10 + tempi ;
	    exit when exp = 0 ;

            exp := exp - 1 ;
            val := (val - tempr)*10.0 ;

	 end loop ;

	 if P < 0.0 then
	    return -1 * result ;
	 else
	    return result ;
	 end if ;
      end To_Int ;

      function To_Real ( P : in Integer ) return Real is
         variable exp : Integer := 0 ;
         variable val, tempi, tempv : Integer ;
         variable Result, tempr : Real := 0.0 ;
      begin
         val := abs P ;
	 loop
            tempv := val / 10 ;
            tempi := val - tempv*10;

            case tempi is
	       when 0 =>
		  tempr := 0.0 ;
	       when 1 =>
		  tempr := 1.0 ;
	       when 2 =>
		  tempr := 2.0 ;
	       when 3 =>
		  tempr := 3.0 ;
	       when 4 =>
		  tempr := 4.0 ;
	       when 5 =>
		  tempr := 5.0 ;
	       when 6 =>
		  tempr := 6.0 ;
	       when 7 =>
		  tempr := 7.0 ;
	       when 8 =>
		  tempr := 8.0 ;
	       when 9 =>
		  tempr := 9.0 ;
	       when others =>
		  null ;
	    end case ;

            result := result + tempr*(10.0**exp) ;
            exit when val < 10 ;

            val := tempv ;
	    exp := exp + 1 ;

	 end loop ;

	 if P < 0 then
	    return -1.0 * result ;
	 else
	    return result ;
	 end if ;
      end To_Real ;

      component UUT1
         generic ( G : Integer := 2) ;
         port ( P : in Integer ;
	        Q : out Integer ) ;
      end component ;

      component UUT2
         generic ( G : REAL := 2.0 ) ;
         port ( P : in REAL ;
	        Q : out REAL ) ;
      end component ;

      for all : UUT1 use entity WORK.ENT00330_1 ( ARCH00330_1 ) ;
      for all : UUT2 use entity WORK.ENT00330_2 ( ARCH00330_2 ) ;

      signal In1 : Integer := -1 ;
      signal Out1, Out3, Out4 : Integer := 0 ;
      signal Out2 : Real := -1.0 ;

      signal Check : boolean := false;

   begin
      In1 <= transport 1 after 10 ns ;  -- Get the ball rolling

      CIS1 : UUT1
	 generic map ( 3 )
	 port map ( In1 ,     -- 1
		    Out1 ) ;  -- 3

      CIS2 : UUT2
	 generic map ( G => 3.0 )
	 port map ( Q => Out2 ,             -- 9.0
		    P => To_Real (Out1) ) ; -- 3.0

      CIS3 : UUT1
	 generic map ( open )  -- 2
	 port map ( To_Int ( Out2 ) ,  -- 9
		    Out3 ) ;           -- 18

      CIS4 : UUT2
	 generic map ( open )  -- 2.0
	 port map ( To_Int (Q) => Out4 ,    -- 36.0
		    P => To_Real (Out3) ) ; -- 18.0

      Check <= transport true after 100 ns ;
      Check_it :
      process ( Check )
	 variable First_Time : boolean := true ;
      begin
	 if First_Time then
	    First_Time := false ;
	 else
	    test_report ( "ARCH00330_Test_Bench" ,
			  "Component may be instantiated more than once" ,
			  Out4 = 36 ) ;
	 end if ;
      end process Check_it ;


   end block L1 ;
end ARCH00330_Test_Bench ;
