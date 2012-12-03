package com.prosoft.vhdl.ir;

import com.prosoft.vhdl.sim.SimValue;

public class IRTypeStdLogicVector extends IRTypeArray /*implements IRangedElement*/ {
	
	boolean isDownTo;

	public static IRTypeStdLogicVector std_logic_vector( int low, int high, boolean isDownTo)
	{
		IRTypeStdLogicVector res = new IRTypeStdLogicVector("std_logic_vector", false);
//		res.setRangeLow( IRTypeInteger.createConstant(low).getConstant() );
//		res.setRangeHigh( IRTypeInteger.createConstant(high).getConstant() );
//		res.setDownTo( isDownTo );
		return res;
	}
	public static IRTypeStdLogicVector std_ulogic_vector( int low, int high, boolean isDownTo)
	{
		IRTypeStdLogicVector res = new IRTypeStdLogicVector("std_ulogic_vector", true);
//		res.setRangeLow( IRTypeInteger.createConstant(low).getConstant() );
//		res.setRangeHigh( IRTypeInteger.createConstant(high).getConstant() );
//		res.setDownTo( isDownTo );
		return res;
	}
	public static IRTypeStdLogicVector std_logic_vector() {return new IRTypeStdLogicVector("std_logic_vector", false);}
	public static IRTypeStdLogicVector std_ulogic_vector() {return new IRTypeStdLogicVector("std_ulogic_vector", true);}
	
	boolean isUnresolved;

	public IRTypeStdLogicVector(String name, boolean isUnresolved) {
		super(null, name, isUnresolved ? IRTypeStdLogic.std_ulogic : IRTypeStdLogic.std_logic);
		this.isUnresolved = isUnresolved;
	}

//	public SimValue getRangeHigh() {
//		return rangeHigh;
//	}
//
//	public void setRangeHigh(SimValue rangeHigh) {
//		this.rangeHigh = rangeHigh;
//	}
//
//	public SimValue getRangeLow() {
//		return rangeLow;
//	}
//
//	public void setRangeLow(SimValue rangeLow) {
//		this.rangeLow = rangeLow;
//	}
//
//	public boolean isDownTo() {
//		return isDownTo;
//	}
//
//	public void setDownTo(boolean isDownTo) {
//		this.isDownTo = isDownTo;
//	}

	public boolean isUnresolved() {
		return isUnresolved;
	}
	
	@Override
	public IRTypeStdLogicVector dup() {
		IRTypeStdLogicVector res = new IRTypeStdLogicVector(getName(), isUnresolved);
//		res.setDownTo(isDownTo);
//		res.setRangeLow(rangeLow);
//		res.setRangeHigh(rangeHigh);
		return res;
	}

}
