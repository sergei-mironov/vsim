package com.prosoft.vhdl.sim;

import java.util.ArrayList;

import com.prosoft.glue.HDLKind;
import com.prosoft.vhdl.ir.IRArchitecture;
import com.prosoft.vhdl.ir.IRComponentInstance;
import com.prosoft.vhdl.ir.IREntity;
import com.prosoft.vhdl.ir.IRFunction;
import com.prosoft.vhdl.ir.IROper;
import com.prosoft.vhdl.ir.IROperAssoc;
import com.prosoft.vhdl.ir.IRPort;
import com.prosoft.vhdl.ir.IRProcess;
import com.prosoft.vhdl.ir.IRSignal;
import com.prosoft.vhdl.ir.IRStatement;

public class InterpreterEntity extends Entity {

	public InterpreterEntity(Simulator sim, String name, IREntity desc) {
		super(sim, name, desc);
	}

	public void createComponents() {
		IREntity en = getDescription();
		ArrayList<IRPort> ports = en.getPorts();
		for( int i = 0; i < ports.size(); i++ ) {
			IRPort p = ports.get(i);
			Data sig = sim.createData(p, null);
			add(sig);
		}
		IRArchitecture arch = en.getArchitectures()[0];
		ArrayList<IRSignal> sigs = arch.getSignals();
		for( int i = 0; i < sigs.size(); i++ ) {
			IRSignal isig = sigs.get(i);
			Data sig = sim.createData(isig, null);
			add(sig);
		}
		ArrayList<IRComponentInstance> comps = arch.getComponents();
		for( int i = 0; i < comps.size(); i++ ) {
			IRComponentInstance c = comps.get(i);
			if( c.getComponent().getKind() == HDLKind.VHDL ) {
				IREntity chEntity = c.getComponent().getEntity();
				InterpreterEntity chInst = new InterpreterEntity(sim, c.getName(), chEntity);
				chInst.createComponents();
				add(chInst);
			} else {
				System.err.println("No implementation for " + c.getComponent().getEntity().getName());
//				throw new RuntimeException(c.getComponent().getName());
			}
		}
		ArrayList<IRProcess> prs = arch.getProcesses();
		for( int pi = 0; pi < prs.size(); pi++ ) {
			IRProcess pr = prs.get(pi);
			InterpreterProcess proc = new InterpreterProcess(sim, pr, this);
			add(proc);
			ArrayList<IROper> sens = pr.getSensivityList();
			for( int oi = 0; oi < sens.size(); oi++ ) {
				Data[] resolved = sim.resolveSignal(sens.get(oi), this);
				putInSensivityList(proc, resolved);
			}
		}
	}
	
	protected void putInSensivityList( InterpreterProcess proc, Data[] sigs ) {
		for( int i = 0; i < sigs.length; i++ ) {
			Data sig = sigs[i];
			if( sig.isScalar() ) {
				ScalarSignal sc = (ScalarSignal) sig;
				sc.addProcess(proc);
			} else {
				AggregateData agg = (AggregateData) sig;
				putInSensivityList(proc, agg.fields);
			}
		}
	}
	
	public void createWires() {
		IREntity en = getDescription();
		IRArchitecture arch = en.getArchitectures()[0];
		ArrayList<IRComponentInstance> comps = arch.getComponents();
		for( int ci = 0; ci < comps.size(); ci++ ) {
			IRComponentInstance c = comps.get(ci);
			IROper[] op = c.getPortAssociations();
			InterpreterEntity child = (InterpreterEntity) getComponent(c.getName());
			for( int oi = 0; oi < op.length; oi++ ) {
				IROperAssoc ass = (IROperAssoc) op[oi];
				Data[] left = sim.resolveSignal(ass.getChild(0), child);
				Data[] right = sim.resolveSignal(ass.getChild(1), this);
				if( right.length == 0 ) {
					// значит был open
				} else {
					if( left.length != right.length ) {
						throw new RuntimeException();
					}
					for( int wi = 0; wi < left.length; wi++ ) {
						wireSignals( left[wi], right[wi] ); 
					}
				}
			}
		}
	}
	
	@Override
	public Data resolveData(String name) {
		return signals.get(name);
	}
	
//	protected Signal[] resolve( IROper op, Signal cur ) {
//		
//	}

	
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
