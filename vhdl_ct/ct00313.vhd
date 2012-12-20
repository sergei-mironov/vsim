-- NEED RESULT: ARCH00313: Concurrent procedure call is allowed in a block passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00313
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.1 (9)
--    9.1 (10)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00313)
--    ENT00313_Test_Bench(ARCH00313_Test_Bench)
--
-- REVISION HISTORY:
--
--    29-JUL-1987   - initial revision
--    28-NOV-1989   - (ESL) changed files to be of mode out
--
-- NOTES:
--
--    self-checking
--
--
architecture ARCH00313 of E00000 is
begin
   L1 :
   block
      use WORK.STANDARD_TYPES.all ; -- A use clause in a block

      type File_Type is file of Integer ;
      file A_File : File_Type is out "ct00313.dat" ;
               -- A file declaration in a block

      disconnect all : boolean after 10 ns ; -- A disconnection spec in a block

      procedure A_Proc is
      begin
         test_report ( "ARCH00313" ,
		       "Concurrent procedure call is allowed in a block" ,
		       True ) ;
      end A_Proc ;

   begin
      A_Proc ;  -- Concurrent procedure call in a block
   end block L1 ;
end ARCH00313 ;

entity ENT00313_Test_Bench is
end ENT00313_Test_Bench ;

architecture ARCH00313_Test_Bench of ENT00313_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00313 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00313_Test_Bench ;
