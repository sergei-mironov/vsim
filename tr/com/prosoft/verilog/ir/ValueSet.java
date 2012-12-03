package com.prosoft.verilog.ir;

public enum ValueSet {

	X,
	Z,
	ZERO,
	ONE,
	QUESTION;
	
	public String toString() {
		switch(this) {
		case ONE: return "1";
		case Z: return "Z";
		case ZERO: return "0";
		case X: return "X";
		case QUESTION: return "?";
		default: throw new RuntimeException();
		}
	}
	
	public static ValueSet fromChar( char c ) {
		c = Character.toLowerCase(c);
		switch( c ) {
		case '1': return ONE;
		case '0': return ZERO;
		case 'z': return Z;
		case 'x': return X;
		case '?': return QUESTION;
		default : throw new RuntimeException(c+"");
		}
	}
}
