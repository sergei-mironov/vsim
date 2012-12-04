entity test is
end entity test;

architecture test_arch of test is
    -- constant size : integer := 16#10000#;
    constant size : integer := 10;
	type vector_t is array (0 to size-1) of integer;
	signal big_vector : vector_t;
    signal clk : integer := 0;
begin

	main: process
	begin
		for i in 0 to size-1 loop
			big_vector(i) <= big_vector(i) + 1;
		end loop;

		assert false report "end of simulation" severity failure;
	end process;

end architecture test_arch;

