entity test is
end entity test;

architecture test_arch of test is
	
	-- signal a : integer := 0;

    -- shared variable a : integer :=0;

	procedure p1(x1 : in integer) is

        variable a1 : integer := 0;

        procedure p2 (x2 : in integer) is
        begin
            a1 := x2;
        end procedure p2;

	begin
		-- a := x1;
		p2(x1);
	end procedure p1;

begin

	main: process
	begin
		p1(1);
		p1(2);

		assert false report "end of simulation" severity failure;
	end process;

end architecture test_arch;

