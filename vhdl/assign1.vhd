entity ENT00001_Test_Bench is
end entity ENT00001_Test_Bench;

architecture arch of ENT00001_Test_Bench is
	constant CYCLES : integer := 1000;
	signal clk : integer := 0;
begin
    main: process(clk)
		variable a : bit;
	begin
		a := '1';
    end process;

	terminator : process(clk)
	begin
		if clk >= CYCLES then
			assert false report "end of simulation" severity failure;
		-- else
		-- 	report "tick";
		end if;
	end process;

	clk <= (clk+1) after 1 us;
end;
