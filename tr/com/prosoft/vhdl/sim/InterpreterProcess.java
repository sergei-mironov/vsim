package com.prosoft.vhdl.sim;

import com.prosoft.common.FullCoord;
import com.prosoft.vhdl.ir.IREmptyStatement;
import com.prosoft.vhdl.ir.IRFunction;
import com.prosoft.vhdl.ir.IRProcess;
import com.prosoft.vhdl.ir.IRStatement;

public class InterpreterProcess extends Process {
	
	protected InterpreterProcess(Simulator sim, IRProcess desc, InterpreterEntity entity) {
		super(sim, entity, desc);
	}
	
	@Override
	public IRProcess getDescription() {
		return (IRProcess) description;
	}
	
//	protected void simulate( IRStatement stat ) {
//		switch( stat.getKind() ) {
//		default:
//			throw new RuntimeException(stat.getKind().toString());
//		}
//	}

	@Override
	protected void simulate() {
		IRStatement stat = getDescription().getStatements();
		lastFunction = null;
		lastReturn = null;
		try {
			sim.simulateStatement(stat, this);
			IRProcess proc = getDescription();
			sim.simulateStatement(new IREmptyStatement(new FullCoord(proc.getEnd(), proc.getEnd())), this);
		} catch (ReturnException e) {
			e.printStackTrace();
		} catch (ExitException e) {
			e.printStackTrace();
		}
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
