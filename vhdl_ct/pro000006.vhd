-------------------------------------------------------------------------------
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
-- Categories: entity, architecture, process, function, procedure, component, generate, after, type.

entity ENT00002 is
	port (
		  x : in bit
		; y : in bit
		; o : out bit
	);
end entity;

architecture ARCH00002 of ENT00002 is
begin
	o <= x xor y;
end;

entity ENT00002_Test_Bench is
end entity;

architecture ARCH00002_Test_Bench of ENT00002_Test_Bench is

	component ENT00002 is
	port (
		  x : in bit
		; y : in bit
		; o : out bit
	);
	end component;

	type unsigned is array (natural range <>) of bit;
	
	signal x : unsigned(11 downto 0) := x"AAA";
	signal y : unsigned(11 downto 0) := x"000";
	signal o : unsigned(11 downto 0);
	signal x_nxt, y_nxt : unsigned(11 downto 0);
	signal clkx : bit := '0';
	signal clky : bit := '0';
	
	function bufX (xi : bit) return bit is
		variable r : bit;
	begin
		r := xi;
		return r;
	end function;
	
	procedure invBufX (xi : in bit; xo : out bit) is
	begin
		xo := not xi;
	end procedure;
	
	-- simple summator with l'size = r'size without size'controll
	function add_unsigned (l,r : unsigned) return unsigned is
		variable left : unsigned(l'length-1 downto 0);
		variable right : unsigned(r'length-1 downto 0);
		variable res : unsigned(l'length-1 downto 0);
		variable c : unsigned(l'length downto 0);
	begin
		left := l;
		right := r;
		c(0) := '0';
		sum_loop: for i in 0 to res'length-1 loop
			res(i) := (left(i) xor right(i)) xor c(i);
			c(i+1) := ((left(i) xor right(i)) and c(i)) or (left(i) and right(i));
		end loop;
		return res;
	end function add_unsigned;
	
	type integer_vector_dem2 is array (integer range <>, integer range <>) of integer;
	type integer_vector_dem1 is array (integer range <>) of integer;
	signal iv2 : integer_vector_dem2(3 downto 0, 0 to 3) := (others => (others => 0));
	signal iv1 : integer_vector_dem1(3 downto 0) := (others => 0);
	
begin
	
	x_nxt <= add_unsigned(x, x"001");
	y_nxt <= add_unsigned(y, x"001");
	
	clkx <= not clkx after 1 us;
	clky <= not clky after 1.2 us;
	
	process (clkx)
	begin
		if clkx'event and clkx = '1' then
			x <= x_nxt;
		end if;
	end process;
	
	process (clky)
	begin
		if clky'event and clky = '1' then
			y <= y_nxt;
		end if;
	end process;
	
	o_3_0_gen: for i in 3 downto 0 generate
		tst_gen: for j in 0 to i generate
			signal s : integer := 0;
		begin
			process (clkx)
			begin
				if clkx'event and clkx ='1' then
					iv2(i,j) <= iv2(i,j) + j;
					s <= s + j;
--					iv1(i) <= iv1(i) + j;
				end if;
			end process;
		end generate;
		o_1_0_gen: if i <= 1 generate
			signal xi : unsigned(1 downto 0);
		begin
			process (x(i))
				variable v_xi : unsigned(1 downto 0);
			begin
				invBufX(x(i), v_xi(i));
				xi(i) <= v_xi(i) after 0.1 us;
			end process;
			ENT00002_inst : ENT00002
			port map (
				  x => xi(i)
				, y => y(i)
				, o => o(i)
			);
		end generate;
		o_3_2_gen: if i >= 2 generate
			signal xi : unsigned(3 downto 2);
		begin
			process (x(i))
			begin
				xi(i) <= bufX(x(i)) after 0.2 us;
			end process;
			ENT00002_inst : ENT00002
			port map (
				  x => xi(i)
				, y => y(i)
				, o => o(i)
			);
		end generate;
	end generate;
	
	o_7_6_gen: for i in 7 downto 6 generate
		procedure invProc (p : in bit; q : out bit) is
		begin
			q := not p;
		end procedure;
		signal y_inv : bit;
	begin
		process(y(i))
			variable v_y_inv : bit;
		begin
			invProc(y(i),v_y_inv);
			y_inv <= v_y_inv;
		end process;
		ENT00002_inst : ENT00002
		port map (
			  x => x(i)
			, y => y_inv
			, o => o(i)
		);
	end generate;
	
	o_5_4_gen: for i in 5 downto 4 generate
		function invFunc (i : bit) return bit is
			variable r : bit;
		begin
			r := not i;
			return r;
		end function;
		signal y_inv : bit;
	begin
		process(y(i))
		begin
			y_inv <= invFunc(y(i));
		end process;
		ENT00002_inst : ENT00002
		port map (
			  x => x(i)
			, y => y_inv
			, o => o(i)
		);
	end generate;
	
	o_11_8_gen: for i in 11 downto 8 generate
		procedure invProc (p : in bit; q : out bit) is
		begin
			q := not p;
		end procedure;
		signal y_inv : unsigned(11 downto 8);
	begin
		o_11_10_gen: if i >= 10 generate
			function invFunc (i : bit) return bit is
				variable r : bit;
			begin
				r := not i;
				return r;
			end function;
		begin
			process(y(i))
			begin
				y_inv(i) <= invFunc(y(i));
			end process;
			ENT00002_inst : ENT00002
			port map (
				  x => x(i)
				, y => y_inv(i)
				, o => o(i)
			);
		end generate;
		
		o_9_8_gen: if i <= 9 generate
			signal xi : unsigned(9 downto 8);
		begin
			process (x(i))
			begin
				xi(i) <= bufX(x(i)) after 0.2 us;
			end process;
	
			process(y(i))
				variable v_y_inv : bit;
			begin
				invProc(y(i),v_y_inv);
				y_inv(i) <= v_y_inv;
			end process;
			ENT00002_inst : ENT00002
			port map (
				  x => xi(i)
				, y => y_inv(i)
				, o => o(i)
			);
		end generate;
	end generate;
	
end ARCH00002_Test_Bench;
	