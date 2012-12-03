package com.prosoft.vhdl.ir;

public interface IRPrimary {

	boolean isParameter();
	String getName();
	IRType getType();
}
