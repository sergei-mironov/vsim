
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------

-- 
-- TEST NAME: 
-- 
--    CT00662 
-- 
-- AUTHOR: 
-- 
--    G. Tominovich 
-- 
-- TEST OBJECTIVES: 
-- 
--    4.3.3 (19)
-- 
-- DESIGN UNIT ORDERING: 
--
--    ENT00662(ARCH00662)
--    ENT00662_Test_Bench(ARCH00662_Test_Bench)
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
use WORK.STANDARD_TYPES.all;
entity ENT00662 is
   port ( Pt1 : buffer Bit_Vector ;
	  Pt2 : buffer Integer ) ;
end ENT00662 ;
--
architecture ARCH00662 of ENT00662 is
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

begin

   P2 :
   process  -- Check formal port on entity (no signal attributes)

      subtype ST_Up   is integer range Pt1'RANGE ;
      subtype ST_Down is integer range Pt1'REVERSE_RANGE(1) ;

   begin
      test_report ( "ARCH00662" ,
		    "The predefined attributes of an interface "&
                    "object (port) of mode 'buffer' for an entity may be read" ,
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
         test_report ( "ARCH00662" ,
		       "The predefined signal attributes of an interface "&
                       "object (port) of mode 'buffer' for an entity may "&
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


   L1 :  -- Check block ports/generics
   block
      port ( Pt1 : buffer Bit_Vector ;
             Pt2 : buffer Real ) ;
      port map ( Pt1 => Pt1, To_Integer(Pt2) => To_Real(Pt2) ) ;
   begin

      BP2 :
      process  -- Check formal port on block (no signal attributes)

         subtype ST_Up   is integer range Pt1'RANGE ;
         subtype ST_Down is integer range Pt1'REVERSE_RANGE(1) ;

      begin
         test_report ( "ARCH00662" ,
		       "The predefined attributes of an interface "&
                       "object (port) of mode 'buffer' for a block may be read" ,
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
            Pt2 <= transport -1.0 after 10 ns ;
         else
            test_report ( "ARCH00662" ,
		          "The predefined signal attributes of an interface "&
                          "object (port) of mode 'buffer' for a block may be read" ,
                          (Pt2'DELAYED(10 ns) = real'left) and
                          (Not Pt2'STABLE(10 ns)) and
                          (Not Pt2'QUIET(10 ns)) and
                          (Pt2'EVENT) and
                          (Pt2'ACTIVE) and
                          (STD.STANDARD.NOW - Pt2'LAST_EVENT = 10 ns) and
                          (STD.STANDARD.NOW - Pt2'LAST_ACTIVE = 10 ns) and
                          (Pt2'LAST_VALUE = real'left)

                        ) ;
         end if ;
      end process BP3 ; 
   end block L1 ;
end ARCH00662 ;
--
entity ENT00662_Test_Bench is
end ENT00662_Test_Bench ;
 
architecture ARCH00662_Test_Bench of ENT00662_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;
 
      subtype ST is Bit_Vector ( 10 to 20 ) ;
      constant C : ST := B"10101010101" ;

      signal S1 : ST := C ;

      signal S2 : Integer := -2 ;

      for CIS1 : UUT use entity WORK.ENT00662 ( ARCH00662 )
                            port map ( S1, S2 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00662_Test_Bench ;
--
