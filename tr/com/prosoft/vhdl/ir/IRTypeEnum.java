package com.prosoft.vhdl.ir;

import java.util.ArrayList;

import com.prosoft.vhdl.sim.SimValue;

public class IRTypeEnum extends IRType implements IRangedElement {
	
	ArrayList<IREnumValue> values = new ArrayList<IREnumValue>();
//	boolean isLeftRight;
//	IROper isDownTo;
	final IROperRange range = new IROperRange(); 

	public IRTypeEnum(IRPackage pack, String name) {
		super(pack, name);
//		range.setDownTo(pack.designFile.parser.getBooleanConst(false));
	}

	@Override
	public boolean isEnum() {
		return true;
	}

	void add( IREnumValue value ) {
		if( values.size() == 0 ) {
			range.setRangeLow( value.simValue );
		} else {
			range.setRangeHigh( value.simValue );
		}
		values.add(value);
	}
	
	public int getNumValues() {
		return values.size();
	}
	
	public IREnumValue getValue(int index) {
		return values.get(index);
	}
	
	public IREnumValue getValue(String value) {
		// сначала ищем с учетом case'а
		for( int i = 0; i < values.size(); i++ ) {
			if( values.get(i).getName().equals(value) ) {
				return values.get(i);
			}
		}
		for( int i = 0; i < values.size(); i++ ) {
			if( values.get(i).getName().equalsIgnoreCase(value) ) {
				return values.get(i);
			}
		}
		return null;
	}
	
	public int getValueIndex(IREnumValue value) {
		return values.indexOf(value);
	}

	@Override
	public boolean isAssignableFrom(IRType type) {
		if( !(type instanceof IRTypeEnum) ) return false;
        return getBaseTypeName().equalsIgnoreCase(type.getBaseTypeName());
// 		IRTypeEnum other = (IRTypeEnum) type;
//         System.err.println(values.size() + " " + other.values.size());
// 		if( values.size() < other.values.size() ) return false;
		
// 		int fi = 0; // other может быть подтипом, ищем первый совпадающий элемент
// 		boolean found = false;
// 		while( fi < values.size() ) {
// 			if( values.get(fi) == other.values.get(0) ) {
// 				found = true;
// 				break;
// 			}
// 			fi++;
// 		}
// 		if( !found ) return false;
// 		if( values.size() - other.values.size() < fi ) return false;
// 		for( int i = 0; i < other.values.size(); i++ ) {
// 			if( values.get(fi+i) != other.values.get(i) ) return false;
// 		}
// 		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public IRTypeEnum dup() {
		IRTypeEnum res = new IRTypeEnum(pack, getName());
		res.values = (ArrayList<IREnumValue>) values.clone();
		res.getRange().setRangeHigh(range.getRangeHigh());
		res.getRange().setRangeLow(range.getRangeLow());
		res.getRange().setDownTo(range.isDownTo());
        subDup(res);
		return res;
	}
	
	@Override
	public boolean isEqualTo(IRType type) {
		return getOriginalType() == type.getOriginalType();
	}

	/*
	@Override
	public IROper getRangeHigh() {
		return values.get(values.size()-1).getSimValue();
	}

	@Override
	public IROper getRangeLow() {
		return values.get(0).getSimValue();
	}

	@Override
	public IROper isDownTo() {
		if( isDownTo == null ) {
			IRTypeEnum bool = null;
			bool = (IRTypeEnum) resolve("BOOLEAN");
//			(IRTypeEnum) getPackage().resolve("BOOLEAN");
			isDownTo = bool.getValue(0).getSimValue();
		}
		return isDownTo;
	}

	public boolean isLeftRight() {
		return this.isLeftRight;
	}
	public IROper isRight() {
		return isDownTo();
	}
	public void setLeftRight(boolean leftRight) {
		this.isLeftRight = leftRight;
	}
	
	@Override
	public void setDownTo(IROper downTo) {
		this.isDownTo = downTo;
//		if( downTo.getBooleanValue() ) throw new RuntimeException();
	}

	@Override
	public void setRangeHigh(IROper rangeHigh) {
		IREnumValue v = ((IRConst)rangeHigh).getConstant().getEnumValue();
		for( int i = 0; i < values.size(); i++ ) {
			if( v.getName().equalsIgnoreCase(values.get(i).getName()) ) {
				while( values.size() > i + 1 ) {
					values.remove(i+1);
				}
				return;
			}
		}
		throw new RuntimeException();
	}

	@Override
	public void setRangeLow(IROper rangeLow) {
		IREnumValue v = ((IRConst)rangeLow).getConstant().getEnumValue();
		for( int i = 0; i < values.size(); i++ ) {
			if( v.getName().equalsIgnoreCase(values.get(i).getName()) ) {
				while( --i >= 0 ) {
					values.remove(0);
				}
				return;
			}
		}
		throw new RuntimeException();
	}

	@Override
	public boolean isConst() {
		return true;
	}
	*/
	public IRElement getParent() {
		if( super.getParent() == null && this.subtypedFrom != null ) {
			return subtypedFrom.getParent();
		}
		return super.getParent();
	}

    public IRType getRangeType() { return this; }

	@Override
	public IROperRange getRange() {
		return range;
	}
}
