package com.prosoft.verilog.ir;

import java.util.ArrayList;

public class VOperSlice extends VOper implements IElementOper {
	
	boolean isTop;

	public VOperSlice(VOper array, VOperRange range) {
		super(array, range);
	}

	@Override
	public VOperKind getKind() {
		return VOperKind.SLICE;
	}
	
	public VOper getArray() {
		return getChild(0);
	}
	
	public VOperRange getRange() {
		return (VOperRange) getChild(1);
	}

	@Override
	protected VType inferTypeInternal(VEnvironment env) {
		if( env.ensureType(VTypeKind.arrayOrVector, getArray(), false) ) {
			VOperRange range = getRange();
			if( env.ensureType(VTypeKind.intAndVector, range.getLeft(), true) && env.ensureType(VTypeKind.intAndVector, range.getRight(), true) ) {
				if( getArray().getType().isArray() ) {
					VTypeArray src = (VTypeArray) getArray().getType();
					VTypeArray res = new VTypeArray(src.getName(), range, src.elementType);
					return res;
				} else {
					VTypeVector vec = new VTypeVector(range, ((VTypeVector)getArray().getType()).isSigned );
					return vec;
				}
			}
				
		}
		return null;
	}

	@Override
	protected void getAccessedObjects(ArrayList<VOper> write, ArrayList<VOper> read, boolean isWriteTarget) {
		getArray().getAccessedObjects(write, read, isWriteTarget);
		getRange().getAccessedObjects(write, read, false);
	}

	@Override
	public VNamedElement getElement() {
		return null;
	}

	@Override
	public boolean isTop() {
		return isTop;
	}

	@Override
	public void setIsTop(boolean isTop) {
		this.isTop = isTop;
	}

}
