entity test is
end entity test;

architecture atest of test is
	signal clk : integer;
begin
    -- doesn't fire
    main: process(clk)
	begin
		report "signal active";
    end process;

	clk <= clk after 1 us;
end;
