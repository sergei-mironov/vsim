package com.prosoft.vhdl.sim;

import com.prosoft.vhdl.ir.IRForStatement;
import com.prosoft.vhdl.ir.IRFunction;
import com.prosoft.vhdl.ir.IRLoopVariable;
import com.prosoft.vhdl.ir.IRStatement;
import com.prosoft.vhdl.ir.IRTypeEnum;
import com.prosoft.vhdl.ir.IRTypeInteger;

public class ForLoopEnvironment extends LoopEnvironment implements Environment {
	
	ScalarVariable var;
	Environment parent;
	int high, low;
	int step;
	int value;

	protected ForLoopEnvironment(Simulator sim, IRForStatement desc, Environment parent) {
		super(sim, desc);
		this.parent = parent;
		IRLoopVariable loopVar = desc.getLoopVariable();
		high = sim.getIntFromDescreteValue(loopVar.getRange().getRangeHigh(), this);
		low = sim.getIntFromDescreteValue(loopVar.getRange().getRangeLow(), this);
		this.var = new ScalarVariable(sim, null, loopVar.getName(), null, loopVar.getType());
		boolean isDownTo = sim.getValue( loopVar.getRange().isDownTo(), this ).getBoolean();
		step = isDownTo ? -1 : 1;
		value = isDownTo ? high : low;
		setValue();
	}
	
	protected void setValue() {
		SimValue v;
		if( var.getType().isEnum() ) {
			v = ((IRTypeEnum)var.getType()).getValue(value).getSimValue().getConstant();
		} else {
			v = IRTypeInteger.createConstant(value).getConstant();
		}
		var.assignValue( v, false );
	}
	
	public void next() {
		value += step;
		setValue();
	}
	
	public boolean hasNext() {
		if( step > 0 ) {
			return value <= high;
		} else {
			return value >= low;
		}
	}
	
	@Override
	public IRForStatement getDescription() {
		return (IRForStatement) description;
	}

	@Override
	public Data resolveData(String name) {
		if( name.equalsIgnoreCase(getDescription().getLoopVariable().getName()) ) return var;
		return parent.resolveData(name);
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

	@Override
	public IRFunction getLastFunction() {
		return parent.getLastFunction();
	}

	@Override
	public SimValue getLastReturn() {
		return parent.getLastReturn();
	}

	@Override
	public void setLastReturn(SimValue value, IRFunction func) {
		parent.setLastReturn(value, func);
	}
}
