package com.prosoft.vhdl.ir;

public class IRArrayIndex extends IRType implements IRangedElement {
	
	/*
	private IROper rangeHigh, rangeLow;
//	Boolean isDownTo = null;
	IROper isDownTo;
	boolean isLeftRight;
	*/
	IRType indexType;
	int indexInArray;
	IRTypeArray arrayType;
	final IROperRange range = new IROperRange();
	
	public IRArrayIndex(IRPackage pack, String name) {
		super(pack, name);
	}
	
//	public IRArrayIndex(IRPackage pack, IROper rangeHigh, IROper rangeLow,
//			boolean isDownTo, IRType indexType) {
//		super(pack, "__array_index");
//		this.rangeHigh = rangeHigh;
//		this.rangeLow = rangeLow;
//		this.isDownTo = isDownTo;
//		this.indexType = indexType;
//	}
	
	public IRArrayIndex(IRPackage pack, String name, IROper rangeHigh, IROper rangeLow,
			IROper isDownTo, IRType indexType) {
		super(pack, name);
		this.getRange().setRangeHigh( rangeHigh );
		this.getRange().setRangeLow( rangeLow );
		this.getRange().setDownTo( isDownTo );
		this.indexType = indexType;
	}
	
	/*
	public IROper getRangeHigh() {
		return rangeHigh;
	}
	public void setRangeHigh(IROper rangeHigh) {
		this.rangeHigh = rangeHigh;
	}
	public IROper getRangeLow() {
		return rangeLow;
	}
	public void setRangeLow(IROper rangeLow) {
		this.rangeLow = rangeLow;
	}
	public IROper isDownTo() {
		return isDownTo;
	}
	public void setDownTo(IROper isDownTo) {
		this.isDownTo = isDownTo;
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
	public IRArrayIndex dup() {
		IRArrayIndex res;
		res = new IRArrayIndex( pack, getName(), getRange().getRangeHigh()!=null?getRange().getRangeHigh().dup():null, 
				getRange().getRangeLow()!=null?getRange().getRangeLow().dup():null, getRange().isDownTo()!=null?getRange().isDownTo().dup():null, indexType.dup() );
		res.indexInArray = indexInArray;
		res.arrayType = arrayType;
        subDup(res);
		return res;
	}

	public int getIndexInArray() {
		return indexInArray;
	}

	public void setIndexInArray(int indexInArray) {
		this.indexInArray = indexInArray;
	}
	
	public boolean IsInt() {
		return getRange().getRangeHigh().getType().isInt() && getRange().getRangeLow().getType().isInt();
	}
	
	public boolean IsEnum() {
		return getRange().getRangeHigh().getType().isEnum() && getRange().getRangeLow().getType().isEnum();
	}

	public IRType getIndexType() {
		return indexType;
	}

	public void setIndexType(IRType indexType) {
		this.indexType = indexType;
		this.setName( indexType.getName() );
	}

	public IRTypeArray getArrayType() {
		return arrayType;
	}

	public void setArrayType(IRTypeArray arrayType) {
		this.arrayType = arrayType;
	}

	public boolean isCompatibleTo( IRArrayIndex other ) {
		if( !indexType.isEqualTo(other.indexType) ) return false;
		if( !isConst() || !other.isConst() ) return true; // невозможно проверить, проверка будет только в ран-тайм
		
		if( IsInt() && other.IsInt() ) {
			int size1 = ((IRConst)getRange().getRangeHigh()).getConstant().getIntValue() - ((IRConst)getRange().getRangeLow()).getConstant().getIntValue();
			int size2 = ((IRConst)other.getRange().getRangeHigh()).getConstant().getIntValue() - ((IRConst)other.getRange().getRangeLow()).getConstant().getIntValue();
			if( Math.abs(size1) != Math.abs(size2) ) return false;
			return true;
		}
		if( IsEnum() && other.IsEnum() ) {
			int size1 = ((IRConst)getRange().getRangeHigh()).getConstant().getEnumValue().getValue() - 
				((IRConst)getRange().getRangeLow()).getConstant().getEnumValue().getValue();
			int size2 = ((IRConst)other.getRange().getRangeHigh()).getConstant().getEnumValue().getValue() - 
				((IRConst)other.getRange().getRangeLow()).getConstant().getEnumValue().getValue();
			if( Math.abs(size1) != Math.abs(size2) ) return false;
			return true;
		}
		return false;
	}
	
	public boolean isEqualTo( IRArrayIndex other ) {
		if( !indexType.isEqualTo(other.indexType) ) return false;
		if( getRange().getRangeHigh() == null && getRange().getRangeLow() == null && other.getRange().getRangeHigh() == null && other.getRange().getRangeLow() == null ) return true;
		if( !getRange().getRangeHigh().isEqualTo(other.getRange().getRangeHigh()) ) return false;
		if( !getRange().getRangeLow().isEqualTo(other.getRange().getRangeLow()) ) return false;
		if( !getRange().isDownTo().isEqualTo(other.getRange().isDownTo()) ) return false;
		return true;
	}

	@Override
	public boolean isAssignableFrom(IRType type) {
		if( type instanceof IRTypeArray ) {
			type = ((IRTypeArray)type).getFirstIndex();
		}
		if( !(type instanceof IRArrayIndex) ) return false;
		return isCompatibleTo((IRArrayIndex) type);
	}

	@Override
	public boolean isEqualTo(IRType type) {
		if( !(type instanceof IRArrayIndex) ) return false;
		return isEqualTo((IRArrayIndex)type);
	}
	
	public boolean isArray() {
		return true;
	}

	
//	@Override
	public boolean isConst() {
		if( !getRange().isRangeOf() ) {
			return getRange().getRangeLow() != null && getRange().getRangeLow().getKind() == IROperKind.CONST 
			&& getRange().getRangeHigh() != null && getRange().getRangeHigh().getKind() == IROperKind.CONST
			&& getRange().isDownTo() != null && getRange().isDownTo().getKind() == IROperKind.CONST;
		} else {
			return false;
		}
	}
	
	
	public int getRangeHighAsInt( IRErrorFactory err ) {
		return IRConst.getIntFromDescreteConst(err, getRange().getRangeHigh(), false);
	}
	
	public int getRangeLowAsInt( IRErrorFactory err ) {
		return IRConst.getIntFromDescreteConst(err, getRange().getRangeLow(), false);
	}
	
	public IRArrayIndex getNextIndex() {
		if( indexInArray + 1  < arrayType.indexes.size() ) {
			return arrayType.indexes.get( indexInArray + 1 );
		}
		return null;
	}
	
	public IRArrayIndex getPreviousIndex() {
		if( indexInArray > 0 ) {
			return arrayType.indexes.get( indexInArray - 1 );
		}
		return null;
	}
	
	public IRType getNextIndexOrElementType() {
		IRType res = getNextIndex();
		if( res != null ) return res;
		return getArrayType().getElementType();
	}
	
	public String toString() {
		if( isConst() ) {
			String range = getRange().isDownTo().getBooleanValue() ? getRange().getRangeHigh() + " downto " + getRange().getRangeLow() : getRange().getRangeLow() + " to " + getRange().getRangeHigh();
			return indexType + "(" + range + ")";
		} else {
			return indexType + "<>";
		}
	}

    public IRType getRangeType() { return indexType; }

	public boolean isDefined() {
		return getRange().getRangeHigh() != null && getRange().getRangeLow() != null;
	}

	@Override
	public IROperRange getRange() {
		return range;
	}
}
