-- Inertial assignment

entity ENT00001_Test_Bench is
end entity ENT00001_Test_Bench;

architecture arch of ENT00001_Test_Bench is
    constant c : integer := 1;
    type arr is array (0 to c) of integer;
    constant c33 : arr := (others => 33);
    signal i : arr;
begin
	terminator : process
	begin
        i <= c33 after 5 us, (0=>0, 1=>1) after 10 us;

        wait for 100 us;
        assert false report "end of simulation" severity failure;
	end process;
end;

