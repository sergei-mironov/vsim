package com.prosoft.vhdl.sim;

import com.prosoft.vhdl.ir.IRElement;
import com.prosoft.vhdl.ir.IRSignal;
import com.prosoft.vhdl.ir.IRType;

public abstract class AggregateData extends Data {
	
	Data[] fields;
	boolean isRecord;

	public AggregateData(Simulator sim, AggregateData parent, String name, IRElement desc, IRType type ) {
		super(sim, parent, desc, name, type);
		this.isRecord = type.isRecord();
	}
	
	void setFields( Data[] fields ) {
		this.fields = fields;
	}
	
	public Data[] getFiels() {
		return fields;
	}

	@Override
	public boolean isArray() {
		return !isRecord;
	}

	@Override
	public boolean isRecord() {
		return isRecord;
	}

	@Override
	public boolean isScalar() {
		return false;
	}

}
