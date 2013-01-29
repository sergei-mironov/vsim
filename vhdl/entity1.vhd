-- Simple entity test, in/out ports

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
    signal o1 : integer;
    signal o2 : integer;
	signal o : integer;
begin

	terminator : process(clk)
	begin
		if clk >= CYCLES then
			assert false report "end of simulation" severity failure;
		end if;
	end process;

    u1:entity unit1(unit1_a) port map(inum=>clk, oled=>o1);
    u2:entity unit1(unit1_a) port map(inum=>clk, oled=>o2);

    clk <= clk + 1 after 1 us;
	o <= o1 + o2;

    reporter : process(o)
    begin
        report "o=" & integer'image(o);
    end process;

end architecture main;

