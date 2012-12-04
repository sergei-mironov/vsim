package com.prosoft.vhdl.ir;

public interface IRangedElement {

	/*
	public IROper getRangeLow();
	public IROper getRangeHigh();
	IROper isDownTo();

	public void setRangeLow(IROper rangeLow);
	public void setRangeHigh(IROper rangeHigh);
	public void setDownTo( IROper downTo );
	
	// для случаев, когда нам надо описывать границы лево-право надо выставить leftRight в true
	// при это "лево" соответствует !isDownTo, "право" isDownTo
	public void setLeftRight(boolean leftRight);
	public boolean isLeftRight();
	public IROper isRight();
	
	public boolean isConst();
	
    */
	IROperRange getRange();
	IRangedElement dup();
    // тип диапазона для unconstrained массивов
    IRType getRangeType();

}
