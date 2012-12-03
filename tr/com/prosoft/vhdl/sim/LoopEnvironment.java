package com.prosoft.vhdl.sim;

import com.prosoft.vhdl.ir.IRLoopStatement;

public class LoopEnvironment extends SimulationObject {

	protected LoopEnvironment(Simulator sim, IRLoopStatement desc) {
		super(sim, desc);
	}

	@Override
	public IRLoopStatement getDescription() {
		return (IRLoopStatement) description;
	}
}
