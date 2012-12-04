entity test is
end entity test;

--{{{
entity unit1 is
    generic (n : integer := 16);
    port (
       inum : in integer;
       oled : out integer);
end entity unit1;

architecture unit1_a of unit1 is
    signal a : integer := 1;
begin
    oled <= inum + n;
end architecture unit1_a;
--}}}

--{{{
entity unit2 is
    port (
       inum : in integer;
       oled : out integer);
end entity unit2;

architecture unit2_a of unit2 is
    constant Z : integer := 0;
    signal a : integer;
begin
    u:entity unit1(unit1_a) 
        generic map (n => Z+20)
        port map (inum=>inum, oled=>a);
    oled <= a + 22;
end architecture unit2_a;
--}}}

architecture test_arch of test is
    constant CYCLES : integer := 100;
    signal clk : integer := 0;
    signal i : integer := 0;
    signal o1 : integer;
    signal o2 : integer;
begin

	terminator : process(clk)
	begin
		if clk >= CYCLES then
			assert false report "end of simulation" severity failure;
		-- else
		-- 	report "tick";
		end if;
	end process;

    u1:entity unit1(unit1_a) port map(inum=>i, oled=>o1);
    u2:entity unit2(unit2_a) port map(inum=>i, oled=>o2);

    clk <= clk + 1 after 1 us;

end architecture test_arch;

