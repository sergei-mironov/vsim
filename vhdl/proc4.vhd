-- Wait in procedure

entity test is
end entity test;

architecture test_arch of test is

    signal s : integer;

    procedure p1(signal s1 : inout integer; variable v1 : inout integer) is
    begin
        s1 <= 0;
        v1 := 0;
        wait for 4 us;
        s1 <= 1;
        v1 := 1;
        wait for 4 us;
        s1 <= 2;
        v1 := 2;
    end procedure;

begin

    main: process
        variable v : integer;
    begin
        p1(s,v);
        report "s = " & integer'image(s);
        report "v = " & integer'image(v);
        assert false report "end of simulation" severity failure;
    end process;

end architecture test_arch;

