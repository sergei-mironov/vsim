package com.prosoft.vhdl.sim;

import com.prosoft.vhdl.ir.IREnumValue;
import com.prosoft.vhdl.ir.IRTypeReal;

public class RealValue extends SimValue {

	double value;

	public RealValue(IRTypeReal type, double value) {
		super(type);
		this.value = value;
	}

	@Override
	public StdLogic getStdLogicValue() {
		throw new RuntimeException();
	}

	@Override
	public boolean isEqualTo(SimValue otherValue) {
		return value == otherValue.getDoubleValue();
	}

	@Override
	public int getIntValue() {
		throw new RuntimeException();
	}

	@Override
	public double getDoubleValue() {
		return value;
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
		return Double.toString(value);
	}

}
