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
-- Categories: entity, architecture, process, after, if-then-else, enumerations, array, record, case, for-loop, signals-attributes.

use work.std_logic_1164_for_tst.all;

entity ENT00016_Test_Bench is
end ENT00016_Test_Bench;

architecture ARCH00016_Test_Bench of ENT00016_Test_Bench is

	type std_array_array is array (0 to 3, 1 to 4) of std_ulogic;
	signal I_saa : std_array_array := (others => x"B");
	signal I_saa_lv : std_array_array;
	
	subtype byte is bit_vector(7 downto 0);
	
	subtype byte2 is bit_vector(0 to 7);
	
	signal b1 : byte := x"00";
	signal b1_lv : byte;
	signal b2 : byte2 := x"00";
	signal b2_lv : byte2;
	
	type bit_array_array is array (0 to 3, 4 downto 1) of bit;
	signal I_baa : bit_array_array := (others => x"A");
	signal I_baa_lv : bit_array_array;
	
	type NatArray is array (natural range <>) of natural;
	
	type std_array is array (0 to 7) of std_logic;
	signal I_sa : std_array := "10101010";
	signal I_sa_lv : std_array;
	
	type enum is (a_v, b_v, c_v, d_v, e_v, f_v);
	
	type enum_array is array (integer range <>) of enum;
	
	type rec is record
		f1 : integer;
		f2 : boolean;
		f3 : bit;
		f4 : enum;
		f5 : enum_array(0 to 3);
		f6 : NatArray(7 downto 0);
		f7 : bit_vector(7 downto 0);
	end record;
	
	type rec_array is array (integer range <>) of rec;
	
	signal e : enum := a_v;
	signal e_lv : enum;
	signal ea : enum_array(0 to 3) := (others => a_v);
	signal ea_lv : enum_array(0 to 3);
	signal r : rec := (
		  f1 => 10
		, f2 => true
		, f3 => '1'
		, f4 => a_v
		, f5 => (others => a_v)
		, f6 => (0 => 10, 7 => 3, others => 0)
		, f7 => x"33"
	);
	signal r_lv : rec;
	signal ra : rec_array(0 to 3) := (others => (
		  f1 => 10
		, f2 => true
		, f3 => '1'
		, f4 => a_v
		, f5 => (others => a_v)
		, f6 => (0 => 10, 7 => 3, others => 0)
		, f7 => x"33"
		)
	);
	signal ra_lv : rec_array(0 to 3);
	
	signal bv : bit_vector(15 downto 0) := x"CCCC";
	signal bv_lv : bit_vector(15 downto 0);
	
	signal clk : std_ulogic := '0';
	signal clk2 : std_ulogic := '0';
	signal clk_lv : std_ulogic;
	signal clk2_lv : std_ulogic;
	
	
begin
	
    clk_lv <= clk'Last_value;
	clk2_lv <= clk2'Last_value;
	bv_lv <= bv'Last_value;
	ra_lv <= ra'Last_value;
	r_lv <= r'Last_value;
	ea_lv <= ea'Last_value;
	e_lv <= e'Last_value;
	I_sa_lv <= I_sa'Last_value;
	I_baa_lv <= I_baa'Last_value;
	I_saa_lv <= I_saa'Last_value;
	b1_lv <= b1'Last_value;
	b2_lv <= b2'Last_value;
	
	clk <= not clk after 1 us;
	
	clk2 <= not clk2 after 3 us;
	
	process (clk)
	begin
		if clk'event and clk = '1' then
			b1 <= b1(6 downto 0) & not b1(7);
			
			case e is
				when a_v => e <= b_v;
				when b_v => e <= c_v;
				when c_v => e <= d_v;
				when d_v => e <= e_v;
				when e_v => e <= f_v;
				when f_v => e <= a_v;
			end case;
			
			ea(0) <= e;
			ea_loop: for i in 1 to ea'length-1 loop
				ea(i) <= ea(i-1);
			end loop ea_loop;
			
		elsif falling_edge(clk) then
			bv <= bv(bv'left-1 downto bv'low) & bv(bv'high);
			
			r.f1 <= r.f1 + 1;
			r.f2 <= not r.f2;
			r.f3 <= not r.f3;
			r.f4 <= e;
			r.f5 <= ea;
			r_f6_loop: for i in r.f6'low to r.f6'high loop
				r.f6(i) <= r.f6(i) + 1;
			end loop r_f6_loop;
			r.f7 <= r.f7(6 downto 0) & r.f7(7);
			
			ra(ra'high) <= r;
			ra_loop: for i in ra'high-1 downto 0 loop
				ra(i) <= ra(i+1);
			end loop;
			
		end if;
	end process;
		
	process (clk2)
	begin
		if rising_edge(clk2) then
			I_sa <= I_sa(I_sa'length-1) & I_sa(0 to I_sa'length-2);
		elsif clk2'event and clk2 = '0' then
			I_saa_loop_1: for i in 0 to 3 loop
				I_saa_loop_2: for j in 1 to 4 loop
					I_saa(i,j) <= I_sa(i+j);
				end loop I_saa_loop_2;
			end loop I_saa_loop_1;
			
			I_baa_loop_1: for i in 0 to 3 loop
				I_baa_loop_2: for j in 1 to 4 loop
					I_baa(i,j) <= bv(i*j);
				end loop I_baa_loop_2;
			end loop I_baa_loop_1;
			
		end if;
	end process;

    
end ARCH00016_Test_Bench ;