package com.prosoft.vhdl.sim;

import com.prosoft.vhdl.ir.IRSignal;
import com.prosoft.vhdl.ir.IRType;

public class AggregateSignal extends AggregateData implements Signal {

	public AggregateSignal(Simulator sim, AggregateData parent, String name, IRSignal desc, IRType type) {
		super(sim, parent, name, desc, type);
	}

}
