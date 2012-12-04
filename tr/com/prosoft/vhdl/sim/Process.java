package com.prosoft.vhdl.sim;

import java.util.ArrayList;
import java.util.HashMap;

import com.prosoft.vhdl.ir.IRProcess;
import com.prosoft.vhdl.ir.IRSignal;
import com.prosoft.vhdl.ir.IRVariable;

public abstract class Process extends SimulationObject implements Environment {

	class ActivationEvent extends Event {
		
		protected ActivationEvent(Simulator sim) {
			super(sim);
		}

		@Override
		public void simulate() {
			activated = false;
			//Process.this.simulate();
			sim.executeProcess(Process.this);
		}
		
		public String toString() {
			return "Activate Process \"" + Process.this.getDescription().getName() + "\" at " + this.time;
		}
	}
	
	final ActivationEvent event = new ActivationEvent(sim);
	ArrayList<ProcessActivator> activators = new ArrayList<ProcessActivator>();
	HashMap<String, Data> variables = new HashMap<String, Data>();
	boolean activated;
	
	Entity entity;
	
	protected Process(Simulator sim, Entity entity, IRProcess desc) {
		super(sim, desc);
		this.entity = entity;
		initialize();
	}
	
	protected void initialize() {
		IRProcess pr = getDescription();
		ArrayList<IRVariable> vars = pr.getVars();
		for( int i = 0; i < vars.size(); i++ ) {
			IRVariable desc = vars.get(i);
			Data var = sim.createData(desc, null);
			variables.put(desc.getName().toLowerCase(), var);
		}
	}

	public void activate() {
		if( !activated ) {
			sim.insertEventWithDeltaDelay(event);
			activated = true;
		}
	}
	
	public void add( ProcessActivator act ) {
		activators.add(act);
	}

	protected abstract void simulate();

	public ArrayList<ProcessActivator> getActivators() {
		return activators;
	}
	
	@Override
	public IRProcess getDescription() {
		return (IRProcess) description;
	}

	@Override
	public Data resolveData(String name) {
		Data res = (Data) variables.get(name.toLowerCase());
		if( res != null ) return res;
		return entity.resolveData(name);
	}
	
	public Data[] getData() {
		return variables.values().toArray( new Data[variables.size()] );
	}
	
	public Entity getEntity() {
		return entity;
	}
	
	public String toString() {
		return "Process " + getDescription().getName(); 
	}
}
