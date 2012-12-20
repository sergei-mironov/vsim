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
-- Categories: entity, architecture, process, type, case, enumerations, scalar-type-attributes.

entity ENT00022_Test_Bench is
end ENT00022_Test_Bench;

architecture ARCH00022_Test_Bench of ENT00022_Test_Bench is

    type IntArray is array (natural range <>) of integer;
    
    type enum is (a_v, b_v, c_v, d_v, e_v, f_v);
    
    type BooleanVector is array (integer range <>) of boolean;
    type StateType is (init, assign, analize, waiting);
    signal state : StateType := init;
    
begin
    
    process (state)
        variable b, b_image : bit;
        variable n : natural;
        variable s2 : string(1 to 2);
        variable s1 : string(1 to 1);
        variable s3, s4, s5 : string (1 to 3);
        variable bva : bit_vector(1 to 4) := x"0";
        variable int : IntArray(1 to 4) := (others => 0);
        type RealArray is array (integer range <>) of real;
        variable ra : RealArray(1 to 4) := (others => 0.0);
        variable bool : BooleanVector(1 to 9) := (others => false);
        
        variable bv2 : bit_vector(7 downto 0) := x"AC";    
        type EnumArray is array (integer range <>) of enum;
        variable ea : EnumArray(1 to 4) := (others => a_v);
        variable e1 : enum := c_v;
        variable e2 : enum := a_v;
        
    begin
        case state is
            when init =>
                s1 := "1";
                s2 := "10";
                s4 := "d_v";
                e1 := c_v;
                b_image := '1';
                state <= assign;
            when assign =>
                b := bit'Value(s1);
                n := natural'Value(s2);
                s3 := bit'image(b_image);
                s5 := enum'image(e1);
                e2 := enum'Value(s4);
                -- bit
                bva(1) := bit'low;
                bva(2) := bit'high;
                bva(3) := bit'left;
                bva(4) := bit'right;
                bool(5) := bit'ascending;
                -- boolean
                bool(1) := boolean'low;
                bool(2) := boolean'high;
                bool(3) := boolean'left;
                bool(4) := boolean'right;
                bool(6) := boolean'ascending;
                -- integer
                int(1) := integer'low;
                int(2) := integer'high;
                int(3) := integer'left;
                int(4) := integer'right;
                bool(7) := integer'ascending;
                -- real
                ra(1) := real'low;
                ra(2) := real'high;
                ra(3) := real'left;
                ra(4) := real'right;
                bool(8) := real'ascending;
                -- enumeration
                bool(9) := enum'ascending;
                ea(1) := enum'low;
                ea(2) := enum'high;
                ea(3) := enum'left;
                ea(4) := enum'right;
                
                state <= analize;
            when analize =>
                state <= waiting;
                -- T'Image
                assert s3 /= "'1'"
                    report "Scalar type attribute T'Image worked with the type Bit correctly"
                    severity NOTE;
                assert s3 = "'1'"
                    report "Scalar type attribute T'Image does not with the type Bit"
                    severity NOTE;
                assert s5 /= "c_v"
                    report "Scalar type attribute T'Image worked with the Enumerations correctly"
                    severity NOTE;
                assert s5 = "c_v"
                    report "Scalar type attribute T'Image does not with the Enumerations"
                    severity NOTE;
                
                -- T'Value
                assert b /= '1'
                    report "Scalar type attribute T'Value worked with the type Bit correctly"
                    severity NOTE;
                assert b = '1'
                    report "Scalar type attribute T'Value does not with the type Bit"
                    severity NOTE;
                assert n /= 10
                    report "Scalar type attribute T'Value worked with the subtype Natural correctly"
                    severity NOTE;
                assert n = 10
                    report "Scalar type attribute T'Value does not with the subtype Natural"
                    severity NOTE;
                assert e2 /= d_v
                    report "Scalar type attribute T'Value worked with the Enumerations correctly"
                    severity NOTE;
                assert e2 = d_v
                    report "Scalar type attribute T'Value does not with the Enumerations"
                    severity NOTE;
            
                -- boolean
                assert bool(1)
                    report "Scalar type attribute T'Low worked with the type Boolean correctly"
                    severity NOTE;
                assert not bool(1)
                    report "Scalar type attribute T'Low does not work with the type Boolean"
                    severity NOTE;
                assert not bool(2)
                    report "Scalar type attribute T'High worked with the type Boolean correctly"
                    severity NOTE;
                assert bool(2)
                    report "Scalar type attribute T'High does not work with the type Boolean"
                    severity NOTE;
                assert bool(3)
                    report "Scalar type attribute T'Left worked with the type Boolean correctly"
                    severity NOTE;
                assert not bool(3)
                    report "Scalar type attribute T'Left does not work with the type Boolean"
                    severity NOTE;
                assert not bool(4)
                    report "Scalar type attribute T'Right worked with the type Boolean correctly"
                    severity NOTE;
                assert bool(4)
                    report "Scalar type attribute T'Right does not work with the type Boolean"
                    severity NOTE;
                -- bit
                assert bva(1) = '1'
                    report "Scalar type attribute T'Low worked with the type Bit correctly"
                    severity NOTE;
                assert bva(1) = '0'
                    report "Scalar type attribute T'Low does not work with the type Bit"
                    severity NOTE;
                assert bva(2) = '0'
                    report "Scalar type attribute T'High worked with the type Bit correctly"
                    severity NOTE;
                assert bva(2) = '1'
                    report "Scalar type attribute T'High does not work with the type Bit"
                    severity NOTE;
                assert bva(3) = '1'
                    report "Scalar type attribute T'Left worked with the type Bit correctly"
                    severity NOTE;
                assert bva(3) = '0'
                    report "Scalar type attribute T'Left does not work with the type Bit"
                    severity NOTE;
                assert bva(4) = '0'
                    report "Scalar type attribute T'Right worked with the type Bit correctly"
                    severity NOTE;
                assert bva(4) = '1'
                    report "Scalar type attribute T'Right does not work with the type Bit"
                    severity NOTE;
                -- integer
