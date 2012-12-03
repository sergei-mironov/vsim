package com.prosoft.vhdl.sim;

import com.prosoft.vhdl.ir.IRSignal;
import com.prosoft.vhdl.ir.IRType;
import com.prosoft.vhdl.ir.IRVariable;

public class AggregateVariable extends AggregateData implements Variable {

	public AggregateVariable(Simulator sim, AggregateData parent, String name, IRVariable desc, IRType type) {
		super(sim, parent, name, desc, type);
	}

}
