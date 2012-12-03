package com.prosoft.vhdl.sim;

import com.prosoft.vhdl.ir.IREnumValue;
import com.prosoft.vhdl.ir.IRTypeRecord;

public class RecordValue extends SimValue {
	
	final SimValue[] values;
	IRTypeRecord type;
	
	public RecordValue(SimValue[] values, IRTypeRecord type) {
		super(type);
		this.values = values;
		this.type = type;
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
		// TODO Auto-generated method stub
		throw new RuntimeException();
	}

	@Override
	public void assignFrom(SimValue otherValue) {
		RecordValue v = (RecordValue) otherValue;
		for( int i = 0; i < values.length; i++ ) {
			values[i].assignFrom(v.values[i]);
		}
	}

	@Override
	public IREnumValue getEnumValue() {
		throw new RuntimeException();
	}

//	public SimValue getFieldValue( IRRecordField field ) {
//		return values[field.getIndex()];
//	}
//	
//	public void assignFieldValue( IRRecordField field, SimValue value ) {
//		values[field.getIndex()].assignFrom(value);
//	}
	
	public void setFieldValue( int fieldIndex, SimValue value ) {
		values[fieldIndex].assignFrom(value);
	}
	
	public SimValue getFieldValue( int fieldIndex ) {
		return values[fieldIndex];
	}

	@Override
	public SimValue getComponent(int index) {
		return values[index];
	}

	@Override
	public int getNumComponents() {
		return values.length;
	}
}
