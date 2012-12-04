entity ENT00001_Test_Bench is
end entity ENT00001_Test_Bench;

architecture arch of ENT00001_Test_Bench is
	constant CYCLES : integer := 1000;
	signal clk : integer := 0;
	signal sig1 : integer := 0;
	signal sig2 : integer := 1;
begin

	terminator : process(clk)
	begin
		if clk >= CYCLES then
			assert false report "end of simulation" severity failure;
		-- else
		-- 	report "tick";
		end if;
	end process;

	sig1 <= sig1 + sig2 after 1 us;
	clk <= clk + 1 after 1 us;

end;
