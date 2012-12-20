-- NEED RESULT: ARCH00249: All tests for Section 2.2  passed
-------------------------------------------------------------------------------
	--
	--	   Copyright (c) 1989 by Intermetrics, Inc.
	--                All rights reserved.
	--
-------------------------------------------------------------------------------
--
-- TEST NAME:
--
--    CT00249
--
-- AUTHOR:
--
--    D. Hyman
--
-- TEST OBJECTIVES:
--
--    2.2 (1)
--    2.2 (2)
--    2.2 (3)
--    2.2 (4)
--    2.2 (5)
--    2.2 (6)
--    2.2 (7)
--    2.2 (8)
--
-- DESIGN UNIT ORDERING:
--
--    E00000(ARCH00249)
--    ENT00249_Test_Bench(ARCH00249_Test_Bench)
--
-- REVISION HISTORY:
--
--    15-JUL-1987   - initial revision
--    11-DEC-1989   - GDT: removed signal asg from function
--
-- NOTES:
--
--    self-checking
--
--    Only objectives 2.2 (6) and 2.2 (7) are checked dynamically; the others
--    are static compile-time checks.
--
--
--
use WORK.STANDARD_TYPES.all ;
architecture ARCH00249 of E00000 is

   constant c : integer := 25 ;

   signal s : integer ;

   -- the following proc shows that all admissable declarations may appear
   -- in a subprogram declaration part  2.2 (1)
   procedure proc_with_big_declarative_part is
      variable x : integer ;                           -- variable declaration
      procedure subprogram ( a,b,c : integer ) ;       -- subprogram declaration
      procedure subprogram ( a,b,c : integer ) is      -- subprogram body
      begin
      end ;
      type enum_type is (enum_0, enum_1, enum_2) ;     -- type declaration
      subtype sub_enum_type is                         -- subtype declaration
         enum_type range enum_0 to enum_1 ;
      constant k : integer := 2 ;                      -- constant declaration
      type enum_file_type is file of enum_type ;
      file enum_file : enum_file_type is in "HOSTFILENAME";
                                                       -- file declaration
      alias alias_x : integer is x ;                   -- alias declaration
      attribute enum_attribute : enum_type ;           -- attribute declaration
      attribute enum_attribute of all : signal is enum_0 ; -- attribute spec
      use WORK.all ;                                   -- use clause
      use STANDARD_TYPES.all ;                         -- use clause
   begin
   end proc_with_big_declarative_part ;

   -- the following proc shows that the ending designator is optional  2.2 (2)
   -- and that a subprogram statement part need contain no statements  2.2 (4)
   -- and that the declaration of a subprogram is optional  2.2 (5)
   procedure proc_without_ending_designator is
   begin
   end ;

   -- the following proc & function shows that all sequential sttements can
   -- appear in a subprogram (except wait statements in a function)  2.2 (3)
   -- JW: signal parameter added so that the signal assign stm would be legal
   procedure proc_with_all_sequential_statements(signal s: inout integer) is
      variable b : boolean ;
      variable x : integer ;
   begin
      s <= 1 ;                               -- signal assign statement
      assert false report "false" ;          -- assertion statement
      wait for 1 ns ;                        -- wait statement
      case b is                              -- case statement
	 when false => null;                 -- null statement
	 when true => proc_without_ending_designator;-- procedure call statement
      end case ;
      for i in 1 to 5 loop                   -- loop statement via "for"
         if i < 5 then                       -- if statement
   	    next ;                           -- next statement
         else
            exit;                            -- exit statement
         end if ;
      end loop ;
      while x < 5 loop                       -- loop statement via "while"
         x := x + 1 ;                        -- variable assign statement
      end loop ;
      return ;                               -- return statement
   end ;

   -- the following shows that subprograms can access constants outside
   -- their declarative regions  2.2 (6) and 2.2 (7)
   procedure proc_called_by_func ( n: inout integer ) is
   begin
      n := n + c ;
   end proc_called_by_func ;
   function func_calling_proc ( n: integer) return integer is
      variable v : integer;
   begin
      v := n;
      proc_called_by_func(v);
      return v + c ;
   end func_calling_proc ;

   -- the following shows that dynamically sized structures may be declared
   -- within a subroutine that contains a wait statement  2.2 (8)
   procedure proc_with_wait_statement ( n: integer ) is
      type dyn_array is array ( integer range <> ) of integer ;
      variable arr : dyn_array (1 to n) ;
   begin
      wait for 1 ns ;
   end proc_with_wait_statement ;

begin
   JW:
   process
     -- JW: This function was moved into a process so that the signal assign
     -- statement would be legal.
     function func_with_all_sequential_statements return integer is
        variable b : boolean ;
        variable x : integer ;
     begin
        -- GDT 12-7-89: s <= 1 ;               -- signal assign statement
        assert false report "false" ;          -- assertion statement
        case b is                              -- case statement
	   when false => null;                 -- null statement
	   when true => proc_without_ending_designator;-- procedure call statement
        end case ;
        for i in 1 to 5 loop                   -- loop statement via "for"
           if i < 5 then                       -- if statement
   	      next ;                           -- next statement
           else
              exit;                            -- exit statement
           end if ;
        end loop ;
        while x < 5 loop                       -- loop statement via "while"
           x := x + 1 ;                        -- variable assign statement
        end loop ;
        return 0 ;                             -- return statement
     end ;
   begin
     wait ;
   end process;

   P :
   process
   begin
      test_report ( "ARCH00249" ,
		    "All tests for Section 2.2 " ,
		    func_calling_proc (20) = 20 + 2*25 ) ;
      wait ;
   end process P ;
end ARCH00249 ;

entity ENT00249_Test_Bench is
end ENT00249_Test_Bench ;

architecture ARCH00249_Test_Bench of ENT00249_Test_Bench is
begin
   L1:
   block
      component UUT
      end component ;

      for CIS1 : UUT use entity WORK.E00000 ( ARCH00249 ) ;
   begin
      CIS1 : UUT ;
   end block L1 ;
end ARCH00249_Test_Bench ;
