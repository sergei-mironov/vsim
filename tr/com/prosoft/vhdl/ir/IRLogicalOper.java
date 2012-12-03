package com.prosoft.vhdl.ir;

public class IRLogicalOper extends IRBinaryOper {
	
//	IROperKind kind;

	public IRLogicalOper(IROper op1, IROperKind kind, IROper op2, String image) {
		super(op1, kind, op2, image);
	}
	
	public IRLogicalOper dup() {
		IRLogicalOper res = new IRLogicalOper(getChild(0).dup(), getKind(), getChild(1).dup(), image);
		res.dupChildrenAndCoordAndType(this);
		return res;
	}

	@Override
	public IROperKind getKind() {
		return kind;
	}

//	@Override
//	public void semanticCheck(IRErrorFactory err) throws CompilerError {
//		// TODO Сделать нормальное определение типа
//		getChild(0).semanticCheck(err);
//		getChild(1).semanticCheck(err);
//		setType( getChild(0).getType() );
//	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return true;
	}

	@Override
	public boolean isEqualTo(IROper other) {
		return defaultIsEqualTo(other);
	}

	public String toString() {
		return getChild(0) + " " + getKind() + " " + getChild(1);
	}
}
