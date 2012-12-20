-- NEED RESULT: ARCH00659: The predefined attributes of an interface object (port) of mode 'inout' for an entity may be read passed
-- NEED RESULT: ARCH00659: The predefined attributes of an interface object (port) of mode 'inout' for a block may be read failed
-- NEED RESULT: ARCH00659: The predefined signal attributes of an interface object (port) of mode 'inout' for an entity may be read failed
-- NEED RESULT: ARCH00659.Proc2: The predefined attributes of an interface object (variable parameter) of mode 'inout' for a subp may be read failed
-- NEED RESULT: ARCH00659: The predefined attributes of an interface object (signal parameter) of mode 'inout' for a subp may be read failed
-- NEED RESULT: ARCH00659: The predefined signal attributes of an interface object (signal parameter) of mode 'inout' for a subp may be read passed
-- NEED RESULT: ARCH00659: The predefined signal attributes of an interface object (port) of mode 'inout' for a block may be read passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

-- 
-- TEST NAME: 
-- 
--    CT00659 
-- 
-- AUTHOR: 
-- 
--    G. Tominovich 
-- 
-- TEST OBJECTIVES: 
-- 
--    4.3.3 (17)
-- 
-- DESIGN UNIT ORDERING: 
--
--    PKG00659 
--    PKG00659/BODY
--    ENT00659(ARCH00659)
--    ENT00659_Test_Bench(ARCH00659_Test_Bench)
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
package PKG00659 is
      
      subtype ST is Bit_Vector ( 10 to 20 ) ;
      type Bit_Vector_Array is array (Integer range <>) of ST;

      function bf_BV (P : Bit_Vector_Array) return ST;
      subtype rBV is bf_BV ST ;

      type Int_Arr is array ( Integer range <> ) of Integer ;
      function bf_I ( P : Int_Arr ) return Integer ;
      subtype rI is bf_I Integer ;
end PKG00659 ;

package body PKG00659 is
      function bf_BV (P : Bit_Vector_Array) return ST is
      begin
         return P(P'Left) ;
      end bf_BV ;

      function bf_I ( P : Int_Arr ) return Integer is
      begin
         return P(P'Left) ;
      end bf_I ;

end PKG00659 ;

use WORK.STANDARD_TYPES.all, WORK.PKG00659.all ;
entity ENT00659 is
   port ( Pt1 : inout rBV ;
	  Pt2 : inout rI ) ;
end ENT00659 ;
--
architecture ARCH00659 of ENT00659 is
   function To_Real ( P : Integer ) return Real is
   begin
      if P = -1 then
	 return -1.0 ;
      else
	 return -2.0 ;
      end if ;
   end To_Real ;

   function To_Integer ( P : Real ) return Integer is
   begin
      if P = -1.0 then
	 return -1 ;
      else
	 return -2 ;
      end if ;
   end To_Integer ;

   procedure Proc2 ( variable G : inout Bit_Vector ) is
      subtype ST_Up   is integer range G'RANGE ;
      subtype ST_Down is integer range G'REVERSE_RANGE(1) ;
   begin
      test_report ( "ARCH00659.Proc2" ,
		    "The predefined attributes of an interface "&
                    "object (variable parameter) of mode 'inout' for a "&
                    "subp may be read" ,
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

   Procedure Proc3 ( signal Pt1 : inout Bit_Vector; 
                     variable correct : out boolean ) is
      subtype ST_Up   is integer range Pt1'RANGE ;
      subtype ST_Down is integer range Pt1'REVERSE_RANGE(1) ;
   begin
      correct := (Pt1'LEFT = 10) and
                 (Pt1'RIGHT(1) = 20) and
                 (Pt1'HIGH(1) = 20) and
                 (Pt1'LOW = 10) and
                 (Pt1'LENGTH = 11) and
                 (ST_Up'LEFT = 10) and
                 (ST_Up'RIGHT = 20) and
                 (ST_Down'LEFT = 20) and
                 (ST_Down'RIGHT = 10) 
                 ;
   end Proc3 ; 

   procedure Proc4 ( signal Pt2 : inout Integer;
                     variable correct : out boolean ) is
   begin
      correct := 
                 (Pt2'EVENT) and
                 (Pt2'ACTIVE) and
                 (STD.STANDARD.NOW - Pt2'LAST_EVENT = 10 ns) and
                 (STD.STANDARD.NOW - Pt2'LAST_ACTIVE = 10 ns) and
                 (Pt2'LAST_VALUE = -2)
                 ;

   end Proc4 ; 

begin

   P2 :
   process  -- Check formal port on entity (no signal attributes)

      subtype ST_Up   is integer range Pt1'RANGE ;
      subtype ST_Down is integer range Pt1'REVERSE_RANGE(1) ;

   begin
      test_report ( "ARCH00659" ,
		    "The predefined attributes of an interface "&
                    "object (port) of mode 'inout' for an entity may be read" ,
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
         test_report ( "ARCH00659" ,
		       "The predefined signal attributes of an interface "&
                       "object (port) of mode 'inout' for an entity may "&
                       "be read" ,
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

      variable V : Bit_Vector (10 to 20) ;
      variable First_Time : boolean := True ;
      variable correct : boolean ;

   begin
      if First_Time then
         First_Time := false ;
      else
         Proc2 (G => V) ;
         Proc3 (Pt1, correct) ;
         test_report ( "ARCH00659" ,
		       "The predefined attributes of an interface "&
                       "object (signal parameter) of mode 'inout' for a subp "&
                       "may be read" ,
                       correct
                     ) ;
         Proc4 (Pt2, correct) ;
         test_report ( "ARCH00659" ,
		       "The predefined signal attributes of an interface "&
                       "object (signal parameter) of mode 'inout' for a subp "&
                       "may be read" ,
                       correct
                     ) ;
      end if ;
   end process P4 ; 

   L1 :  -- Check block ports/generics
   block
      port ( Pt1 : inout Bit_Vector ;
             Pt2 : inout Real ) ;
      port map ( Pt1 => Pt1, To_Integer(Pt2) => To_Real(Pt2) ) ;
   begin

      BP2 :
      process  -- Check formal port on block (no signal attributes)

         subtype ST_Up   is integer range Pt1'RANGE ;
         subtype ST_Down is integer range Pt1'REVERSE_RANGE(1) ;

      begin
         test_report ( "ARCH00659" ,
		       "The predefined attributes of an interface "&
                       "object (port) of mode 'inout' for a block may be read" ,
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
            test_report ( "ARCH00659" ,
		          "The predefined signal attributes of an interface "&
                          "object (port) of mode 'inout' for a block may be read" ,
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
end ARCH00659 ;
--
use WORK.PKG00659.all;
entity ENT00659_Test_Bench is
end ENT00659_Test_Bench ;

architecture ARCH00659_Test_Bench of ENT00659_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
 
      constant C : ST := B"10101010101" ;

      signal S1 : rBV := C;

      signal S2 : rI := -2;

      for CIS1 : UUT use entity WORK.ENT00659 ( ARCH00659 )
                            port map ( S1, S2 ) ;
   begin
      SigA : S2 <= transport -1 after 10 ns ;

      CIS1 : UUT ;
   end block L1 ;
end ARCH00659_Test_Bench ;
--
