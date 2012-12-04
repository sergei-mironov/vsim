
entity ENT00001_Test_Bench is
end entity ENT00001_Test_Bench;

architecture arch of ENT00001_Test_Bench is
    signal s1 : integer := 33;
begin

	terminator : process
	begin
        report "s1 = " & integer'image(s1);
		assert false report "end of simulation" severity failure;
	end process;
end;
