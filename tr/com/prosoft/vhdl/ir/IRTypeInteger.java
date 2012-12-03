package com.prosoft.vhdl.ir;

import java.math.BigInteger;

import com.prosoft.common.TextCoord;
import com.prosoft.vhdl.sim.IntValue;

public class IRTypeInteger extends IRType implements IRangedElement/*, IRActualRanged*/ {
	
	public static IRTypeInteger TYPE;
	static {
		TYPE = new IRTypeInteger(null, "integer");
		TYPE.locked = true;
	}

    static int minInt = -2147483647; // Integer.MIN_VALUE
    static IRConst rangeMin = new IRConst( new IntValue( (IRTypeInteger) IRTypeInteger.createConstant(minInt).getType(), minInt ) );
	static IRConst rangeMax = new IRConst( new IntValue( (IRTypeInteger) IRTypeInteger.createConstant(Integer.MAX_VALUE).getType(), Integer.MAX_VALUE ) );

	final IROperRange range = new IROperRange();
	/*
	IROper rangeLow;// = rangeMin;
	IROper rangeHigh;// = rangeMax;
	IROper isDownTo;
	boolean isLeftRight;
	*/
	boolean locked;

	public IRTypeInteger(IRPackage pack, String name) {
		super(pack, name);
		range.setParent(this);
	}

	/*
	public IROper getRangeLow() {
		return rangeLow;
	}

	public IROper getRangeHigh() {
		return rangeHigh;
	}

	public IRConst getActualRangeLow() {
		return (IRConst) (rangeLow != null ? rangeLow : rangeMin);
	}

	public IRConst getActualRangeHigh() {
		return (IRConst) (rangeHigh != null ? rangeHigh : rangeMax);
	}

	public void setRangeLow(IROper rangeLow) {
		ensureNotLocked();
		this.rangeLow = rangeLow;
	}

	public void setRangeHigh(IROper rangeHigh) {
		ensureNotLocked();
		this.rangeHigh = rangeHigh;
	}

	@Override
	public void setDownTo(IROper downTo) {
		ensureNotLocked();
		this.isDownTo = downTo;
	}

	public IROper isDownTo() {
		return isDownTo;
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
	*/
	
	@Override
	public boolean isInt() {
		return true;
	}
	
	public static IRConst createConstant( TextCoord coord, String value, IRErrorFactory err ) {
		String orig = value;
		value = value.toLowerCase();
		StringBuffer buf = new StringBuffer(value);
		int underIndex;
		while( (underIndex = buf.indexOf("_") ) >= 0 ) {
			buf.deleteCharAt(underIndex);
		}
		value = buf.toString();
		int expIndex = value.indexOf('e');
		String expStr = null;
		if( expIndex >= 0 ) {
			expStr = value.substring(expIndex+1, value.length());
			value = value.substring(0, expIndex);
		}
		BigInteger iv = new BigInteger(value);
		BigInteger mult = BigInteger.ONE;
		if( expStr != null ) {
			BigInteger exp = new BigInteger(expStr);
			if( exp.compareTo(BigInteger.ZERO) < 0 ) {
				err.valueOutOfRange(coord, value);
			} else {
				mult = BigInteger.TEN.pow(exp.intValue());
			}
		}
		iv = iv.multiply(mult);
		if( iv.compareTo(BigInteger.valueOf(Integer.MAX_VALUE)) > 0 ) {
			err.valueOutOfRange(coord, orig+"("+iv+")");
		}
		return createConstant(iv.intValue());
	}

	public static IRConst createConstant( int value ) {
		IRTypeInteger type = new IRTypeInteger(null, "integer");
		IntValue v = new IntValue( type, value );
		IRConst cnst = new IRConst( v );
		type.getRange().setRangeHigh( cnst );
		type.getRange().setRangeLow( cnst );
		return new IRConst( new IRTypeInteger(null, "integer"), v );
	}

	@Override
	public IRTypeInteger dup() {
		IRTypeInteger res = new IRTypeInteger(pack, getName());
		res.getRange().setDownTo(range.isDownTo());
		res.getRange().setRangeLow(range.getRangeLow());
		res.getRange().setRangeHigh(range.getRangeHigh());
        subDup(res);
        return res;
	}

	@Override
	public boolean isAssignableFrom(IRType type) {
		if( !type.isInt() ) return false;
		IRTypeInteger other = (IRTypeInteger) type;
		if( other.getRange().getRangeHigh() == null && other.getRange().getRangeLow() == null ) return true;
//		if( getActualRangeLow().getConstant().getIntValue() > other.getActualRangeLow().getConstant().getIntValue() 
//				|| getActualRangeHigh().getConstant().getIntValue() < other.getActualRangeHigh().getConstant().getIntValue() )
//			return false;
		
		return true;
	}

	@Override
	public boolean isEqualTo(IRType type) {
		if( !type.isInt() ) return false;
		IRTypeInteger other = (IRTypeInteger) type;
//		if( other.getActualRangeHigh().getConstant().getIntValue() != getActualRangeHigh().getConstant().getIntValue() ) return false;
//		if( other.getActualRangeLow().getConstant().getIntValue() != getActualRangeLow().getConstant().getIntValue() ) return false;
		return true;
	}

//	@Override
//	public boolean isConst() {
//		return rangeLow != null && rangeHigh != null;
//	}
	
	protected void ensureNotLocked() {
		if( locked ) throw new RuntimeException();
	}

	@Override
	public String getBaseTypeName() {
//		if( subtypedFrom != null ) {
//			return subtypedFrom.getBaseTypeName();
//		}
//		if( getName() != null ) {
//			return getName();
//		}
		return "STD.STANDARD.INTEGER";
        // TODO: надо выпилить всякие места, где используется непосредственно
        // тип integer, заменив его на integer из стандартной библиотеки.
        // тогда эта ф-ия будет не нужна, как и аналогичная в IRTypeReal
	}
	
    public IRType getRangeType() { return this; }

	@Override
	public IROperRange getRange() {
		return range;
	}

}
