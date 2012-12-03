package com.prosoft.vhdl.ir;

public class IROperQualify extends IROper {
	
	public IROperQualify(IRType type, IROper expr) {
		setFixedType(type);
		setChild(0, expr);
	}
	
	public IROperQualify dup() {
		IROperQualify res = (IROperQualify) new IROperQualify(getType(), getChild(0).dup()).dupChildrenAndCoordAndType(this);
		res.setFixedType(getFixedType());
		return res;
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.QUALIFY;
	}

	@Override
	public boolean isEqualTo(IROper other) {
		return defaultIsEqualTo(other);
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return false;
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		if( getBegin() != null && getBegin().getLine() == 52 ) {
			int a = 0;
			a++;
		}
		getChild(0).setType( getType() );
		getChild(0).semanticCheck(err);
		if( !getType().isAssignableFrom(getChild(0).getType()) ) err.incompatibleTypes(getType(), getChild(0).getType(), this);
	}

}
