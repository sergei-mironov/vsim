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
-- Categories: entity, architecture, process, after, enumerations, physical-types, attributes-of-discrete-or-physical-types-and-subtypes.

entity ENT00021_Test_Bench is
end ENT00021_Test_Bench;

architecture ARCH00021_Test_Bench of ENT00021_Test_Bench is

	type enum is (a_v, b_v, c_v, d_v, e_v, f_v);
	signal clk : bit := '0';
	
	type uph_t is range -100000 to 100000
		units 
			f_uph; 
			p_uph = 10 f_uph; 
			n_uph = 10 p_uph; 
			u_uph = 10 n_uph; 
			m_uph = 10 u_uph; 
			uph = 10 m_uph; 
		end units;

begin
	
	clk <= not clk after 1 us;
	
	process (clk)
		variable bv2_b1, bv2_b2, bv2_b3, bv2_b4, bv2_b5, bv2_b6, bv2_b7, bv2_b8 : bit;
		variable na1_i1, na1_i2, na1_i3, na1_i4, na1_i5, na1_i6, na1_i7, na1_i8, na1_i9 : integer;
		variable e1, e2, e3, e4, e5, e6 : enum;
		variable int_00 : integer;
		variable t1, t2, t3, t4, t5 : time;
		variable v_uph1, v_uph2, v_uph3, v_uph4, v_uph5 : uph_t;
		
	begin

		e1 := enum'Val(3);
		e2 := enum'Succ(b_v);
		e3 := enum'Pred(b_v);
		e4 := enum'Leftof(d_v);
		e5 := enum'Rightof(d_v);
		int_00 := enum'Pos(e_v);
		
		t1 := time'Val(3);
		t2 := time'Succ(3 us);
		t3 := time'Pred(1 us);
		t4 := time'Leftof(2 ns);
		t5 := time'Rightof(1 fs);
		na1_i8 := time'Pos(1 us);
		
		v_uph1 := uph_t'Val(3);
		v_uph2 := uph_t'Succ(3 u_uph);
		v_uph3 := uph_t'Pred(1 u_uph);
		v_uph4 := uph_t'Leftof(2 n_uph);
		v_uph5 := uph_t'Rightof(1 f_uph);
		na1_i9 := uph_t'Pos(1 u_uph);
		
		na1_i1 := integer'Val(3);
		na1_i2 := integer'Succ(7);
		na1_i3 := integer'Pred(3);
		na1_i4 := integer'Leftof(-1);
		na1_i5 := integer'Rightof(9);
		na1_i6 := integer'Pos(0);
		
		bv2_b1 := bit'Val(0);
		bv2_b2 := bit'Succ('0');
		bv2_b3 := bit'Pred('1');
		bv2_b4 := bit'Leftof('1');
		bv2_b5 := bit'Rightof('0');
		na1_i7 := bit'Pos('1');

    end process;

end ARCH00021_Test_Bench ;