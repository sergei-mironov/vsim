package com.prosoft.vhdl.ir;

import java.util.ArrayList;

public class IRTypeArray extends IRType /*implements IRangedElement*/ {
	
	public static IRArrayIndex getIndex( IRType type, int indexOfArrayIndex, IRErrorFactory err, IROper relatedOper ) {
		if( type instanceof IRTypeArray ) {
			return ((IRTypeArray)type).indexes.get(indexOfArrayIndex);
		} else if( type instanceof IRArrayIndex ) {
			return (IRArrayIndex) type;
		} else {
			err.arrayExpected(relatedOper);
			return null;
		}
	}
	
	public static IRArrayIndex getIndex( IRType type, IRErrorFactory err, IROper relatedOper ) {
		if( type instanceof IRTypeArray ) {
			return ((IRTypeArray)type).getFirstIndex();
		} else if( type instanceof IRArrayIndex ) {
			return (IRArrayIndex) type;
		} else {
			err.arrayExpected(relatedOper);
			return null;
		}
	}
	
	public static IRTypeArray getArray( IRType type, IRErrorFactory err, IROper relatedOper ) {
		if( type instanceof IRTypeArray ) {
			return (IRTypeArray) type;
		} else if( type instanceof IRArrayIndex ) {
			return ((IRArrayIndex) type).getArrayType();
		} else {
			err.arrayExpected(relatedOper);
			return null;
		}
	}
	
	IRType elementType;
//	SimValue rangeLow;
//	SimValue rangeHigh;
//	boolean isDownTo;
	
	ArrayList<IRArrayIndex> indexes = new ArrayList<IRArrayIndex>();
	
	public int _currentIndex;

	public IRTypeArray(IRPackage pack, String name, IRType elementType) {
		super(pack, name);
		this.elementType = elementType;
	}
	
	public void add( IRArrayIndex index ) {
		index.setIndexInArray(indexes.size());
		indexes.add(index);
		index.setArrayType(this);
	}
	
	public IRArrayIndex[]  getIndexes() {
		return indexes.toArray( new IRArrayIndex[indexes.size()] );
	}

//	public SimValue getRangeLow() {
//		return rangeLow;
//	}
//
//	public void setRangeLow(SimValue rangeLow) {
//		this.rangeLow = rangeLow;
//	}
//
//	public SimValue getRangeHigh() {
//		return rangeHigh;
//	}
//
//	public void setRangeHigh(SimValue rangeHigh) {
//		this.rangeHigh = rangeHigh;
//	}
//
//	public boolean isDownTo() {
//		return isDownTo;
//	}
//
//	public void setDownTo(boolean isDownTo) {
//		this.isDownTo = isDownTo;
//	}
//
	public IRType getElementType() {
		return elementType;
	}

	@Override
	public boolean isArray() {
		return true;
	}
	
	public void setElementType( IRType elementType ) {
		this.elementType = elementType;
	}
	
	public boolean isMultidimensional() {
		return indexes.size() > 1;
	}

	@Override
	public IRTypeArray dup() {
		IRTypeArray res = new IRTypeArray(pack, getName(), elementType);
//		res.setDownTo(isDownTo);
//		res.setRangeLow(rangeLow);
//		res.setRangeHigh(rangeHigh);
		res.indexes = new ArrayList<IRArrayIndex>();
		for( int i = 0; i < indexes.size(); i++ ) {
			res.add( (IRArrayIndex) indexes.get(i).dup() ); 
		}
        subDup(res);
		return res;
	}

	public String toString() {
		StringBuffer res = new StringBuffer();
		res.append( "ARRAY ( " );
		for( int i = 0; i < indexes.size(); i++ ) {
			res.append(indexes.get(i)+", ");
		}
		res.append( ") OF " + elementType);
		return res.toString();
//		if( isDownTo ) {
//			return "ARRAY ( " + rangeHigh + " downto " + rangeLow + " ) OF " + elementType;
//		} else {
//			return "ARRAY ( " + rangeLow + " to " + rangeHigh + " ) OF " + elementType;
//		}
	}

	@Override
	public boolean isAssignableFrom(IRType type) {
		if( type == null ) {
			int a = 0;
			a++;
		}
		if( !type.isArray() ) return false;
		if( type instanceof IRTypeArray ) {
			IRTypeArray other = (IRTypeArray) type;
			if( !elementType.isAssignableFrom(other.elementType) ) {
                return false;
            }
			if( indexes.size() != other.indexes.size() ) {
				return false;
            }
			for( int i = 0; i < indexes.size(); i++ ) {
				if( !indexes.get(i).getIndexType().
                    isAssignableFrom(other.indexes.get(i).getIndexType()) ) {
                //if( !indexes.get(i).isCompatibleTo(other.indexes.get(i)) ) return false;
                // совместимость проверяется в интерпретаторе с учетом динамических типов
                // здесь проверяется только возможность присвоения
                    return false;
                }
			}
	//		if( Math.abs(rangeHigh.getIntValue()-rangeLow.getIntValue()) != 
	//			Math.abs(other.rangeHigh.getIntValue()-other.rangeLow.getIntValue()) ) 
	//			return false;
				
			return true;
		} else {
			IRArrayIndex index = (IRArrayIndex) type;
			if( indexes.size() != 1 ) {
				throw new RuntimeException("TODO");
			}
			return indexes.get(0).isAssignableFrom(index);
		}
	}

	@Override
	public boolean isEqualTo(IRType type) {
		if( !type.isArray() ) return false;
		IRTypeArray other = (IRTypeArray) type;
		if( !elementType.isEqualTo(other.elementType) ) return false;
		for( int i = 0; i < indexes.size(); i++ ) {
			if( !indexes.get(i).isEqualTo(other.indexes.get(i)) ) return false;
		}
//		if( isDownTo != other.isDownTo) return false;
//		if( rangeHigh.getIntValue() != other.rangeHigh.getIntValue() ) return false;
//		if( rangeLow.getIntValue() != other.rangeLow.getIntValue() ) return false;
		return true;
	}
	
	public IRArrayIndex getFirstIndex() {
		if( indexes.size() == 0 ) {
			throw new RuntimeException();
		}
		return indexes.get(0);
	}
	
	public IRArrayIndex getLastIndex() {
		return indexes.get(indexes.size()-1);
	}
}
