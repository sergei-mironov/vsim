entity ENT00001_Test_Bench is
end entity ENT00001_Test_Bench;

architecture ARCH00001_Test_Bench of ENT00001_Test_Bench is
      type t_int1 is range 0 to 100 ;
      subtype  st_int1 is t_int1 range 8 to 60 ;
begin
    main: process
		variable a : t_int1;
		variable b : st_int1;
    begin
        report integer'image(a);
		assert false report "end of simulation" severity failure;
        wait;
    end process;
end;





