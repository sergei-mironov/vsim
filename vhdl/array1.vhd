entity test is
end entity test;

architecture test_arch of test is
    constant size : integer := 10;
	type vector_t is array (0 to size-1) of integer;


    constant c1 : integer := 1;

	signal v : vector_t := (c1 => 1, 2=>2, others => 33);

begin

	main: process
	begin
        -- report integer'image(v(2));
        -- v <= (c1=>11, 2=>22, others => 3333);
        -- report integer'image(v(2));

		assert false report "end of simulation" severity failure;
	end process;

end architecture test_arch;


