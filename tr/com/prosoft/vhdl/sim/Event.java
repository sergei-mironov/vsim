package com.prosoft.vhdl.sim;

public abstract class Event extends SimulationObject {
	
	protected Event(Simulator sim) {
		super(sim, null);
	}

	VTime time = new VTime();

	public VTime getTime() {
		return time;
	}
	
	public abstract void simulate();
}
