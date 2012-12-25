entity test is
end entity test;

architecture test_arch of test is

    signal s : integer;

	procedure p1(variable s1 : in integer) is
	begin
        report "aaaaaa";
	end procedure;
	
begin

	main: process
	begin
		p1(s);
		assert false report "end of simulation" severity failure;
	end process;

end architecture test_arch;




