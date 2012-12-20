-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00055
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.7 (3)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00055)
--    ENT00055_Test_Bench(ARCH00055_Test_Bench)
--
-- REVISION HISTORY:
--
--     02-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00055 of E00000 is
   signal Dummy : Boolean := false ;
--
begin
--
   P1 :
   process ( Dummy )
      variable correct : boolean := false;
      constant c1 : integer := 0 ;
      function f ( x : st_int1 ) return st_int1 is
      begin
         return x;
      end f;
   begin
      for i in st_int1 loop  -- 8 to 60
         case f(i) is
            when t_int1'Low to 1 | 7 downto 2
            => correct := false ;
--
            when 8 to 10 | 20 to 60
            => correct := ((i >= 8)  and (i <= 10)) or
                          ((i >= 20) and (i <= 60)) ;
--
            when 11 to 19
            => correct := ((i >= 11)  and (i <= 19)) ;
--
            when others
            => correct := false ;
--
         end case ;
         test_report ( "ARCH00055.P1",
                       "Choices in a case statement where the expression "&
                       "is of a locally static subtype need not belong to "&
                       "that subtype",
                        correct) ;
      end loop ;
   end process P1 ;
--
--
end ARCH00055 ;
--
entity ENT00055_Test_Bench is
end ENT00055_Test_Bench ;
--
architecture ARCH00055_Test_Bench of ENT00055_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00055 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00055_Test_Bench ;
