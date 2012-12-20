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
-- Categories: entity, architecture, process, after, generate, function.

entity ENT00007_Test_Bench is
end entity ENT00007_Test_Bench;

architecture ARCH00007_Test_Bench of ENT00007_Test_Bench is

	signal flag : bit_vector(3 downto 0) := x"0";
	
	signal cnt_nxt : bit_vector(3 downto 0);
	signal cnt : bit_vector(3 downto 0) := x"0";

	function add_bit_vector (l,r : bit_vector) return bit_vector is
		variable left : bit_vector(l'length-1 downto 0);
		variable right : bit_vector(r'length-1 downto 0);
		variable res : bit_vector(l'length-1 downto 0);
		variable c : bit_vector(l'length downto 0);
	begin
		left := l;
		right := r;
		c(0) := '0';
		sum_loop: for i in 0 to res'length-1 loop
			res(i) := (left(i) xor right(i)) xor c(i);
			c(i+1) := ((left(i) xor right(i)) and c(i)) or (left(i) and right(i));
		end loop;
		return res;
	end function add_bit_vector;

begin
	
	flag_0_gen : if true generate
		flag_0_true_gen: if true generate
			flag(0) <= not flag(0) after 1 us;
		end generate;
		flag_0_false_gen: if true = false generate
			flag(0) <= not flag(0) after 2 us;
		end generate;
	end generate;
	
	flag_1_1_gen : if true generate
		cnt_nxt <= add_bit_vector(cnt, x"1");
		process (flag(0), cnt)
		begin
			if flag(0)'event and flag(0) = '1' then
				cnt <= cnt_nxt;
			end if;
		end process;
		flag(1) <= cnt(3);
	end generate;
	
	flag_1_2_gen: if true = false generate
		flag(1) <= flag(0);
	end generate;
	
	flag_2_1_gen: if false generate
		flag(2) <= '0';
	end generate;
	
	flag_2_2_gen: if true generate
		flag(2) <= flag(0) and flag(1) after 1 us;
	end generate;
	
	flag_3_1_gen: if true = true generate
		flag(3) <= cnt(1);
	end generate;
	

end ARCH00007_Test_Bench;