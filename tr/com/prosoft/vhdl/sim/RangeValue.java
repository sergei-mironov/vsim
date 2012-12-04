package com.prosoft.vhdl.sim;

import com.prosoft.vhdl.ir.IRArrBound;
import com.prosoft.vhdl.ir.IREnumValue;
import com.prosoft.vhdl.ir.IROper;
import com.prosoft.vhdl.ir.IROperRange;
import com.prosoft.vhdl.ir.IRType;
import com.prosoft.vhdl.ir.IRPackage;
import com.prosoft.vhdl.ir.IRTypeRange;
import com.prosoft.vhdl.ir.IRangedElement;

public class RangeValue extends SimValue implements IRangedElement {
	
//	IROper rangeHigh;
//	IROper rangeLow;
//	Boolean isDownTo = null;
//	IROper isDownTo;
private boolean isLeftRight;

	IROperRange range = new IROperRange(null);

//	public RangeValue( IROper rangeLow, boolean isDownTo, IROper rangeHigh ) {
//		super(new IRTypeRange(null));
//		this.rangeHigh = rangeHigh;
//		this.rangeLow = rangeLow;
//		this.isDownTo = isDownTo;
//	}
//
	public RangeValue( IROper rangeLow, IROper isDownTo, IROper rangeHigh ) {
		super(new IRTypeRange(null));
		this.getRange().setRangeHigh( rangeHigh );
		this.getRange().setRangeLow( rangeLow );
		this.getRange().setDownTo( isDownTo );
	}

	@Override
	public void assignFrom(SimValue otherValue) {
		RangeValue other = (RangeValue) otherValue;
		this.getRange().setRangeHigh( other.getRange().getRangeHigh() );
		this.getRange().setRangeLow( other.getRange().getRangeLow() );
		this.getRange().setDownTo( other.getRange().isDownTo() );
	}
	
	@Override
	public double getDoubleValue() {
		throw new RuntimeException();
	}

	@Override
	public IREnumValue getEnumValue() {
		throw new RuntimeException();
	}

	@Override
	public int getIntValue() {
		throw new RuntimeException();
	}

	public boolean isLeftRight() {
		return this.isLeftRight;
	}
//	public IROper isRight() {
//		return isDownTo;
//	}
	public void setLeftRight(boolean leftRight) {
		this.isLeftRight = leftRight;
	}
	
	@Override
	public StdLogic getStdLogicValue() {
		throw new RuntimeException();
	}

	@Override
	public boolean isEqualTo(SimValue otherValue) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public IRangedElement dup() {
		return new RangeValue( getRange().getRangeLow(), getRange().isDownTo(), getRange().getRangeHigh() );
	}

	/*
	@Override
	public IROper getRangeHigh() {
		return rangeHigh;
	}

	@Override
	public IROper getRangeLow() {
		return rangeLow;
	}

	@Override
	public IROper isDownTo() {
		return isDownTo;
	}

	@Override
	public void setDownTo(IROper downTo) {
		this.isDownTo = downTo;
	}

	@Override
	public void setRangeHigh(IROper rangeHigh) {
		this.rangeHigh = rangeHigh;
	}

	@Override
	public void setRangeLow(IROper rangeLow) {
		this.rangeLow = rangeLow;
	}

	@Override
	public boolean isConst() {
		return rangeHigh != null && rangeHigh.isConst() && rangeLow != null && rangeLow.isConst();
	}
	*/

    public IRType getRangeType() { return getType(); }

	@Override
	public IROperRange getRange() {
		return range;
	}

}
