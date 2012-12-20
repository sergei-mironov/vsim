-- NEED RESULT: ARCH00665: Reference to array element in alias uses subtype given in alias declaration passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00665
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.4 (3)
--    4.3.4 (4)
--    4.3.4 (7)
--    4.3.4 (8)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00665(ARCH00665)
--    ENT00665_Test_Bench(ARCH00665_Test_Bench)
--
-- REVISION HISTORY:
--
--    27-AUG-1987   - initial revision
--    16-JUN-1988   - (KLM) added wait statement at end of process
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
entity ENT00665 is
   generic ( g_integer : integer := 5 ) ;
--
   attribute at_scalar : character ;
   attribute at_composite : string ;
end ENT00665 ;
--
architecture ARCH00665 of ENT00665 is
   attribute at_composite of ARCH00665 : architecture is "abcde" ;
   constant str : string := ARCH00665'at_composite ;
   subtype str1 is string (1 to 5 ) ;
   subtype str2 is string (5 to 9 ) ;
   subtype str3 is string (5 + g_integer - 1 downto 5) ;
   alias al_att1 : str1 is str ;
   alias al_att2 : str2 is str ;
   alias al_att3 : str3 is str ;

   alias at_scalar1 : character is al_att1(1) ;
   alias at_scalar2 : character is al_att2(g_integer) ;
   alias at_scalar3 : character is al_att3(g_integer + 4) ;

begin
   process
      variable correct : boolean := true ;
   begin
      test_report ( "ARCH00665" ,
		    "Reference to array element in alias uses subtype"
                    & " given in alias declaration" ,
     		    correct and at_scalar1 = at_scalar2 and
                                at_scalar2 = at_scalar3 and at_scalar3 = 'a' ) ;
      wait;
   end process ;
end ARCH00665 ;
--
entity ENT00665_Test_Bench is
end ENT00665_Test_Bench ;

architecture ARCH00665_Test_Bench of ENT00665_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00665 ( ARCH00665 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00665_Test_Bench ;
--
