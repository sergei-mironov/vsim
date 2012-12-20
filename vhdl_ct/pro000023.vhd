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
-- Categories: entity, architecture, process, type, subtype, case, enumerations, array, for-loop, Attributes-of-the-array-type-or-objects-of-the-array-type

use work.std_logic_1164_for_tst.all;

entity ENT00023_Test_Bench is
end ENT00023_Test_Bench;

architecture ARCH00023_Test_Bench of ENT00023_Test_Bench is

	subtype byte is bit_vector(1 to 8);
	
	type IntArray is array (natural range <>) of integer;
	
	type std_array is array (0 to 3) of std_logic;
	signal I_sa : std_array := "1010";
	
	type enum is (a_v, b_v, c_v, d_v, e_v, f_v);
	
	type BooleanVector is array (integer range <>) of boolean;
	type StateType is (init, assign, analize, waiting);
	signal state : StateType := init;
	
begin
   
	process (state)
		variable vv1 : IntArray(7 downto 0) := (others => 7);
		variable bv : bit_vector(9 downto 2);
		variable vv3, vv4, vv5, vv6, vv7, vv8, vv9, vv10, vv11 : IntArray(7 downto 0);
		variable vv2 : IntArray(107 downto 100);
        subtype IntArray8 is IntArray(1 to 8);
		variable int : IntArray(1 to 35) := (others => 0);
		variable r_1, r_2, r_3, r_4 : real;
		variable bool : BooleanVector(1 to 12) := (others => false);
		
        type EnumArray is array (integer range <>) of enum;
		variable ea : EnumArray(1 to 4);
		subtype EnumArray4 is EnumArray(2 to 5);
		
	begin
		case state is
			when init =>
				vv2 := (107 => 10, 100 => 0, others => 3);
				bv := x"A0";
				state <= assign;
			when assign =>
				state <= analize;
				-- bit_vector
				int(5) := bv'low;
				int(6) := bv'high;
				int(7) := bv'left;
				int(8) := bv'right;
				int(17) := bv'length;
				bool(2) := not bv'ascending;
				
				int(27) := byte'low;
				int(28) := byte'high;
				int(29) := byte'left;
				int(30) := byte'right;
				int(31) := byte'length;
				bool(6) := byte'ascending;
				
				-- boolean vector
				int(9) := bool'low;
				int(10) := bool'high;
				int(11) := bool'left;
				int(12) := bool'right;
				int(18) := bool'length;
				bool(1) := bool'ascending;
				-- IntArray
				int(1) := vv2'low;
				int(2) := vv2'high;
				int(3) := vv2'left;
				int(4) := vv2'right;
				int(19) := vv2'length;
		        bool(3) := not vv2'ascending;
		        bool(4) := IntArray8'ascending;
				int(20) := IntArray8'length;
				int(32) := IntArray8'low;
				int(33) := IntArray8'high;
				int(34) := IntArray8'left;
				int(35) := IntArray8'right;
				-- EnumArray
				int(13) := ea'Low;
				int(14) := ea'High;
				int(15) := ea'Left;
				int(16) := ea'Right;
				int(21) := ea'length;
				bool(5) := ea'Ascending;
				
				int(22) := EnumArray4'Low;
				int(23) := EnumArray4'High;
				int(24) := EnumArray4'Left;
				int(25) := EnumArray4'Right;
				int(26) := EnumArray4'Length;
				bool(7) := EnumArray4'Ascending;
				
				
				-- range
				l1: for i in I_sa'range loop
		            vv1(i) := i;
		        end loop l1;
				
				l2: for i in IntArray8'range loop
		            vv3(i-1) := i-1;
		        end loop l2;
				
				l3: for i in bv'range loop
		            vv4(i-2) := i-2;
		        end loop l3;
				
				l4: for i in std_array'range loop
		            vv5(i) := i;
					vv5(i+4) := i+4;
		        end loop l4;
				
				l5: for i in EnumArray4'range loop
		            vv6(i-2) := i-2;
					vv6(i-2+4) := i-2+4;
		        end loop l5;
				-- reverse_range
				l6: for i in I_sa'reverse_range loop
		            vv7(i) := i;
					vv7(i+4) := i+4;
		        end loop l6;
				
				l7: for i in IntArray8'reverse_range loop
		            vv8(i-1) := i-1;
		        end loop l7;
				
				l8: for i in bv'reverse_range loop
		            vv9(i-2) := i-2;
		        end loop l8;
				
				l9: for i in std_array'reverse_range loop
		            vv10(i) := i;
					vv10(i+4) := i+4;
		        end loop l9;
				
				l10: for i in EnumArray4'reverse_range loop
		            vv11(i-2) := i-2;
					vv11(i-2+4) := i-2+4;
		        end loop l10;
				
			when analize =>
				state <= waiting;
				-- bit_vector
				
				assert int(5) /= 2
					report "Attribute A'Low(0) worked with the object of the type Bit_Vector correctly"
					severity NOTE;
				assert int(5) = 2
					report "Attribute A'Low(0) does not work with the object of the type Bit_Vector"
					severity NOTE;
				assert int(6) /= 9
					report "Attribute A'High(0) worked with the object of the type Bit_Vector correctly"
					severity NOTE;
				assert int(6) = 9
					report "Attribute A'High(0) does not work with the object of the type Bit_Vector"
					severity NOTE;
				assert int(7) /= 9
					report "Attribute A'Left(0) worked with the object of the type Bit_Vector correctly"
					severity NOTE;
				assert int(7) = 9
					report "Attribute A'Left(0) does not work with the object of the type Bit_Vector"
					severity NOTE;
				assert int(8) /= 2
					report "Attribute A'Right(0) worked with the object of the type Bit_Vector correctly"
					severity NOTE;
				assert int(8) = 2
					report "Attribute A'Right(0) does not work with the object of the type Bit_Vector"
					severity NOTE;
				assert int(17) /= 8
					report "Attribute A'Length(0) worked with the object of the type Bit_Vector correctly"
					severity NOTE;
				assert int(17) = 8
					report "Attribute A'Length(0) does not work with the object of the type Bit_Vector"
					severity NOTE;
				assert not bool(2)
					report "Attribute A'Ascending(0) worked with the object of the type Bit_Vector correctly"
					severity NOTE;
				assert bool(2)
					report "Attribute A'Ascending(0) does not work with the object of the type Bit_Vector"
					severity NOTE;
					
				assert int(27) /= 1
					report "Attribute A'Low(0) worked with the boarded subtype of the type Bit_Vector correctly"
					severity NOTE;
				assert int(27) = 1
					report "Attribute A'Low(0) does not work with the boarded subtype of the type Bit_Vector"
					severity NOTE;
				assert int(28) /= 8
					report "Attribute A'High(0) worked with the boarded subtype of the type Bit_Vector correctly"
					severity NOTE;
				assert int(28) = 8
					report "Attribute A'High(0) does not work with the boarded subtype of the type Bit_Vector"
					severity NOTE;
				assert int(29) /= 1
					report "Attribute A'Left(0) worked with the boarded subtype of the type Bit_Vector correctly"
					severity NOTE;
				assert int(29) = 1
					report "Attribute A'Left(0) does not work with the boarded subtype of the type Bit_Vector"
					severity NOTE;
				assert int(30) /= 8
					report "Attribute A'Right(0) worked with the boarded subtype of the type Bit_Vector correctly"
					severity NOTE;
				assert int(30) = 8
					report "Attribute A'Right(0) does not work with the boarded subtype of the type Bit_Vector"
					severity NOTE;
				assert int(31) /= 8
					report "Attribute A'Length(0) worked with the boarded subtype of the type Bit_Vector correctly"
					severity NOTE;
				assert int(31) = 8
					report "Attribute A'Length(0) does not work with the boarded subtype of the type Bit_Vector"
					severity NOTE;
				assert not bool(6)
					report "Attribute A'Ascending(0) worked with the boarded subtype of the type Bit_Vector correctly"
					severity NOTE;
				assert bool(6)
					report "Attribute A'Ascending(0) does not work with the boarded subtype of the type Bit_Vector"
					severity NOTE;
					
				-- boolean vector
				
				assert int(9) /= 1
					report "Attribute A'Low(0) worked with the object of the boarded type Boolean Array correctly"
					severity NOTE;
				assert int(9) = 1
					report "Attribute A'Low(0) does not work with the object of the boarded type Boolean Array"
					severity NOTE;
				assert int(10) /= 16#C#
					report "Attribute A'High(0) worked with the object of the boarded type Boolean Array correctly"
					severity NOTE;
				assert int(10) = 16#C#
					report "Attribute A'High(0) does not work with the object of the boarded type Boolean Array"
					severity NOTE;
				assert int(11) /= 1
					report "Attribute A'Left(0) worked with the object of the boarded type Boolean Array correctly"
					severity NOTE;
				assert int(11) = 1
					report "Attribute A'Left(0) does not work with the object of the boarded type Boolean Array"
					severity NOTE;
				assert int(12) /= 16#C#
					report "Attribute A'Right(0) worked with the object of the boarded type Boolean Array correctly"
					severity NOTE;
				assert int(12) = 16#C#
					report "Attribute A'Right(0) does not work with the object of the boarded type Boolean Array"
					severity NOTE;
				assert int(18) /= 16#C#
					report "Attribute A'Length(0) worked with the object of the boarded type Boolean Array correctly"
					severity NOTE;
				assert int(18) = 16#C#
					report "Attribute A'Length(0) does not work with the object of the boarded type Boolean Array"
					severity NOTE;
				assert not bool(1)
					report "Attribute A'Ascending(0) worked with the object of the boarded type Boolean Array correctly"
					severity NOTE;
				assert bool(1)
					report "Attribute A'Ascending(0) does not work with the object of the boarded type Boolean Array"
					severity NOTE;
					
				-- IntArray
				
				assert int(1) /= 100
					report "Attribute A'Low(0) worked with the object of the boarded type Integer Array correctly"
					severity NOTE;
				assert int(1) = 100
					report "Attribute A'Low(0) does not work with the object of the boarded type Integer Array"
					severity NOTE;
				assert int(2) /= 107
					report "Attribute A'High(0) worked with the object of the boarded type Integer Array correctly"
					severity NOTE;
				assert int(2) = 107
					report "Attribute A'High(0) does not work with the object of the boarded type Integer Array"
					severity NOTE;
				assert int(3) /= 107
					report "Attribute A'Left(0) worked with the object of the boarded type Integer Array correctly"
					severity NOTE;
				assert int(3) = 107
					report "Attribute A'Left(0) does not work with the object of the boarded type Integer Array"
					severity NOTE;
				assert int(4) /= 100
					report "Attribute A'Right(0) worked with the object of the boarded type Integer Array correctly"
					severity NOTE;
				assert int(4) = 100
					report "Attribute A'Right(0) does not work with the object of the boarded type Integer Array"
					severity NOTE;
				assert int(19) /= 8
					report "Attribute A'Length(0) worked with the object of the boarded type Integer Array correctly"
					severity NOTE;
				assert int(19) = 8
					report "Attribute A'Length(0) does not work with the object of the boarded type Integer Array"
					severity NOTE;
				assert not bool(3)
					report "Attribute A'Ascending(0) worked with the object of the boarded type Integer Array correctly"
					severity NOTE;
				assert bool(3)
					report "Attribute A'Ascending(0) does not work with the object of the type boarded type Integer Array"
					severity NOTE;
					
				assert int(32) /= 1
					report "Attribute A'Low(0) worked with the boarded subtype Integer Array correctly"
					severity NOTE;
				assert int(32) = 1
					report "Attribute A'Low(0) does not work with the boarded subtype Integer Array"
					severity NOTE;
				assert int(33) /= 8
					report "Attribute A'High(0) worked with the boarded subtype Integer Array correctly"
					severity NOTE;
				assert int(33) = 8
					report "Attribute A'High(0) does not work with the boarded subtype Integer Array"
					severity NOTE;
				assert int(34) /= 1
					report "Attribute A'Left(0) worked with the boarded subtype Integer Array correctly"
					severity NOTE;
				assert int(34) = 1
					report "Attribute A'Left(0) does not work with the boarded subtype Integer Array"
					severity NOTE;
				assert int(35) /= 8
					report "Attribute A'Right(0) worked with the boarded subtype Integer Array correctly"
					severity NOTE;
				assert int(35) = 8
					report "Attribute A'Right(0) does not work with the boarded subtype Integer Array"
					severity NOTE;
				assert int(20) /= 8
					report "Attribute A'Length(0) worked with the boarded subtype Integer Array correctly"
					severity NOTE;
				assert int(20) = 8
					report "Attribute A'Length(0) does not work with the boarded subtype Integer Array"
					severity NOTE;
				assert not bool(4)
					report "Attribute A'Ascending(0) worked with the boarded subtype Integer Array correctly"
					severity NOTE;
				assert bool(4)
					report "Attribute A'Ascending(0) does not work with the type boarded subtype Integer Array"
					severity NOTE;
				
				-- EnumArray
				
				assert int(13) /= 1
					report "Attribute A'Low(0) worked with the object of the boarded type Enum Array correctly"
					severity NOTE;
				assert int(13) = 1
					report "Attribute A'Low(0) does not work with the object of the boarded type Enum Array"
					severity NOTE;
				assert int(14) /= 4
					report "Attribute A'High(0) worked with the object of the boarded type Enum Array correctly"
					severity NOTE;
				assert int(14) = 4
					report "Attribute A'High(0) does not work with the object of the boarded type Enum Array"
					severity NOTE;
				assert int(15) /= 1
					report "Attribute A'Left(0) worked with the object of the boarded type Enum Array correctly"
					severity NOTE;
				assert int(15) = 1
					report "Attribute A'Left(0) does not work with the object of the boarded type Enum Array"
					severity NOTE;
				assert int(16) /= 4
					report "Attribute A'Right(0) worked with the object of the boarded type Enum Array correctly"
					severity NOTE;
				assert int(16) = 4
					report "Attribute A'Right(0) does not work with the object of the boarded type Enum Array"
					severity NOTE;
				assert int(21) /= 4
					report "Attribute A'Length(0) worked with the object of the boarded type Enum Array correctly"
					severity NOTE;
				assert int(21) = 4
					report "Attribute A'Length(0) does not work with the object of the boarded type Enum Array"
					severity NOTE;
				assert not bool(5)
					report "Attribute A'Ascending(0) worked with the object of the boarded type Enum Array correctly"
					severity NOTE;
				assert bool(5)
					report "Attribute A'Ascending(0) does not work with the object of the type boarded type Enum Array"
					severity NOTE;
					
				assert int(22) /= 2
					report "Attribute A'Low(0) worked with the boarded type Enum Array correctly"
					severity NOTE;
				assert int(22) = 2
					report "Attribute A'Low(0) does not work with the boarded type Enum Array"
					severity NOTE;
				assert int(23) /= 5
					report "Attribute A'High(0) worked with the boarded type Enum Array correctly"
					severity NOTE;
				assert int(23) = 5
					report "Attribute A'High(0) does not work with the boarded type Enum Array"
					severity NOTE;
				assert int(24) /= 2
					report "Attribute A'Left(0) worked with the boarded type Enum Array correctly"
					severity NOTE;
				assert int(24) = 2
					report "Attribute A'Left(0) does not work with the boarded type Enum Array"
					severity NOTE;
				assert int(25) /= 5
					report "Attribute A'Right(0) worked with the boarded type Enum Array correctly"
					severity NOTE;
				assert int(25) = 5
					report "Attribute A'Right(0) does not work with the boarded type Enum Array"
					severity NOTE;
				assert int(26) /= 4
					report "Attribute A'Length(0) worked with the boarded type Enum Array correctly"
					severity NOTE;
				assert int(26) = 4
					report "Attribute A'Length(0) does not work with the boarded type Enum Array"
					severity NOTE;
				assert not bool(7)
					report "Attribute A'Ascending(0) worked with the boarded type Enum Array correctly"
					severity NOTE;
				assert bool(7)
					report "Attribute A'Ascending(0) does not work with the type boarded type Enum Array"
					severity NOTE;
				
				-- Range
				
				-- obj of std_logic array
				assert vv1 /= 7 & 7 & 7 & 7 & 3 & 2 & 1 & 0
					report "Attribute A'Range(0) worked with the object of the boarded type Std_logic Array correctly"
					severity NOTE;
				assert vv1 = 7 & 7 & 7 & 7 & 3 & 2 & 1 & 0
					report "Attribute A'Range(0) does not work with the object of the boarded type Std_logic Array"
					severity NOTE;
				-- Boarded Integer Array
				assert vv3 /= 7 & 6 & 5 & 4 & 3 & 2 & 1 & 0
					report "Attribute A'Range(0) worked with the boarded subtype Integer Array correctly"
					severity NOTE;
				assert vv3 = 7 & 6 & 5 & 4 & 3 & 2 & 1 & 0
					report "Attribute A'Range(0) does not work with the boarded subtype Integer Array"
					severity NOTE;
				-- obj of boarded bit_vector
				assert vv4 /= 7 & 6 & 5 & 4 & 3 & 2 & 1 & 0
					report "Attribute A'Range(0) worked with the object of the bit_vector correctly"
					severity NOTE;
				assert vv4 = 7 & 6 & 5 & 4 & 3 & 2 & 1 & 0
					report "Attribute A'Range(0) does not work with the object of the bit_vector"
					severity NOTE;
				-- boarded std_logic array
				assert vv5 /= 7 & 6 & 5 & 4 & 3 & 2 & 1 & 0
					report "Attribute A'Range(0) worked with the boarded type Std_logic Array correctly"
					severity NOTE;
				assert vv5 = 7 & 6 & 5 & 4 & 3 & 2 & 1 & 0
					report "Attribute A'Range(0) does not work with the boarded type Std_logic Array"
					severity NOTE;
				-- boarded enum array
				assert vv6 /= 7 & 6 & 5 & 4 & 3 & 2 & 1 & 0
					report "Attribute A'Range(0) worked with the boarded subtype Enumeration Array correctly"
					severity NOTE;
				assert vv6 = 7 & 6 & 5 & 4 & 3 & 2 & 1 & 0
					report "Attribute A'Range(0) does not work with the boarded subtype Enumeration Array"
					severity NOTE;
				
				-- Reverse_Range
				
				-- obj of std_logic array
				assert vv7 /= 7 & 6 & 5 & 4 & 3 & 2 & 1 & 0
					report "Attribute A'Reverse_range(0) worked with the object of the boarded type Std_logic Array correctly"
					severity NOTE;
				assert vv7 = 7 & 6 & 5 & 4 & 3 & 2 & 1 & 0
					report "Attribute A'Reverse_range(0) does not work with the object of the boarded type Std_logic Array"
					severity NOTE;
				-- Boarded Integer Array
				assert vv8 /= 7 & 6 & 5 & 4 & 3 & 2 & 1 & 0
					report "Attribute A'Reverse_range(0) worked with the boarded subtype Integer Array correctly"
					severity NOTE;
				assert vv8 = 7 & 6 & 5 & 4 & 3 & 2 & 1 & 0
					report "Attribute A'Reverse_range(0) does not work with the boarded subtype Integer Array"
					severity NOTE;
				-- obj of boarded bit_vector
				assert vv9 /= 7 & 6 & 5 & 4 & 3 & 2 & 1 & 0
					report "Attribute A'Reverse_range(0) worked with the object of the bit_vector correctly"
					severity NOTE;
				assert vv9 = 7 & 6 & 5 & 4 & 3 & 2 & 1 & 0
					report "Attribute A'Reverse_range(0) does not work with the object of the bit_vector"
					severity NOTE;
				-- boarded std_logic array
				assert vv10 /= 7 & 6 & 5 & 4 & 3 & 2 & 1 & 0
					report "Attribute A'Reverse_range(0) worked with the boarded type Std_logic Array correctly"
					severity NOTE;
				assert vv10 = 7 & 6 & 5 & 4 & 3 & 2 & 1 & 0
					report "Attribute A'Reverse_range(0) does not work with the boarded type Std_logic Array"
					severity NOTE;
				-- boarded enum array
				assert vv11 /= 7 & 6 & 5 & 4 & 3 & 2 & 1 & 0
					report "Attribute A'Reverse_range(0) worked with the boarded subtype Enumeration Array correctly"
					severity NOTE;
				assert vv11 = 7 & 6 & 5 & 4 & 3 & 2 & 1 & 0
					report "Attribute A'Reverse_range(0) does not work with the boarded subtype Enumeration Array"
					severity NOTE;
			
			when waiting =>
				null;
		end case;
		
	end process;
	
end ARCH00023_Test_Bench ;