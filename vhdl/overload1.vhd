-- Demonstrates overloading of procedures

entity main is
end entity main;

architecture main of main is

	type arr01 is array (0 to 1) of integer;

    procedure p1(variable f1 : in integer; variable f2 : out integer) is
    begin
        f2 := f1;
    end procedure p1;

    procedure p1(variable f1 : in integer; variable f2 : out arr01) is
    begin
        f2(0) := f1;
    end procedure p1;

begin

	main: process
		variable a : arr01 := (others => 33);
		variable i : integer := 1;
		variable o : integer := 0;
	begin
		p1(i, o);
		p1(i, a);
		assert false report "end of simulation" severity failure;
	end process;

end architecture main;

