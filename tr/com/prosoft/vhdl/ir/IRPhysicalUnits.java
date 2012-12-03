package com.prosoft.vhdl.ir;

import com.prosoft.vhdl.sim.PhysicalValue;

public class IRPhysicalUnits extends IRNamedElement {
	
	IROper value;
	IRTypePhysical type;

	public IRPhysicalUnits(IRTypePhysical type, String name, IROper value) {
		super(null, name);
		this.type = type;
		this.value = value;
	}

	public IROper getValue() {
		return value;
	}

	public IRTypePhysical getType() {
		return type;
	}

	public PhysicalValue getPhysValue() {
		return (PhysicalValue) ((IRConst)value).getConstant();
	}
}
