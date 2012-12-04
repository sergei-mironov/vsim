package com.prosoft.vhdl.sim;

import com.prosoft.vhdl.ir.IREnumValue;
import com.prosoft.vhdl.ir.IRTypeStdLogic;

public class StdLogicValue extends SimValue {
	
	StdLogic value = StdLogic.U;
	
	public StdLogicValue(IRTypeStdLogic type, StdLogic value) {
		super(type);
		this.value = value;
	}

	@Override
	public StdLogic getStdLogicValue() {
		return value;
	}

	@Override
	public boolean isEqualTo(SimValue otherValue) {
		return value == otherValue.getStdLogicValue();
	}

	@Override
	public int getIntValue() {
		throw new RuntimeException();
	}

	@Override
	public void assignFrom(SimValue otherValue) {
		this.value = otherValue.getStdLogicValue();
	}

	@Override
	public double getDoubleValue() {
		throw new RuntimeException();
	}
	
	@Override
	public IREnumValue getEnumValue() {
		throw new RuntimeException();
	}

	public String toString() {
		return value.toString();
	}
}
