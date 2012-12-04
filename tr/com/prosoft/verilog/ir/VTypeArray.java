package com.prosoft.verilog.ir;

public class VTypeArray extends VType {

	VOperRange range;
	VType elementType;
	
	public VTypeArray(String name, VOperRange range, VType elementType) {
		super(name);
		this.range = range;
		this.elementType = elementType;
	}

	@Override	
	public VTypeKind getKind() {
		return VTypeKind.ARRAY;
	}

	@Override
	public long getSize() {
		return elementType.getSize() * range.getSize();
	}

	public VType getElementType() {
		return elementType;
	}

	public VOperRange getRange() {
		return range;
	}
	
	
}
