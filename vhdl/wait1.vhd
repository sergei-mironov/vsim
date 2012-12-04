entity ENT00001_Test_Bench is
end entity ENT00001_Test_Bench;

architecture arch of ENT00001_Test_Bench is
begin

	terminator : process
	begin
        report "wait 1";
        wait for 5 ms;
        report "wait 2";
        wait for 5 ms;
        report "wait 3";
        wait for 5 ms;
		assert false report "end of simulation" severity failure;
	end process;
end;
