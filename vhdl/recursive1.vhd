-- Recursive procedures

entity test is
end entity test;

architecture test_arch of test is

    signal s : integer;

    procedure p2(constant i:integer);

    procedure p1(constant i:integer) is
    begin
        p2(i);
    end procedure;

    procedure p2(constant i:integer) is
    begin
        p1(i);
        return;
    end procedure;

    constant i : integer := 0;
begin

    main: process
    begin
        p1(i);
        assert false report "end of simulation" severity failure;
    end process;

end architecture test_arch;


