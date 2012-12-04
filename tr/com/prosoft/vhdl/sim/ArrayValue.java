package com.prosoft.vhdl.sim;

import com.prosoft.vhdl.ir.IREnumValue;
import com.prosoft.vhdl.ir.IRType;

public class ArrayValue extends SimValue {
	
	final SimValue[] value;
	IRType elementType;

	// здесь IRType вместо IRTypeArray потому, что кроме это может еще быть IRArrayIndex
	public ArrayValue(/*IRTypeArray*/IRType type, SimValue[] value, IRType elementType) {
		super(type);
		this.value = value;
		this.elementType = elementType;
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
	public double getDoubleValue() {
		throw new RuntimeException();
	}
	
	@Override
	public boolean isEqualTo(SimValue otherValue) {
		if( !(otherValue instanceof ArrayValue) ) return false;
		ArrayValue ot = (ArrayValue) otherValue;
		// TODO надо сделать полноценное сравнение типов
		if( elementType != ot.elementType || value.length != ot.value.length ) return false;
		for( int i = 0; i < value.length; i++ ) {
			if( !value[i].isEqualTo(ot.value[i]) ) return false;
		}
		return true;
	}

	@Override
	public void assignFrom(SimValue otherValue) {
		ArrayValue v = (ArrayValue) otherValue;
		for( int i = 0; i < value.length; i++ ) {
			value[i].assignFrom(v.value[i]);
		}
	}

	@Override
	public IREnumValue getEnumValue() {
		throw new RuntimeException();
	}

	public String toString() {
		StringBuffer buf = new StringBuffer();
		for( int i = 0; i < value.length; i++ ) {
			buf.append(value[i].toString());
		}
		return buf.toString();
	}
	
	@Override
	public int getNumComponents() {
		return value.length;
	}

	@Override
	public SimValue getComponent(int index) {
		return value[index];
	}
}
