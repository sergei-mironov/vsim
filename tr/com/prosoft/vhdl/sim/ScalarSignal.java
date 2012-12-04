package com.prosoft.vhdl.sim;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.IRSignal;
import com.prosoft.vhdl.ir.IRType;

public class ScalarSignal extends ScalarData implements Signal {
	
	class AssignEvent extends Event {
		
		SimValue newValue;
		boolean activated;

		protected AssignEvent(Simulator sim) {
			super(sim);
		}

		@Override
		public void simulate() {
			activated = false;
			drivenValue = newValue;
			if( wire != null )
				wire.updateDriver(ScalarSignal.this);
			else
				effectiveValue = drivenValue;
		}
		
		protected void activate( SimValue newValue ) {
			this.newValue = newValue;
			if( !activated ) {
				sim.insertEventWithDeltaDelay(this);
				activated = true;
			}
		}
		
		public String toString() {
			return "Assign Signal \"" + name + "\" to " + newValue + " at " + this.time;
		}
	}

	final AssignEvent event = new AssignEvent(sim);
	
	ArrayList<Process> listeners = new ArrayList<Process>();;

	SimValue effectiveValue;
	SimValue drivenValue;
	Wire wire;
	
	public ScalarSignal(Simulator sim, AggregateData parent, String name, IRSignal desc, IRType type ) {
		super(sim, parent, desc, name, type);
	}

	void addProcess( Process process ) {
		listeners.add(process);
	}
	
	void removeProcess( Process process ) {
		listeners.remove(process);
	}
	
	protected void activateListeners() {
		for( int i = 0; i < listeners.size(); i++ ) {
			listeners.get(i).activate();
		}
	}
	
//	public IRType getType() {
//		return type;
//	}
	
	public SimValue getDrivenValue() {
		return drivenValue;
	}
	
	public SimValue getEffectiveValue() {
		return effectiveValue;
	}
	
	void assignAndSendEvent( SimValue value ) {
		if( value == null || drivenValue == null || !value.isEqualTo(drivenValue) ) {
			event.activate(value);
		}
	}
	
	void setWire( Wire wire ) {
		this.wire = wire;
	}
	
	void updateEffectiveValue( SimValue newValue ) {
		if( effectiveValue == null || !effectiveValue.isEqualTo(newValue) ) {
			effectiveValue = newValue;
			activateListeners();
		}
	}

	@Override
	public IRSignal getDescription() {
		return (IRSignal) description;
	}
}
