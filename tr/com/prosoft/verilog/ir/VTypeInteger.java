package com.prosoft.verilog.ir;

public class VTypeInteger extends VType {
	
	public static final int SIZE = 32;
	
	public static final VTypeInteger TYPE = new VTypeInteger();

	public VTypeInteger() {
		super("int");
//		super("integer", VOperRange.range(SIZE-1, 0), true);
	}

	@Override
	public VTypeKind getKind() {
		return VTypeKind.INT;
	}

	@Override
	public long getSize() {
		return SIZE;
	}

}
