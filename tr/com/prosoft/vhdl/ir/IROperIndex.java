package com.prosoft.vhdl.ir;

import java.util.ArrayList;

public class IROperIndex extends IROper implements IObjectElement {
	
	public IROperIndex( IROper array, IROper index ) {
        setBegin(array.getBegin());
        setEnd(index.getEnd());
		setChild(0, array);
		setChild(1, index);
		if( index.getBegin() != null && index.getBegin().getFile().endsWith("aggregates.vhd") ) {
			int a = 0;
			a++;
			boolean isRange = index.isRangeOrReverse();
			if( index.getChildNum() <= 0 ) return;
			boolean isArr = index.getChild(0).getType().isArray();
		}
	}
	
	public IROperIndex dup() {
		return (IROperIndex) new IROperIndex(getChild(0).dup(), getChild(1).dup()).dupChildrenAndCoordAndType(this);
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.INDEX;
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return true;
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		getChild(0).semanticCheck(err);
		if( getChild(0).getType() == null ) {
			getChild(0).semanticCheck(err);
			return;
		}
		if( !getChild(0).getType().isArray() ) {
			err.arrayExpected(getChild(0));
			return;
		} else {
			IRType t = getChild(0).getType();
			if( t instanceof IRTypeArray ) {
				t = ((IRTypeArray)t).getFirstIndex();
				if( t == ((IRArrayIndex)t).getArrayType().getLastIndex() ) {
					t = ((IRArrayIndex)t).getArrayType().getElementType();
				}
			} else if( t instanceof IRArrayIndex ) {
				t = ((IRArrayIndex)t).getNextIndex();
				if( t == null || t == ((IRArrayIndex)t).getArrayType().getLastIndex() ) {
					t = ((IRArrayIndex)getChild(0).getType()).getArrayType().getElementType();
				}
			} else {
				throw new RuntimeException();
			}
			setType( t );
			getChild(1).semanticCheck(err);
			if( !getChild(1).getType().isDescrete() ) {
				err.discreteExpected(getChild(1));
				return;
			} else {
				if( getChild(0).getFixedType() != null && getChild(1).getType() != null ) {
					if( getBegin() != null && getBegin().getFile().endsWith("boothmult.vhd") && getBegin().getLine() == 39 ) {
						int a = 0;
						a++;
					}
					setFixedType(getType());
				}
			}
		}
	}

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
	}

	@Override
	public IRObjectClass getObjectClass() {
		return ((IObjectElement)getChild(0)).getObjectClass();
	}
	
	@Override
	public IRNamedElement getTopmostObject() {
		return ((IObjectElement)getChild(0)).getTopmostObject();
	}
	public String toString() {
		return getChild(0) + "[" + getChild(1) + "]";
	}

	@Override
	public boolean isEqualTo(IROper other) {
		return defaultIsEqualTo(other);
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
	public IRNamedElement getLocalObject() {
		return ((IObjectElement)getChild(0)).getLocalObject();
	}

	@Override
	public IRNamedElement getTopmostValueableObject() {
		return ((IObjectElement)getChild(0)).getTopmostValueableObject();
	}

}
