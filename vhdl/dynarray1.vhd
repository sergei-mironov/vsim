entity test is
end entity test;

architecture test_arch of test is
	
	procedure p (variable s : integer; op : in integer)
	is
		type vector_t is array (0 to s-1) of integer;
		variable bv : vector_t;

	begin
		if op = 1 then
			bv(0) := 1;
		end if;
	end procedure p;

begin

	main: process
		variable s : integer;
	begin
		s := 4;
		p(s,1);
		s := 5;
		p(s,0);

		assert false report "end of simulation" severity failure;
	end process;

end architecture test_arch;

