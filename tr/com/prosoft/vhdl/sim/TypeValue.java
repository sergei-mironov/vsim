package com.prosoft.vhdl.sim;

import com.prosoft.vhdl.ir.IREnumValue;
import com.prosoft.vhdl.ir.IRType;
import com.prosoft.vhdl.ir.IRTypeType;

public class TypeValue extends SimValue {
	
	IRType value;

	public TypeValue(IRType value) {
		super(new IRTypeType(value.getPackage()));
		this.value = value;
	}

	@Override
	public void assignFrom(SimValue otherValue) {
		throw new RuntimeException();
	}

	@Override
	public double getDoubleValue() {
		throw new RuntimeException();
	}

	@Override
	public IREnumValue getEnumValue() {
		throw new RuntimeException();
	}

	@Override
	public int getIntValue() {
		throw new RuntimeException();
	}

	@Override
	public StdLogic getStdLogicValue() {
		throw new RuntimeException();
	}

	@Override
	public boolean isEqualTo(SimValue otherValue) {
		throw new RuntimeException();
	}

	public IRType getValue() {
		return value;
	}
	
	public String toString() {
		return type.toString();
	}
}
