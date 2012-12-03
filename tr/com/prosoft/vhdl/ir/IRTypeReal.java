package com.prosoft.vhdl.ir;

import com.prosoft.vhdl.sim.RealValue;

public class IRTypeReal extends IRType implements IRangedElement/*, IRActualRanged*/ {
	
	static IRConst rangeMin = new IRConst( new RealValue( (IRTypeReal) IRTypeReal.createConstant(Double.MIN_VALUE).getType(), Double.MIN_VALUE ) );
	static IRConst rangeMax = new IRConst( new RealValue( (IRTypeReal) IRTypeReal.createConstant(Double.MAX_VALUE).getType(), Double.MAX_VALUE ) );
	
	public static final IRTypeReal TYPE = new IRTypeReal(null, "real");

	/*
	IRConst rangeLow;// = rangeMin;
	IRConst rangeHigh;// = rangeMax;
	IROper isDownTo;
	private boolean isLeftRight;
	*/
	final IROperRange range = new IROperRange();

	public IRTypeReal(IRPackage pack, String name) {
		super(pack, name);
		range.setParent(this);
	}

	/*
	public IRConst getRangeLow() {
		return rangeLow;
	}

	public IRConst getRangeHigh() {
		return rangeHigh;
	}

	public IRConst getActualRangeLow() {
		return rangeLow != null ? rangeLow : rangeMin;
	}

	public IRConst getActualRangeHigh() {
		return rangeHigh != null ? rangeHigh : rangeMax;
	}

	public void setRangeLow(IROper rangeLow) {
		this.rangeLow = (IRConst) rangeLow;
	}

	public void setRangeHigh(IROper rangeHigh) {
		this.rangeHigh = (IRConst) rangeHigh;
	}

	@Override
	public void setDownTo(IROper downTo) {
		this.isDownTo = downTo;
	}

	public IROper isDownTo() {
		return isDownTo;
	}
	*/
	@Override
	public boolean isReal() {
		return true;
	}
	/*
	public boolean isLeftRight() {
		return this.isLeftRight;
	}
	public IROper isRight() {
		return isDownTo;
	}
	public void setLeftRight(boolean leftRight) {
		this.isLeftRight = leftRight;
	}
	*/
	public static IRConst createConstant( String value ) {
		StringBuffer buf = new StringBuffer(value);
		int index;
		while( (index=buf.indexOf("_")) >= 0 ) {
			buf.replace(index, index+1, "");
		}
		return createConstant( Double.parseDouble(buf.toString()) );
	}

	public static IRConst createConstant( double value ) {
		IRTypeReal type = new IRTypeReal(null, "Real");
		IRConst v = new IRConst( new RealValue( type, value ) );
		type.getRange().setRangeHigh(v);
		type.getRange().setRangeLow(v);
		return v;
	}

	@Override
	public IRTypeReal dup() {
		IRTypeReal res = new IRTypeReal(pack, getName());
		res.getRange().setDownTo(getRange().isDownTo());
		res.getRange().setRangeLow(getRange().getRangeLow());
		res.getRange().setRangeHigh(getRange().getRangeHigh());
        subDup(res);
		return res;
	}

	@Override
	public boolean isAssignableFrom(IRType type) {
		if( type.isReal() ) {
//			IRTypeReal other = (IRTypeReal) type;
//			if( getActualRangeLow().getConstant().getDoubleValue() > other.getActualRangeLow().getConstant().getDoubleValue() 
//					|| getActualRangeHigh().getConstant().getDoubleValue() < other.getActualRangeHigh().getConstant().getDoubleValue() )
//				return false;
			
			return true;
//		} else if( type.isInt() ) {
//			IRTypeInteger other = (IRTypeInteger) type;
//			if( rangeLow.getDoubleValue() > other.getRangeLow().getIntValue() 
//					|| rangeHigh.getDoubleValue() < other.getRangeHigh().getIntValue() )
//				return false;
//			
//			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean isEqualTo(IRType type) {
		return false;
//		if( !type.isReal() ) return false;
//		IRTypeReal other = (IRTypeReal) type;
//		if( getRange().getRangeHigh() == null || getRange().getRangeLow() == null || other.getRange().getRangeHigh() == null || other.getRange().getRangeLow() == null ) return true;
//		if( getRange().getRangeHigh().getConstant().getDoubleValue() != other.getRange().getRangeHigh().getConstant().getDoubleValue() ) return false;
//		if( getRange().getRangeLow().getConstant().getDoubleValue() != other.getRange().getRangeLow().getConstant().getDoubleValue() ) return false;
//		return true;
	}

//	@Override
//	public boolean isConst() {
//		return true;
//	}

	@Override
	public String getBaseTypeName() {
//		if( subtypedFrom != null ) {
//			return subtypedFrom.getBaseTypeName();
//		}
//		if( getName() != null ) {
//			return getName();
//		}
		return "STD.STANDARD.REAL";
        // TODO: надо выпилить всякие места, где используется непосредственно
        // тип integer, заменив его на integer из стандартной библиотеки.
        // тогда эта ф-ия будет не нужна, как и аналогичная в IRTypeReal
	}
	
//	@Override
//	public String getFullName() {
//		return "STD.STANDARD.REAL";
//	}

    public IRType getRangeType() { return this; }

	@Override
	public IROperRange getRange() {
		return range;
	}

}
