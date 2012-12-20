-------------------------------------------------------------------------------
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
-- Categories: entity, architecture, process, if-then-else, block, function, procedure, component.

entity ENT00001 is
    port (
        rst : in bit;
        clk : in bit;
        shift_toggle : in bit;
        add_op1 : in bit_vector(3 downto 0);
        add_op2 : in bit_vector(3 downto 0);
        mul_op  : in integer;
        result  : out bit_vector(3 downto 0)
    );
end ENT00001;

architecture ARCH00001 of ENT00001 is

  	-- simple summator with l'size = r'size without size'controll
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
	
	function strange_mul (op : bit_vector; multiplier : integer) return bit_vector is
		variable v : bit_vector(op'length-1 downto 0);
		variable r : bit_vector(op'length-1 downto 0);
	begin
		v := op;
		r := v;
		if multiplier > 1 then
			mul_loop: for i in 1 to multiplier-1 loop
				r := add_bit_vector(r, v);
			end loop;
		end if;
		return r;
	end strange_mul;
   
   procedure recurse (num : integer) is
   begin
       if num > 0 then
           recurse(num-1);
       end if;
   end recurse;
    
   signal result_for_shift, result_t, result_asyn : bit_vector(3 downto 0);
   
   signal shift_en_tst : bit;
   signal shift_en_tst_clk, shift_toggle_clk : bit_vector(1 downto 0);
    
begin
    
    async_logic: process(add_op1, add_op2, mul_op, shift_toggle, result_t)
        variable vres : bit_vector(3 downto 0);
        variable sum : bit_vector(3 downto 0);
    begin
        vres := result_t;
        sum := add_bit_vector(add_op1,add_op2);
        
        if shift_toggle = '0' then
            vres := strange_mul(sum, mul_op);
        end if;
        
        result_for_shift <= vres;
        
        recurse(5);
        
    end process;
    
    shift: process (shift_toggle, result_for_shift)
        variable vout : bit_vector(3 downto 0);
    begin
        vout := result_for_shift;
        
        if shift_toggle = '1' then
            vout := vout(2 downto 0) & '0';
        end if;
        
--        result_asyn <= vout;
    end process;
	
	shift_block : block
        port (
              input  : in bit_vector(3 downto 0)
            ; shift_en : in bit
			; shift_en_out : out bit
            ; output : out bit_vector(3 downto 0)
        );
        port map (
              input => result_for_shift
            , shift_en => shift_toggle
			, shift_en_out => shift_en_tst
            , output => result_asyn
        );
        signal output_t : bit_vector(3 downto 0);
        function shiftZeroFunc (x : bit_vector) return bit_vector is
            variable v, r : bit_vector(x'length-1 downto 0);
        begin
            v := x;
            r := v(v'high-1 downto 0) & '0';
            return r;
        end function;
        
        procedure bufXOut4 (bi : in bit_vector(3 downto 0); bo : out bit_vector(3 downto 0)) is
        begin
            bo(0) := bi(3);
            bo(1) := bi(2);
            bo(2) := bi(1);
            bo(3) := bi(0);
        end procedure;
		
    begin
		
		shift_en_out <= shift_en;
		
        output <= output_t;

        process (input, shift_en)
            variable vout : bit_vector(3 downto 0);
            variable voutX : bit_vector(3 downto 0);
        begin
            vout := input;
            if shift_en = '1' then
                vout := shiftZeroFunc(vout);
            end if;
            bufXOut4(vout(3 downto 0), voutX);
            output_t(3 downto 0) <= voutX after 0.2 us;
        end process;
    end block shift_block;
            
    result <= result_t;
    
    sync: process (rst, clk)
    begin
        if rst = '1' then
            result_t <= x"0";
			shift_en_tst_clk <= "00";
			shift_toggle_clk <= "00";
        elsif clk'event and clk = '1' then
            result_t <= result_asyn;
			shift_en_tst_clk <= shift_en_tst_clk(0) & shift_en_tst;
			shift_toggle_clk <= shift_toggle_clk(0) & shift_toggle;
			assert shift_en_tst_clk(1) = shift_toggle_clk(1)
				report "Input shift_toggle is not transmit to input port shift_en of the block 'shift_block'"
				severity FAILURE;
        end if;
    end process;

end;

entity ENT00001_Test_Bench is
end ENT00001_Test_Bench;

architecture ARCH00001_Test_Bench of ENT00001_Test_Bench is
    -- Component declaration of the tested unit
    component ENT00001
    port(
        rst : in bit;
        clk : in bit;
        shift_toggle : in bit;
        add_op1 : in bit_vector(3 downto 0);
        add_op2 : in bit_vector(3 downto 0);
        mul_op : in integer;
        result : out bit_vector(3 downto 0) );
    end component;

    -- Stimulus signals - signals mapped to the input and inout ports of tested entity
    signal rst : bit;
    signal clk : bit := '0';
    signal shift_toggle : bit := '0';
    signal add_op1 : bit_vector(3 downto 0);
    signal add_op2 : bit_vector(3 downto 0);
    signal mul_op : integer;
    -- Observed signals - signals mapped to the output ports of tested entity
    signal result : bit_vector(3 downto 0);

    -- Add your code here ...

begin

    -- Unit Under Test port map
    UUT : ENT00001
        port map (
            rst => rst,
            clk => clk,
            shift_toggle => shift_toggle,
            add_op1 => add_op1,
            add_op2 => add_op2,
            mul_op => mul_op,
            result => result
        );

    -- Add your stimulus here ...
    
    process (clk)
    variable init : boolean := true;
    variable done : boolean := false;
    begin
        if init then
            rst <= '1';
            init := false;
        elsif clk'event and clk = '1' then
            if not done then
                done := true;
                rst <= '0';
            end if;
        end if;
    end process;
    
    clk <= not clk after 1 us;
    
    shift_toggle <= not shift_toggle after 20 us;
    
    add_op1 <= x"1";
    add_op2 <= x"2";
    mul_op  <= 2;

end ARCH00001_Test_Bench;

