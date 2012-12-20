-- NEED RESULT: ARCH00424: Identifiers passed
-- 
-- TEST NAME: 
-- 
--    CT00424 
-- 
-- AUTHOR: 
-- 
--    D. Hyman 
-- 
-- TEST OBJECTIVES: 
-- 
--    13.3 (1) 
--    13.3 (2) 
--    13.3 (3)
-- 
-- DESIGN UNIT ORDERING: 
--
--    E00000(ARCH00424)
--    ENT00424_Test_Bench(ARCH00424_Test_Bench)
--
-- REVISION HISTORY: 
-- 
--     3-AUG-1987   - initial revision
-- 
-- NOTES:
-- 
--    self-checking
--
-- 
use WORK.STANDARD_TYPES.all ;
architecture ARCH00424 of E00000 is
begin
   P :
   PROCESS

      -- these declarations verify that letter case is insignificant (13.3 (1))
      TYpe XyZ is ( A1, A2, A3, A4, A5, A6, A7 ) ; 
      suBtyPe XYZ_subtype is xYz range a3 to a6 ; 
      cONStant xyz_C1 : XYZ_SUBTYpe := A4 ; 
      Constant Xyz_C2 : xyZ_SUBType := A6 ; 
      constaNT Xyz_C3 : XyZ_sUBType := xyz_Subtype'RighT ; 

      -- these declarations chack that input lines and identifiers can be
      -- 132 chars long, and that all chars in a name are significant
      -- (13.3 (2) and 13.3 (3))
      variABle 
X1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890a
             : inTeger := 25 ; 
      VAriABle 
X1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890b
             : InTeger := 25 ;
   begin
X1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890A
             := 
X1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890B
             + 2 ;
      Test_REPort ( "ARCH00424" ,
		    "Identifiers" ,
                    (xYz_C1 /= Xyz_c2) and
                    (XyZ_C2 = XYZ_C3) and 
		    (
x1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890A
                     = 25 + 2)
                  ) ;
      wait ;
   end process P ;
end ARCH00424 ;

entitY ENT00424_Test_Bench iS
enD ENT00424_Test_Bench ;
 
ARCHitecture ARCH00424_Test_Bench of ENT00424_Test_Bench is
begiN
   L1:
   blOCk
      cOMPonent UUT
      end component ;
 
      foR cis1 : uut USe Entity WORK.e00000 ( aRCH00424 ) ;
   beGin
      CIS1 : UUT ;
   end block L1 ;
end aRCH00424_Test_Bench ;

