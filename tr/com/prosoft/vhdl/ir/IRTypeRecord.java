package com.prosoft.vhdl.ir;

import java.util.ArrayList;

public class IRTypeRecord extends IRType {
	
	ArrayList<IRRecordField> fields = new ArrayList<IRRecordField>();

	public IRTypeRecord(IRPackage pack, String name) {
		super(pack, name);
		if( name.equals("st_rec1") ) {
			int a = 0;
			a++;
		}
	}

	void add( IRRecordField field ) {
		field.index = fields.size();
		fields.add(field);
	}
	
	public IRRecordField getField(String name) {
		for( int i = 0; i < fields.size(); i++ ) {
			if( fields.get(i).getName().equalsIgnoreCase(name) ) {
				return fields.get(i);
			}
		}
		return null;
	}
	
	public int getNumFields() {
		return fields.size();
	}
	
	public IRRecordField getField( int index ) {
		return fields.get(index);
	}

	@Override
	public boolean isRecord() {
		return true;
	}

	@Override
	public IRType dup() {
		IRTypeRecord res = new IRTypeRecord(pack, getName());
		res.fields = fields;
		res.setFull(getFull());
		res.setParent(getParent());
		return res;
	}

	@Override
	public boolean isAssignableFrom(IRType type) {
		if( !type.isRecord() ) return false;
		return isSameBase(type);
//		IRTypeRecord other = (IRTypeRecord) type;
//		return fields == other.fields;
	}

	@Override
	public boolean isEqualTo(IRType type) {
		return getOriginalType() == type.getOriginalType();
	}

	@Override
	public String getFullName() {
		return super.getFullName();
	}

	
	
}
