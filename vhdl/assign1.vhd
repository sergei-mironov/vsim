entity main is
end entity main;

architecture main of main is
	constant CYCLES : integer := 1000;
	signal clk : integer := 0;
    signal s : integer;
begin
    main: process(clk)
		variable a : integer;
	begin
		a := 1;
        s <= 1;
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
