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
        a1(5) <= a2;
        wait for 1 us;
        if a1(5) >= 5 then
            report "greater_eq_5";
            return;
        end if;
        report "less_5";
	end procedure;

    signal v : integer := 10;
	
begin

    main: process
	begin
		p1(a, v);
		assert false report "end of simulation" severity failure;
	end process;

end architecture test_arch;

