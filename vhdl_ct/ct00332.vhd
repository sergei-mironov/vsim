-- NEED RESULT: ARCH00332.Check_s6: Concurrent signal assignment may have a label passed
-- NEED RESULT: ARCH00332.Check_s5: Concurrent signal assignment need not have a label passed
-- NEED RESULT: ARCH00332.Check_s4: Concurrent signal assignment may have a label passed
-- NEED RESULT: ARCH00332.Check_s3: Concurrent signal assignment need not have a label passed
-- NEED RESULT: ARCH00332.Check_s2: Concurrent signal assignment may have a label passed
-- NEED RESULT: ARCH00332.Check_s1: Concurrent signal assignment need not have a label passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00332
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.5 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00332)
--    ENT00332_Test_Bench(ARCH00332_Test_Bench)
--
-- REVISION HISTORY:
--
--    30-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00332 of E00000 is
   type T is array ( Integer range <> ) of integer ;
   subtype T_range is Integer range 1 to 6 ;
   subtype TA is T ( T_range ) ;
   signal s : TA := (others => 0) ;

   subtype st_integer is integer range 0 to 7 ;
   alias s1 : st_integer is s(1) ;
   alias s2 : st_integer is s(2) ;
   alias s3 : st_integer is s(3) ;
   alias s4 : st_integer is s(4) ;
   alias s5 : st_integer is s(5) ;
   alias s6 : st_integer is s(6) ;

   signal IntSig : Integer := 1 ;

begin
   A_Label : s1 <= transport  1 after 10 ns ;
             s2 <= transport  2 after 10 ns ;

   B_Label : s3 <= transport  3 after 10 ns when true else 1 ;
             s4 <= transport  4 after 10 ns when true else 1 ;

   C_Label : with IntSig select
		s5 <= transport 5 after 10 ns when 1,
				1            when others ;
             with IntSig select
		s6 <= transport 6 after 10 ns when 1,
				1            when others ;

   g1: for i in Integer range 1 to 6 generate
      L :
      block
	 function To_Char ( P : T_Range ) return Character is
	 begin
	    case P is
	       when 1 =>
		  return '1' ;
	       when 2 =>
		  return '2' ;
	       when 3 =>
		  return '3' ;
	       when 4 =>
		  return '4' ;
	       when 5 =>
		  return '5' ;
	       when 6 =>
		  return '6' ;
               when others =>
                  test_report ( "ARCH00332.To_Char" ,
				"Illegal input parameter" ,
				False ) ;
	    end case ;
	 end To_Char ;
      begin
         process
         begin
            wait on s(i) for 11 ns ;
            if (i mod 2) = 0 then
               test_report ( "ARCH00332.Check_s" & To_Char(i) ,
	                     "Concurrent signal assignment may have a label" ,
		             s(i) = i ) ;
            else
               test_report ( "ARCH00332.Check_s" & To_Char(i) ,
		             "Concurrent signal assignment need not have a label" ,
		             s(i) = i ) ;
            end if ;

            wait ;

         end process ;
      end block L ;
   end generate ;

end ARCH00332 ;

entity ENT00332_Test_Bench is
end ENT00332_Test_Bench ;

architecture ARCH00332_Test_Bench of ENT00332_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00332 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00332_Test_Bench ;
