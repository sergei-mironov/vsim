entity test is
end entity test;


entity unit is
    generic (n : integer := 100);
    port (
       inum : in integer;
       oled : out integer);
end entity unit;

architecture unit_a of unit is
    subtype  oneten is integer range 0 to 9 ;
    signal a : oneten := 0;
begin
    oled <= inum + a + n;
end architecture unit_a;


architecture test_arch of test is
    constant CYCLES : integer := 100;
    signal clk : integer := 0;
    signal i : integer := 0;

    type tarr is array (0 to 10) of integer;
    signal os : tarr;
begin

	terminator : process(clk)
	begin
		if clk >= CYCLES then
			assert false report "end of simulation" severity failure;
		-- else
		-- 	report "tick";
		end if;
	end process;

    gen1: for x in 1 to 10 generate
        u1:entity unit(unit_a)
            generic map (n=>x)
            port map(inum=>i, oled=>os(x));
    end generate;

    clk <= clk + 1 after 1 us;

end architecture test_arch;
