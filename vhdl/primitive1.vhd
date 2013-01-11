entity ENT00001_Test_Bench is
end entity ENT00001_Test_Bench;

architecture ARCH00001_Test_Bench of ENT00001_Test_Bench is
      type t_int1 is range 0 to 100 ;
begin
    main: process
		variable a : t_int1;
    begin
        report "Process in the architecture of the entity.";
        wait;
    end process;
end;





