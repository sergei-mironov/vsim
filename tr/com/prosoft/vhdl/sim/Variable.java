package com.prosoft.vhdl.sim;

public interface Variable {

	void assignValue( SimValue value, boolean drive );
	SimValue getValue();
}
