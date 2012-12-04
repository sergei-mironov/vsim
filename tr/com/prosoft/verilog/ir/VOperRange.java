package com.prosoft.verilog.ir;

import java.util.ArrayList;

import com.prosoft.verilog.ir.VValue.VValueInteger;
import com.prosoft.vhdl.ir.IROper;

public class VOperRange extends VOper {
	
	public static final VOperRange zeroToZero = new VOperRange(VConst.intZero, VConst.intZero);
	
	public static VOperRange range( long left, long right ) {
		return new VOperRange( new VConst(VValue.integer(left)), new VConst(VValue.integer(right)));
	}

	public VOperRange(VOper left, VOper right) {
		super(left, right);
	}

	@Override
	public VOperKind getKind() {
		return VOperKind.RANGE;
	}
	
	public VOper getLeft() {
		return getChild(0);
	}
	
	public VOper getRight() {
		return getChild(1);
	}
	
	public long getLeftValue() {
		return ((VValueInteger)VConst.getConst(getLeft()).value).value;
	}

	public long getRightValue() {
		return ((VValueInteger)VConst.getConst(getRight()).value).value;
	}
	
	public long getSize() {
		return Math.abs(getLeftValue() - getRightValue()) + 1;
	}
	
	@Override
	protected VType inferTypeInternal(VEnvironment env) {
		// Проверка осуществляется на уровне выше
		return null;
	}

	public boolean isDownTo() {
		return getLeftValue() > getRightValue();
	}

	
}
