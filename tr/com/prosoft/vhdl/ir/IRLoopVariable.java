package com.prosoft.vhdl.ir;

public class IRLoopVariable extends IRConstant implements IRangedElement {
	
	/*
	IROper rangeLow;
	IROper rangeHigh;
	IROper isDownTo;
	boolean isLeftRight;
	
	IROper runtimeRange;
	*/
	IROperRange range = new IROperRange();
	
//	String uniqueName;

	public IRLoopVariable(IRStatement stat, String name) {
		super(stat, name, null, null);
	}

//	@Override
	public IRLoopVariable dup() {
		IRLoopVariable res = new IRLoopVariable((IRStatement) getParent(), getName());
		res.setFull(getFull());
		/*
		res.rangeHigh = rangeHigh;
		res.rangeLow = rangeLow;
		res.isDownTo = isDownTo;
		*/
		res.range = range.dup();
		return res;
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
		this.type = rangeHigh.getType();
	}

	@Override
	public void setRangeLow(IROper rangeLow) {
		this.rangeLow = rangeLow;
		this.type = rangeLow.getType();
	}

	public boolean isLeftRight() {
		return this.isLeftRight;
	}
	public IROper isRight() {
		return isDownTo;
	}
	public void setLeftRight(boolean leftRight) {
		this.isLeftRight = leftRight;
	}
	
	public IROper getRuntimeRange() {
		return runtimeRange;
	}

	public void setRuntimeRange(IROper runtimeRange) {
		this.runtimeRange = runtimeRange;
	}

	@Override
	public boolean isConst() {
		return rangeHigh != null && rangeHigh.isConst() && rangeLow != null && rangeLow.isConst();
	}
	*/

	public String toString() {
		return getName();
	}

	@Override
	public String getUniqueName() {
		return uniqueName;
	}

	@Override
	public void setUniqueName(String uniqueName) {
		this.uniqueName = uniqueName;
	}
    public IRType getRangeType() { return getType(); }

	@Override
	public IROperRange getRange() {
		return range;
	}

	@Override
	public IRType getType() {
		if( type == null ) {
			if( getRange().isRangeOf() ) {
				type = IRTypeArray.getIndex(range.getRangeOf().getType(), null, range).indexType; 
			} else if( getRange().getRangeLow() != null && getRange().getRangeLow().getType() != null ) {
				type = getRange().getRangeLow().getType();
			} else if( getRange().getRangeHigh() != null && getRange().getRangeHigh().getType() != null ) {
				type = getRange().getRangeHigh().getType();
			}
		}
		return type;
	}
}
