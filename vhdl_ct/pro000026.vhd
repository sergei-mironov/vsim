-- Prosoft VHDL tests.
--
-- Copyright (C) 2011 Prosoft.
--
-- Author: Zefirov, Karavaev.
--
-- This is a set of simplest tests for isolated tests of VHDL features.
--
-- Nothing more than standard package should be required.
--
-- Categories: entity, architecture, process, type, array, for-loop, function, if-then-else, Attributes-of-the-array-type-or-objects-of-the-array-type

entity ENT00026_Test_Bench is
end entity ENT00026_Test_Bench;

architecture ARCH00026_Test_Bench of ENT00026_Test_Bench is

    signal rst : bit := '0';
    signal clk : bit := '0';
    
    pure function integer_log2(v : in natural) return integer is
        variable log2count : integer := 0;
        variable x : integer := v;
    begin
        while x > 1 loop
            log2count := log2count + 1;
            x := (x + 1) / 2;
        end loop;
        return log2count;
    end function integer_log2;
    
    constant data_width : natural := 32;
    constant addr_width : natural := 32;
    
    function bus_width_ctrl (width : natural) return natural is
        variable r : natural;
    begin
        r := width;
        assert r mod 8 = 0
            report "Check the bus data/addr width. Actual width is not multiple of 8."
            severity WARNING;
        return r;
    end function;
    
    constant bus_data_width : natural := bus_width_ctrl(data_width);
    constant bus_addr_width : natural := bus_width_ctrl(addr_width);
    
    constant master_num : natural := 5;
    
    function bus_mst_control (addr_width, mst_num : natural) return natural is
        variable max_dev : integer;
        variable r : integer;
    begin
        max_dev := 2**(addr_width-4);
        
        assert mst_num < max_dev
            report "Number of masters is bigger then the possible number of devices on the bus. You must correct the number of masters"
            severity ERROR;
            
        if mst_num <= max_dev then
            r := mst_num;
        else
            r := max_dev;
        end if;
        
        if r < 0 then
            r := 0;
        end if;
        
        assert r > 0
            report "System have no any masters!"
            severity WARNING;
        return natural(r);
    end function;
    
    constant bus_master_num : natural := bus_mst_control(bus_addr_width,master_num);
    
    type device_conf_type is record
        addr_mask : bit_vector(bus_addr_width-1 downto 0);
        addr_mask_msb : bit_vector(integer_log2(bus_addr_width)-1 downto 0);
        addr_mask_lsb : bit_vector(integer_log2(bus_addr_width)-1 downto 0);
        registered : bit;
        periphery : bit;
    end record;
    
    type device_conf_array_type is array (natural range <>) of device_conf_type;
    
    type addr_mask_boardBit_array_type is array (natural range <>) of bit_vector(4 downto 0);
    type registered_array_type is array (natural range <>) of bit_vector(3 downto 0);
    type addr_mask_array_type is array (natural range <>) of bit_vector(bus_addr_width-1 downto 0);
    
    signal mst_conf : device_conf_array_type(bus_master_num-1 downto 0);
    
    signal mst_registered : registered_array_type(bus_master_num-1 downto 0);
    signal mst_addr_mask_msb : addr_mask_boardBit_array_type(bus_master_num-1 downto 0);
    signal mst_addr_mask_lsb : addr_mask_boardBit_array_type(bus_master_num-1 downto 0);
    signal mst_addr_mask : addr_mask_array_type(bus_master_num-1 downto 0);
    
    constant const_1_4b : bit_vector(3 downto 0) := "0001";
	constant const_1_5b : bit_vector(4 downto 0) := "00001";
    constant const_30_32b : bit_vector(31 downto 0) := x"0000001E";
    constant const_1m_5b : bit_vector(4 downto 0) := "11111";
	
	 function add_bit_vector (l,r : bit_vector) return bit_vector is
		variable left : bit_vector(l'length-1 downto 0);
		variable right : bit_vector(r'length-1 downto 0);
		variable res : bit_vector(l'length-1 downto 0);
		variable c : bit_vector(l'length downto 0);
	begin
		left := l;
		right := r;
		c(0) := '0';
		sum_loop: for i in 0 to res'length-1 loop
			res(i) := (left(i) xor right(i)) xor c(i);
			c(i+1) := ((left(i) xor right(i)) and c(i)) or (left(i) and right(i));
		end loop;
		return res;
	end function add_bit_vector;

begin

    clk <= not clk after 1 us;
    
    process
    begin
        rst <= '0';
        wait for 10 us;
        rst <= '1';
        wait;
    end process;
       
    process (rst, mst_addr_mask_msb, mst_addr_mask_lsb, mst_addr_mask, mst_registered)
    begin
        if rst = '0' then
            mst_conf_components_loop: for i in mst_conf'length-1 downto 0 loop
                if i = bus_master_num-1 then
                    mst_registered(i) <= x"7";
                    mst_addr_mask(i) <= x"FFF00000";
                    mst_addr_mask_lsb(i) <= "00110";
                    mst_addr_mask_msb(i) <= "11111";
                else
                    mst_registered(i) <= add_bit_vector((mst_registered(i+1)(2 downto 0) & mst_registered(i+1)(3)), const_1_4b);
                    mst_addr_mask(i) <= add_bit_vector(mst_addr_mask(i+1), const_30_32b);
                    if mst_addr_mask_msb(i+1) >= "11100" then
                        mst_addr_mask_msb(i) <= add_bit_vector(mst_addr_mask_msb(i+1),const_1m_5b);
                    else
                        mst_addr_mask_msb(i) <= "11111";
                    end if;
                    if mst_addr_mask_lsb(i+1) <= "01100" then
                        mst_addr_mask_lsb(i) <= add_bit_vector(mst_addr_mask_lsb(i+1),const_1_5b);
                    else
                        mst_addr_mask_lsb(i) <= "00110";
                    end if;
                end if;
            end loop;
        end if;
    end process;
	
	process (rst)
	begin
		if rst = '1' then
			assert (mst_registered(0) = x"3" and mst_registered(1) = x"1" and mst_registered(2) = x"0" and mst_registered(3) = x"F" and mst_registered(4) = x"7")
				report "Wrong work of a for-loop"
				severity FAILURE;
		end if;
	end process;
    
end architecture ARCH00026_Test_Bench;
