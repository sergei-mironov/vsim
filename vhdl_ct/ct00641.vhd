-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00641
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    6.3 (4)
--
-- DESIGN UNIT ORDERING:
--
--    ENT00641(ARCH00641)
--    ENT00641_Test_Bench(ARCH00641_Test_Bench)
--
-- REVISION HISTORY:
--
--    25-AUG-1987   - initial revision
--    11-DEC-1989   - GDT: made "x" a constant instead of a variable so
--                         global ref within function is ok; removed def of
--                         "*" from ENT00641.
--
-- NOTES:
--
--    self-checking
--
--
use WORK.STANDARD_TYPES.all ;
entity ENT00641 is
   function f1 ( i : integer ) return integer is
   begin
      return i + 1 ;
   end f1 ;

   -- GDT 12-7-89: Removed the following
   -- function "*" ( a,b : integer ) return integer is
   -- begin
   --    return a+b ;
   -- end "*" ;
   --

   type ent_enum_type is ( 'W', 'X' , 'Y', 'Z' ) ;
begin
end ENT00641 ;
--
architecture ARCH00641 of ENT00641 is
   function f ( i : integer ) return integer is
   begin
      return i + 2 ;
   end f ;
   function "+" ( a,b : integer ) return integer is
   begin
      return a/b ;
   end "+" ;
   type arch_enum_type is ( 'X', 'Y', 'Z', 'W' ) ;
begin
   B :
   block
      type block_enum_type is ( 'Y', 'Z', 'W', 'X' ) ;
      function f ( i : integer ) return integer is
      begin
         return STD.Standard."+" (i,3) ;
      end f ;
      function "+" ( a,b : integer ) return integer is
      begin
	 return a-b ;
      end "+" ;
   begin
      P :
      process
         function f ( i : integer ) return integer is
	    -- GDT 12-7-89: variable x : integer ;
	    constant x : integer := i ;  -- GDT 12-7-89
            function ff return integer is
	       constant x : integer := 8 ;
	    begin
	       if f.x >= ff.x then
		  return f.x ;
	       else
		  return ff.x ;
	       end if ;
	    end ff ;
         begin
            -- GDT 12-7-89: x := i ;
            return STD.Standard."+" (ff,20) ;
         end f ;
         function "+" ( a,b : integer ) return integer is
         begin
	    return STD.Standard."*" (a,b) ;
         end "+" ;
         type process_enum_type is ( 'Z', 'W', 'X', 'Y' ) ;
         variable loop_test_ok : boolean := true ;
         variable ent_enum : ent_enum_type := 'X' ;
         variable arch_enum : arch_enum_type := ARCH00641.'X' ;
         variable block_enum : block_enum_type := B.'X' ;
         variable process_enum : process_enum_type := P.'X' ;
      begin
         Loop1 :
         for i in 1 to 3 loop
	    Loop2 :
	    for i in 4 to 6 loop
	       if Loop1.i = Loop2.i then
	          loop_test_ok := false ;
	       end if ;
	    end loop Loop2 ;
         end loop Loop1 ;

         test_report ( "ARCH00641" ,
		       "Expanded names" ,
                       (loop_test_ok = true) and
                       (ent_enum_type'pos(ent_enum) = 1) and
                       (arch_enum_type'pos(arch_enum) = 0) and
                       (block_enum_type'pos(block_enum) = 3) and
                       (process_enum_type'pos(process_enum) = 2) and
--		       (ENT00641.f1(10) = 11) and This expanded form is not legal
		       (ARCH00641.f(10) = 12) and
		       (B.f(10) = 13) and
		       (P.f(10) = 30) and
--                       (ENT00641."*"(6,3) = 6+3) and This expanded form is not
                       (ARCH00641."+"(6,3) = 6/3) and
                       (B."+"(6,3) = 6-3) and
                       (P."+"(6,3) = 6*3)
                     ) ;
         wait ;
      end process P ;
   end block B ;
end ARCH00641 ;
--
entity ENT00641_Test_Bench is
end ENT00641_Test_Bench ;

architecture ARCH00641_Test_Bench of ENT00641_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.ENT00641 ( ARCH00641 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00641_Test_Bench ;
--
