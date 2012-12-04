package com.prosoft.vhdl.ir;

import com.prosoft.vhdl.sim.EnumSimValue;

public class IREnumValue extends IRNamedElement {

	int value;
	IRTypeEnum owningType;
	IRTypeEnum rangeType;
	IRConst simValue;
	
	public IREnumValue(String name, int value, IRTypeEnum owningType) {
		super(owningType, name);
		this.value = value;
		this.owningType = owningType;
		rangeType = owningType;// .dup();
        // непонятно, зачем ограниченный rangeType.
        // из-за него у EnumSimValue получается тип, не
        // соответствующий типу enum-а. Более того, он не содержит ни
        // координат ни parent-ов.
		simValue = new IRConst(new EnumSimValue(this));//new EnumSimValue(this);
		//rangeType.setRangeHigh(simValue);
		//rangeType.setRangeLow(simValue);
		owningType.add(this);
	}

	public int getValue() {
		return value;
	}

	public IRTypeEnum getOwningType() {
		return owningType;
	}

	public IRTypeEnum getRangeType() {
		return rangeType;
	}

	public IRConst getSimValue() {
		return simValue;
	}
	
	public String toString() {
		return getName();
	}
}
