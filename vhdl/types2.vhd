entity ENT00001_Test_Bench is
end entity ENT00001_Test_Bench;

architecture ARCH00001_Test_Bench of ENT00001_Test_Bench is
  type     t_int1 is range 0 to 100 ;
  subtype  st_int1 is t_int1 range 8 to 60 ;
  type     t_arr1 is array (integer range <>) of st_int1 ;
  subtype  t_arr2_range1 is integer range 1 to 10 ;
  subtype  t_arr2_range2 is boolean range false to true ;
  subtype  t_arr1_range1 is integer range 1 to 10 ;
  subtype  st_arr1 is t_arr1 (t_arr1_range1) ;
  type     t_arr2 is array (integer range <>, boolean range <>) of st_arr1 ;
  subtype  st_arr2 is t_arr2 (t_arr2_range1, t_arr2_range2);
  type     t_rec1 is record
              f1 : integer range 0 to 1000 ;
              f2 : time ;
              f3 : boolean ;
              f4 : real ;
           end record ;
  subtype  st_rec1 is t_rec1 ;
  type     t_rec2 is record
              f1 : boolean ;
              f2 : st_rec1 ;
              f3 : time ;
           end record ;
  subtype  st_rec2 is t_rec2 ;
  type     t_rec3 is record
              f1 : boolean ;
              f2 : st_rec2 ;
              f3 : st_arr2 ;
           end record ;

begin
    main: process
        type t_new_int1 is range -10 to 10;
        type t_new_int2 is range -10 to 10;

        variable a : t_new_int1 := 0;
        variable b : t_new_int2 := 0;
    begin
        -- should fail
        -- b:=a;
        report "Process in the architecture of the entity.";
        wait;
    end process;
end;




