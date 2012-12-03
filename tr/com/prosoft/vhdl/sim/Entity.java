package com.prosoft.vhdl.sim;

import java.util.ArrayList;
import java.util.HashMap;

import com.prosoft.vhdl.ir.IRArchitecture;
import com.prosoft.vhdl.ir.IRComponentInstance;
import com.prosoft.vhdl.ir.IREntity;
import com.prosoft.vhdl.ir.IRPort;
import com.prosoft.vhdl.ir.IRSignal;

public abstract class Entity extends SimulationObject implements Environment {
	
	String name;

	protected Entity(Simulator sim, String name, IREntity desc) {
		super(sim, desc);
		this.name = name;
	}

	Process[] debugSet;
	Process[] optimizedSet;
	
	protected HashMap<String, Data> signals = new HashMap<String, Data>();
	protected HashMap<String, Data> variables = new HashMap<String, Data>();
	protected HashMap<String, Entity> components = new HashMap<String, Entity>();
	protected ArrayList<Process> processes = new ArrayList<Process>();
	
	private Process[] currentSet;
	
	protected void add( Process proc ) {
		processes.add(proc);
	}
	
	protected void add( Data sig ) {
		signals.put(sig.name.toLowerCase(), sig);
	}
	
	protected void add( ScalarVariable var ) {
		variables.put( var.getName().toLowerCase(), var);
	}
	
	protected void add( Entity entity ) {
		components.put(entity.getName().toLowerCase(), entity);
	}
	
	public Signal getData(String name) {
		return (Signal) signals.get(name);
	}
	
	protected Variable getVariable(String name) {
		return (Variable) variables.get(name);
	}
	
	protected Entity getComponent(String name) {
		return components.get(name.toLowerCase());
	}
	
	protected void linkSet( Process[] set ) {
		this.currentSet = set;
		for( int pi = 0; pi < currentSet.length; pi++ ) {
			ArrayList<ProcessActivator> acts = currentSet[pi].getActivators();
			for( int ai = 0; ai < acts.size(); ai++ ) {
				acts.get(ai).addProcess(currentSet[pi]);
			}
		}
	}
	
	protected void unlinkCurrentSet() {
		if( currentSet != null ) {
			for( int pi = 0; pi < currentSet.length; pi++ ) {
				ArrayList<ProcessActivator> acts = currentSet[pi].getActivators();
				for( int ai = 0; ai < acts.size(); ai++ ) {
					acts.get(ai).removeProcess(currentSet[pi]);
				}
			}
			currentSet = null;
		}
	}
	
	public void wireSignals( Data left, Data right ) {
//		if( !left.getType().isAssignableFrom(right.getType()) || !right.getType().isAssignableFrom(left.getType()) ) {
//			sim.err.incompatibleTypes(left.getType(), right.getType(), null);
//		}
		if( left instanceof ScalarSignal ) {
			ScalarSignal l = (ScalarSignal) left, r = (ScalarSignal) right;
			Wire w = sim.getWire(l);
			if( w == null ) {
				w = sim.getWire(r);
			}
			if( w == null ) {
				w = new Wire(sim, l.getType());
			}
			w.add(l, false, true);
			w.add(r, false, true);
		} else {
			AggregateData l = (AggregateData) left, r = (AggregateData) right;
			if( l.fields.length != r.fields.length ) throw new RuntimeException();
			for( int i = 0; i < l.fields.length; i++ ) {
				wireSignals(l.fields[i], r.fields[i]);
			}
		}
	}

	@Override
	public IREntity getDescription() {
		return (IREntity) description;
	}
	
	public String getName() {
		return name;
	}

	public String toString() {
		return getName();
	}
	
	public Data[] getData() {
		ArrayList<Data> res = new ArrayList<Data>();
		res.addAll( variables.values() );
		res.addAll( signals.values() );
		return res.toArray( new Data[res.size()] );
	}
}
