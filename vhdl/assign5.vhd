-- Inertial assignment

entity ENT00001_Test_Bench is
end entity ENT00001_Test_Bench;

architecture arch of ENT00001_Test_Bench is
    signal i : integer := 0;
    signal o1 : integer := 0;
    signal o2 : integer := 0;
begin
	terminator : process
	begin
        i <= 1 after 5 us, 0 after 10 us, 1 after 20 us, 0 after 30 us;

        wait for 100 us;
        assert false report "end of simulation" severity failure;
	end process;

    o1 <= i after 8 us;
    o2 <= i after 2 us;
end;
