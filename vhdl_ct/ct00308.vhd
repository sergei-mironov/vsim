-- NEED RESULT: ARCH00308: Access types passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00308
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    3.3 (1)
--    3.3 (2)
--    3.3 (3)
--    3.3 (4)
--    3.3 (5)
--    3.3 (6)
--    3.3 (7)
--    3.3.1 (1)
--    3.3.1 (2)
--    3.3.2 (1)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00308(ARCH00308)
--    ENT00308_Test_Bench(ARCH00308_Test_Bench)
--
-- REVISION HISTORY:
--
--    27-JUL-1987   - initial revision
--
-- NOTES:
--
--    self-checking
--
--    ONLY 3.3 (1) IS DYNAMICALLY TESTED.
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00308 is
   generic ( gen1, gen2 : integer := 5 ) ;
begin
end ENT00308 ;

architecture ARCH00308 of ENT00308 is
   -- this tests 3.3 (7)
   procedure proc ( v1, v2 : integer ) is
      type t1 is array (v1 to 10) of boolean;
      type t2 is array (v1 to v2) of bit;
      type t3 is array (1 to v2) of integer;
      type rec is record
                     a1 : t1 ;
                     a2 : t2 ;
                     a3 : t3 ;
	          end record ;
      type access_t1 is access t1 ;
      type access_t2 is access t2 ;
      type access_t3 is access t3 ;
      type access_rec is access rec ;
      variable a_t1 : access_t1 ;      -- this tests 3.3 (2)
      variable a_t2 : access_t1 ;
      variable a_t3 : access_t1 ;
      variable a_r : access_t1 ;
   begin
   end proc ;
begin
   P :
   process

      -- 3.3 (3), 3.3 (4), and 3.3 (5) are tested by the access types
      -- declared in STANDARD_TYPES, except for access of access types,
      -- which is the following:
      type access_access is access WORK.STANDARD_TYPES.a_bit ;

      -- these will test 3.3 (6)
      type t1 is array (1 to 10) of boolean;
      type t2 is array (gen1 to gen2) of bit;
      type record_with_array_elements is record
			   	            a1 : t1 ;
				            a2 : t2 ;
				         end record ;
      type access_t1 is access t1 ;
      type access_record is access record_with_array_elements ;
      variable a_a : access_access ;
      variable a_t : access_t1 ;
      variable a_r : access_record ;

      -- these test 3.3.1 (1) and 3.3.2 (2)
      type object_1 ;
      type object_2 ;
      type access_object_1 is access object_1 ;
      type access_object_2 is access object_2 ;
      type object_1 is ('*') ;
      type object_2 is ('*') ;
      type array_1 is array ( integer range <> ) of access_object_1 ;
      type array_2 is array ( integer range <> ) of access_object_2 ;
      type access_array_1 is access array_1 ;
      type access_array_2 is access array_2 ;
      type structure_1 is record
                             data1 : integer ;
                             data2 : integer ;
                             link : access_array_2 ;
                          end record ;
      type structure_2 is record
                             data1 : integer ;
                             data2 : integer ;
                             link : access_array_1 ;
                          end record ;
      variable a_o_1 : access_object_1 ;
      variable a_o_2 : access_object_2 ;
      variable a_a_1 : access_array_1  ;
      variable a_a_2 : access_array_2  ;

   begin
      test_report ( "ARCH00308" ,
		    "Access types" ,
		    (a_a   = null) and  -- this tests 3.3 (1)
		    (a_t   = null) and
		    (a_r   = null) and
		    (a_o_1 = null) and
		    (a_o_2 = null) and
		    (a_a_1 = null) and
		    (a_a_2 = null)
                  ) ;
      -- these test 3.3.2 (1)
      deallocate (a_a) ;
      deallocate (a_t) ;
      deallocate (a_r) ;
      deallocate (a_o_1) ;
      deallocate (a_o_2) ;
      deallocate (a_a_1) ;
      deallocate (a_a_2) ;

      wait ;
   end process P ;
end ARCH00308 ;

entity ENT00308_Test_Bench is
end ENT00308_Test_Bench ;

architecture ARCH00308_Test_Bench of ENT00308_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00308 ( ARCH00308 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00308_Test_Bench ;

