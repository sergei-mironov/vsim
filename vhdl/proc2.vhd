-- Innermost procedure

entity test is
end entity test;

architecture test_arch of test is
	
	procedure p1(x1 : in integer) is

        variable a1 : integer := 0;

        procedure p2 (x2 : in integer) is
        begin
            a1 := x2;
        end procedure p2;

	begin
		p2(x1);
        report "a1 = " & integer'image(a1);
	end procedure p1;

begin

	main: process
	begin
		p1(33);
		assert false report "end of simulation" severity failure;
	end process;

end architecture test_arch;

