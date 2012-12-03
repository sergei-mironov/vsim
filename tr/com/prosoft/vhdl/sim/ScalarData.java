package com.prosoft.vhdl.sim;

import com.prosoft.vhdl.ir.IRElement;
import com.prosoft.vhdl.ir.IRSignal;
import com.prosoft.vhdl.ir.IRType;

public abstract class ScalarData extends Data {

	protected ScalarData(Simulator sim, AggregateData parent, IRElement desc, String name, IRType type) {
		super(sim, parent, desc, name, type);
	}

	@Override
	public boolean isArray() {
		return false;
	}

	@Override
	public boolean isRecord() {
		return false;
	}

	@Override
	public boolean isScalar() {
		return true;
	}
}
