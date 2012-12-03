package com.prosoft.vhdl.sim;

import com.prosoft.vhdl.ir.IRElement;

public class SimulationObject {
	
	Simulator sim;
	IRElement description;
	
	protected SimulationObject( Simulator sim, IRElement desc ) {
		this.sim = sim;
		this.description = desc;
	}

	public IRElement getDescription() {
		return description;
	}
}
