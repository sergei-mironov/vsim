entity ENT00001_Test_Bench is
end entity ENT00001_Test_Bench;

architecture arch of ENT00001_Test_Bench is
	constant CYCLES : integer := 10;
	signal clk : integer := 0;
	signal n1   : integer := 101;
	signal n2   : integer := 102;
begin

	clk <= clk+1 after 5 us;

	main: process(clk)
	begin
		report "bla-bla-bla";
		n1 <= clk after 20 us;
		n2 <= 5 after 20 us;
	end process;

	terminator : process(clk)
	begin
		if clk >= CYCLES then
			assert false report "end of simulation" severity failure;
		end if;
	end process;
end;
