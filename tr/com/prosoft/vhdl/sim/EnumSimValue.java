package com.prosoft.vhdl.sim;

import com.prosoft.vhdl.ir.IREnumValue;

public class EnumSimValue extends SimValue {
	
	IREnumValue value;

	public EnumSimValue(IREnumValue value) {
		super(value.getOwningType());
		this.value = value;
		type = value.getRangeType();
	}

	@Override
	public int getIntValue() {
		throw new RuntimeException();
	}

	@Override
	public double getDoubleValue() {
		throw new RuntimeException();
	}
	
	@Override
	public StdLogic getStdLogicValue() {
		throw new RuntimeException();
	}

	@Override
	public boolean isEqualTo(SimValue otherValue) {
		return otherValue == this;
	}

	@Override
	public void assignFrom(SimValue otherValue) {
		this.value = otherValue.getEnumValue();
	}

	@Override
	public IREnumValue getEnumValue() {
		return value;
	}

	public String toString() {
		return value.getName();
	}

	@Override
	public int getIntOrEnumIndex() {
		return value.getValue();
	}

	@Override
	public boolean getBoolean() {
		if( type.getName().equalsIgnoreCase("BOOLEAN") ) {
			return value.getValue() > 0;
		}
		throw new RuntimeException();
	}
	
	
}
