package com.prosoft.vhdl.ir;

public class IRArrBound extends IROper {
	
	public enum Bound {
		LOW,
		HIGH,
		LEFT,
		RIGHT,
		IS_DOWN_TO
	}

	Bound bound;

	public IRArrBound( IROper array, Bound isHighBound ) {
		setChild(0, array);
		this.bound = isHighBound;
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.ARRAY_BOUND;
	}

	@Override
	public boolean isEqualTo(IROper other) {
		if( !(other instanceof IRArrBound) ) return false;
		IRArrBound ab = (IRArrBound) other;
		if( bound != ab.bound ) return false;
		return defaultIsEqualTo(other);
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return false;
	}

	public Bound getBound() {
		return bound;
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		// TODO Auto-generated method stub
		if( getChild(0).getType().isArray() ) {
			IRTypeArray arr = (IRTypeArray) getChild(0).getType();
			setType( arr.getIndexes()[0].getIndexType() );
		} else {
			err.arrayExpected(getChild(0));
		}
	}
	
	public String toString() {
		return getChild(0) + "'" + bound;
	}

	@Override
	public IROper dup() {
		IRArrBound res = new IRArrBound(getChild(0).dup(), bound);
		res.setFull(getFull());
		res.setType( getType() );
		return res;
	}
}
