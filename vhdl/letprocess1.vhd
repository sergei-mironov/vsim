entity test is
end entity test;

architecture test_arch of test is
    -- constant size : integer := 10;
	signal clk : integer := 0;
	signal s1 : integer := 0;
begin

	main: process
        constant xzz : integer := 10;
		variable aone : integer := 1;
	begin
		report "simple letprocess";
        s1 <= clk + aone;
		assert false report "end of simulation" severity failure;
	end process;

end architecture test_arch;
