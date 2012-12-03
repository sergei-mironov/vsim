package com.prosoft.verilog.ir;

import java.util.ArrayList;

public class VOperIndex extends VOper implements IElementOper {
	
	boolean isTop;

	public VOperIndex(VOper array, VOper index) {
		super(array, index);
	}

	@Override
	public VOperKind getKind() {
		return VOperKind.INDEX;
	}

	public VOper getArray() {
		return getChild(0);
	}
	
	public VOper getIndex() {
		return getChild(1);
	}

	@Override
	protected VType inferTypeInternal(VEnvironment env) {
		if( env.ensureType(VTypeKind.arrayOrVector, getArray(), false) && env.ensureType(VTypeKind.intAndVector, getIndex(), false) ) {
			if( getArray().getType() instanceof VTypeArray ) {
				VTypeArray arr = (VTypeArray) getArray().getType();
				return arr.elementType;
			} else {
				return VTypeVector.singleBit;
			}
		}
		return null;
	}

	@Override
	protected void getAccessedObjects(ArrayList<VOper> write, ArrayList<VOper> read, boolean isWriteTarget) {
		getArray().getAccessedObjects(write, read, isWriteTarget);
		getIndex().getAccessedObjects(write, read, false);
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
