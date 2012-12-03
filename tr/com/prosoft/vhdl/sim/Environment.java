package com.prosoft.vhdl.sim;

import com.prosoft.vhdl.ir.IRFunction;
import com.prosoft.vhdl.ir.IRStatement;

public interface Environment {

	public Data resolveData( String name );
	public IRStatement getCurrentStatement();
	public void setCurrentStatement(IRStatement stat);
	public SimValue getLastReturn();
	public IRFunction getLastFunction();
	public void setLastReturn(SimValue value, IRFunction func);
}
