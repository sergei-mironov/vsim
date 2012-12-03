package com.prosoft.vhdl.sim;

import com.prosoft.vhdl.ir.IRFunction;
import com.prosoft.vhdl.ir.IRStatement;
import com.prosoft.vhdl.ir.IRTypeEnum;

public class ClockGenerator extends Entity {
	
	class GenEvent extends Event {
		
		boolean isRising;

		protected GenEvent(Simulator sim) {
			super(sim);
		}

		@Override
		public void simulate() {
			this.time.time += cycle/2;
			sim.addEvent(this);
			isRising = this.time.time%cycle == 0;
			sim.assignSignal(clk, std_logic.getValue(isRising ? "'1'" : "'0'").getSimValue().getConstant(), null);
		}
		
		public String toString() {
			return "Clock Generator: " + (isRising ? "rising" : "falling");
		}
		
	}
	
	long cycle;
	ScalarSignal clk;
	IRTypeEnum std_logic;
	GenEvent event;

	public ClockGenerator(Simulator sim, String name, long cycle, IRTypeEnum std_logic) {
		super(sim, name, null);
		this.cycle = cycle;
		this.std_logic = std_logic;
		clk = new ScalarSignal(sim, null, "clk", null, std_logic);
		add(clk);
		event = new GenEvent(sim);
		sim.addEvent(event);
	}

	@Override
	public Data resolveData(String name) {
		return null;
	}

	IRStatement currentStatement;
	@Override
	public IRStatement getCurrentStatement() {
		return currentStatement;
	}
	@Override
	public void setCurrentStatement(IRStatement stat) {
		this.currentStatement = stat;
	}
	
	IRFunction lastFunction;
	SimValue lastReturn;
	@Override
	public IRFunction getLastFunction() {
		return lastFunction;
	}
	@Override
	public SimValue getLastReturn() {
		return lastReturn;
	}
	@Override
	public void setLastReturn(SimValue value, IRFunction func) {
		lastReturn = value;
		lastFunction = func;
	}
}
