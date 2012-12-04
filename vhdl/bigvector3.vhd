entity test is
end entity test;

architecture test_arch of test is
    constant CYCLES : integer := 100;
    constant size : integer := 16#10000#;
    -- constant size : integer := 16#2#;
	type vector_t is array (0 to size-1) of integer;
	signal big_vector : vector_t;
	signal clk : integer := 0;
begin

	main: process(clk)
	begin
		for i in 0 to size-1 loop
			big_vector(i) <= clk + i;
		end loop;
	end process;

	terminator : process(clk)
	begin
		if clk >= CYCLES then
			assert false report "end of simulation" severity failure;
		else
			report "tick";
		end if;
	end process;

	clk <= (clk+1) after 1 us;

end architecture test_arch;

