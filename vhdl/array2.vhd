entity test is
end entity test;

-- Dynamic array inside a procedure

architecture test_arch of test is
	
	procedure p (variable sz : integer; v : in integer) is
		type vector_t is array (0 to s-1) of integer;
		variable bv : vector_t;
	begin
        bv(s-1) := v;
        report integer'image (bv(s-1))
	end procedure p;

begin

	main: process
		variable s : integer;
	begin
        -- implicit
		s := 4;
		p(s,11);

        -- explicit
		p(5,22);

		assert false report "end of simulation" severity failure;
	end process;

end architecture test_arch;

