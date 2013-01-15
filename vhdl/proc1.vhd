entity test is
end entity test;

architecture test_arch of test is

    -- procedure p1(variable f1 : in integer := 0;
    --              variable f2 : out integer := 0; <-- ERROR
    --              variable f3 : inout integer :=0) <-- ERROR
    -- is begin
    --     f2 := f1;
    --     f3 := f3 + f1;
    -- end procedure p1;


    procedure p1(variable f1 : in integer := 0;
                 variable f2 : out integer;
                 variable f3 : inout integer) is
    begin
        f2 := f1;
        f3 := f3 + f1;
    end procedure p1;

    procedure p2(signal f1 : in integer;
                 signal f2 : out integer;
                 signal f3 : inout integer) is
    begin
        f2 <= f1;
        f3 <= f3 + f1;
    end procedure p2;
        
    signal si : integer := 1;
    signal so : integer := 0;

begin

	main: process
		variable i : integer := 1;
		variable o : integer := 0;
	begin
		p1(i, o, o);
		-- p1(si, o, o); <-- ERROR
        -- p2(si, o, o); <-- ERROR
        report integer'image(o);
		assert false report "end of simulation" severity failure;
	end process;

end architecture test_arch;

