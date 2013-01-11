-- Subtypes

entity test is
end entity test;

architecture test_arch of test is

	type vector is array (integer range <>) of integer;
	subtype svec1 is vector (1 to 3);
	subtype svec2 is vector (4 to 7);
	
	procedure p1(variable v1 : inout svec2) is
	begin
		v1(4) := 4;
	end procedure;
	
begin

	main: process
		variable v : svec1 := (0=>0, 1=>1, 2=>2, 3=>3);
	begin
		p1(v);
		report integer'image(v(0));
		report integer'image(v(1));
		report integer'image(v(2));
		report integer'image(v(3));
		assert false report "end of simulation" severity failure;
	end process;

end architecture test_arch;


