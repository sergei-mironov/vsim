-- Array retyping

entity test is
end entity test;

architecture test_arch of test is

    type integer_vector is array (integer range <>) of integer;
    subtype integer_subvector is integer_vector(0 to 10);
    signal a : integer_subvector := (others => 0);

	type vector_t is array (0 to 10) of integer;
	signal x : vector_t := (1=>1, 2=>2, others => 33);

	procedure p1(
        signal a1 : inout integer_vector;
        signal a2 : in integer) is
	begin
        a1(20) <= 1;
	end procedure;
	
begin

    main: process
	begin
		p1(a, 4);
		assert false report "end of simulation" severity failure;
	end process;

end architecture test_arch;

