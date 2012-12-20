-- NEED RESULT: ARCH00244: Procedures and functions may be called recursively passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00244
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    2.1 (5)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00244)
--    ENT00244_Test_Bench(ARCH00244_Test_Bench)
--
-- REVISION HISTORY:
--
--    14-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00244 of E00000 is
begin
   P :
   process
      variable global_int : integer := 0;

      procedure Recursive_subr ( x: integer ) is
      begin
         global_int := global_int + 1;
         if x > 1 then
            Recursive_subr (x-1);
         end if;
      end Recursive_subr ;

      function Recursive_func ( n: integer ) return integer is  -- factorial
      begin
         if n > 1 then
            return n * Recursive_func (n-1);
         else
            return 1;
         end if;
      end Recursive_func ;

   begin
      Recursive_subr ( 10 ) ;
      test_report ( "ARCH00244" ,
		    "Procedures and functions may be called recursively" ,
		    (global_int = 10) and
                    (Recursive_func(5) = 5*4*3*2)
                  ) ;
      wait ;
   end process P ;
end ARCH00244 ;

entity ENT00244_Test_Bench is
end ENT00244_Test_Bench ;

architecture ARCH00244_Test_Bench of ENT00244_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00244 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00244_Test_Bench ;

