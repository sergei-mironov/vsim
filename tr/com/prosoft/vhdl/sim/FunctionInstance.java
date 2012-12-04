package com.prosoft.vhdl.sim;

import java.util.ArrayList;
import java.util.HashMap;

import com.prosoft.vhdl.ir.IRArrayIndex;
import com.prosoft.vhdl.ir.IRFunction;
import com.prosoft.vhdl.ir.IRParameter;
import com.prosoft.vhdl.ir.IRStatement;
import com.prosoft.vhdl.ir.IRType;
import com.prosoft.vhdl.ir.IRTypeArray;
import com.prosoft.vhdl.ir.IRVariable;

public class FunctionInstance extends SimulationObject implements Environment {
	
	SimValue returnValue;
	
	HashMap<String, Data> variables = new HashMap<String, Data>();

	protected FunctionInstance(Simulator sim, IRFunction desc) {
		super(sim, desc);
	}
	
	public void initialize(SimValue[] args) {
		IRFunction func = getDescription();
		if( func.getCanonicalName().equalsIgnoreCase("MAKE_BINARY(SIGNED)") ) {
			int a = 0;
			a++;
		}
		ArrayList<IRParameter> params = func.getParameters();
		for( int i = 0; i < params.size(); i++ ) {
			IRParameter desc = params.get(i);
			IRType varType;
			if( desc.getType().isArray() ) {
				IRArrayIndex ind = IRTypeArray.getIndex(desc.getType(), sim.err, null);
				if( ind.getRange().getRangeHigh() == null && ind.getRange().getRangeLow() == null ) {
					// если это массив неизвестной длины, то берем тип из параметра
					varType = args[i].getType();
				} else {
					varType = ind;
				}
			} else {
				varType = desc.getType();
			}
			Data var = sim.createData(varType, desc.getName(), null, null, this, false);
			var.assignValue(args[i], false);
			variables.put(desc.getName().toLowerCase(), var);
		}
		ArrayList<IRVariable> vars = func.getVars();
		for( int i = 0; i < vars.size(); i++ ) {
			IRVariable desc = vars.get(i);
			Data var = sim.createData(desc, this);
			variables.put(desc.getName().toLowerCase(), var);
		}
	}
	
	@Override
	public IRFunction getDescription() {
		return (IRFunction) description;
	}

	@Override
	public Data resolveData(String name) {
		return (Data) variables.get(name.toLowerCase());
	}

	public SimValue getReturnValue() {
		return returnValue;
	}

	public void setReturnValue(SimValue returnValue) {
		this.returnValue = returnValue;
	}
	
	public Data[] getData() {
		return variables.values().toArray( new Data[variables.size()] );
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
	
	public String toString() {
		return getDescription().getCanonicalName();
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


