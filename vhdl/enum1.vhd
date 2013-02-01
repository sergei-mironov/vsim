
entity main is
end entity main;

architecture main of main is

    type enum1 is ('A', 'B');
    type enum2 is ('B', 'A');

    procedure p1 (variable a: in enum1; variable b : in enum1) is
    begin
        report "p1 called";
    end;

    procedure p1 (variable a: in enum2; variable b : in enum2) is
    begin
        report "p1 called";
    end;

begin
	terminator : process
        variable e1 : enum1 := 'A';
        variable e2 : enum2 := 'B';
        variable e3 : enum2;
	begin
        p1 ( 'A', e2);
        p1 ( e1, 'B');
        e3 := 'B';
        assert false report "end of simulation" severity failure;
	end process;
end;
