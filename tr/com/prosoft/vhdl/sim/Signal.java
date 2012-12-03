package com.prosoft.vhdl.sim;

public interface Signal {

	void assignValue( SimValue value, boolean drive );
	SimValue getValue();
}
