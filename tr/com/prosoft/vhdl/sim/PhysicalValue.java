package com.prosoft.vhdl.sim;

import com.prosoft.vhdl.ir.IREnumValue;
import com.prosoft.vhdl.ir.IRType;

public class PhysicalValue extends SimValue {
	
	long value;
	String units;
	
	public PhysicalValue(IRType type, long value, String units) {
		super(type);
		this.value = value;
		this.units = units;
	}

	@Override
	public void assignFrom(SimValue otherValue) {
		PhysicalValue other = getPhysicalValue();
		this.value = other.value;
		this.units = other.units;
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
		return (int) value;
	}

	@Override
	public StdLogic getStdLogicValue() {
		throw new RuntimeException();
	}

	public long getValue() {
		return value;
	}

	public String getUnits() {
		return units;
	}

	@Override
	public boolean isEqualTo(SimValue otherValue) {
		if( otherValue instanceof PhysicalValue ) {
			PhysicalValue other = (PhysicalValue) otherValue;
			if( value != other.value ) return false;
			if( (units == null) != (other.units == null) ) return false;
			if( units == null ) {
				return true;
			}
			return units.equalsIgnoreCase(other.units);
		}
		return false;
	}

	public String toString() {
		if( units != null ) {
			return value + " " + units;
		}
		return Long.toString(value);
	}
}
