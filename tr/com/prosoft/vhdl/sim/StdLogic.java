package com.prosoft.vhdl.sim;

public class StdLogic {

	/*
    TYPE std_ulogic IS ( 
    		'U',  -- Uninitialized
            'X',  -- Forcing  Unknown
            '0',  -- Forcing  0
            '1',  -- Forcing  1
            'Z',  -- High Impedance   
            'W',  -- Weak     Unknown
            'L',  -- Weak     0       
            'H',  -- Weak     1       
            '-'   -- Don't care
          );
    */
	
	public final int value;
	
	protected StdLogic( int value ) {
		this.value = value;
	}
    
	public StdLogic() {
		this.value = Z_VAL;
	}
	
    public static final byte U_VAL = 0;
    public static final byte X_VAL = 1;
    public static final byte ZERO_VAL = 2;
    public static final byte ONE_VAL = 3;
    public static final byte Z_VAL = 4;
    public static final byte W_VAL = 5;
    public static final byte L_VAL = 6;
    public static final byte H_VAL = 7;
    public static final byte MINUS_VAL = 8;
    
    public static final StdLogic U = new StdLogic(U_VAL);
    public static final StdLogic X = new StdLogic(X_VAL);
    public static final StdLogic ZERO = new StdLogic(ZERO_VAL);
    public static final StdLogic ONE = new StdLogic(ONE_VAL);
    public static final StdLogic Z = new StdLogic(Z_VAL);
    public static final StdLogic W = new StdLogic(W_VAL);
    public static final StdLogic L = new StdLogic(L_VAL);
    public static final StdLogic H = new StdLogic(H_VAL);
    public static final StdLogic MINUS = new StdLogic(MINUS_VAL);
    
    public static final StdLogic[] valuesArray = new StdLogic[] { U, X, ZERO, ONE, Z, W, L, H, MINUS };
    
    public static StdLogic fromChar( int ch ) {
    	ch = Character.toUpperCase( ch );
    	switch( ch ) {
    	case 'U': return U;
    	case 'X': return X;
    	case '0': return ZERO;
    	case '1': return ONE;
    	case 'Z': return Z;
    	case 'W': return W;
    	case 'L': return L;
    	case 'H': return H;
    	case '-': return MINUS;
    	default: throw new RuntimeException();
    	}
    }
    
    public static StdLogic fromInt( int value ) {
    	return valuesArray[value];
    }
    
    public static final int[][] resolutionTable = { 
	    {    U_VAL,    U_VAL,    U_VAL,    U_VAL,    U_VAL,    U_VAL,    U_VAL,    U_VAL,    U_VAL },
	    {    U_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL },
	    {    U_VAL,    X_VAL,    ZERO_VAL, X_VAL, ZERO_VAL, ZERO_VAL, ZERO_VAL, ZERO_VAL,    X_VAL },
	    {    U_VAL,    X_VAL,    X_VAL,  ONE_VAL,  ONE_VAL,  ONE_VAL,  ONE_VAL,  ONE_VAL,    X_VAL },
	    {    U_VAL,    X_VAL, ZERO_VAL,  ONE_VAL,    Z_VAL,    W_VAL,    L_VAL,    H_VAL,    X_VAL },
	    {    U_VAL,    X_VAL, ZERO_VAL,  ONE_VAL,    W_VAL,    W_VAL,    W_VAL,    W_VAL,    X_VAL },
	    {    U_VAL,    X_VAL, ZERO_VAL,  ONE_VAL,    L_VAL,    W_VAL,    L_VAL,    W_VAL,    X_VAL },
	    {    U_VAL,    X_VAL, ZERO_VAL,  ONE_VAL,    H_VAL,    W_VAL,    W_VAL,    H_VAL,    X_VAL },
	    {    U_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL }
	};
    public static int resolve( int stdligic1, int stdlogic2 ) {
    	int res = resolutionTable[stdligic1][stdlogic2];
    	if( res == X_VAL || res == U_VAL || res == MINUS_VAL ) {
    		res++;
    		res--;
    	}
		return res;
//    	return resolutionTable[stdligic1][stdlogic2];
    }
    
