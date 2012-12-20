-- NEED RESULT: ARCH00003.P1: Wait statement causes suspension of a process statement passed
-- NEED RESULT: ARCH00003.Glb_Proc1: Wait statement causes suspension of a procedure passed
-- NEED RESULT: ARCH00003.P2: Wait statement causes suspension of a process statement passed
-- NEED RESULT: ARCH00003.Glb_Proc2: Wait statement causes suspension of a procedure passed
-- NEED RESULT: ARCH00003.P3: Wait statement causes suspension of a process statement passed
-- NEED RESULT: ARCH00003.P4.Loc_Proc1: Wait statement causes suspension of a procedure passed
-- NEED RESULT: ARCH00003.P4: Wait statement causes suspension of a process statement passed
-- NEED RESULT: ARCH00003.P5.Loc_Proc2: Wait statement causes suspension of a procedure passed
-- NEED RESULT: ARCH00003.P5: Wait statement causes suspension of a process statement passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00003
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    8.1 (1)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00003)
--    ENT00003_Test_Bench(ARCH00003_Test_Bench)
--
-- REVISION HISTORY:
--
--    25-JUN-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00003 of E00000 is  -- Check with simple names
   signal Pulse : Boolean := c_boolean_1 ;

   procedure Glb_Proc1 is
      variable Save : Boolean ;
   begin
      Save := Pulse ;
      wait on Pulse ;
      test_report ( "ARCH00003.Glb_Proc1" ,
		    "Wait statement causes suspension of a procedure" ,
		    Save /= Pulse ) ;
   end Glb_Proc1 ;

   procedure Glb_Proc2 ( signal InParm : in Boolean ) is
      variable Save : Boolean ;
   begin
      Save := InParm ;
      wait on InParm ;
      test_report ( "ARCH00003.Glb_Proc2" ,
		    "Wait statement causes suspension of a procedure" ,
		    Save /= InParm ) ;
   end Glb_Proc2 ;

begin
   Change_Pulse :
   process (Pulse)
   begin
      if Pulse /= c_boolean_2 then
         Pulse <= transport c_boolean_2 after 1 ns ;
      end if ;
   end process Change_Pulse ;

   P1 :
   process
      variable Save : Boolean ;
   begin
      Save := Pulse ;
      wait on Pulse ;
      test_report ( "ARCH00003.P1" ,
		    "Wait statement causes suspension of a process statement" ,
		    Save /= Pulse ) ;
   end process P1 ;

   P2 :
   process
      variable Save : Boolean ;
   begin
      Save := Pulse ;
      Glb_Proc1 ;
      test_report ( "ARCH00003.P2" ,
		    "Wait statement causes suspension of a process statement" ,
		    Save /= Pulse ) ;
   end process P2 ;

   P3 :
   process
      variable Save : Boolean ;
   begin
      Save := Pulse ;
      Glb_Proc2 ( Pulse ) ;
      test_report ( "ARCH00003.P3" ,
		    "Wait statement causes suspension of a process statement" ,
		    Save /= Pulse ) ;
   end process P3 ;

   P4 :
   process
      variable Save : Boolean ;

      procedure Loc_Proc1 is
         variable Save : Boolean ;
      begin
         Save := Pulse ;
         wait on Pulse ;
         test_report ( "ARCH00003.P4.Loc_Proc1" ,
   		       "Wait statement causes suspension of a procedure" ,
		       Save /= Pulse ) ;
      end Loc_Proc1 ;

   begin
      Save := Pulse ;
      Loc_Proc1 ;
      test_report ( "ARCH00003.P4" ,
		    "Wait statement causes suspension of a process statement" ,
		    Save /= Pulse ) ;
   end process P4 ;


   P5 :
   process
      variable Save : Boolean ;

      procedure Loc_Proc2 ( signal InParm : in Boolean ) is
         variable Save : Boolean ;
      begin
         Save := InParm ;
         wait on InParm ;
         test_report ( "ARCH00003.P5.Loc_Proc2" ,
		       "Wait statement causes suspension of a procedure" ,
		       Save /= InParm ) ;
      end Loc_Proc2 ;

   begin
      Save := Pulse ;
      Loc_Proc2 ( Pulse ) ;
      test_report ( "ARCH00003.P5" ,
		    "Wait statement causes suspension of a process statement" ,
		    Save /= Pulse ) ;
   end process P5 ;

end ARCH00003 ;

entity ENT00003_Test_Bench is
end ENT00003_Test_Bench ;

architecture ARCH00003_Test_Bench of ENT00003_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00003 ) ;

   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00003_Test_Bench ;

