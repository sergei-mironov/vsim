entity ENT00001_Test_Bench is
end entity ENT00001_Test_Bench;

architecture arch of ENT00001_Test_Bench is
    signal s1 : integer := 0;
    signal s2 : integer := 10;
begin

	terminator : process
	begin

        -- t =0

        s1 <= 1 after 1 us, 2 after 2 us, 3 after 3 us, 4 after 4 us;
        s2 <= s1 after 2 us;

        wait for 10 us;

        -- t == 10 us
        assert false report "end of simulation" severity failure;
	end process;
end;
