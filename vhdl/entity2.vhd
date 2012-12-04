entity test is
end entity test;


entity unit is
    port (
       inum : in integer;
       oled : out integer);
end entity unit;

architecture unit_a of unit is
    subtype  oneten is integer range 1 to 10 ;
    signal a : oneten := 1;
begin
    oled <= inum + a;
end architecture unit_a;


architecture test_arch of test is
    subtype  onetwo is integer range 1 to 2 ;
    constant CYCLES : integer := 100;
    signal clk : integer := 0;
    signal i : integer := 0;
    signal o1,o2 : integer;
begin

	terminator : process(clk)
	begin
		if clk >= CYCLES then
			assert false report "end of simulation" severity failure;
		-- else
		-- 	report "tick";
		end if;
	end process;

    u1:entity unit(unit_a) port map(inum=>i, oled=>o1);
    u2:entity unit(unit_a) port map(inum=>i, oled=>o2);

    clk <= clk + 1 after 1 us;

end architecture test_arch;
