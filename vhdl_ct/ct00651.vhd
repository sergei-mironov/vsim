-- NEED RESULT: ARCH00651: The value and predefined attributes of an interface object (generic) of mode 'in' for an entity may be read failed
-- NEED RESULT: ARCH00651: The value and predefined attributes of an interface object (port) of mode 'in' for an entity may be read failed
-- NEED RESULT: ARCH00651: The value and predefined attributes of an interface object (generic) of mode 'in' for a block may be read failed
-- NEED RESULT: ARCH00651: The value and predefined attributes of an interface object (port) of mode 'in' for a block may be read failed
-- NEED RESULT: ARCH00651: The value and predefined signal attributes of an interface object (port) of mode 'in' for an entity may be read passed
-- NEED RESULT: ARCH00651.Proc1: The value and predefined attributes of an interface object (constant parameter) of mode 'in' for a subp may be read failed
-- NEED RESULT: ARCH00651.Proc2: The value and predefined attributes of an interface object (variable parameter) of mode 'in' for a subp may be read failed
-- NEED RESULT: ARCH00651: The value and predefined attributes of an interface object (signal parameter) of mode 'in' for a subp may be read failed
-- NEED RESULT: ARCH00651: The value and predefined signal attributes of an interface object (signal parameter) of mode 'in' for a subp may be read (except DELAYED, STABLE, and QUIET) passed
-- NEED RESULT: ARCH00651: The value and predefined signal attributes of an interface object (port) of mode 'in' for a block may be read passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

-- 
-- TEST NAME: 
-- 
--    CT00651 
-- 
-- AUTHOR: 
-- 
--    G. Tominovich 
-- 
-- TEST OBJECTIVES: 
-- 
--    4.3.3 (13)
-- 
-- DESIGN UNIT ORDERING: 
--
--    ENT00651(ARCH00651)
--    ENT00651_Test_Bench(ARCH00651_Test_Bench)
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
entity ENT00651 is
   generic ( G : Bit_Vector ) ;
   port ( Pt1 : in Bit_Vector ;
	  Pt2 : in Integer ) ;