--                assert int(1) /= -16#80000000#
                assert int(1) /= -16#7FFFFFFF# - 1
                    report "Scalar type attribute T'Low worked with the type Integer correctly"
                    severity NOTE;
--                assert int(1) = -16#80000000#
                assert int(1) = -16#7FFFFFFF# - 1
                    report "Scalar type attribute T'Low does not work with the type Integer"
                    severity NOTE;
                assert int(2) /= 16#7FFFFFFF#
                    report "Scalar type attribute T'High worked with the type Integer correctly"
                    severity NOTE;
                assert int(2) = 16#7FFFFFFF#
                    report "Scalar type attribute T'High does not work with the type Integer"
                    severity NOTE;
--                assert int(3) /= -16#80000000#
                assert int(3) /= -16#7FFFFFFF# - 1
                    report "Scalar type attribute T'Left worked with the type Integer correctly"
                    severity NOTE;
--                assert int(3) = -16#80000000#
                assert int(3) = -16#7FFFFFFF# - 1
                    report "Scalar type attribute T'Left does not work with the type Integer"
                    severity NOTE;
                assert int(4) /= 16#7FFFFFFF#
                    report "Scalar type attribute T'Right worked with the type Integer correctly"
                    severity NOTE;
                assert int(4) = 16#7FFFFFFF#
                    report "Scalar type attribute T'Right does not work with the type Integer"
                    severity NOTE;
                -- real
--                assert ra(1) /= -1.0e+308
                assert ra(1) /= -1.79769e+308
                    report "Scalar type attribute T'Low worked with the type Real correctly"
                    severity NOTE;
                assert ra(1) = -1.79769e+308
                    report "Scalar type attribute T'Low does not work with the type Real"
                    severity NOTE;
                assert ra(2) /= 1.79769e+308
                    report "Scalar type attribute T'High worked with the type Real correctly"
                    severity NOTE;
                assert ra(2) = 1.79769e+308
                    report "Scalar type attribute T'High does not work with the type Real"
                    severity NOTE;
                assert ra(3) /= -1.79769e+308
                    report "Scalar type attribute T'Left worked with the type Real correctly"
                    severity NOTE;
                assert ra(3) = -1.79769e+308
                    report "Scalar type attribute T'Left does not work with the type Real"
                    severity NOTE;
                assert ra(4) /= 1.79769e+308
                    report "Scalar type attribute T'Right worked with the type Real correctly"
                    severity NOTE;
                assert ra(4) = 1.79769e+308
                    report "Scalar type attribute T'Right does not work with the type Real"
                    severity NOTE;                
                -- enumeration
                assert ea(1) /= a_v
                    report "Scalar type attribute T'Low worked with the Enumerations correctly"
                    severity NOTE;
                assert ea(1) = a_v
                    report "Scalar type attribute T'Low does not work with the Enumerations"
                    severity NOTE;
                assert ea(2) /= f_v
                    report "Scalar type attribute T'High worked with the Enumerations correctly"
                    severity NOTE;
                assert ea(2) = f_v
                    report "Scalar type attribute T'High does not work with the Enumerations"
                    severity NOTE;
                assert ea(3) /= a_v
                    report "Scalar type attribute T'Left worked with the Enumerations correctly"
                    severity NOTE;
                assert ea(3) = a_v
                    report "Scalar type attribute T'Left does not work with the Enumerations"
                    severity NOTE;
                assert ea(4) /= f_v
                    report "Scalar type attribute T'Right worked with the Enumerations correctly"
                    severity NOTE;
                assert ea(4) = f_v
                    report "Scalar type attribute T'Right does not work with the Enumerations"
                    severity NOTE;
                    
                --    ascending
                -- boolean
                assert not bool(6)
                    report "Scalar type attribute T'Ascending worked with the type Boolean correctly"
                    severity NOTE;
                assert bool(6)
                    report "Scalar type attribute T'Ascending does not work with the type Boolean"
                    severity NOTE;
                -- bit
                assert not bool(5)
                    report "Scalar type attribute T'Ascending worked with the type Bit correctly"
                    severity NOTE;
                assert bool(5)
                    report "Scalar type attribute T'Ascending does not work with the type Bit"
                    severity NOTE;
                -- integer
                assert not bool(7)
                    report "Scalar type attribute T'Ascending worked with the type Integer correctly"
                    severity NOTE;
                assert bool(7)
                    report "Scalar type attribute T'Ascending does not work with the type Integer"
                    severity NOTE;
                -- real
                assert not bool(8)
                    report "Scalar type attribute T'Ascending worked with the type Real correctly"
                    severity NOTE;
                assert bool(8)
                    report "Scalar type attribute T'Ascending does not work with the type Real"
                    severity NOTE;
                -- enumeration
                assert not bool(9)
                    report "Scalar type attribute T'Ascending worked with the Enumerations correctly"
                    severity NOTE;
                assert bool(9)
                    report "Scalar type attribute T'Ascending does not work with the Enumerations"
                    severity NOTE;
                
            when waiting =>
                null;
        end case;

        
    end process;

    
end ARCH00022_Test_Bench ;