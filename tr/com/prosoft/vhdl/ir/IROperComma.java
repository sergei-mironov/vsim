package com.prosoft.vhdl.ir;

public class IROperComma extends IROper {
	
	public IROperComma( IROper left, IROper right ) {
		setChild(0, left);
		setChild(1, right);
	}
	
	public IROper getLeft() {
		return getChild(0);
	}
	
	public IROper getRight() {
		return getChild(1);
	}

	@Override
	public IROper dup() {
		IROperComma res = new IROperComma(getLeft().dup(), getRight().dup());
		res.dupChildrenAndCoordAndType(this);
		return res;
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.COMMA;
	}

	@Override
	public boolean isEqualTo(IROper other) {
		return defaultIsEqualTo(other);
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return true;
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		if( getType() != null ) {
			getLeft().setTypeIfNullAndSemanticCheck(getType(), err);
			getRight().setTypeIfNullAndSemanticCheck(getType(), err);
			if( !getType().isAssignableFrom(getLeft().getType()) ) {
				err.incompatibleTypes(getType(), getLeft().getType(), this);
			}
			if( !getType().isAssignableFrom(getRight().getType()) ) {
				err.incompatibleTypes(getType(), getRight().getType(), this);
			}
		} else {
			getLeft().semanticCheck(err);
			getRight().semanticCheck(err);
			if( getLeft().getType() == null && getRight().getType() != null ) {
				getLeft().setTypeIfNullAndSemanticCheck(getRight().getType(), err);
				setType(getRight().getType());
			} else if( getRight().getType() == null && getLeft().getType() != null ) {
				getRight().setTypeIfNullAndSemanticCheck(getLeft().getType(), err);
				setType(getLeft().getType());
			} else if( getRight().getType() == null && getLeft().getType() == null ) {
				err.cantInferType(this);
			}
		}
	}

}
