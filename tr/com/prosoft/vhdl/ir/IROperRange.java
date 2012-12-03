package com.prosoft.vhdl.ir;

import java.util.ArrayList;


public class IROperRange extends IROper implements IRangedElement, IObjectElement {
	
//	boolean isLeftRight;
	IROper rangeOf;
	boolean isReverseRange;
	IRType rangeType;

//	SimValue rangeLow;
//	SimValue rangeHigh;
//	boolean isDownTo;
	
	// в child'е с индексом 3 хранится isDownTo для совместимости с кодом, 
	// который уже использует 1 и 2-ой child'ы для хранения диапазона 
	
	public IROperRange( IROper src ) {
        if ( src != null ) setBegin(src.getBegin());
		setChild(0, src);
		setChild(1, null);
		setChild(2, null);
		setChild(3, null);
	}
	
	public IROperRange(IROper rangeOf, IRType rangeType, boolean isReverseRange) {
		this.rangeOf = rangeOf;
		this.isReverseRange = isReverseRange;
		this.rangeType = rangeType;
	}
	
	protected IROperRange() {}
	
	public IROperRange dup() {
		IROperRange res = new IROperRange();
		res.dupChildrenAndCoordAndType(this);
		res.rangeOf = rangeOf;
		res.isReverseRange = isReverseRange;
		return res;
	}
	
	public IROperRange( IROper src, IROper rangeLow, IROper isDownTo, IROper rangeHigh ) {
        if ( src != null ) setBegin(src.getBegin());
        if ( src == null && rangeLow != null ) setBegin(rangeLow.getBegin());
        if ( rangeHigh != null ) setEnd(rangeHigh.getEnd());
		setChild(0, src);
		setChild(1, rangeLow);
		setChild(3, isDownTo );
		setChild(2, rangeHigh);
	}
	
	public IROper getRangeOf() {
		return rangeOf;
	}
	
	public boolean isRangeOf() {
		return rangeOf != null;
	}
	
	public void ensureRangeOf() {
		if( !isRangeOf() ) {
			reportError();
		}
	}

	public void ensureNotRangeOf() {
		if( isRangeOf() ) {
			reportError();
		}
	}

	public IROper getRangeLow() {
		ensureNotRangeOf();
		if(getChildNum()<=1) return null;
		return getChild(1);
	}
	public void setRangeLow(IROper rangeLow) {
		ensureNotRangeOf();
        if ( (getChildNum() < 1 || getChild(0) == null) && rangeLow != null ) setBegin(rangeLow.getBegin());
		setChild(1, rangeLow);
	}
	public IROper getRangeHigh() {
		ensureNotRangeOf();
		if(getChildNum()<=2) return null;
		return getChild(2);
	}
	public void setRangeHigh(IROper rangeHigh) {
		ensureNotRangeOf();
        if ( rangeHigh != null ) setEnd(rangeHigh.getEnd());
		setChild(2, rangeHigh);
	}
	public IROper isDownTo() {
		ensureNotRangeOf();
		if(getChildNum()<=3) return null;
		return getChild(3);
	}
	public void setDownTo(IROper isDownTo) {
		ensureNotRangeOf();
		setChild(3, isDownTo);
	}
	
	
//	public IRangedElement getElement() {
//		ensureRangeOf();
//		return rangeOf;
//	}
	
	public boolean isReverseRange() {
		ensureRangeOf();
		return isReverseRange;
	}
	
//	public boolean isRangeOfType() {
//		if( !isRangeOf() ) return false;
//		return rangeOf instanceof IRType;
//	}
	
	/*
	public boolean isLeftRight() {
		return this.isLeftRight;
	}
	public IROper isRight() {
		return isDownTo();
	}
	public void setLeftRight(boolean leftRight) {
		this.isLeftRight = leftRight;
	}
	*/
	
	public void assignFrom( IROperRange other ) {
		rangeOf = other.rangeOf;
		isReverseRange = other.isReverseRange;
		isPrimary = other.isPrimary;
		dupChildrenAndCoordAndType(other);
	}
	
	
	
	public IROper getExpression() {
		ensureNotRangeOf();
		return getChild(0);
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.RANGE;
	}
	
//	@Override
//	public IRangedElement dup() {
//		IROperRange res = new IROperRange( getExpression(), getRangeLow(), isDownTo, getRangeHigh() );
//		return res;
//	}

	@Override
	public void getAccessedObjects(ArrayList<IROper> write,	ArrayList<IROper> read, boolean isWriteTarget) {
		if( isPrimary() ) {
			if( isWriteTarget ) {
				write.add(this);
			} else {
				read.add(this);
			}
		}
		getChild(1).getAccessedObjects(write, read, false);
		getChild(2).getAccessedObjects(write, read, false);
	}

	@Override
	public IRObjectClass getObjectClass() {
		return ((IObjectElement)getChild(0)).getObjectClass();
	}
	
	@Override
	public IRNamedElement getTopmostObject() {
		return ((IObjectElement)getChild(0)).getTopmostObject();
	}
	
