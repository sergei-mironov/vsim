-- Aggregate as function argument [not in VHDL]

entity test is
end entity test;

architecture test_arch of test is

    type arr01 is array (0 to 1) of integer;

	procedure p1(variable a1 : inout arr01) is
	begin
        a1(0) := 0;
        a1(1) := 1;
	end procedure;

begin

    main: process
        variable s0, s1 : integer := 10;
	begin
		-- p1(a1 => (0 => s0 , 1 => s1)); -- ERROR
		assert false report "end of simulation" severity failure;
	end process;

end architecture test_arch;


