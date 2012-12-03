package com.prosoft.vhdl.sim;

import com.prosoft.vhdl.ir.IREnumValue;

public class StringValue extends SimValue {
	
	String value;

	public StringValue(String value) {
		super(null);
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
		if( otherValue instanceof StringValue ) {
			StringValue other = (StringValue) otherValue;
			return value.equalsIgnoreCase(other.value);
		}
		return false;
	}

	public String getValue() {
		return value;
	}

	public String toString() {
		return value;
	}
}
