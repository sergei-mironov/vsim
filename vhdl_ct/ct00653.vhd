-- NEED RESULT: ARCH00653: The predefined attributes of an interface object (port) of mode 'out' for an entity may be read failed
-- NEED RESULT: ARCH00653.Proc1: The predefined attributes of an interface object (signal parameter) of mode 'out' for a subp may be read failed
-- NEED RESULT: ARCH00653.Proc2: The predefined attributes of an interface object (variable parameter) of mode 'out' for a subp may be read failed
-- NEED RESULT: ARCH00653: The predefined attributes of an interface object (port) of mode 'out' for a block may be read failed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00653
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    4.3.3 (15)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00653(ARCH00653)
--    ENT00653_Test_Bench(ARCH00653_Test_Bench)
--
-- REVISION HISTORY:
--
--    26-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00653 is
   port ( Pt1, Pt2 : out Bit_Vector ) ;

end ENT00653 ;
--
architecture ARCH00653 of ENT00653 is
   procedure Proc1 ( signal G : out Bit_Vector ) is
      subtype ST_Up   is integer range G'RANGE ;
      subtype ST_Down is integer range G'REVERSE_RANGE(1) ;
   begin
      test_report ( "ARCH00653.Proc1" ,
		    "The predefined attributes of an interface "&
                    "object (signal parameter) of mode 'out' for a subp "&
                    "may be read" ,
                    (G'LEFT = 10) and
                    (G'RIGHT(1) = 20) and
                    (G'HIGH(1) = 20) and
                    (G'LOW = 10) and
                    (G'LENGTH = 11) and
                    (ST_Up'LEFT = 10) and
                    (ST_Up'RIGHT = 20) and
                    (ST_Down'LEFT = 20) and
                    (ST_Down'RIGHT = 10) ) ;
   end Proc1 ;

   procedure Proc2 ( variable G : out Bit_Vector ) is
      subtype ST_Up   is integer range G'RANGE ;
      subtype ST_Down is integer range G'REVERSE_RANGE(1) ;
   begin
      test_report ( "ARCH00653.Proc2" ,
		    "The predefined attributes of an interface "&
                    "object (variable parameter) of mode 'out' for a subp "&
                    "may be read" ,
                    (G'LEFT = 10) and
                    (G'RIGHT(1) = 20) and
                    (G'HIGH(1) = 20) and
                    (G'LOW = 10) and
                    (G'LENGTH = 11) and
                    (ST_Up'LEFT = 10) and
                    (ST_Up'RIGHT = 20) and
                    (ST_Down'LEFT = 20) and
                    (ST_Down'RIGHT = 10) ) ;
   end Proc2 ;

begin
   P2 :
   process  -- Check formal port on entity (no signal attributes)

      subtype ST_Up   is integer range Pt1'RANGE ;
      subtype ST_Down is integer range Pt1'REVERSE_RANGE(1) ;

   begin
      test_report ( "ARCH00653" ,
		    "The predefined attributes of an interface "&
                    "object (port) of mode 'out' for an entity may be read" ,
                    (Pt1'LEFT = 10) and
                    (Pt1'RIGHT(1) = 20) and
                    (Pt1'HIGH(1) = 20) and
                    (Pt1'LOW = 10) and
                    (Pt1'LENGTH = 11) and
                    (ST_Up'LEFT = 10) and
                    (ST_Up'RIGHT = 20) and
                    (ST_Down'LEFT = 20) and
                    (ST_Down'RIGHT = 10)

                  ) ;
      wait ;
   end process P2 ;




   P4 :
   process  -- Check formal parameters in a subprogram

      variable V : Bit_Vector (10 to 20) ;

   begin
      Proc1 (G => Pt2) ;
      Proc2 (G => V) ;
      wait ;
   end process P4 ;

   L1 :  -- Check block ports/generics
   block
      port ( Pt1 : out Bit_Vector ) ;
      port map ( Pt1 => Pt1 ) ;
   begin
      BP2 :
      process  -- Check formal port on block (no signal attributes)

         subtype ST_Up   is integer range Pt1'RANGE ;
         subtype ST_Down is integer range Pt1'REVERSE_RANGE(1) ;

      begin
         test_report ( "ARCH00653" ,
		       "The predefined attributes of an interface "&
                       "object (port) of mode 'out' for a block may be read" ,
                       (Pt1'LEFT = 10) and
                       (Pt1'RIGHT(1) = 20) and
                       (Pt1'HIGH(1) = 20) and
                       (Pt1'LOW = 10) and
                       (Pt1'LENGTH = 11) and
                       (ST_Up'LEFT = 10) and
                       (ST_Up'RIGHT = 20) and
                       (ST_Down'LEFT = 20) and
                       (ST_Down'RIGHT = 10)

                     ) ;
         wait ;
      end process BP2 ;
   end block L1 ;
end ARCH00653 ;
--
entity ENT00653_Test_Bench is
end ENT00653_Test_Bench ;

architecture ARCH00653_Test_Bench of ENT00653_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      subtype ST is Bit_Vector (10 to 20) ;
      signal S1, S2 : ST ;

      for CIS1 : UUT use entity WORK.ENT00653 ( ARCH00653 )
                            port map ( S1, S2 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00653_Test_Bench ;
--
