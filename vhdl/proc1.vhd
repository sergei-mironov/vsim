entity test is
end entity test;

architecture test_arch of test is
	
	procedure p1(variable f1 : inout integer := 0; variable f2 : inout integer) is
        variable l1 : integer := 0;
	begin
		f2 := f1;
	end procedure;
	
begin

	main: process
		variable x1 : integer := 11;
		variable x2 : integer := 22;
	begin
		p1(x1, x2);
		p1(f2 => x2, f1 => x1);
		assert false report "end of simulation" severity failure;
	end process;

end architecture test_arch;

