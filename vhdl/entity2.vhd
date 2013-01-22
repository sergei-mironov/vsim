-- Simple entity test, array and indexed mappings

entity main is
end entity main;

entity unit1 is
    port (
       inum : in integer;
       oled : out integer);
end entity unit1;

architecture unit1_a of unit1 is
    signal a : integer := 1;
begin
    oled <= inum + a;
end architecture unit1_a;

architecture main of main is
    constant CYCLES : integer := 100;
    signal clk : integer := 0;
	type arr is array (0 to 1) of integer;
	signal oi : arr := (others => 0);
	signal o : integer;
begin

	terminator : process(clk)
	begin
		if clk >= CYCLES then
			assert false report "end of simulation" severity failure;
		end if;
	end process;

    u1:entity unit1(unit1_a) port map(inum=>clk, oled=>oi(0));
    u2:entity unit1(unit1_a) port map(inum=>clk, oled=>oi(1));

    clk <= clk + 1 after 1 us;
	o <= oi(0) + oi(1);

end architecture main;
