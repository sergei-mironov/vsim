-- NEED RESULT: ARCH00476: Functions can return user defined types passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00476
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    2.1 (8)
--    2.1 (10)
--
-- DESIGN UNIT ORDERING:
--
--    GENERIC_STANDARD_TYPES(ARCH00476)
--    ENT00476_Test_Bench(ARCH00476_Test_Bench)
--
-- REVISION HISTORY:
--
--     6-AUG-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--    The various types are taken from GENERIC_STANDARD_TYPES without the
--    explicit qualifier, as is the resolution function bf_rec3.
--
--
use WORK.STANDARD_TYPES.test_report ;
architecture ARCH00476 of GENERIC_STANDARD_TYPES is

   function t_enum1_func ( i : integer ) return t_enum1 is
   begin
      return t_enum1'val(i) ;
   end t_enum1_func ;

   function st_enum1_func ( i : integer ) return st_enum1 is
   begin
      return st_enum1'val(i) ;
   end st_enum1_func ;

   function t_int1_func ( i : t_int1 ) return t_int1 is
   begin
      return i + 1 ;
   end t_int1_func ;

   function st_int1_func ( i : st_int1 ) return st_int1 is
   begin
      return i + 1 ;
   end st_int1_func ;

   function t_phys1_func ( i : integer ) return t_phys1 is
   begin
      return i * phys1_2;
   end t_phys1_func ;

   function st_phys1_func ( i : integer ) return st_phys1 is
   begin
      return i * phys1_2;
   end st_phys1_func ;

   function t_real1_func ( r : t_real1 ) return t_real1 is
   begin
      return r + 1.0;
   end t_real1_func ;

   function st_real1_func ( r : st_real1 ) return st_real1 is
   begin
      return r + 1.0;
   end st_real1_func ;

   function t_rec1_func ( r : real ) return t_rec1 is
      variable rec : t_rec1 ;
   begin
      rec.f1 := lowb_i2 ;
      rec.f2 := 0 ns ;
      rec.f3 := true ;
      rec.f4 := r + 1.0 ;
      return rec ;
   end t_rec1_func ;

   function st_arr1_func ( i : integer ) return st_arr1 is
      variable arr : st_arr1 ;
   begin
      for j in lowb to highb loop
	 arr(j) := t_int1(i + j);
      end loop ;
      return arr ;
   end st_arr1_func ;

begin
   P :
   process
      variable vec : rec3_vector (1 to 3) ;
   begin
      test_report ( "ARCH00476" ,
		    "Functions can return user defined types" ,
                    (t_enum1_func(1) = en2) and
                    (st_enum1_func(1) = en2) and
                    (t_int1_func(10) = 11 ) and
                    (st_int1_func(10) = 11 ) and
                    (t_phys1_func(2) = 2 phys1_2 ) and
                    (st_phys1_func(2) = 2 phys1_2 ) and
                    (t_real1_func(10.0) = 11.0 ) and
                    (st_real1_func(10.0) = 11.0 ) and
                    (t_rec1_func(10.0).f4 = 11.0 )
                  ) ;
      wait ;
   end process P ;
end ARCH00476 ;

entity ENT00476_Test_Bench is
end ENT00476_Test_Bench ;

architecture ARCH00476_Test_Bench of ENT00476_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.GENERIC_STANDARD_TYPES ( ARCH00476 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00476_Test_Bench ;

