-- NEED RESULT: ARCH00580: Check involving overloading context rule 1 passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00580
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    10.5 (1)
--
-- DESIGN UNIT ORDERING:
--
--    PKG00580
--    PKG00580/BODY
--    ENT00580_Test_Bench(ARCH00580_Test_Bench)
--
-- REVISION HISTORY:
--
--    20-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
package PKG00580 is
   type COLOR is (RED, YELLOW, GREEN, BROWN, TAN, WHITE, BLUE) ;
   type LIGHTS is (RED, YELLOW, GREEN, BROWN, TAN, WHITE, BLUE) ;

   function F1 (A : COLOR := RED; B : LIGHTS := RED) return COLOR;
   function F1 (A : LIGHTS := BLUE; B : COLOR := BLUE) return LIGHTS;

   function "+" ( L,R : COLOR ) return COLOR ;
   function "+" ( L,R : LIGHTS ) return LIGHTS ;

end PKG00580 ;

package body PKG00580 is
   function F1 (A : COLOR := RED; B : LIGHTS := RED) return COLOR is
      variable RESULT : COLOR := RED;
   begin
      if (A /= RED) and (B /= BLUE) then
         RESULT  := COLOR'PRED (A) ;
         return RESULT ;
      else
         return GREEN;
      end if;
   end F1;

   function F1 (A : LIGHTS := BLUE; B : COLOR := BLUE) return LIGHTS is
      variable RESULT : LIGHTS := RED;
   begin
      if (A /= RED) and (B /= BLUE) then
         RESULT  := LIGHTS'PRED (A) ;
         return RESULT ;
      else
         return GREEN;
      end if;
   end F1;

   function "+" ( L,R : COLOR ) return COLOR is
   begin
      return COLOR'Val ((COLOR'Pos (L) + COLOR'Pos (R)) mod 7) ;
   end "+" ;

   function "+" ( L,R : LIGHTS ) return LIGHTS is
   begin
      return LIGHTS'Val (COLOR'Pos (COLOR'Val (LIGHTS'Pos (L)) +
                                    COLOR'Val (LIGHTS'Pos (R))
                                   )
                        ) ;
   end "+" ;

end PKG00580 ;

use WORK.STANDARD_TYPES.all ;
use WORK.PKG00580.all ;
entity ENT00580_Test_Bench is
end ENT00580_Test_Bench ;

architecture ARCH00580_Test_Bench of ENT00580_Test_Bench is
begin
   L1 :
   block
      constant CC1 : COLOR  := F1 ;   -- set to GREEN
      constant LC1 : LIGHTS := F1 ;   -- set to GREEN

      constant CC2 : COLOR  := F1 (COLOR'(GREEN)) ;    -- set to YELLOW
      constant LC2 : LIGHTS := F1 (LIGHTS'(GREEN)) ;   -- set to GREEN

      constant CC3 : COLOR  := F1 (B => BLUE) ;  -- set to GREEN
      constant LC3 : LIGHTS := F1 (B => BLUE) ;  -- set to GREEN

      constant CC4 : COLOR  := COLOR'(YELLOW) + COLOR'(GREEN) ;    -- set to BRO
      constant LC4 : LIGHTS := LIGHTS'(YELLOW) + LIGHTS'(GREEN) ;  -- set to BRO

      constant CC5 : COLOR  := COLOR'(YELLOW)  + BROWN ;  -- set to TAN
      constant LC5 : LIGHTS := LIGHTS'(YELLOW) + BROWN ;  -- set to TAN

      constant CC6 : COLOR  := YELLOW + TAN ;  -- set to WHITE
      constant LC6 : LIGHTS := YELLOW + TAN ;  -- set to WHITE

   begin
      process
      begin
	 test_report ( "ARCH00580" ,
		       "Check involving overloading context rule 1" ,
                       (CC1 = GREEN) and
                       (LC1 = GREEN) and
                       (CC2 = YELLOW) and
                       (LC2 = GREEN) and
                       (CC3 = GREEN) and
                       (LC3 = GREEN) and
                       (CC4 = BROWN) and
                       (LC4 = BROWN) and
                       (CC5 = TAN) and
                       (LC5 = TAN) and
                       (CC6 = WHITE) and
                       (LC6 = WHITE)
		         ) ;
	 wait ;
      end process ;
   end block L1 ;
end ARCH00580_Test_Bench ;
--

