package com.prosoft.vhdl.ir;

public enum IRObjectClass {

	CONSTANT,
	VARIABLE,
	SIGNAL,
	FILE,
	NONE;
	
	public static final IRObjectClass[] sig_const_file = new IRObjectClass[] { SIGNAL, CONSTANT, FILE };
}
