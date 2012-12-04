package com.prosoft.verilog.ir;

public class VTypeVector extends VType {
	
	public static final VTypeVector singleBit = new VTypeVector(VOperRange.zeroToZero, false);

	VOperRange range;
	boolean isSigned;
	
	public VTypeVector(VOperRange range, boolean isSigned) {
		super("vector");//range.getSize()>1?"vector":"logic");
		this.range = range;
		this.isSigned = isSigned;
	}

	protected VTypeVector(String name, VOperRange range, boolean isSigned) {
		super(name);
		this.range = range;
		this.isSigned = isSigned;
	}

	@Override
	public VTypeKind getKind() {
		return VTypeKind.VECTOR;
	}

	public VOperRange getRange() {
		return range;
	}

	public boolean isSigned() {
		return isSigned;
	}

	@Override
	public long getSize() {
		return range.getSize();
	}
	
	
	
}