    public static StdLogic resolve( StdLogic val1, StdLogic val2 ) {
    	return valuesArray[resolve(val1.value, val2.value)];
    }

    
    /*
    -- truth table for "and" function
    CONSTANT and_table : stdlogic_table := (
    --      ----------------------------------------------------
    --      |  U    X    0    1    Z    W    L    H    -         |   |  
    --      ----------------------------------------------------
            ( 'U', 'U', '0', 'U', 'U', 'U', '0', 'U', 'U' ),  -- | U |
            ( 'U', 'X', '0', 'X', 'X', 'X', '0', 'X', 'X' ),  -- | X |
            ( '0', '0', '0', '0', '0', '0', '0', '0', '0' ),  -- | 0 |
            ( 'U', 'X', '0', '1', 'X', 'X', '0', '1', 'X' ),  -- | 1 |
            ( 'U', 'X', '0', 'X', 'X', 'X', '0', 'X', 'X' ),  -- | Z |
            ( 'U', 'X', '0', 'X', 'X', 'X', '0', 'X', 'X' ),  -- | W |
            ( '0', '0', '0', '0', '0', '0', '0', '0', '0' ),  -- | L |
            ( 'U', 'X', '0', '1', 'X', 'X', '0', '1', 'X' ),  -- | H |
            ( 'U', 'X', '0', 'X', 'X', 'X', '0', 'X', 'X' )   -- | - |
    );
    */
    public static final int[][] andTruthTable = {
	    {    U_VAL,    U_VAL, ZERO_VAL,    U_VAL,    U_VAL,    U_VAL, ZERO_VAL,    U_VAL,    U_VAL },
	    {    U_VAL,    X_VAL, ZERO_VAL,    X_VAL,    X_VAL,    X_VAL, ZERO_VAL,    X_VAL,    X_VAL },
	    { ZERO_VAL, ZERO_VAL, ZERO_VAL, ZERO_VAL, ZERO_VAL, ZERO_VAL, ZERO_VAL, ZERO_VAL, ZERO_VAL },
	    {    U_VAL,    X_VAL, ZERO_VAL,  ONE_VAL,    X_VAL,    X_VAL, ZERO_VAL,  ONE_VAL,    X_VAL },
	    {    U_VAL,    X_VAL, ZERO_VAL,    X_VAL,    X_VAL,    X_VAL, ZERO_VAL,    X_VAL,    X_VAL },
	    {    U_VAL,    X_VAL, ZERO_VAL,    X_VAL,    X_VAL,    X_VAL, ZERO_VAL,    X_VAL,    X_VAL },
	    { ZERO_VAL, ZERO_VAL, ZERO_VAL, ZERO_VAL, ZERO_VAL, ZERO_VAL, ZERO_VAL, ZERO_VAL, ZERO_VAL },
	    {    U_VAL,    X_VAL, ZERO_VAL,  ONE_VAL,    X_VAL,    X_VAL, ZERO_VAL,  ONE_VAL,    X_VAL },
	    {    U_VAL,    X_VAL, ZERO_VAL,    X_VAL,    X_VAL,    X_VAL, ZERO_VAL,    X_VAL,    X_VAL }
    };
    public static StdLogic and( StdLogic stdlogic1, StdLogic stdlogic2 ) {
    	return valuesArray[andTruthTable[stdlogic1.value][stdlogic2.value]];
    }
    public static StdLogic and( int stdlogic1, StdLogic stdlogic2 ) {
    	return valuesArray[andTruthTable[stdlogic1 != 0 ? ONE_VAL : ZERO_VAL][stdlogic2.value]];
    }
    public static StdLogic and( StdLogic stdlogic1, int stdlogic2 ) {
    	return valuesArray[andTruthTable[stdlogic1.value][stdlogic2 != 0 ? ONE_VAL : ZERO_VAL]];
    }

    
    /*
    -- truth table for "or" function
    CONSTANT or_table : stdlogic_table := (
    --      ----------------------------------------------------
    --      |  U    X    0    1    Z    W    L    H    -         |   |  
    --      ----------------------------------------------------
            ( 'U', 'U', 'U', '1', 'U', 'U', 'U', '1', 'U' ),  -- | U |
            ( 'U', 'X', 'X', '1', 'X', 'X', 'X', '1', 'X' ),  -- | X |
            ( 'U', 'X', '0', '1', 'X', 'X', '0', '1', 'X' ),  -- | 0 |
            ( '1', '1', '1', '1', '1', '1', '1', '1', '1' ),  -- | 1 |
            ( 'U', 'X', 'X', '1', 'X', 'X', 'X', '1', 'X' ),  -- | Z |
            ( 'U', 'X', 'X', '1', 'X', 'X', 'X', '1', 'X' ),  -- | W |
            ( 'U', 'X', '0', '1', 'X', 'X', '0', '1', 'X' ),  -- | L |
            ( '1', '1', '1', '1', '1', '1', '1', '1', '1' ),  -- | H |
            ( 'U', 'X', 'X', '1', 'X', 'X', 'X', '1', 'X' )   -- | - |
    );
    */
    public static final int[][] orTruthTable = {
	    {    U_VAL,    U_VAL,    U_VAL,  ONE_VAL,    U_VAL,    U_VAL,    U_VAL,  ONE_VAL,    U_VAL },
	    {    U_VAL,    X_VAL,    X_VAL,  ONE_VAL,    X_VAL,    X_VAL,    X_VAL,  ONE_VAL,    X_VAL },
	    {    U_VAL,    X_VAL, ZERO_VAL,  ONE_VAL,    X_VAL,    X_VAL, ZERO_VAL,  ONE_VAL,    X_VAL },
	    {  ONE_VAL,  ONE_VAL,  ONE_VAL,  ONE_VAL,  ONE_VAL,  ONE_VAL,  ONE_VAL,  ONE_VAL,  ONE_VAL },
	    {    U_VAL,    X_VAL,    X_VAL,  ONE_VAL,    X_VAL,    X_VAL,    X_VAL,  ONE_VAL,    X_VAL },
	    {    U_VAL,    X_VAL,    X_VAL,  ONE_VAL,    X_VAL,    X_VAL,    X_VAL,  ONE_VAL,    X_VAL },
	    {    U_VAL,    X_VAL, ZERO_VAL,  ONE_VAL,    X_VAL,    X_VAL, ZERO_VAL,  ONE_VAL,    X_VAL },
	    {  ONE_VAL,  ONE_VAL,  ONE_VAL,  ONE_VAL,  ONE_VAL,  ONE_VAL,  ONE_VAL,  ONE_VAL,  ONE_VAL },
	    {    U_VAL,    X_VAL,    X_VAL,  ONE_VAL,    X_VAL,    X_VAL,    X_VAL,  ONE_VAL,    X_VAL }
    };
    public static StdLogic or( StdLogic stdlogic1, StdLogic stdlogic2 ) {
    	return valuesArray[orTruthTable[stdlogic1.value][stdlogic2.value]];
    }
    public static StdLogic or( int stdlogic1, StdLogic stdlogic2 ) {
    	return valuesArray[orTruthTable[stdlogic1 != 0 ? ONE_VAL : ZERO_VAL][stdlogic2.value]];
    }
    public static StdLogic or( StdLogic stdlogic1, int stdlogic2 ) {
    	return valuesArray[orTruthTable[stdlogic1.value][stdlogic2 != 0 ? ONE_VAL : ZERO_VAL]];
    }
    
    
    
    
    /*
    -- truth table for "xor" function
    CONSTANT xor_table : stdlogic_table := (
    --      ----------------------------------------------------
    --      |  U    X    0    1    Z    W    L    H    -         |   |  
    --      ----------------------------------------------------
            ( 'U', 'U', 'U', 'U', 'U', 'U', 'U', 'U', 'U' ),  -- | U |
            ( 'U', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X' ),  -- | X |
            ( 'U', 'X', '0', '1', 'X', 'X', '0', '1', 'X' ),  -- | 0 |
            ( 'U', 'X', '1', '0', 'X', 'X', '1', '0', 'X' ),  -- | 1 |
            ( 'U', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X' ),  -- | Z |
            ( 'U', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X' ),  -- | W |
            ( 'U', 'X', '0', '1', 'X', 'X', '0', '1', 'X' ),  -- | L |
            ( 'U', 'X', '1', '0', 'X', 'X', '1', '0', 'X' ),  -- | H |
            ( 'U', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X' )   -- | - |
    );
    */
    public static final int[][] xorTruthTable = {
	    {    U_VAL,    U_VAL,    U_VAL,    U_VAL,    U_VAL,    U_VAL,    U_VAL,    U_VAL,    U_VAL },
	    {    U_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL },
	    {    U_VAL,    X_VAL, ZERO_VAL,  ONE_VAL,    X_VAL,    X_VAL, ZERO_VAL,  ONE_VAL,    X_VAL },
	    {    U_VAL,    X_VAL,  ONE_VAL, ZERO_VAL,    X_VAL,    X_VAL,  ONE_VAL, ZERO_VAL,    X_VAL },
	    {    U_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL },
	    {    U_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL },
	    {    U_VAL,    X_VAL, ZERO_VAL,  ONE_VAL,    X_VAL,    X_VAL, ZERO_VAL,  ONE_VAL,    X_VAL },
	    {    U_VAL,    X_VAL,  ONE_VAL, ZERO_VAL,    X_VAL,    X_VAL,  ONE_VAL, ZERO_VAL,    X_VAL },
	    {    U_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL,    X_VAL }
    };
    public static StdLogic xor( StdLogic stdlogic1, StdLogic stdlogic2 ) {
    	return valuesArray[xorTruthTable[stdlogic1.value][stdlogic2.value]];
    }
    public static StdLogic xor( int stdlogic1, StdLogic stdlogic2 ) {
    	return valuesArray[xorTruthTable[stdlogic1 != 0 ? ONE_VAL : ZERO_VAL][stdlogic2.value]];
    }
    public static StdLogic xor( StdLogic stdlogic1, int stdlogic2 ) {
    	return valuesArray[xorTruthTable[stdlogic1.value][stdlogic2 != 0 ? ONE_VAL : ZERO_VAL]];
    }

    
    
    
    
    
	/*
    -- truth table for "not" function
    CONSTANT not_table: stdlogic_1d := 
    --  -------------------------------------------------
    --  |   U    X    0    1    Z    W    L    H    -   |
    --  -------------------------------------------------
         ( 'U', 'X', '1', '0', 'X', 'X', '1', '0', 'X' );
    */ 
    public static final int[] notTruthTable = {
           U_VAL,    X_VAL,  ONE_VAL, ZERO_VAL,    X_VAL,    X_VAL,  ONE_VAL, ZERO_VAL,    X_VAL
    };
    public static int not( int stdlogic ) {
    	return notTruthTable[stdlogic];
    }
    public static StdLogic not( StdLogic stdlogic ) {
    	return valuesArray[notTruthTable[stdlogic.value]];
    }
    public static boolean not( boolean b ) {
    	return !b;
    }
    
    public String toString() {
    	switch(value) {
    	case U_VAL:
    		return "StdLogic.U"; 
    	case X_VAL:
    		return "StdLogic.X"; 
    	case ZERO_VAL:
    		return "StdLogic.ZERO"; 
    	case ONE_VAL:
    		return "StdLogic.ONE"; 
    	case Z_VAL:
    		return "StdLogic.Z"; 
    	case W_VAL:
    		return "StdLogic.W"; 
    	case L_VAL:
    		return "StdLogic.L"; 
    	case H_VAL:
    		return "StdLogic.H"; 
    	case MINUS_VAL:
    		return "StdLogic.MINUS";
    	default: throw new RuntimeException();
    	}
    }
}
