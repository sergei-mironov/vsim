-- Prosoft VHDL tests.
--
-- Copyright (C) 2011 Prosoft.
--
-- Author: Zefirov, Karavaev.
--
-- This is a set of simplest tests for isolated tests of VHDL features.
--
-- Nothing more than standard package should be required.
--
-- Categories: entity, architecture, process, type, subtype, case, enumerations, array, for-loop, function, Attributes-of-the-array-type-or-objects-of-the-array-type

use work.std_logic_1164_for_tst.all;

entity ENT00024_Test_Bench is
end ENT00024_Test_Bench;

architecture ARCH00024_Test_Bench of ENT00024_Test_Bench is

	subtype byte is bit_vector(0 to 7);
	
	type IntArray is array (integer range <>) of integer;
	
	type ArrayOfIntArray is array (1 to 5) of IntArray(1 to 6);
	
	type ArrayOfIntArray_ForRange is array (1 to 6) of IntArray(-3 to 20);
	type ArrayOfArrayOfIntArray_ForRange is array (1 to 12) of ArrayOfIntArray_ForRange;
	
	type ArrayOfArrayOfIntArray is array (1 to 12) of ArrayOfIntArray;
	
	type std_array is array (0 to 3) of std_logic;
	signal I_sa : std_array := "1010";
	
	type enum is (a_v, b_v, c_v, d_v, e_v, f_v);
	type rec is record
		f1 : integer;
		f2 : boolean;
		f3 : bit;
	end record;
	
	type BooleanVector is array (integer range <>) of boolean;
	type cond_type is array (1 to 12) of BooleanVector(1 to 8);
	type ArrayOfBooleanVector is array (1 to 12) of BooleanVector(1 to 6);
	type StateType is (init, assign, analize, waiting);
	signal state : StateType := init;
	
	type std_logic_array_dem_5 is array (integer range <>, integer range <>, integer range <>, integer range <>, integer range <>) of std_logic;
	type bit_array_dem_5       is array (integer range <>, integer range <>, integer range <>, integer range <>, integer range <>) of bit;
	type integer_array_dem_5   is array (integer range <>, integer range <>, integer range <>, integer range <>, integer range <>) of integer;
	type boolean_array_dem_5   is array (integer range <>, integer range <>, integer range <>, integer range <>, integer range <>) of boolean;
	type enum_array_dem_5      is array (integer range <>, integer range <>, integer range <>, integer range <>, integer range <>) of enum;
	type rec_array_dem_5       is array (integer range <>, integer range <>, integer range <>, integer range <>, integer range <>) of rec;
	
	subtype std_logic_array_dem_5_sub is std_logic_array_dem_5(1 to 3, 7 downto 0, 1 downto -1, 10 to 20, -3 to 3);
	type bit_array_dem_5_boarded      is array                (1 to 3, 7 downto 0, 1 downto -1, 10 to 20, -3 to 3) of bit;
	subtype integer_array_dem_5_sub   is integer_array_dem_5  (1 to 3, 7 downto 0, 1 downto -1, 10 to 20, -3 to 3);
	subtype boolean_array_dem_5_sub   is boolean_array_dem_5  (1 to 3, 7 downto 0, 1 downto -1, 10 to 20, -3 to 3);
	type enum_array_dem_5_boarded     is array                (1 to 3, 7 downto 0, 1 downto -1, 10 to 20, -3 to 3) of enum;
	subtype rec_array_dem_5_sub       is rec_array_dem_5      (1 to 3, 7 downto 0, 1 downto -1, 10 to 20, -3 to 3);
	
	
	signal stdl_a_d5 : std_logic_array_dem_5(1 to 3, 7 downto 0, 1 downto -1, 10 to 20, -3 to 3);
	signal bit_a_d5  : bit_array_dem_5      (1 to 3, 7 downto 0, 1 downto -1, 10 to 20, -3 to 3);
	signal int_a_d5  : integer_array_dem_5  (1 to 3, 7 downto 0, 1 downto -1, 10 to 20, -3 to 3);
	signal bool_a_d5 : boolean_array_dem_5  (1 to 3, 7 downto 0, 1 downto -1, 10 to 20, -3 to 3);
	signal enum_a_d5 : enum_array_dem_5     (1 to 3, 7 downto 0, 1 downto -1, 10 to 20, -3 to 3);
	signal rec_a_d5  : rec_array_dem_5      (1 to 3, 7 downto 0, 1 downto -1, 10 to 20, -3 to 3);
	
	function all100 (i : IntArray) return boolean is
		variable v : IntArray(i'range);
		variable r : boolean;
	begin
		v := i;
		r := true;
		l1: for i in v'range loop
			r := r and (v(i) = 100);
		end loop;
		return r;
	end function;
	
	
begin
   
	process (state)
		variable vv : ArrayOfArrayOfIntArray_ForRange := (others => (others => (others => 100)));
		variable vv_reverse : ArrayOfArrayOfIntArray_ForRange := (others => (others => (others => 100)));
		variable int : ArrayOfArrayOfIntArray := (others => (others => (others => 0)));
		variable bool : ArrayOfBooleanVector := (others => (others => false));
		variable cond : cond_type := (others => (others => false));
		
	begin
		case state is
			when init =>
				state <= assign;
			when assign =>
				state <= analize;
				-- std_logic_array
				int(1)(1)(1) := stdl_a_d5'Low;
				int(1)(1)(2) := stdl_a_d5'Low(1);
				int(1)(1)(3) := stdl_a_d5'Low(2);
				int(1)(1)(4) := stdl_a_d5'Low(3);
				int(1)(1)(5) := stdl_a_d5'Low(4);
				int(1)(1)(6) := stdl_a_d5'Low(5);
				
				int(1)(2)(1) := stdl_a_d5'High;
				int(1)(2)(2) := stdl_a_d5'High(1);
				int(1)(2)(3) := stdl_a_d5'High(2);
				int(1)(2)(4) := stdl_a_d5'High(3);
				int(1)(2)(5) := stdl_a_d5'High(4);
				int(1)(2)(6) := stdl_a_d5'High(5);
				
				int(1)(3)(1) := stdl_a_d5'Left;
				int(1)(3)(2) := stdl_a_d5'Left(1);
				int(1)(3)(3) := stdl_a_d5'Left(2);
				int(1)(3)(4) := stdl_a_d5'Left(3);
				int(1)(3)(5) := stdl_a_d5'Left(4);
				int(1)(3)(6) := stdl_a_d5'Left(5);
				
				int(1)(4)(1) := stdl_a_d5'Right;
				int(1)(4)(2) := stdl_a_d5'Right(1);
				int(1)(4)(3) := stdl_a_d5'Right(2);
				int(1)(4)(4) := stdl_a_d5'Right(3);
				int(1)(4)(5) := stdl_a_d5'Right(4);
				int(1)(4)(6) := stdl_a_d5'Right(5);
				
				int(1)(5)(1) := stdl_a_d5'Length;
				int(1)(5)(2) := stdl_a_d5'Length(1);
				int(1)(5)(3) := stdl_a_d5'Length(2);
				int(1)(5)(4) := stdl_a_d5'Length(3);
				int(1)(5)(5) := stdl_a_d5'Length(4);
				int(1)(5)(6) := stdl_a_d5'Length(5);
				
				int(2)(1)(1) := std_logic_array_dem_5_sub'Low;
				int(2)(1)(2) := std_logic_array_dem_5_sub'Low(1);
				int(2)(1)(3) := std_logic_array_dem_5_sub'Low(2);
				int(2)(1)(4) := std_logic_array_dem_5_sub'Low(3);
				int(2)(1)(5) := std_logic_array_dem_5_sub'Low(4);
				int(2)(1)(6) := std_logic_array_dem_5_sub'Low(5);
				
				int(2)(2)(1) := std_logic_array_dem_5_sub'High;
				int(2)(2)(2) := std_logic_array_dem_5_sub'High(1);
				int(2)(2)(3) := std_logic_array_dem_5_sub'High(2);
				int(2)(2)(4) := std_logic_array_dem_5_sub'High(3);
				int(2)(2)(5) := std_logic_array_dem_5_sub'High(4);
				int(2)(2)(6) := std_logic_array_dem_5_sub'High(5);
				
				int(2)(3)(1) := std_logic_array_dem_5_sub'Left;
				int(2)(3)(2) := std_logic_array_dem_5_sub'Left(1);
				int(2)(3)(3) := std_logic_array_dem_5_sub'Left(2);
				int(2)(3)(4) := std_logic_array_dem_5_sub'Left(3);
				int(2)(3)(5) := std_logic_array_dem_5_sub'Left(4);
				int(2)(3)(6) := std_logic_array_dem_5_sub'Left(5);
				
				int(2)(4)(1) := std_logic_array_dem_5_sub'Right;
				int(2)(4)(2) := std_logic_array_dem_5_sub'Right(1);
				int(2)(4)(3) := std_logic_array_dem_5_sub'Right(2);
				int(2)(4)(4) := std_logic_array_dem_5_sub'Right(3);
				int(2)(4)(5) := std_logic_array_dem_5_sub'Right(4);
				int(2)(4)(6) := std_logic_array_dem_5_sub'Right(5);
				
				int(2)(5)(1) := std_logic_array_dem_5_sub'Length;
				int(2)(5)(2) := std_logic_array_dem_5_sub'Length(1);
				int(2)(5)(3) := std_logic_array_dem_5_sub'Length(2);
				int(2)(5)(4) := std_logic_array_dem_5_sub'Length(3);
				int(2)(5)(5) := std_logic_array_dem_5_sub'Length(4);
				int(2)(5)(6) := std_logic_array_dem_5_sub'Length(5);
				
				bool(1)(1) := stdl_a_d5'Ascending;
				bool(1)(2) := stdl_a_d5'Ascending(1);
				bool(1)(3) := stdl_a_d5'Ascending(2);
				bool(1)(4) := stdl_a_d5'Ascending(3);
				bool(1)(5) := stdl_a_d5'Ascending(4);
				bool(1)(6) := stdl_a_d5'Ascending(5);
				
				bool(2)(1) := std_logic_array_dem_5_sub'Ascending;
				bool(2)(2) := std_logic_array_dem_5_sub'Ascending(1);
				bool(2)(3) := std_logic_array_dem_5_sub'Ascending(2);
				bool(2)(4) := std_logic_array_dem_5_sub'Ascending(3);
				bool(2)(5) := std_logic_array_dem_5_sub'Ascending(4);
				bool(2)(6) := std_logic_array_dem_5_sub'Ascending(5);
				
				-- bit_array
				int(3)(1)(1) := bit_a_d5'Low;
				int(3)(1)(2) := bit_a_d5'Low(1);
				int(3)(1)(3) := bit_a_d5'Low(2);
				int(3)(1)(4) := bit_a_d5'Low(3);
				int(3)(1)(5) := bit_a_d5'Low(4);
				int(3)(1)(6) := bit_a_d5'Low(5);
				
				int(3)(2)(1) := bit_a_d5'High;
				int(3)(2)(2) := bit_a_d5'High(1);
				int(3)(2)(3) := bit_a_d5'High(2);
				int(3)(2)(4) := bit_a_d5'High(3);
				int(3)(2)(5) := bit_a_d5'High(4);
				int(3)(2)(6) := bit_a_d5'High(5);
				
				int(3)(3)(1) := bit_a_d5'Left;
				int(3)(3)(2) := bit_a_d5'Left(1);
				int(3)(3)(3) := bit_a_d5'Left(2);
				int(3)(3)(4) := bit_a_d5'Left(3);
				int(3)(3)(5) := bit_a_d5'Left(4);
				int(3)(3)(6) := bit_a_d5'Left(5);
				
				int(3)(4)(1) := bit_a_d5'Right;
				int(3)(4)(2) := bit_a_d5'Right(1);
				int(3)(4)(3) := bit_a_d5'Right(2);
				int(3)(4)(4) := bit_a_d5'Right(3);
				int(3)(4)(5) := bit_a_d5'Right(4);
				int(3)(4)(6) := bit_a_d5'Right(5);
				
				int(3)(5)(1) := bit_a_d5'Length;
				int(3)(5)(2) := bit_a_d5'Length(1);
				int(3)(5)(3) := bit_a_d5'Length(2);
				int(3)(5)(4) := bit_a_d5'Length(3);
				int(3)(5)(5) := bit_a_d5'Length(4);
				int(3)(5)(6) := bit_a_d5'Length(5);

				int(4)(1)(1) := bit_array_dem_5_boarded'Low;
				int(4)(1)(2) := bit_array_dem_5_boarded'Low(1);
				int(4)(1)(3) := bit_array_dem_5_boarded'Low(2);
				int(4)(1)(4) := bit_array_dem_5_boarded'Low(3);
				int(4)(1)(5) := bit_array_dem_5_boarded'Low(4);
				int(4)(1)(6) := bit_array_dem_5_boarded'Low(5);
				
				int(4)(2)(1) := bit_array_dem_5_boarded'High;
				int(4)(2)(2) := bit_array_dem_5_boarded'High(1);
				int(4)(2)(3) := bit_array_dem_5_boarded'High(2);
				int(4)(2)(4) := bit_array_dem_5_boarded'High(3);
				int(4)(2)(5) := bit_array_dem_5_boarded'High(4);
				int(4)(2)(6) := bit_array_dem_5_boarded'High(5);
				
				int(4)(3)(1) := bit_array_dem_5_boarded'Left;
				int(4)(3)(2) := bit_array_dem_5_boarded'Left(1);
				int(4)(3)(3) := bit_array_dem_5_boarded'Left(2);
				int(4)(3)(4) := bit_array_dem_5_boarded'Left(3);
				int(4)(3)(5) := bit_array_dem_5_boarded'Left(4);
				int(4)(3)(6) := bit_array_dem_5_boarded'Left(5);
				
				int(4)(4)(1) := bit_array_dem_5_boarded'Right;
				int(4)(4)(2) := bit_array_dem_5_boarded'Right(1);
				int(4)(4)(3) := bit_array_dem_5_boarded'Right(2);
				int(4)(4)(4) := bit_array_dem_5_boarded'Right(3);
				int(4)(4)(5) := bit_array_dem_5_boarded'Right(4);
				int(4)(4)(6) := bit_array_dem_5_boarded'Right(5);
				
				int(4)(5)(1) := bit_array_dem_5_boarded'Length;
				int(4)(5)(2) := bit_array_dem_5_boarded'Length(1);
				int(4)(5)(3) := bit_array_dem_5_boarded'Length(2);
				int(4)(5)(4) := bit_array_dem_5_boarded'Length(3);
				int(4)(5)(5) := bit_array_dem_5_boarded'Length(4);
				int(4)(5)(6) := bit_array_dem_5_boarded'Length(5);
				
				bool(3)(1) := bit_a_d5'Ascending;
				bool(3)(2) := bit_a_d5'Ascending(1);
				bool(3)(3) := bit_a_d5'Ascending(2);
				bool(3)(4) := bit_a_d5'Ascending(3);
				bool(3)(5) := bit_a_d5'Ascending(4);
				bool(3)(6) := bit_a_d5'Ascending(5);
				
				bool(4)(1) := bit_array_dem_5_boarded'Ascending;
				bool(4)(2) := bit_array_dem_5_boarded'Ascending(1);
				bool(4)(3) := bit_array_dem_5_boarded'Ascending(2);
				bool(4)(4) := bit_array_dem_5_boarded'Ascending(3);
				bool(4)(5) := bit_array_dem_5_boarded'Ascending(4);
				bool(4)(6) := bit_array_dem_5_boarded'Ascending(5);
				
				-- integer_array
				int(5)(1)(1) := int_a_d5'Low;
				int(5)(1)(2) := int_a_d5'Low(1);
				int(5)(1)(3) := int_a_d5'Low(2);
				int(5)(1)(4) := int_a_d5'Low(3);
				int(5)(1)(5) := int_a_d5'Low(4);
				int(5)(1)(6) := int_a_d5'Low(5);
				
				int(5)(2)(1) := int_a_d5'High;
				int(5)(2)(2) := int_a_d5'High(1);
				int(5)(2)(3) := int_a_d5'High(2);
				int(5)(2)(4) := int_a_d5'High(3);
				int(5)(2)(5) := int_a_d5'High(4);
				int(5)(2)(6) := int_a_d5'High(5);
				
				int(5)(3)(1) := int_a_d5'Left;
				int(5)(3)(2) := int_a_d5'Left(1);
				int(5)(3)(3) := int_a_d5'Left(2);
				int(5)(3)(4) := int_a_d5'Left(3);
				int(5)(3)(5) := int_a_d5'Left(4);
				int(5)(3)(6) := int_a_d5'Left(5);
				
				int(5)(4)(1) := int_a_d5'Right;
				int(5)(4)(2) := int_a_d5'Right(1);
				int(5)(4)(3) := int_a_d5'Right(2);
				int(5)(4)(4) := int_a_d5'Right(3);
				int(5)(4)(5) := int_a_d5'Right(4);
				int(5)(4)(6) := int_a_d5'Right(5);
				
				int(5)(5)(1) := int_a_d5'Length;
				int(5)(5)(2) := int_a_d5'Length(1);
				int(5)(5)(3) := int_a_d5'Length(2);
				int(5)(5)(4) := int_a_d5'Length(3);
				int(5)(5)(5) := int_a_d5'Length(4);
				int(5)(5)(6) := int_a_d5'Length(5);

				int(6)(1)(1) := integer_array_dem_5_sub'Low;
				int(6)(1)(2) := integer_array_dem_5_sub'Low(1);
				int(6)(1)(3) := integer_array_dem_5_sub'Low(2);
				int(6)(1)(4) := integer_array_dem_5_sub'Low(3);
				int(6)(1)(5) := integer_array_dem_5_sub'Low(4);
				int(6)(1)(6) := integer_array_dem_5_sub'Low(5);
				
				int(6)(2)(1) := integer_array_dem_5_sub'High;
				int(6)(2)(2) := integer_array_dem_5_sub'High(1);
				int(6)(2)(3) := integer_array_dem_5_sub'High(2);
				int(6)(2)(4) := integer_array_dem_5_sub'High(3);
				int(6)(2)(5) := integer_array_dem_5_sub'High(4);
				int(6)(2)(6) := integer_array_dem_5_sub'High(5);
				
				int(6)(3)(1) := integer_array_dem_5_sub'Left;
				int(6)(3)(2) := integer_array_dem_5_sub'Left(1);
				int(6)(3)(3) := integer_array_dem_5_sub'Left(2);
				int(6)(3)(4) := integer_array_dem_5_sub'Left(3);
				int(6)(3)(5) := integer_array_dem_5_sub'Left(4);
				int(6)(3)(6) := integer_array_dem_5_sub'Left(5);
				
				int(6)(4)(1) := integer_array_dem_5_sub'Right;
				int(6)(4)(2) := integer_array_dem_5_sub'Right(1);
				int(6)(4)(3) := integer_array_dem_5_sub'Right(2);
				int(6)(4)(4) := integer_array_dem_5_sub'Right(3);
				int(6)(4)(5) := integer_array_dem_5_sub'Right(4);
				int(6)(4)(6) := integer_array_dem_5_sub'Right(5);
				
				int(6)(5)(1) := integer_array_dem_5_sub'Length;
				int(6)(5)(2) := integer_array_dem_5_sub'Length(1);
				int(6)(5)(3) := integer_array_dem_5_sub'Length(2);
				int(6)(5)(4) := integer_array_dem_5_sub'Length(3);
				int(6)(5)(5) := integer_array_dem_5_sub'Length(4);
				int(6)(5)(6) := integer_array_dem_5_sub'Length(5);
				
				bool(5)(1) := int_a_d5'Ascending;
				bool(5)(2) := int_a_d5'Ascending(1);
				bool(5)(3) := int_a_d5'Ascending(2);
				bool(5)(4) := int_a_d5'Ascending(3);
				bool(5)(5) := int_a_d5'Ascending(4);
				bool(5)(6) := int_a_d5'Ascending(5);
				
				bool(6)(1) := integer_array_dem_5_sub'Ascending;
				bool(6)(2) := integer_array_dem_5_sub'Ascending(1);
				bool(6)(3) := integer_array_dem_5_sub'Ascending(2);
				bool(6)(4) := integer_array_dem_5_sub'Ascending(3);
				bool(6)(5) := integer_array_dem_5_sub'Ascending(4);
				bool(6)(6) := integer_array_dem_5_sub'Ascending(5);
				
				-- boolean_array
				int(7)(1)(1) := bool_a_d5'Low;
				int(7)(1)(2) := bool_a_d5'Low(1);
				int(7)(1)(3) := bool_a_d5'Low(2);
				int(7)(1)(4) := bool_a_d5'Low(3);
				int(7)(1)(5) := bool_a_d5'Low(4);
				int(7)(1)(6) := bool_a_d5'Low(5);
				
				int(7)(2)(1) := bool_a_d5'High;
				int(7)(2)(2) := bool_a_d5'High(1);
				int(7)(2)(3) := bool_a_d5'High(2);
				int(7)(2)(4) := bool_a_d5'High(3);
				int(7)(2)(5) := bool_a_d5'High(4);
				int(7)(2)(6) := bool_a_d5'High(5);
				
				int(7)(3)(1) := bool_a_d5'Left;
				int(7)(3)(2) := bool_a_d5'Left(1);
				int(7)(3)(3) := bool_a_d5'Left(2);
				int(7)(3)(4) := bool_a_d5'Left(3);
				int(7)(3)(5) := bool_a_d5'Left(4);
				int(7)(3)(6) := bool_a_d5'Left(5);
				
				int(7)(4)(1) := bool_a_d5'Right;
				int(7)(4)(2) := bool_a_d5'Right(1);
				int(7)(4)(3) := bool_a_d5'Right(2);
				int(7)(4)(4) := bool_a_d5'Right(3);
				int(7)(4)(5) := bool_a_d5'Right(4);
				int(7)(4)(6) := bool_a_d5'Right(5);
				
				int(7)(5)(1) := bool_a_d5'Length;
				int(7)(5)(2) := bool_a_d5'Length(1);
				int(7)(5)(3) := bool_a_d5'Length(2);
				int(7)(5)(4) := bool_a_d5'Length(3);
				int(7)(5)(5) := bool_a_d5'Length(4);
				int(7)(5)(6) := bool_a_d5'Length(5);

				int(8)(1)(1) := boolean_array_dem_5_sub'Low;
				int(8)(1)(2) := boolean_array_dem_5_sub'Low(1);
				int(8)(1)(3) := boolean_array_dem_5_sub'Low(2);
				int(8)(1)(4) := boolean_array_dem_5_sub'Low(3);
				int(8)(1)(5) := boolean_array_dem_5_sub'Low(4);
				int(8)(1)(6) := boolean_array_dem_5_sub'Low(5);
				
				int(8)(2)(1) := boolean_array_dem_5_sub'High;
				int(8)(2)(2) := boolean_array_dem_5_sub'High(1);
				int(8)(2)(3) := boolean_array_dem_5_sub'High(2);
				int(8)(2)(4) := boolean_array_dem_5_sub'High(3);
				int(8)(2)(5) := boolean_array_dem_5_sub'High(4);
				int(8)(2)(6) := boolean_array_dem_5_sub'High(5);
				
				int(8)(3)(1) := boolean_array_dem_5_sub'Left;
				int(8)(3)(2) := boolean_array_dem_5_sub'Left(1);
				int(8)(3)(3) := boolean_array_dem_5_sub'Left(2);
				int(8)(3)(4) := boolean_array_dem_5_sub'Left(3);
				int(8)(3)(5) := boolean_array_dem_5_sub'Left(4);
				int(8)(3)(6) := boolean_array_dem_5_sub'Left(5);
				
				int(8)(4)(1) := boolean_array_dem_5_sub'Right;
				int(8)(4)(2) := boolean_array_dem_5_sub'Right(1);
				int(8)(4)(3) := boolean_array_dem_5_sub'Right(2);
				int(8)(4)(4) := boolean_array_dem_5_sub'Right(3);
				int(8)(4)(5) := boolean_array_dem_5_sub'Right(4);
				int(8)(4)(6) := boolean_array_dem_5_sub'Right(5);
				
				int(8)(5)(1) := boolean_array_dem_5_sub'Length;
				int(8)(5)(2) := boolean_array_dem_5_sub'Length(1);
				int(8)(5)(3) := boolean_array_dem_5_sub'Length(2);
				int(8)(5)(4) := boolean_array_dem_5_sub'Length(3);
				int(8)(5)(5) := boolean_array_dem_5_sub'Length(4);
				int(8)(5)(6) := boolean_array_dem_5_sub'Length(5);
				
				bool(7)(1) := bool_a_d5'Ascending;
				bool(7)(2) := bool_a_d5'Ascending(1);
				bool(7)(3) := bool_a_d5'Ascending(2);
				bool(7)(4) := bool_a_d5'Ascending(3);
				bool(7)(5) := bool_a_d5'Ascending(4);
				bool(7)(6) := bool_a_d5'Ascending(5);
				
				bool(8)(1) := boolean_array_dem_5_sub'Ascending;
				bool(8)(2) := boolean_array_dem_5_sub'Ascending(1);
				bool(8)(3) := boolean_array_dem_5_sub'Ascending(2);
				bool(8)(4) := boolean_array_dem_5_sub'Ascending(3);
				bool(8)(5) := boolean_array_dem_5_sub'Ascending(4);
				bool(8)(6) := boolean_array_dem_5_sub'Ascending(5);
				
				-- enum_array
				int(9)(1)(1) := enum_a_d5'Low;
				int(9)(1)(2) := enum_a_d5'Low(1);
				int(9)(1)(3) := enum_a_d5'Low(2);
				int(9)(1)(4) := enum_a_d5'Low(3);
				int(9)(1)(5) := enum_a_d5'Low(4);
				int(9)(1)(6) := enum_a_d5'Low(5);
				
				int(9)(2)(1) := enum_a_d5'High;
				int(9)(2)(2) := enum_a_d5'High(1);
				int(9)(2)(3) := enum_a_d5'High(2);
				int(9)(2)(4) := enum_a_d5'High(3);
				int(9)(2)(5) := enum_a_d5'High(4);
				int(9)(2)(6) := enum_a_d5'High(5);
				
				int(9)(3)(1) := enum_a_d5'Left;
				int(9)(3)(2) := enum_a_d5'Left(1);
				int(9)(3)(3) := enum_a_d5'Left(2);
				int(9)(3)(4) := enum_a_d5'Left(3);
				int(9)(3)(5) := enum_a_d5'Left(4);
				int(9)(3)(6) := enum_a_d5'Left(5);
				
				int(9)(4)(1) := enum_a_d5'Right;
				int(9)(4)(2) := enum_a_d5'Right(1);
				int(9)(4)(3) := enum_a_d5'Right(2);
				int(9)(4)(4) := enum_a_d5'Right(3);
				int(9)(4)(5) := enum_a_d5'Right(4);
				int(9)(4)(6) := enum_a_d5'Right(5);
				
				int(9)(5)(1) := enum_a_d5'Length;
				int(9)(5)(2) := enum_a_d5'Length(1);
				int(9)(5)(3) := enum_a_d5'Length(2);
				int(9)(5)(4) := enum_a_d5'Length(3);
				int(9)(5)(5) := enum_a_d5'Length(4);
				int(9)(5)(6) := enum_a_d5'Length(5);

				int(10)(1)(1) := enum_array_dem_5_boarded'Low;
				int(10)(1)(2) := enum_array_dem_5_boarded'Low(1);
				int(10)(1)(3) := enum_array_dem_5_boarded'Low(2);
				int(10)(1)(4) := enum_array_dem_5_boarded'Low(3);
				int(10)(1)(5) := enum_array_dem_5_boarded'Low(4);
				int(10)(1)(6) := enum_array_dem_5_boarded'Low(5);
				
				int(10)(2)(1) := enum_array_dem_5_boarded'High;
				int(10)(2)(2) := enum_array_dem_5_boarded'High(1);
				int(10)(2)(3) := enum_array_dem_5_boarded'High(2);
				int(10)(2)(4) := enum_array_dem_5_boarded'High(3);
				int(10)(2)(5) := enum_array_dem_5_boarded'High(4);
				int(10)(2)(6) := enum_array_dem_5_boarded'High(5);
				
				int(10)(3)(1) := enum_array_dem_5_boarded'Left;
				int(10)(3)(2) := enum_array_dem_5_boarded'Left(1);
				int(10)(3)(3) := enum_array_dem_5_boarded'Left(2);
				int(10)(3)(4) := enum_array_dem_5_boarded'Left(3);
				int(10)(3)(5) := enum_array_dem_5_boarded'Left(4);
				int(10)(3)(6) := enum_array_dem_5_boarded'Left(5);
				
				int(10)(4)(1) := enum_array_dem_5_boarded'Right;
				int(10)(4)(2) := enum_array_dem_5_boarded'Right(1);
				int(10)(4)(3) := enum_array_dem_5_boarded'Right(2);
				int(10)(4)(4) := enum_array_dem_5_boarded'Right(3);
				int(10)(4)(5) := enum_array_dem_5_boarded'Right(4);
				int(10)(4)(6) := enum_array_dem_5_boarded'Right(5);
				
				int(10)(5)(1) := enum_array_dem_5_boarded'Length;
				int(10)(5)(2) := enum_array_dem_5_boarded'Length(1);
				int(10)(5)(3) := enum_array_dem_5_boarded'Length(2);
				int(10)(5)(4) := enum_array_dem_5_boarded'Length(3);
				int(10)(5)(5) := enum_array_dem_5_boarded'Length(4);
				int(10)(5)(6) := enum_array_dem_5_boarded'Length(5);
				
				bool(9)(1) := enum_a_d5'Ascending;
				bool(9)(2) := enum_a_d5'Ascending(1);
				bool(9)(3) := enum_a_d5'Ascending(2);
				bool(9)(4) := enum_a_d5'Ascending(3);
				bool(9)(5) := enum_a_d5'Ascending(4);
				bool(9)(6) := enum_a_d5'Ascending(5);
				
				bool(10)(1) := enum_array_dem_5_boarded'Ascending;
				bool(10)(2) := enum_array_dem_5_boarded'Ascending(1);
				bool(10)(3) := enum_array_dem_5_boarded'Ascending(2);
				bool(10)(4) := enum_array_dem_5_boarded'Ascending(3);
				bool(10)(5) := enum_array_dem_5_boarded'Ascending(4);
				bool(10)(6) := enum_array_dem_5_boarded'Ascending(5);
				
				-- rec_array   
				int(11)(1)(1) := rec_a_d5'Low;
				int(11)(1)(2) := rec_a_d5'Low(1);
				int(11)(1)(3) := rec_a_d5'Low(2);
				int(11)(1)(4) := rec_a_d5'Low(3);
				int(11)(1)(5) := rec_a_d5'Low(4);
				int(11)(1)(6) := rec_a_d5'Low(5);
				
				int(11)(2)(1) := rec_a_d5'High;
				int(11)(2)(2) := rec_a_d5'High(1);
				int(11)(2)(3) := rec_a_d5'High(2);
				int(11)(2)(4) := rec_a_d5'High(3);
				int(11)(2)(5) := rec_a_d5'High(4);
				int(11)(2)(6) := rec_a_d5'High(5);
				
				int(11)(3)(1) := rec_a_d5'Left;
				int(11)(3)(2) := rec_a_d5'Left(1);
				int(11)(3)(3) := rec_a_d5'Left(2);
				int(11)(3)(4) := rec_a_d5'Left(3);
				int(11)(3)(5) := rec_a_d5'Left(4);
				int(11)(3)(6) := rec_a_d5'Left(5);
				
				int(11)(4)(1) := rec_a_d5'Right;
				int(11)(4)(2) := rec_a_d5'Right(1);
				int(11)(4)(3) := rec_a_d5'Right(2);
				int(11)(4)(4) := rec_a_d5'Right(3);
				int(11)(4)(5) := rec_a_d5'Right(4);
				int(11)(4)(6) := rec_a_d5'Right(5);
				
				int(11)(5)(1) := rec_a_d5'Length;
				int(11)(5)(2) := rec_a_d5'Length(1);
				int(11)(5)(3) := rec_a_d5'Length(2);
				int(11)(5)(4) := rec_a_d5'Length(3);
				int(11)(5)(5) := rec_a_d5'Length(4);
				int(11)(5)(6) := rec_a_d5'Length(5);

				int(12)(1)(1) := rec_array_dem_5_sub'Low;
				int(12)(1)(2) := rec_array_dem_5_sub'Low(1);
				int(12)(1)(3) := rec_array_dem_5_sub'Low(2);
				int(12)(1)(4) := rec_array_dem_5_sub'Low(3);
				int(12)(1)(5) := rec_array_dem_5_sub'Low(4);
				int(12)(1)(6) := rec_array_dem_5_sub'Low(5);
				
				int(12)(2)(1) := rec_array_dem_5_sub'High;
				int(12)(2)(2) := rec_array_dem_5_sub'High(1);
				int(12)(2)(3) := rec_array_dem_5_sub'High(2);
				int(12)(2)(4) := rec_array_dem_5_sub'High(3);
				int(12)(2)(5) := rec_array_dem_5_sub'High(4);
				int(12)(2)(6) := rec_array_dem_5_sub'High(5);
				
				int(12)(3)(1) := rec_array_dem_5_sub'Left;
				int(12)(3)(2) := rec_array_dem_5_sub'Left(1);
				int(12)(3)(3) := rec_array_dem_5_sub'Left(2);
				int(12)(3)(4) := rec_array_dem_5_sub'Left(3);
				int(12)(3)(5) := rec_array_dem_5_sub'Left(4);
				int(12)(3)(6) := rec_array_dem_5_sub'Left(5);
				
				int(12)(4)(1) := rec_array_dem_5_sub'Right;
				int(12)(4)(2) := rec_array_dem_5_sub'Right(1);
				int(12)(4)(3) := rec_array_dem_5_sub'Right(2);
				int(12)(4)(4) := rec_array_dem_5_sub'Right(3);
				int(12)(4)(5) := rec_array_dem_5_sub'Right(4);
				int(12)(4)(6) := rec_array_dem_5_sub'Right(5);
				
				int(12)(5)(1) := rec_array_dem_5_sub'Length;
				int(12)(5)(2) := rec_array_dem_5_sub'Length(1);
				int(12)(5)(3) := rec_array_dem_5_sub'Length(2);
				int(12)(5)(4) := rec_array_dem_5_sub'Length(3);
				int(12)(5)(5) := rec_array_dem_5_sub'Length(4);
				int(12)(5)(6) := rec_array_dem_5_sub'Length(5);
				
				bool(11)(1) := rec_a_d5'Ascending;
				bool(11)(2) := rec_a_d5'Ascending(1);
				bool(11)(3) := rec_a_d5'Ascending(2);
				bool(11)(4) := rec_a_d5'Ascending(3);
				bool(11)(5) := rec_a_d5'Ascending(4);
				bool(11)(6) := rec_a_d5'Ascending(5);
				
				bool(12)(1) := rec_array_dem_5_sub'Ascending;
				bool(12)(2) := rec_array_dem_5_sub'Ascending(1);
				bool(12)(3) := rec_array_dem_5_sub'Ascending(2);
				bool(12)(4) := rec_array_dem_5_sub'Ascending(3);
				bool(12)(5) := rec_array_dem_5_sub'Ascending(4);
				bool(12)(6) := rec_array_dem_5_sub'Ascending(5);
				
				-- range
				
				-- std_logic_array
				l1_1: for i in stdl_a_d5'range loop vv(1)(1)(i) := i; end loop l1_1;
				l1_2: for i in stdl_a_d5'range(1) loop vv(1)(2)(i) := i; end loop l1_2;
				l1_3: for i in stdl_a_d5'range(2) loop vv(1)(3)(i) := i; end loop l1_3;
				l1_4: for i in stdl_a_d5'range(3) loop vv(1)(4)(i) := i; end loop l1_4;
				l1_5: for i in stdl_a_d5'range(4) loop vv(1)(5)(i) := i; end loop l1_5;
				l1_6: for i in stdl_a_d5'range(5) loop vv(1)(6)(i) := i; end loop l1_6;
				
				l2_1: for i in std_logic_array_dem_5_sub'range loop vv(2)(1)(i) := i; end loop l2_1;
				l2_2: for i in std_logic_array_dem_5_sub'range(1) loop vv(2)(2)(i) := i; end loop l2_2;
				l2_3: for i in std_logic_array_dem_5_sub'range(2) loop vv(2)(3)(i) := i; end loop l2_3;
				l2_4: for i in std_logic_array_dem_5_sub'range(3) loop vv(2)(4)(i) := i; end loop l2_4;
				l2_5: for i in std_logic_array_dem_5_sub'range(4) loop vv(2)(5)(i) := i; end loop l2_5;
				l2_6: for i in std_logic_array_dem_5_sub'range(5) loop vv(2)(6)(i) := i; end loop l2_6;
				
				lr1_1: for i in stdl_a_d5'Reverse_range loop vv_reverse(1)(1)(i) := i; end loop lr1_1;
				lr1_2: for i in stdl_a_d5'Reverse_range(1) loop vv_reverse(1)(2)(i) := i; end loop lr1_2;
				lr1_3: for i in stdl_a_d5'Reverse_range(2) loop vv_reverse(1)(3)(i) := i; end loop lr1_3;
				lr1_4: for i in stdl_a_d5'Reverse_range(3) loop vv_reverse(1)(4)(i) := i; end loop lr1_4;
				lr1_5: for i in stdl_a_d5'Reverse_range(4) loop vv_reverse(1)(5)(i) := i; end loop lr1_5;
				lr1_6: for i in stdl_a_d5'Reverse_range(5) loop vv_reverse(1)(6)(i) := i; end loop lr1_6;
				
				lr2_1: for i in std_logic_array_dem_5_sub'Reverse_range loop vv_reverse(2)(1)(i) := i; end loop lr2_1;
				lr2_2: for i in std_logic_array_dem_5_sub'Reverse_range(1) loop vv_reverse(2)(2)(i) := i; end loop lr2_2;
				lr2_3: for i in std_logic_array_dem_5_sub'Reverse_range(2) loop vv_reverse(2)(3)(i) := i; end loop lr2_3;
				lr2_4: for i in std_logic_array_dem_5_sub'Reverse_range(3) loop vv_reverse(2)(4)(i) := i; end loop lr2_4;
				lr2_5: for i in std_logic_array_dem_5_sub'Reverse_range(4) loop vv_reverse(2)(5)(i) := i; end loop lr2_5;
				lr2_6: for i in std_logic_array_dem_5_sub'Reverse_range(5) loop vv_reverse(2)(6)(i) := i; end loop lr2_6;
				
				-- bit array
				
				l3_1: for i in bit_a_d5'range loop vv(3)(1)(i) := i; end loop l3_1;
				l3_2: for i in bit_a_d5'range(1) loop vv(3)(2)(i) := i; end loop l3_2;
				l3_3: for i in bit_a_d5'range(2) loop vv(3)(3)(i) := i; end loop l3_3;
				l3_4: for i in bit_a_d5'range(3) loop vv(3)(4)(i) := i; end loop l3_4;
				l3_5: for i in bit_a_d5'range(4) loop vv(3)(5)(i) := i; end loop l3_5;
				l3_6: for i in bit_a_d5'range(5) loop vv(3)(6)(i) := i; end loop l3_6;
				
				l4_1: for i in bit_array_dem_5_boarded'range loop vv(4)(1)(i) := i; end loop l4_1;
				l4_2: for i in bit_array_dem_5_boarded'range(1) loop vv(4)(2)(i) := i; end loop l4_2;
				l4_3: for i in bit_array_dem_5_boarded'range(2) loop vv(4)(3)(i) := i; end loop l4_3;
				l4_4: for i in bit_array_dem_5_boarded'range(3) loop vv(4)(4)(i) := i; end loop l4_4;
				l4_5: for i in bit_array_dem_5_boarded'range(4) loop vv(4)(5)(i) := i; end loop l4_5;
				l4_6: for i in bit_array_dem_5_boarded'range(5) loop vv(4)(6)(i) := i; end loop l4_6;
				
				lr3_1: for i in bit_a_d5'Reverse_range loop vv_reverse(3)(1)(i) := i; end loop lr3_1;
				lr3_2: for i in bit_a_d5'Reverse_range(1) loop vv_reverse(3)(2)(i) := i; end loop lr3_2;
				lr3_3: for i in bit_a_d5'Reverse_range(2) loop vv_reverse(3)(3)(i) := i; end loop lr3_3;
				lr3_4: for i in bit_a_d5'Reverse_range(3) loop vv_reverse(3)(4)(i) := i; end loop lr3_4;
				lr3_5: for i in bit_a_d5'Reverse_range(4) loop vv_reverse(3)(5)(i) := i; end loop lr3_5;
				lr3_6: for i in bit_a_d5'Reverse_range(5) loop vv_reverse(3)(6)(i) := i; end loop lr3_6;
				
				lr4_1: for i in bit_array_dem_5_boarded'Reverse_range loop vv_reverse(4)(1)(i) := i; end loop lr4_1;
				lr4_2: for i in bit_array_dem_5_boarded'Reverse_range(1) loop vv_reverse(4)(2)(i) := i; end loop lr4_2;
				lr4_3: for i in bit_array_dem_5_boarded'Reverse_range(2) loop vv_reverse(4)(3)(i) := i; end loop lr4_3;
				lr4_4: for i in bit_array_dem_5_boarded'Reverse_range(3) loop vv_reverse(4)(4)(i) := i; end loop lr4_4;
				lr4_5: for i in bit_array_dem_5_boarded'Reverse_range(4) loop vv_reverse(4)(5)(i) := i; end loop lr4_5;
				lr4_6: for i in bit_array_dem_5_boarded'Reverse_range(5) loop vv_reverse(4)(6)(i) := i; end loop lr4_6;
					
				-- integer array
				l5_1: for i in int_a_d5'range loop vv(5)(1)(i) := i; end loop l5_1;
				l5_2: for i in int_a_d5'range(1) loop vv(5)(2)(i) := i; end loop l5_2;
				l5_3: for i in int_a_d5'range(2) loop vv(5)(3)(i) := i; end loop l5_3;
				l5_4: for i in int_a_d5'range(3) loop vv(5)(4)(i) := i; end loop l5_4;
				l5_5: for i in int_a_d5'range(4) loop vv(5)(5)(i) := i; end loop l5_5;
				l5_6: for i in int_a_d5'range(5) loop vv(5)(6)(i) := i; end loop l5_6;
				
				l6_1: for i in integer_array_dem_5_sub'range loop vv(6)(1)(i) := i; end loop l6_1;
				l6_2: for i in integer_array_dem_5_sub'range(1) loop vv(6)(2)(i) := i; end loop l6_2;
				l6_3: for i in integer_array_dem_5_sub'range(2) loop vv(6)(3)(i) := i; end loop l6_3;
				l6_4: for i in integer_array_dem_5_sub'range(3) loop vv(6)(4)(i) := i; end loop l6_4;
				l6_5: for i in integer_array_dem_5_sub'range(4) loop vv(6)(5)(i) := i; end loop l6_5;
				l6_6: for i in integer_array_dem_5_sub'range(5) loop vv(6)(6)(i) := i; end loop l6_6;
				
				lr5_1: for i in int_a_d5'Reverse_range loop vv_reverse(5)(1)(i) := i; end loop lr5_1;
				lr5_2: for i in int_a_d5'Reverse_range(1) loop vv_reverse(5)(2)(i) := i; end loop lr5_2;
				lr5_3: for i in int_a_d5'Reverse_range(2) loop vv_reverse(5)(3)(i) := i; end loop lr5_3;
				lr5_4: for i in int_a_d5'Reverse_range(3) loop vv_reverse(5)(4)(i) := i; end loop lr5_4;
				lr5_5: for i in int_a_d5'Reverse_range(4) loop vv_reverse(5)(5)(i) := i; end loop lr5_5;
				lr5_6: for i in int_a_d5'Reverse_range(5) loop vv_reverse(5)(6)(i) := i; end loop lr5_6;
				
				lr6_1: for i in integer_array_dem_5_sub'Reverse_range loop vv_reverse(6)(1)(i) := i; end loop lr6_1;
				lr6_2: for i in integer_array_dem_5_sub'Reverse_range(1) loop vv_reverse(6)(2)(i) := i; end loop lr6_2;
				lr6_3: for i in integer_array_dem_5_sub'Reverse_range(2) loop vv_reverse(6)(3)(i) := i; end loop lr6_3;
				lr6_4: for i in integer_array_dem_5_sub'Reverse_range(3) loop vv_reverse(6)(4)(i) := i; end loop lr6_4;
				lr6_5: for i in integer_array_dem_5_sub'Reverse_range(4) loop vv_reverse(6)(5)(i) := i; end loop lr6_5;
				lr6_6: for i in integer_array_dem_5_sub'Reverse_range(5) loop vv_reverse(6)(6)(i) := i; end loop lr6_6;
					
				-- boolean array
					
				l7_1: for i in bool_a_d5'range loop vv(7)(1)(i) := i; end loop l7_1;
				l7_2: for i in bool_a_d5'range(1) loop vv(7)(2)(i) := i; end loop l7_2;
				l7_3: for i in bool_a_d5'range(2) loop vv(7)(3)(i) := i; end loop l7_3;
				l7_4: for i in bool_a_d5'range(3) loop vv(7)(4)(i) := i; end loop l7_4;
				l7_5: for i in bool_a_d5'range(4) loop vv(7)(5)(i) := i; end loop l7_5;
				l7_6: for i in bool_a_d5'range(5) loop vv(7)(6)(i) := i; end loop l7_6;
				
				l8_1: for i in boolean_array_dem_5_sub'range loop vv(8)(1)(i) := i; end loop l8_1;
				l8_2: for i in boolean_array_dem_5_sub'range(1) loop vv(8)(2)(i) := i; end loop l8_2;
				l8_3: for i in boolean_array_dem_5_sub'range(2) loop vv(8)(3)(i) := i; end loop l8_3;
				l8_4: for i in boolean_array_dem_5_sub'range(3) loop vv(8)(4)(i) := i; end loop l8_4;
				l8_5: for i in boolean_array_dem_5_sub'range(4) loop vv(8)(5)(i) := i; end loop l8_5;
				l8_6: for i in boolean_array_dem_5_sub'range(5) loop vv(8)(6)(i) := i; end loop l8_6;
				
				lr7_1: for i in bool_a_d5'Reverse_range loop vv_reverse(7)(1)(i) := i; end loop lr7_1;
				lr7_2: for i in bool_a_d5'Reverse_range(1) loop vv_reverse(7)(2)(i) := i; end loop lr7_2;
				lr7_3: for i in bool_a_d5'Reverse_range(2) loop vv_reverse(7)(3)(i) := i; end loop lr7_3;
				lr7_4: for i in bool_a_d5'Reverse_range(3) loop vv_reverse(7)(4)(i) := i; end loop lr7_4;
				lr7_5: for i in bool_a_d5'Reverse_range(4) loop vv_reverse(7)(5)(i) := i; end loop lr7_5;
				lr7_6: for i in bool_a_d5'Reverse_range(5) loop vv_reverse(7)(6)(i) := i; end loop lr7_6;
				
				lr8_1: for i in boolean_array_dem_5_sub'Reverse_range loop vv_reverse(8)(1)(i) := i; end loop lr8_1;
				lr8_2: for i in boolean_array_dem_5_sub'Reverse_range(1) loop vv_reverse(8)(2)(i) := i; end loop lr8_2;
				lr8_3: for i in boolean_array_dem_5_sub'Reverse_range(2) loop vv_reverse(8)(3)(i) := i; end loop lr8_3;
				lr8_4: for i in boolean_array_dem_5_sub'Reverse_range(3) loop vv_reverse(8)(4)(i) := i; end loop lr8_4;
				lr8_5: for i in boolean_array_dem_5_sub'Reverse_range(4) loop vv_reverse(8)(5)(i) := i; end loop lr8_5;
				lr8_6: for i in boolean_array_dem_5_sub'Reverse_range(5) loop vv_reverse(8)(6)(i) := i; end loop lr8_6;
					
				-- enum array
				
				l9_1: for i in enum_a_d5'range loop vv(9)(1)(i) := i; end loop l9_1;
				l9_2: for i in enum_a_d5'range(1) loop vv(9)(2)(i) := i; end loop l9_2;
				l9_3: for i in enum_a_d5'range(2) loop vv(9)(3)(i) := i; end loop l9_3;
				l9_4: for i in enum_a_d5'range(3) loop vv(9)(4)(i) := i; end loop l9_4;
				l9_5: for i in enum_a_d5'range(4) loop vv(9)(5)(i) := i; end loop l9_5;
				l9_6: for i in enum_a_d5'range(5) loop vv(9)(6)(i) := i; end loop l9_6;
				
				l10_1: for i in enum_array_dem_5_boarded'range loop vv(10)(1)(i) := i; end loop l10_1;
				l10_2: for i in enum_array_dem_5_boarded'range(1) loop vv(10)(2)(i) := i; end loop l10_2;
				l10_3: for i in enum_array_dem_5_boarded'range(2) loop vv(10)(3)(i) := i; end loop l10_3;
				l10_4: for i in enum_array_dem_5_boarded'range(3) loop vv(10)(4)(i) := i; end loop l10_4;
				l10_5: for i in enum_array_dem_5_boarded'range(4) loop vv(10)(5)(i) := i; end loop l10_5;
				l10_6: for i in enum_array_dem_5_boarded'range(5) loop vv(10)(6)(i) := i; end loop l10_6;
				
				lr9_1: for i in enum_a_d5'Reverse_range loop vv_reverse(9)(1)(i) := i; end loop lr9_1;
				lr9_2: for i in enum_a_d5'Reverse_range(1) loop vv_reverse(9)(2)(i) := i; end loop lr9_2;
				lr9_3: for i in enum_a_d5'Reverse_range(2) loop vv_reverse(9)(3)(i) := i; end loop lr9_3;
				lr9_4: for i in enum_a_d5'Reverse_range(3) loop vv_reverse(9)(4)(i) := i; end loop lr9_4;
				lr9_5: for i in enum_a_d5'Reverse_range(4) loop vv_reverse(9)(5)(i) := i; end loop lr9_5;
				lr9_6: for i in enum_a_d5'Reverse_range(5) loop vv_reverse(9)(6)(i) := i; end loop lr9_6;
				
				lr10_1: for i in enum_array_dem_5_boarded'Reverse_range loop vv_reverse(10)(1)(i) := i; end loop lr10_1;
				lr10_2: for i in enum_array_dem_5_boarded'Reverse_range(1) loop vv_reverse(10)(2)(i) := i; end loop lr10_2;
				lr10_3: for i in enum_array_dem_5_boarded'Reverse_range(2) loop vv_reverse(10)(3)(i) := i; end loop lr10_3;
				lr10_4: for i in enum_array_dem_5_boarded'Reverse_range(3) loop vv_reverse(10)(4)(i) := i; end loop lr10_4;
				lr10_5: for i in enum_array_dem_5_boarded'Reverse_range(4) loop vv_reverse(10)(5)(i) := i; end loop lr10_5;
				lr10_6: for i in enum_array_dem_5_boarded'Reverse_range(5) loop vv_reverse(10)(6)(i) := i; end loop lr10_6;
					
				-- rec array
				
				l11_1: for i in rec_a_d5'range loop vv(11)(1)(i) := i; end loop l11_1;
				l11_2: for i in rec_a_d5'range(1) loop vv(11)(2)(i) := i; end loop l11_2;
				l11_3: for i in rec_a_d5'range(2) loop vv(11)(3)(i) := i; end loop l11_3;
				l11_4: for i in rec_a_d5'range(3) loop vv(11)(4)(i) := i; end loop l11_4;
				l11_5: for i in rec_a_d5'range(4) loop vv(11)(5)(i) := i; end loop l11_5;
				l11_6: for i in rec_a_d5'range(5) loop vv(11)(6)(i) := i; end loop l11_6;
				
				l12_1: for i in rec_array_dem_5_sub'range loop vv(12)(1)(i) := i; end loop l12_1;
				l12_2: for i in rec_array_dem_5_sub'range(1) loop vv(12)(2)(i) := i; end loop l12_2;
				l12_3: for i in rec_array_dem_5_sub'range(2) loop vv(12)(3)(i) := i; end loop l12_3;
				l12_4: for i in rec_array_dem_5_sub'range(3) loop vv(12)(4)(i) := i; end loop l12_4;
				l12_5: for i in rec_array_dem_5_sub'range(4) loop vv(12)(5)(i) := i; end loop l12_5;
				l12_6: for i in rec_array_dem_5_sub'range(5) loop vv(12)(6)(i) := i; end loop l12_6;
				
				lr11_1: for i in rec_a_d5'Reverse_range loop vv_reverse(11)(1)(i) := i; end loop lr11_1;
				lr11_2: for i in rec_a_d5'Reverse_range(1) loop vv_reverse(11)(2)(i) := i; end loop lr11_2;
				lr11_3: for i in rec_a_d5'Reverse_range(2) loop vv_reverse(11)(3)(i) := i; end loop lr11_3;
				lr11_4: for i in rec_a_d5'Reverse_range(3) loop vv_reverse(11)(4)(i) := i; end loop lr11_4;
				lr11_5: for i in rec_a_d5'Reverse_range(4) loop vv_reverse(11)(5)(i) := i; end loop lr11_5;
				lr11_6: for i in rec_a_d5'Reverse_range(5) loop vv_reverse(11)(6)(i) := i; end loop lr11_6;
				
				lr12_1: for i in rec_array_dem_5_sub'Reverse_range loop vv_reverse(12)(1)(i) := i; end loop lr12_1;
				lr12_2: for i in rec_array_dem_5_sub'Reverse_range(1) loop vv_reverse(12)(2)(i) := i; end loop lr12_2;
				lr12_3: for i in rec_array_dem_5_sub'Reverse_range(2) loop vv_reverse(12)(3)(i) := i; end loop lr12_3;
				lr12_4: for i in rec_array_dem_5_sub'Reverse_range(3) loop vv_reverse(12)(4)(i) := i; end loop lr12_4;
				lr12_5: for i in rec_array_dem_5_sub'Reverse_range(4) loop vv_reverse(12)(5)(i) := i; end loop lr12_5;
				lr12_6: for i in rec_array_dem_5_sub'Reverse_range(5) loop vv_reverse(12)(6)(i) := i; end loop lr12_6;
				
					
				cond_loop: for i in 1 to 12 loop
					-- low
					cond(i)(1) := int(i)(1)(1) = 1 and int(i)(1)(2) = 1 and int(i)(1)(3) = 0 and int(i)(1)(4) = -1 and int(i)(1)(5) = 10 and int(i)(1)(6) = -3;
					-- high
					cond(i)(2) := int(i)(2)(1) = 3 and int(i)(2)(2) = 3 and int(i)(2)(3) = 7 and int(i)(2)(4) = 1 and int(i)(2)(5) = 20 and int(i)(2)(6) = 3;
					-- left
					cond(i)(3) := int(i)(3)(1) = 1 and int(i)(3)(2) = 1 and int(i)(3)(3) = 7 and int(i)(3)(4) = 1 and int(i)(3)(5) = 10 and int(i)(3)(6) = -3;
					-- right
					cond(i)(4) := int(i)(4)(1) = 3 and int(i)(4)(2) = 3 and int(i)(4)(3) = 0 and int(i)(4)(4) = -1 and int(i)(4)(5) = 20 and int(i)(4)(6) = 3;
					-- length
					cond(i)(5) := int(i)(5)(1) = 3 and int(i)(5)(2) = 3 and int(i)(5)(3) = 8 and int(i)(5)(4) = 3 and int(i)(5)(5) = 11 and int(i)(5)(6) = 7;
					-- Ascending
					cond(i)(6) := bool(i)(1) and bool(i)(2) and not(bool(i)(3)) and not(bool(i)(4)) and bool(i)(5) and bool(i)(6);
					-- range
					cond(i)(7) := all100(vv(i)(1)(-3 to 0)) and vv(i)(1)(1 to 3) = 1 & 2 & 3 and all100(vv(i)(1)(4 to 20)) and
					              all100(vv(i)(2)(-3 to 0)) and vv(i)(2)(1 to 3) = 1 & 2 & 3 and all100(vv(i)(2)(4 to 20)) and
					              all100(vv(i)(3)(-3 to -1)) and vv(i)(3)(0 to 7) = 0 & 1 & 2 & 3 & 4 & 5 & 6 & 7 and all100(vv(i)(3)(8 to 20)) and
					              all100(vv(i)(4)(-3 to -2)) and vv(i)(4)(-1 to 1) = -1 & 0 & 1 and all100(vv(i)(4)(2 to 20)) and
					              all100(vv(i)(5)(-3 to 9)) and vv(i)(5)(10 to 20) = 10 & 11 & 12 & 13 & 14 & 15 & 16 & 17 & 18 & 19 & 20 and
					              vv(i)(6)(-3 to 3) = (-3) & (-2) & (-1) & 0 & 1 & 2 & 3 and all100(vv(i)(6)(4 to 20));
					-- reverse range
					cond(i)(8) := all100(vv_reverse(i)(1)(-3 to 0)) and vv_reverse(i)(1)(1 to 3) = 1 & 2 & 3 and all100(vv_reverse(i)(1)(4 to 20)) and
					              all100(vv_reverse(i)(2)(-3 to 0)) and vv_reverse(i)(2)(1 to 3) = 1 & 2 & 3 and all100(vv_reverse(i)(2)(4 to 20)) and
					              all100(vv_reverse(i)(3)(-3 to -1)) and vv_reverse(i)(3)(0 to 7) = 0 & 1 & 2 & 3 & 4 & 5 & 6 & 7 and all100(vv_reverse(i)(3)(8 to 20)) and
					              all100(vv_reverse(i)(4)(-3 to -2)) and vv_reverse(i)(4)(-1 to 1) = -1 & 0 & 1 and all100(vv_reverse(i)(4)(2 to 20)) and
					              all100(vv_reverse(i)(5)(-3 to 9)) and vv_reverse(i)(5)(10 to 20) = 10 & 11 & 12 & 13 & 14 & 15 & 16 & 17 & 18 & 19 & 20 and
					              vv_reverse(i)(6)(-3 to 3) = (-3) & (-2) & (-1) & 0 & 1 & 2 & 3 and all100(vv_reverse(i)(6)(4 to 20));
				end loop cond_loop;

		-- std_logic_array
			-- obj = 1
			-- type = 2
		-- bit array
			-- obj = 3
			-- type = 4
		-- integer array
			-- obj = 5
			-- type = 6
		-- boolean array
			-- obj = 7
			-- type = 8
		-- enum array
			-- obj = 9
			-- type = 10
		-- rec array
			-- obj = 11
			-- type = 12
	
			when analize =>
				state <= waiting;
				
			-- std_logic array
				-- Obj
				assert not cond(1)(1)
					report "Attribute A'Low(n) worked with the object of the type std_logic array of demention up to 5 correctly"
					severity NOTE;
				assert cond(1)(1)
					report "Attribute A'Low(n) does not work with the object of the type std_logic array of demention up to 5"
					severity NOTE;
				assert not cond(1)(2)
					report "Attribute A'High(n) worked with the object of the type std_logic array of demention up to 5 correctly"
					severity NOTE;
				assert cond(1)(2)
					report "Attribute A'High(n) does not work with the object of the type std_logic array of demention up to 5"
					severity NOTE;
				assert not cond(1)(3)
					report "Attribute A'Left(n) worked with the object of the type std_logic array of demention up to 5 correctly"
					severity NOTE;
				assert cond(1)(3)
					report "Attribute A'Left(n) does not work with the object of the type std_logic array of demention up to 5"
					severity NOTE;
				assert not cond(1)(4)
					report "Attribute A'Right(n) worked with the object of the type std_logic array of demention up to 5 correctly"
					severity NOTE;
				assert cond(1)(4)
					report "Attribute A'Right(n) does not work with the object of the type std_logic array of demention up to 5"
					severity NOTE;
				assert not cond(1)(5)
					report "Attribute A'Length(n) worked with the object of the type std_logic array of demention up to 5 correctly"
					severity NOTE;
				assert cond(1)(5)
					report "Attribute A'Length(n) does not work with the object of the type std_logic array of demention up to 5"
					severity NOTE;
				assert not cond(1)(6)
					report "Attribute A'Ascending(n) worked with the object of the type std_logic array of demention up to 5 correctly"
					severity NOTE;
				assert cond(1)(6)
					report "Attribute A'Ascending(n) does not work with the object of the type std_logic array of demention up to 5"
					severity NOTE;
				assert not cond(1)(7)
					report "Attribute A'Range(n) worked with the object of the type std_logic array of demention up to 5 correctly"
					severity NOTE;
				assert cond(1)(7)
					report "Attribute A'Range(n) does not work with the object of the type std_logic array of demention up to 5"
					severity NOTE;
				assert not cond(1)(8)
					report "Attribute A'Reverse_range(n) worked with the object of the type std_logic array of demention up to 5 correctly"
					severity NOTE;
				assert cond(1)(8)
					report "Attribute A'Reverse_range(n) does not work with the object of the type std_logic array of demention up to 5"
					severity NOTE;
					
				-- subtype
				assert not cond(2)(1)
					report "Attribute A'Low(n) worked with the subtype std_logic array of demention up to 5 correctly"
					severity NOTE;
				assert cond(2)(1)
					report "Attribute A'Low(n) does not work with the subtype std_logic array of demention up to 5"
					severity NOTE;
				assert not cond(2)(2)
					report "Attribute A'High(n) worked with the subtype std_logic array of demention up to 5 correctly"
					severity NOTE;
				assert cond(2)(2)
					report "Attribute A'High(n) does not work with the subtype std_logic array of demention up to 5"
					severity NOTE;
				assert not cond(2)(3)
					report "Attribute A'Left(n) worked with the subtype std_logic array of demention up to 5 correctly"
					severity NOTE;
				assert cond(2)(3)
					report "Attribute A'Left(n) does not work with the subtype std_logic array of demention up to 5"
					severity NOTE;
				assert not cond(2)(4)
					report "Attribute A'Right(n) worked with the subtype std_logic array of demention up to 5 correctly"
					severity NOTE;
				assert cond(2)(4)
					report "Attribute A'Right(n) does not work with the subtype std_logic array of demention up to 5"
					severity NOTE;
				assert not cond(2)(5)
					report "Attribute A'Length(n) worked with the subtype std_logic array of demention up to 5 correctly"
					severity NOTE;
				assert cond(2)(5)
					report "Attribute A'Length(n) does not work with the subtype std_logic array of demention up to 5"
					severity NOTE;
				assert not cond(2)(6)
					report "Attribute A'Ascending(n) worked with the subtype std_logic array of demention up to 5 correctly"
					severity NOTE;
				assert cond(2)(6)
					report "Attribute A'Ascending(n) does not work with the subtype std_logic array of demention up to 5"
					severity NOTE;
				assert not cond(2)(7)
					report "Attribute A'Range(n) worked with the subtype std_logic array of demention up to 5 correctly"
					severity NOTE;
				assert cond(2)(7)
					report "Attribute A'Range(n) does not work with the subtype std_logic array of demention up to 5"
					severity NOTE;
				assert not cond(2)(8)
					report "Attribute A'Reverse_range(n) worked with the subtype std_logic array of demention up to 5 correctly"
					severity NOTE;
				assert cond(2)(8)
					report "Attribute A'Reverse_range(n) does not work with the subtype std_logic array of demention up to 5"
					severity NOTE;
					
			-- bit array
			
				-- Obj
				assert not cond(3)(1)
					report "Attribute A'Low(n) worked with the object of the type bit array of demention up to 5 correctly"
					severity NOTE;
				assert cond(3)(1)
					report "Attribute A'Low(n) does not work with the object of the type bit array of demention up to 5"
					severity NOTE;
				assert not cond(3)(2)
					report "Attribute A'High(n) worked with the object of the type bit array of demention up to 5 correctly"
					severity NOTE;
				assert cond(3)(2)
					report "Attribute A'High(n) does not work with the object of the type bit array of demention up to 5"
					severity NOTE;
				assert not cond(3)(3)
					report "Attribute A'Left(n) worked with the object of the type bit array of demention up to 5 correctly"
					severity NOTE;
				assert cond(3)(3)
					report "Attribute A'Left(n) does not work with the object of the type bit array of demention up to 5"
					severity NOTE;
				assert not cond(3)(4)
					report "Attribute A'Right(n) worked with the object of the type bit array of demention up to 5 correctly"
					severity NOTE;
				assert cond(3)(4)
					report "Attribute A'Right(n) does not work with the object of the type bit array of demention up to 5"
					severity NOTE;
				assert not cond(3)(5)
					report "Attribute A'Length(n) worked with the object of the type bit array of demention up to 5 correctly"
					severity NOTE;
				assert cond(3)(5)
					report "Attribute A'Length(n) does not work with the object of the type bit array of demention up to 5"
					severity NOTE;
				assert not cond(3)(6)
					report "Attribute A'Ascending(n) worked with the object of the type bit array of demention up to 5 correctly"
					severity NOTE;
				assert cond(3)(6)
					report "Attribute A'Ascending(n) does not work with the object of the type bit array of demention up to 5"
					severity NOTE;
				assert not cond(3)(7)
					report "Attribute A'Range(n) worked with the object of the type bit array of demention up to 5 correctly"
					severity NOTE;
				assert cond(3)(7)
					report "Attribute A'Range(n) does not work with the object of the type bit array of demention up to 5"
					severity NOTE;
				assert not cond(3)(8)
					report "Attribute A'Reverse_range(n) worked with the object of the type bit array of demention up to 5 correctly"
					severity NOTE;
				assert cond(3)(8)
					report "Attribute A'Reverse_range(n) does not work with the object of the type bit array of demention up to 5"
					severity NOTE;
					
				-- subtype
				assert not cond(4)(1)
					report "Attribute A'Low(n) worked with the boarded type bit array of demention up to 5 correctly"
					severity NOTE;
				assert cond(4)(1)
					report "Attribute A'Low(n) does not work with the boarded type bit array of demention up to 5"
					severity NOTE;
				assert not cond(4)(2)
					report "Attribute A'High(n) worked with the boarded type bit array of demention up to 5 correctly"
					severity NOTE;
				assert cond(4)(2)
					report "Attribute A'High(n) does not work with the boarded type bit array of demention up to 5"
					severity NOTE;
				assert not cond(4)(3)
					report "Attribute A'Left(n) worked with the boarded type bit array of demention up to 5 correctly"
					severity NOTE;
				assert cond(4)(3)
					report "Attribute A'Left(n) does not work with the boarded type bit array of demention up to 5"
					severity NOTE;
				assert not cond(4)(4)
					report "Attribute A'Right(n) worked with the boarded type bit array of demention up to 5 correctly"
					severity NOTE;
				assert cond(4)(4)
					report "Attribute A'Right(n) does not work with the boarded type bit array of demention up to 5"
					severity NOTE;
				assert not cond(4)(5)
					report "Attribute A'Length(n) worked with the boarded type bit array of demention up to 5 correctly"
					severity NOTE;
				assert cond(4)(5)
					report "Attribute A'Length(n) does not work with the boarded type bit array of demention up to 5"
					severity NOTE;
				assert not cond(4)(6)
					report "Attribute A'Ascending(n) worked with the boarded type bit array of demention up to 5 correctly"
					severity NOTE;
				assert cond(4)(6)
					report "Attribute A'Ascending(n) does not work with the boarded type bit array of demention up to 5"
					severity NOTE;
				assert not cond(4)(7)
					report "Attribute A'Range(n) worked with the boarded type bit array of demention up to 5 correctly"
					severity NOTE;
				assert cond(4)(7)
					report "Attribute A'Range(n) does not work with the boarded type bit array of demention up to 5"
					severity NOTE;
				assert not cond(4)(8)
					report "Attribute A'Reverse_range(n) worked with the boarded type bit array of demention up to 5 correctly"
					severity NOTE;
				assert cond(4)(8)
					report "Attribute A'Reverse_range(n) does not work with the boarded type bit array of demention up to 5"
					severity NOTE;
					
			-- integer array
				-- Obj
				assert not cond(5)(1)
					report "Attribute A'Low(n) worked with the object of the type integer array of demention up to 5 correctly"
					severity NOTE;
				assert cond(5)(1)
					report "Attribute A'Low(n) does not work with the object of the type integer array of demention up to 5"
					severity NOTE;
				assert not cond(5)(2)
					report "Attribute A'High(n) worked with the object of the type integer array of demention up to 5 correctly"
					severity NOTE;
				assert cond(5)(2)
					report "Attribute A'High(n) does not work with the object of the type integer array of demention up to 5"
					severity NOTE;
				assert not cond(5)(3)
					report "Attribute A'Left(n) worked with the object of the type integer array of demention up to 5 correctly"
					severity NOTE;
				assert cond(5)(3)
					report "Attribute A'Left(n) does not work with the object of the type integer array of demention up to 5"
					severity NOTE;
				assert not cond(5)(4)
					report "Attribute A'Right(n) worked with the object of the type integer array of demention up to 5 correctly"
					severity NOTE;
				assert cond(5)(4)
					report "Attribute A'Right(n) does not work with the object of the type integer array of demention up to 5"
					severity NOTE;
				assert not cond(5)(5)
					report "Attribute A'Length(n) worked with the object of the type integer array of demention up to 5 correctly"
					severity NOTE;
				assert cond(5)(5)
					report "Attribute A'Length(n) does not work with the object of the type integer array of demention up to 5"
					severity NOTE;
				assert not cond(5)(6)
					report "Attribute A'Ascending(n) worked with the object of the type integer array of demention up to 5 correctly"
					severity NOTE;
				assert cond(5)(6)
					report "Attribute A'Ascending(n) does not work with the object of the type integer array of demention up to 5"
					severity NOTE;
				assert not cond(5)(7)
					report "Attribute A'Range(n) worked with the object of the type integer array of demention up to 5 correctly"
					severity NOTE;
				assert cond(5)(7)
					report "Attribute A'Range(n) does not work with the object of the type integer array of demention up to 5"
					severity NOTE;
				assert not cond(5)(8)
					report "Attribute A'Reverse_range(n) worked with the object of the type integer array of demention up to 5 correctly"
					severity NOTE;
				assert cond(5)(8)
					report "Attribute A'Reverse_range(n) does not work with the object of the type integer array of demention up to 5"
					severity NOTE;
					
				-- subtype
				assert not cond(6)(1)
					report "Attribute A'Low(n) worked with the subtype integer array of demention up to 5 correctly"
					severity NOTE;
				assert cond(6)(1)
					report "Attribute A'Low(n) does not work with the subtype integer array of demention up to 5"
					severity NOTE;
				assert not cond(6)(2)
					report "Attribute A'High(n) worked with the subtype integer array of demention up to 5 correctly"
					severity NOTE;
				assert cond(6)(2)
					report "Attribute A'High(n) does not work with the subtype integer array of demention up to 5"
					severity NOTE;
				assert not cond(6)(3)
					report "Attribute A'Left(n) worked with the subtype integer array of demention up to 5 correctly"
					severity NOTE;
				assert cond(6)(3)
					report "Attribute A'Left(n) does not work with the subtype integer array of demention up to 5"
					severity NOTE;
				assert not cond(6)(4)
					report "Attribute A'Right(n) worked with the subtype integer array of demention up to 5 correctly"
					severity NOTE;
				assert cond(6)(4)
					report "Attribute A'Right(n) does not work with the subtype integer array of demention up to 5"
					severity NOTE;
				assert not cond(6)(5)
					report "Attribute A'Length(n) worked with the subtype integer array of demention up to 5 correctly"
					severity NOTE;
				assert cond(6)(5)
					report "Attribute A'Length(n) does not work with the subtype integer array of demention up to 5"
					severity NOTE;
				assert not cond(6)(6)
					report "Attribute A'Ascending(n) worked with the subtype integer array of demention up to 5 correctly"
					severity NOTE;
				assert cond(6)(6)
					report "Attribute A'Ascending(n) does not work with the subtype integer array of demention up to 5"
					severity NOTE;
				assert not cond(6)(7)
					report "Attribute A'Range(n) worked with the subtype integer array of demention up to 5 correctly"
					severity NOTE;
				assert cond(6)(7)
					report "Attribute A'Range(n) does not work with the subtype integer array of demention up to 5"
					severity NOTE;
				assert not cond(6)(8)
					report "Attribute A'Reverse_range(n) worked with the subtype integer array of demention up to 5 correctly"
					severity NOTE;
				assert cond(6)(8)
					report "Attribute A'Reverse_range(n) does not work with the subtype integer array of demention up to 5"
					severity NOTE;
					
			-- boolean array
				-- Obj
				assert not cond(7)(1)
					report "Attribute A'Low(n) worked with the object of the type boolean array of demention up to 5 correctly"
					severity NOTE;
				assert cond(7)(1)
					report "Attribute A'Low(n) does not work with the object of the type boolean array of demention up to 5"
					severity NOTE;
				assert not cond(7)(2)
					report "Attribute A'High(n) worked with the object of the type boolean array of demention up to 5 correctly"
					severity NOTE;
				assert cond(7)(2)
					report "Attribute A'High(n) does not work with the object of the type boolean array of demention up to 5"
					severity NOTE;
				assert not cond(7)(3)
					report "Attribute A'Left(n) worked with the object of the type boolean array of demention up to 5 correctly"
					severity NOTE;
				assert cond(7)(3)
					report "Attribute A'Left(n) does not work with the object of the type boolean array of demention up to 5"
					severity NOTE;
				assert not cond(7)(4)
					report "Attribute A'Right(n) worked with the object of the type boolean array of demention up to 5 correctly"
					severity NOTE;
				assert cond(7)(4)
					report "Attribute A'Right(n) does not work with the object of the type boolean array of demention up to 5"
					severity NOTE;
				assert not cond(7)(5)
					report "Attribute A'Length(n) worked with the object of the type boolean array of demention up to 5 correctly"
					severity NOTE;
				assert cond(7)(5)
					report "Attribute A'Length(n) does not work with the object of the type boolean array of demention up to 5"
					severity NOTE;
				assert not cond(7)(6)
					report "Attribute A'Ascending(n) worked with the object of the type boolean array of demention up to 5 correctly"
					severity NOTE;
				assert cond(7)(6)
					report "Attribute A'Ascending(n) does not work with the object of the type boolean array of demention up to 5"
					severity NOTE;
				assert not cond(7)(7)
					report "Attribute A'Range(n) worked with the object of the type boolean array of demention up to 5 correctly"
					severity NOTE;
				assert cond(7)(7)
					report "Attribute A'Range(n) does not work with the object of the type boolean array of demention up to 5"
					severity NOTE;
				assert not cond(7)(8)
					report "Attribute A'Reverse_range(n) worked with the object of the type boolean array of demention up to 5 correctly"
					severity NOTE;
				assert cond(7)(8)
					report "Attribute A'Reverse_range(n) does not work with the object of the type boolean array of demention up to 5"
					severity NOTE;
					
				-- subtype
				assert not cond(8)(1)
					report "Attribute A'Low(n) worked with the subtype boolean array of demention up to 5 correctly"
					severity NOTE;
				assert cond(8)(1)
					report "Attribute A'Low(n) does not work with the subtype boolean array of demention up to 5"
					severity NOTE;
				assert not cond(8)(2)
					report "Attribute A'High(n) worked with the subtype boolean array of demention up to 5 correctly"
					severity NOTE;
				assert cond(8)(2)
					report "Attribute A'High(n) does not work with the subtype boolean array of demention up to 5"
					severity NOTE;
				assert not cond(8)(3)
					report "Attribute A'Left(n) worked with the subtype boolean array of demention up to 5 correctly"
					severity NOTE;
				assert cond(8)(3)
					report "Attribute A'Left(n) does not work with the subtype boolean array of demention up to 5"
					severity NOTE;
				assert not cond(8)(4)
					report "Attribute A'Right(n) worked with the subtype boolean array of demention up to 5 correctly"
					severity NOTE;
				assert cond(8)(4)
					report "Attribute A'Right(n) does not work with the subtype boolean array of demention up to 5"
					severity NOTE;
				assert not cond(8)(5)
					report "Attribute A'Length(n) worked with the subtype boolean array of demention up to 5 correctly"
					severity NOTE;
				assert cond(8)(5)
					report "Attribute A'Length(n) does not work with the subtype boolean array of demention up to 5"
					severity NOTE;
				assert not cond(8)(6)
					report "Attribute A'Ascending(n) worked with the subtype boolean array of demention up to 5 correctly"
					severity NOTE;
				assert cond(8)(6)
					report "Attribute A'Ascending(n) does not work with the subtype boolean array of demention up to 5"
					severity NOTE;
				assert not cond(8)(7)
					report "Attribute A'Range(n) worked with the subtype boolean array of demention up to 5 correctly"
					severity NOTE;
				assert cond(8)(7)
					report "Attribute A'Range(n) does not work with the subtype boolean array of demention up to 5"
					severity NOTE;
				assert not cond(8)(8)
					report "Attribute A'Reverse_range(n) worked with the subtype boolean array of demention up to 5 correctly"
					severity NOTE;
				assert cond(8)(8)
					report "Attribute A'Reverse_range(n) does not work with the subtype boolean array of demention up to 5"
					severity NOTE;
					
			-- enum array
				-- Obj
				assert not cond(9)(1)
					report "Attribute A'Low(n) worked with the object of the type enum array of demention up to 5 correctly"
					severity NOTE;
				assert cond(9)(1)
					report "Attribute A'Low(n) does not work with the object of the type enum array of demention up to 5"
					severity NOTE;
				assert not cond(9)(2)
					report "Attribute A'High(n) worked with the object of the type enum array of demention up to 5 correctly"
					severity NOTE;
				assert cond(9)(2)
					report "Attribute A'High(n) does not work with the object of the type enum array of demention up to 5"
					severity NOTE;
				assert not cond(9)(3)
					report "Attribute A'Left(n) worked with the object of the type enum array of demention up to 5 correctly"
					severity NOTE;
				assert cond(9)(3)
					report "Attribute A'Left(n) does not work with the object of the type enum array of demention up to 5"
					severity NOTE;
				assert not cond(9)(4)
					report "Attribute A'Right(n) worked with the object of the type enum array of demention up to 5 correctly"
					severity NOTE;
				assert cond(9)(4)
					report "Attribute A'Right(n) does not work with the object of the type enum array of demention up to 5"
					severity NOTE;
				assert not cond(9)(5)
					report "Attribute A'Length(n) worked with the object of the type enum array of demention up to 5 correctly"
					severity NOTE;
				assert cond(9)(5)
					report "Attribute A'Length(n) does not work with the object of the type enum array of demention up to 5"
					severity NOTE;
				assert not cond(9)(6)
					report "Attribute A'Ascending(n) worked with the object of the type enum array of demention up to 5 correctly"
					severity NOTE;
				assert cond(9)(6)
					report "Attribute A'Ascending(n) does not work with the object of the type enum array of demention up to 5"
					severity NOTE;
				assert not cond(9)(7)
					report "Attribute A'Range(n) worked with the object of the type enum array of demention up to 5 correctly"
					severity NOTE;
				assert cond(9)(7)
					report "Attribute A'Range(n) does not work with the object of the type enum array of demention up to 5"
					severity NOTE;
				assert not cond(9)(8)
					report "Attribute A'Reverse_range(n) worked with the object of the type enum array of demention up to 5 correctly"
					severity NOTE;
				assert cond(9)(8)
					report "Attribute A'Reverse_range(n) does not work with the object of the type enum array of demention up to 5"
					severity NOTE;
					
				-- subtype
				assert not cond(10)(1)
					report "Attribute A'Low(n) worked with the boarded type enum array of demention up to 5 correctly"
					severity NOTE;
				assert cond(10)(1)
					report "Attribute A'Low(n) does not work with the boarded type enum array of demention up to 5"
					severity NOTE;
				assert not cond(10)(2)
					report "Attribute A'High(n) worked with the boarded type enum array of demention up to 5 correctly"
					severity NOTE;
				assert cond(10)(2)
					report "Attribute A'High(n) does not work with the boarded type enum array of demention up to 5"
					severity NOTE;
				assert not cond(10)(3)
					report "Attribute A'Left(n) worked with the boarded type enum array of demention up to 5 correctly"
					severity NOTE;
				assert cond(10)(3)
					report "Attribute A'Left(n) does not work with the boarded type enum array of demention up to 5"
					severity NOTE;
				assert not cond(10)(4)
					report "Attribute A'Right(n) worked with the boarded type enum array of demention up to 5 correctly"
					severity NOTE;
				assert cond(10)(4)
					report "Attribute A'Right(n) does not work with the boarded type enum array of demention up to 5"
					severity NOTE;
				assert not cond(10)(5)
					report "Attribute A'Length(n) worked with the boarded type enum array of demention up to 5 correctly"
					severity NOTE;
				assert cond(10)(5)
					report "Attribute A'Length(n) does not work with the boarded type enum array of demention up to 5"
					severity NOTE;
				assert not cond(10)(6)
					report "Attribute A'Ascending(n) worked with the boarded type enum array of demention up to 5 correctly"
					severity NOTE;
				assert cond(10)(6)
					report "Attribute A'Ascending(n) does not work with the boarded type enum array of demention up to 5"
					severity NOTE;
				assert not cond(10)(7)
					report "Attribute A'Range(n) worked with the boarded type enum array of demention up to 5 correctly"
					severity NOTE;
				assert cond(10)(7)
					report "Attribute A'Range(n) does not work with the boarded type enum array of demention up to 5"
					severity NOTE;
				assert not cond(10)(8)
					report "Attribute A'Reverse_range(n) worked with the boarded type enum array of demention up to 5 correctly"
					severity NOTE;
				assert cond(10)(8)
					report "Attribute A'Reverse_range(n) does not work with the boarded type enum array of demention up to 5"
					severity NOTE;
					
			-- rec array
				-- Obj
				assert not cond(11)(1)
					report "Attribute A'Low(n) worked with the object of the type record array of demention up to 5 correctly"
					severity NOTE;
				assert cond(11)(1)
					report "Attribute A'Low(n) does not work with the object of the type record array of demention up to 5"
					severity NOTE;
				assert not cond(11)(2)
					report "Attribute A'High(n) worked with the object of the type record array of demention up to 5 correctly"
					severity NOTE;
				assert cond(11)(2)
					report "Attribute A'High(n) does not work with the object of the type record array of demention up to 5"
					severity NOTE;
				assert not cond(11)(3)
					report "Attribute A'Left(n) worked with the object of the type record array of demention up to 5 correctly"
					severity NOTE;
				assert cond(11)(3)
					report "Attribute A'Left(n) does not work with the object of the type record array of demention up to 5"
					severity NOTE;
				assert not cond(11)(4)
					report "Attribute A'Right(n) worked with the object of the type record array of demention up to 5 correctly"
					severity NOTE;
				assert cond(11)(4)
					report "Attribute A'Right(n) does not work with the object of the type record array of demention up to 5"
					severity NOTE;
				assert not cond(11)(5)
					report "Attribute A'Length(n) worked with the object of the type record array of demention up to 5 correctly"
					severity NOTE;
				assert cond(11)(5)
					report "Attribute A'Length(n) does not work with the object of the type record array of demention up to 5"
					severity NOTE;
				assert not cond(11)(6)
					report "Attribute A'Ascending(n) worked with the object of the type record array of demention up to 5 correctly"
					severity NOTE;
				assert cond(11)(6)
					report "Attribute A'Ascending(n) does not work with the object of the type record array of demention up to 5"
					severity NOTE;
				assert not cond(11)(7)
					report "Attribute A'Range(n) worked with the object of the type record array of demention up to 5 correctly"
					severity NOTE;
				assert cond(11)(7)
					report "Attribute A'Range(n) does not work with the object of the type record array of demention up to 5"
					severity NOTE;
				assert not cond(11)(8)
					report "Attribute A'Reverse_range(n) worked with the object of the type record array of demention up to 5 correctly"
					severity NOTE;
				assert cond(11)(8)
					report "Attribute A'Reverse_range(n) does not work with the object of the type record array of demention up to 5"
					severity NOTE;
					
				-- subtype
				assert not cond(12)(1)
					report "Attribute A'Low(n) worked with the subtype record array of demention up to 5 correctly"
					severity NOTE;
				assert cond(12)(1)
					report "Attribute A'Low(n) does not work with the subtype record array of demention up to 5"
					severity NOTE;
				assert not cond(12)(2)
					report "Attribute A'High(n) worked with the subtype record array of demention up to 5 correctly"
					severity NOTE;
				assert cond(12)(2)
					report "Attribute A'High(n) does not work with the subtype record array of demention up to 5"
					severity NOTE;
				assert not cond(12)(3)
					report "Attribute A'Left(n) worked with the subtype record array of demention up to 5 correctly"
					severity NOTE;
				assert cond(12)(3)
					report "Attribute A'Left(n) does not work with the subtype record array of demention up to 5"
					severity NOTE;
				assert not cond(12)(4)
					report "Attribute A'Right(n) worked with the subtype record array of demention up to 5 correctly"
					severity NOTE;
				assert cond(12)(4)
					report "Attribute A'Right(n) does not work with the subtype record array of demention up to 5"
					severity NOTE;
				assert not cond(12)(5)
					report "Attribute A'Length(n) worked with the subtype record array of demention up to 5 correctly"
					severity NOTE;
				assert cond(12)(5)
					report "Attribute A'Length(n) does not work with the subtype record array of demention up to 5"
					severity NOTE;
				assert not cond(12)(6)
					report "Attribute A'Ascending(n) worked with the subtype record array of demention up to 5 correctly"
					severity NOTE;
				assert cond(12)(6)
					report "Attribute A'Ascending(n) does not work with the subtype record array of demention up to 5"
					severity NOTE;
				assert not cond(12)(7)
					report "Attribute A'Range(n) worked with the subtype record array of demention up to 5 correctly"
					severity NOTE;
				assert cond(12)(7)
					report "Attribute A'Range(n) does not work with the subtype record array of demention up to 5"
					severity NOTE;
				assert not cond(12)(8)
					report "Attribute A'Reverse_range(n) worked with the subtype record array of demention up to 5 correctly"
					severity NOTE;
				assert cond(12)(8)
					report "Attribute A'Reverse_range(n) does not work with the subtype record array of demention up to 5"
					severity NOTE;
			
			when waiting =>
				null;
		end case;
		
	end process;
	
end ARCH00024_Test_Bench ;