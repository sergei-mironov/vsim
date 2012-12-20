-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00666
--
-- AUTHOR:
--
--    A. Wilmot
--
-- TEST OBJECTIVES:
--
--    4.3.4 (3)
--    4.3.4 (5)
--    4.3.4 (7)
--    4.3.4 (8)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00666(ARCH00666)
--    ENT00666_Test_Bench(ARCH00666_Test_Bench)
--
-- REVISION HISTORY:
--
--    31-AUG-1987   - initial revision
--    16-JUN-1988   - (KLM) added wait statement at end of process
--
-- NOTES:
--
--    self-checking
--
use WORK.STANDARD_TYPES.all ;
entity ENT00666 is
   generic ( g_integer : integer := 5 ) ;
--
   type bool_arr is array ( severity_level range <> ) of boolean ;
   subtype st_bool_arr is bool_arr
             ( failure downto severity_level'val( g_integer - 5) ) ;
   attribute at_scalar1 : bit ;
   attribute at_scalar2 : bit ;
   attribute at_scalar3 : bit ;
end ENT00666 ;
--
architecture ARCH00666 of ENT00666 is
   constant c_bv : bit_vector := B"11001" ;
   subtype bv1 is bit_vector (1 to 3 ) ;
   subtype bv2 is bit_vector (7 to 9 ) ;
   subtype bv3 is bit_vector (5 + g_integer downto 8) ;
   alias al_att1 : bv1 is c_bv(2 to 4) ;
   alias al_att2 : bv2 is c_bv(g_integer - 5 to 2) ;
   alias al_att3 : bv3 is c_bv(g_integer - 4 to 3) ;

   attribute at_scalar1 of ARCH00666 : architecture is al_att1(3) ;
   attribute at_scalar2 of ARCH00666 : architecture is al_att2(g_integer + 2) ;
   attribute at_scalar3 of ARCH00666 : architecture is al_att3(g_integer + 5) ;

begin
   process
      variable correct : boolean := true ;
      variable v_bool_arr : st_bool_arr ;
      subtype bool1 is bool_arr (note to error) ;
      subtype bool2 is bool_arr (warning to failure) ;
      subtype bool3 is bool_arr
            (severity_level'val(7 - g_integer) downto note) ;
      alias al_bool1 : bool1 is v_bool_arr(failure downto warning ) ;
      alias al_bool2 : bool2 is
         v_bool_arr(error downto severity_level'val(5 - g_integer) ) ;
      alias al_bool3 : bool3 is
         v_bool_arr(failure downto severity_level'val(6 - g_integer)) ;

   begin
      for i in failure downto note loop
	 v_bool_arr(i) := boolean'val(severity_level'pos(i) mod 2) ;
      end loop ;
      correct := correct and al_bool1(warning to error) = al_bool2(warning to
                  error) and al_bool2(warning to error) = al_bool3(warning
                  downto note) and al_bool3(warning downto note) =
                  (false, true) ;

      test_report ( "ARCH00666" ,
		    "Reference to array slice in alias uses subtype"
                    & " given in alias declaration" ,
     		    correct and ARCH00666'at_scalar1 = ARCH00666'at_scalar2 and
                    ARCH00666'at_scalar2 = ARCH00666'at_scalar3 and
                    ARCH00666'at_scalar3 = '1' ) ;
      wait;
   end process ;
end ARCH00666 ;
--
entity ENT00666_Test_Bench is
end ENT00666_Test_Bench ;

architecture ARCH00666_Test_Bench of ENT00666_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00666 ( ARCH00666 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00666_Test_Bench ;
--
