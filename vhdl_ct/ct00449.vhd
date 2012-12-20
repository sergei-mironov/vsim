-- NEED RESULT: ARCH00449 Assert allowed in a FOR generate statement Passed
-- NEED RESULT: ARCH00449: Block statement allowed in a FOR generate statement passed
-- NEED RESULT: ARCH00449: Generate statement allowed in a FOR generate statement passed
-- NEED RESULT: ARCH00449 Assert allowed in a IF generate statement Passed
-- NEED RESULT: ARCH00449: Block statement allowed in a IF generate statement passed
-- NEED RESULT: ARCH00449: Generate statement allowed in a FOR generate statement passed
-- NEED RESULT: ARCH00449: Process and concurrent sig asg statements allowed in a IF generate statement passed
-- NEED RESULT: ARCH00449: Process and concurrent sig asg statements allowed in a FOR generate statement passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00449
--
-- AUTHOR:
--
--    G. Tominovich
--
-- TEST OBJECTIVES:
--
--    9.7 (1)
--    9.7 (3)
--    9.7 (4)
--    9.7 (8)
--    9.7 (9)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00449_1(ARCH00449_1)
--    E00000(ARCH00449)
--    ENT00449_Test_Bench(ARCH00449_Test_Bench)
--
-- REVISION HISTORY:
--
--     5-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--
entity ENT00449_1 is
end ENT00449_1 ;

use WORK.STANDARD_TYPES.all ;
architecture ARCH00449_1 of ENT00449_1 is
begin
   process
   begin
      test_report ( "ARCH00449" ,
		    "Component instantiation is allowed in a generate "&
                    "statement" ,
		    True ) ;
      wait ;
   end process ;
end ARCH00449_1 ;

use WORK.STANDARD_TYPES.all ;
architecture ARCH00449 of E00000 is
   component Comp1
   end component ;

   for all : Comp1 use entity WORK.ENT00449_1 ( ARCH00449_1 );

   signal s1, s2 : boolean := false ;

   constant C : boolean := true ;

begin
   For_Gen :
   for i in 1 to 1 generate
      B1 :
      block
      begin
	 process
	 begin
	    test_report ( "ARCH00449" ,
			  "Block statement allowed in a FOR generate "&
                          "statement" ,
			  i = 1 ) ;
            wait ;
	 end process ;
      end block B1 ;

      assert i /= 1
	   report "ARCH00449 Assert allowed in a FOR generate statement Passed"
	   severity Note ;

      s1 <= transport True after 10 ns ;
      process ( s1 )
         variable First_Time : boolean := true;
      begin
         if First_Time then
            First_Time := false;
         else
            test_report ( "ARCH00449" ,
			  "Process and concurrent sig asg statements "&
                          "allowed in a FOR generate statement" ,
			  s1 ) ;
         end if ;
      end process ;

      CIS1 : Comp1;

      g1:
      if i = 1 generate
	    process
	    begin
	       test_report ( "ARCH00449" ,
			     "Generate statement allowed in a FOR generate "&
                             "statement" ,
			     i = 1 ) ;
               wait ;
	    end process ;
      end generate ;

   end generate For_Gen ;

   If_Gen :
   if C generate
      B2 :
      block
      begin
	 process
	 begin
	    test_report ( "ARCH00449" ,
			  "Block statement allowed in a IF generate statement" ,
			  C ) ;
            wait ;
	 end process ;
      end block B2 ;

      assert Not C
	   report "ARCH00449 Assert allowed in a IF generate statement Passed"
	   severity Note ;

      s2 <= transport True after 10 ns ;
      process ( s2 )
         variable First_Time : boolean := true;
      begin
         if First_Time then
            First_Time := false;
         else
            test_report ( "ARCH00449" ,
			  "Process and concurrent sig asg statements "&
                          "allowed in a IF generate statement" ,
			  s2 ) ;
         end if ;
      end process ;

      CIS2 : Comp1;

      g2:
      for j in 1 to 1 generate
	    process
	    begin
	       test_report ( "ARCH00449" ,
			     "Generate statement allowed in a FOR generate "&
                             "statement" ,
			     j = 1 ) ;
               wait ;
	    end process ;
      end generate ;

   end generate If_Gen ;
end ARCH00449 ;


entity ENT00449_Test_Bench is
end ENT00449_Test_Bench ;

architecture ARCH00449_Test_Bench of ENT00449_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00449 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00449_Test_Bench ;