	public boolean isConst() {
		return getRange().getRangeLow() != null && getRange().getRangeLow().isConst() 
		&& getRange().getRangeHigh() != null && getRange().getRangeHigh().isConst() 
		&& getRange().isDownTo() != null && getRange().isDownTo().isConst();
	}
	
	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
//		if( getBegin() != null && getBegin().getFile().endsWith("iface.vhd")) {
//			int a = 0;
//			a++;
//		}
//		if( isRangeOf() ) {
//			return;
//		}
		if( getChildNum() > 0 && getChild(0) != null ) {
			getChild(0).semanticCheck(err);
			IRArrayIndex index;
			IRType t = (IRTypeArray) getChild(0).getType();
			if( t.isArray() ) {
				index = ((IRTypeArray)t).getFirstIndex();
			} else if( t instanceof IRArrayIndex ) {
				index = ((IRArrayIndex)t).getNextIndex();
			} else {
				throw new RuntimeException();
			}
	//		IRangedElement arrType = index.;
			index = index.dup();
			
			if( isRangeOf() ) {
				setType(index);
				return;
			}
			
			if( index.getIndexType().isInt() ) {
				
				if( getRangeHigh() == null || !getRangeHigh().isConst() || getRangeLow() == null || !getRangeLow().isConst() ) {
					// диапазон не опереден, выходим ничего не проверяя
	//				t = t.dup();
	//				IRArrayIndex ind = IRTypeArray.getIndex(t, err, this);
	//				ind.setRangeHigh(null);
	//				ind
					index.getRange().setRangeHigh(getRangeHigh());
					index.getRange().setRangeLow(getRangeLow());
					setType( index );
					return;
				}
				
				if( index.getRange().getRangeHigh() == null || index.getRange().getRangeLow() == null || 
						!index.getRange().getRangeHigh().isConst() || !index.getRange().getRangeLow().isConst() || 
						!getRangeHigh().isConst() || !getRangeLow().isConst() ) {
					// массив не с неопределенным диапазоном
	//				index.setRangeHigh(null);
	//				index.setRangeLow(null);
					setType( index );
					return;
				}
				
				// границы массива
				int a_h = index.getRangeHighAsInt(err);
				int a_l = index.getRangeLowAsInt(err);
				
				// границы предполагаемого слайса
				int s_h, s_l;
				if( getRangeHigh() instanceof IRConst ) {
					s_h = ((IRConst)getRangeHigh()).getConstant().getIntValue();
				} else if( getRangeHigh() instanceof IRConstRead ) {
					IRConst cnst = (IRConst) ((IRConstRead)getRangeHigh()).getConstant().getValue();
					s_h = IRConst.getIntFromDescreteConst(err, cnst, false);
				} else throw new RuntimeException();
				
				if( getRangeLow() instanceof IRConst ) {
					s_l = ((IRConst)getRangeLow()).getConstant().getIntValue();
				} else if( getRangeLow() instanceof IRConstRead ) {
					IRConst cnst = (IRConst) ((IRConstRead)getRangeLow()).getConstant().getValue();
					s_l = IRConst.getIntFromDescreteConst(err, cnst, false);
				} else throw new RuntimeException();
				
				if( index.isConst() && ( index.getRange().isDownTo().getBooleanValue() != isDownTo().getBooleanValue() || 
						a_h < s_h || 
						a_l > s_l ) ) {
					// it's not error - it's a null slice
					//err.incorrectRange( this, index );
				}
			} else if( index.getIndexType().isEnum() ) {
				if( index.isConst() && (
						index.getRange().isDownTo().getBooleanValue() != isDownTo().getBooleanValue() ||
						((IRConst)index.getRange().getRangeHigh()).getConstant().getEnumValue().getValue() < 
						((IRConst)getRangeHigh()).getConstant().getEnumValue().getValue() || 
						((IRConst)index.getRange().getRangeLow()).getConstant().getEnumValue().getValue() > 
						((IRConst)getRangeLow()).getConstant().getEnumValue().getValue() )
						) {
					err.incorrectRange( this, index );
				}
			}
			index.getRange().setRangeHigh(getRangeHigh());
			index.getRange().setRangeLow(getRangeLow());
			index.getRange().setDownTo(isDownTo());
			t = t.dup();
			IRangedElement r = (IRangedElement) ((IRTypeArray)t).getFirstIndex();
			r.getRange().setRangeHigh(getRangeHigh());
			r.getRange().setRangeLow(getRangeLow());
			r.getRange().setDownTo(isDownTo());
			setType( t );
		}
	}

	@Override
	public boolean isEqualTo(IROper other) {
		if( !defaultIsEqualTo(other) ) return false;
		return false;
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return false;
	}

	public String toString() {
		String r;
		if( isRangeOf() ) {
			return rangeOf + (isReverseRange ? "'REVERSE_RANGE" : "'RANGE");
		} else {
			if( isDownTo() == null ) return"";
			if( isDownTo().getBooleanValue() ) {
				r = getChild(2) + " downto " + getChild(1);
			} else {
				r = getChild(1) + " to " + getChild(2);
			}
			if( getChild(0) == null ) return "";
			return getChild(0).toString() + "(" + r + ")";
		}
	}

	boolean isPrimary = false;

	@Override
	public boolean isPrimary() {
		return isPrimary;
	}

	@Override
	public void setPrimary() {
		isPrimary = true;
	}
	@Override
	public IROperRange getRange() {
		return this;
	}

    public IRType getRangeType() { return rangeType; }

	@Override
	public IRNamedElement getLocalObject() {
		return ((IObjectElement)getChild(0)).getLocalObject();
	}

	@Override
	public IRNamedElement getTopmostValueableObject() {
		return ((IObjectElement)getChild(0)).getTopmostValueableObject();
	}

	@Override
	public void setParent(IRElement parent) {
		if( rangeOf != null && rangeOf.toString().equalsIgnoreCase("al_s") ) {
			int a = 0;
			a++;
		}
		super.setParent(parent);
	}

}
