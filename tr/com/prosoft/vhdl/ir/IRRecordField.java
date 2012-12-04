package com.prosoft.vhdl.ir;

public class IRRecordField extends IRNamedElement {

	IRType type;
	IRTypeRecord parentType;
	int index;
	
	public IRRecordField(String name, IRType type, IRTypeRecord parentType) {
		super(parentType, name);
		this.type = type;
		this.parentType = parentType;
		parentType.add(this);
	}

	public IRType getType() {
		return type;
	}

	public IRTypeRecord getParentType() {
		return parentType;
	}

	public int getIndex() {
		return index;
	}

}
