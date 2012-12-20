-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00054
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.7 (2)
--    8.7 (5)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00054)
--    ENT00054_Test_Bench(ARCH00054_Test_Bench)
--
-- REVISION HISTORY:
--
--     1-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00054 of E00000 is
   signal Dummy : Boolean := false ;
--
begin
--
   P1 :
   process ( Dummy )
      variable correct : boolean := false;
   begin
      for i in severity_level loop
         case severity_level'Val (severity_level'Pos(i)) is
            when Severity_Level'Low | Severity_Level'High
            => correct := (i = NOTE) or (i = FAILURE) ;
--
            when WARNING to Severity_Level'Val(1) | ERROR
            => correct := (i = WARNING) or (i = ERROR) ;
--
            when others
            => correct := false ;
--
         end case ;
         test_report ( "ARCH00054.P1",
                       "Case statement several choices in one alternative",
                        correct) ;
      end loop ;
   end process P1 ;
--
   P2 :
   process ( Dummy )
      variable correct : boolean := false;
      function F (parm : in character) return character is
      begin
         return parm; end;

   begin
      for i in character loop
         case F(i) is
            when SOH | ETX | ENQ
            => correct := (i = SOH) or
                          (i = ETX) or
                          (i = ENQ) ;
--
            when ACK | EOT | STX
            => correct := (i = STX) or
                          (i = EOT) or
                          (i = ACK) ;
--
            when NUL | ' ' to '#' | 'A' to 'Z'
            => correct := (i = NUL) or
                          ((i >= ' ') and (i <= '#')) or
                          ((i >= 'A') and (i <= 'Z')) ;
--
            when others
            => correct := ((i > ACK) and (i < ' ')) or
                          ((i > '#') and (i < 'A')) or
                          ( i > 'Z') ;
--
         end case ;
         test_report ( "ARCH00054.P2",
                       "Case statement several choices in one alternative",
                        correct) ;
      end loop ;
   end process P2 ;
--
   P3 :
   process ( Dummy )
      variable correct : boolean := false;
   begin
      for i in t_enum1 loop
         case t_enum1'(i) is
            when en1 to en2 | en3 to t_enum1'High
            => correct := (i >= en1) and (i <= en4) ;
--
            when others
            => correct := not ((i >= en1) and (i <= en4)) ;
--
         end case ;
         test_report ( "ARCH00054.P3",
                       "Case statement several choices in one alternative",
                        correct) ;
      end loop ;
   end process P3 ;
--
   P4 :
   process ( Dummy )
      variable correct : boolean := false;
      constant c1 : integer := 0 ;
      constant lb : integer := -10 ;
   begin
      for i in lb to 10 loop
         case (i+10)*abs i is
            when integer'Low to -11 | -1 downto -10
            => correct := false ;
--
            when c1*1000 | c1+9 | abs (c1-16)
            => correct := (i = -10) or
                          (i = -9) or
                          (i = -8) or
                          (i = -2) or
                          (i = -1) or
                          (i = 0) ;
--
            when others
            => correct := ((i > -8) and (i < -2)) or (i >= 1);
--
         end case ;
         test_report ( "ARCH00054.P4",
                       "Case statement several choices in one alternative",
                        correct) ;
      end loop ;
   end process P4 ;
--
--
end ARCH00054 ;
--
entity ENT00054_Test_Bench is
end ENT00054_Test_Bench ;
--
architecture ARCH00054_Test_Bench of ENT00054_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
      for CIS1 : UUT use entity WORK.E00000 ( ARCH00054 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00054_Test_Bench ;
