entity test is
end entity test;

architecture test_arch of test is
    -- constant size : integer := 16#10000#;
    constant size : integer := 2;
	type vector_t is array (0 to size-1) of bit;
	signal big_vector : vector_t;
    signal clk : integer := 0;
begin

	main: process(clk)
		variable vbit : bit := '1';
	begin
		for i in 0 to clk-1 loop
			big_vector(i) <= '1';
            if False then
                big_vector(i) <= not big_vector(i);
            end if;
		end loop;

		assert false report "end of simulation" severity failure;
	end process;

    clk <= (clk + 1) after 1 us;

end architecture test_arch;