end ENT00651 ;
--
architecture ARCH00651 of ENT00651 is
   function To_Real ( P : Integer ) return Real is
   begin
      if P = -1 then
	 return -1.0 ;
      else
	 return -2.0 ;
      end if ;
   end To_Real ;

   procedure Proc1 ( constant G : in Bit_Vector ) is
      subtype ST_Up   is integer range G'RANGE ;
      subtype ST_Down is integer range G'REVERSE_RANGE(1) ;
   begin
      test_report ( "ARCH00651.Proc1" ,
		    "The value and predefined attributes of an interface "&
                    "object (constant parameter) of mode 'in' for a subp may be read" ,
		    (G = B"10101010101") and
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

   procedure Proc2 ( variable G : inout Bit_Vector ) is
      subtype ST_Up   is integer range G'RANGE ;
      subtype ST_Down is integer range G'REVERSE_RANGE(1) ;
   begin
      test_report ( "ARCH00651.Proc2" ,
		    "The value and predefined attributes of an interface "&
                    "object (variable parameter) of mode 'in' for a subp may be read" ,
		    (G = B"10101010101") and
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

   function Func1 ( signal Pt1 : in Bit_Vector ) return boolean is
      subtype ST_Up   is integer range Pt1'RANGE ;
      subtype ST_Down is integer range Pt1'REVERSE_RANGE(1) ;
   begin
      return (Pt1 = B"10101010101") and
             (Pt1'LEFT = 10) and
             (Pt1'RIGHT(1) = 20) and
             (Pt1'HIGH(1) = 20) and
             (Pt1'LOW = 10) and
             (Pt1'LENGTH = 11) and
             (ST_Up'LEFT = 10) and
             (ST_Up'RIGHT = 20) and
             (ST_Down'LEFT = 20) and
             (ST_Down'RIGHT = 10) 
             ;
   end Func1 ; 

   function Func2 ( signal Pt2 : in Integer ) return boolean is
   begin
      return (Pt2 = -1) and
             (Pt2'EVENT) and
             (Pt2'ACTIVE) and
             (STD.STANDARD.NOW - Pt2'LAST_EVENT = 10 ns) and
             (STD.STANDARD.NOW - Pt2'LAST_ACTIVE = 10 ns) and
             (Pt2'LAST_VALUE = -2)
             ;

   end Func2 ; 

begin
   P1 :
   process  -- Check formal generic on entity

      subtype ST_Up   is integer range G'RANGE ;
      subtype ST_Down is integer range G'REVERSE_RANGE(1) ;

   begin
      test_report ( "ARCH00651" ,
		    "The value and predefined attributes of an interface "&
                    "object (generic) of mode 'in' for an entity may be read" ,
		    (G = B"10101010101") and
                    (G'LEFT = 10) and
                    (G'RIGHT(1) = 20) and
                    (G'HIGH(1) = 20) and
                    (G'LOW = 10) and
                    (G'LENGTH = 11) and
                    (ST_Up'LEFT = 10) and
                    (ST_Up'RIGHT = 20) and
                    (ST_Down'LEFT = 20) and
                    (ST_Down'RIGHT = 10) ) ;
      wait ;
   end process P1 ; 



   P2 :
   process  -- Check formal port on entity (no signal attributes)

      subtype ST_Up   is integer range Pt1'RANGE ;
      subtype ST_Down is integer range Pt1'REVERSE_RANGE(1) ;

   begin
      test_report ( "ARCH00651" ,
		    "The value and predefined attributes of an interface "&
                    "object (port) of mode 'in' for an entity may be read" ,
		    (Pt1 = B"10101010101") and
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




   P3 :
   process ( Pt2 )  -- Check formal port on entity (signal attributes)

      variable First_Time : boolean := True ;

   begin
      if First_Time then
         First_Time := false ;
      else
         test_report ( "ARCH00651" ,
		       "The value and predefined signal attributes of an interface "&
                       "object (port) of mode 'in' for an entity may be read" ,
		       (Pt2 = -1) and
                       (Pt2'DELAYED(10 ns) = -2) and
                       (Not Pt2'STABLE(10 ns)) and
                       (Not Pt2'QUIET(10 ns)) and
                       (Pt2'EVENT) and
                       (Pt2'ACTIVE) and
                       (STD.STANDARD.NOW - Pt2'LAST_EVENT = 10 ns) and
                       (STD.STANDARD.NOW - Pt2'LAST_ACTIVE = 10 ns) and
                       (Pt2'LAST_VALUE = -2)

                     ) ;
      end if ;
   end process P3 ; 



   P4 :
   process ( Pt2 )  -- Check formal parameters in a subprogram

      variable V : Bit_Vector (G'Range) := G ;
      variable First_Time : boolean := True ;

   begin
      if First_Time then
         First_Time := false ;
      else
         Proc1 (G => G) ;
         Proc2 (G => V) ;
         test_report ( "ARCH00651" ,
		       "The value and predefined attributes of an interface "&
                       "object (signal parameter) of mode 'in' for a subp "&
                       "may be read" ,
                       Func1 (Pt1 => Pt1)
                     ) ;
         test_report ( "ARCH00651" ,
		       "The value and predefined signal attributes of an interface "&
                       "object (signal parameter) of mode 'in' for a subp "&
                       "may be read (except DELAYED, STABLE, and QUIET)" ,
                       Func2 (Pt2 => Pt2)
                     ) ;
      end if ;
   end process P4 ; 

   L1 :  -- Check block ports/generics
   block
      generic ( G : in Bit_Vector ) ;
      generic map ( G => G ) ;
      port ( Pt1 : in Bit_Vector ;
             Pt2 : in Real ) ;
      port map ( Pt1 => Pt1, Pt2 => To_Real(Pt2) ) ;
   begin
      BP1 :
      process  -- Check formal generic on block

         subtype ST_Up   is integer range G'RANGE ;
         subtype ST_Down is integer range G'REVERSE_RANGE(1) ;

      begin
         test_report ( "ARCH00651" ,
		       "The value and predefined attributes of an interface "&
                       "object (generic) of mode 'in' for a block may be read" ,
		       (G = B"10101010101") and
                       (G'LEFT = 10) and
                       (G'RIGHT(1) = 20) and
                       (G'HIGH(1) = 20) and
                       (G'LOW = 10) and
                       (G'LENGTH = 11) and
                       (ST_Up'LEFT = 10) and
                       (ST_Up'RIGHT = 20) and
                       (ST_Down'LEFT = 20) and
                       (ST_Down'RIGHT = 10) ) ;
         wait ;
      end process BP1 ; 



      BP2 :
      process  -- Check formal port on block (no signal attributes)

         subtype ST_Up   is integer range Pt1'RANGE ;
         subtype ST_Down is integer range Pt1'REVERSE_RANGE(1) ;

      begin
         test_report ( "ARCH00651" ,
		       "The value and predefined attributes of an interface "&
                       "object (port) of mode 'in' for a block may be read" ,
		       (Pt1 = B"10101010101") and
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




      BP3 :
      process ( Pt2 )  -- Check formal port on a block (signal attributes)

         variable First_Time : boolean := True ;

      begin
         if First_Time then
            First_Time := false ;
         else
            test_report ( "ARCH00651" ,
		          "The value and predefined signal attributes of an interface "&
                          "object (port) of mode 'in' for a block may be read" ,
		          (Pt2 = -1.0) and
                          (Pt2'DELAYED(10 ns) = -2.0) and
                          (Not Pt2'STABLE(10 ns)) and
                          (Not Pt2'QUIET(10 ns)) and
                          (Pt2'EVENT) and
                          (Pt2'ACTIVE) and
                          (STD.STANDARD.NOW - Pt2'LAST_EVENT = 10 ns) and
                          (STD.STANDARD.NOW - Pt2'LAST_ACTIVE = 10 ns) and
                          (Pt2'LAST_VALUE = -2.0)

                        ) ;
         end if ;
      end process BP3 ; 
   end block L1 ;
end ARCH00651 ;
--
entity ENT00651_Test_Bench is
end ENT00651_Test_Bench ;
 
architecture ARCH00651_Test_Bench of ENT00651_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
 
      subtype ST is Bit_Vector ( 10 to 20 ) ;
      constant C : ST := B"10101010101" ;

      signal S1 : ST := C ;

      signal S2 : Integer := -2 ;

      for CIS1 : UUT use entity WORK.ENT00651 ( ARCH00651 )
			    generic map ( G => C )
                            port map ( S1, S2 ) ;
   begin
      SigA : S2 <= transport -1 after 10 ns ;

      CIS1 : UUT ;
   end block L1 ;
end ARCH00651_Test_Bench ;
--
