package com.prosoft.vhdl.sim;

import com.prosoft.vhdl.ir.IREnumValue;
import com.prosoft.vhdl.ir.IRTypeInteger;

public class IntValue extends SimValue {
	
	int value;

	public IntValue(IRTypeInteger type, int value) {
		super(type);
		this.value = value;
	}

	@Override
	public StdLogic getStdLogicValue() {
		throw new RuntimeException();
	}

	@Override
	public boolean isEqualTo(SimValue otherValue) {
		return value == otherValue.getIntValue();
	}

	@Override
	public int getIntValue() {
		return value;
	}

	@Override
	public double getDoubleValue() {
		throw new RuntimeException();
	}
	
	@Override
	public void assignFrom(SimValue otherValue) {
		this.value = otherValue.getIntValue();
	}

	@Override
	public IREnumValue getEnumValue() {
		throw new RuntimeException();
	}

	public String toString() {
		return Integer.toString(value);
	}

	@Override
	public int getIntOrEnumIndex() {
		return value;
	}

}
