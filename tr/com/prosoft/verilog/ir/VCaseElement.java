package com.prosoft.verilog.ir;

public class VCaseElement extends VOper {
	
	public void add( VOper op ) {
		setChildAt(getChildNum(), op);
	}
	
	// если выражения есть - это case, а если нет, т.е. первый child - это statement, - то default
	public boolean isDefault() {
		return getChild(0).getKind() == VOperKind.STATEMENT;
	}

	@Override
	public VOperKind getKind() {
		return VOperKind.CASE_ELEMENT;
	}

	@Override
	protected VType inferTypeInternal(VEnvironment env) {
		throw new RuntimeException();
	}

	public void check(VEnvironment env, VType exprType) {
		for( int i = 0; i < getChildNum(); i++ ) {
			VOper op = getChild(i);
			if( op.getKind() == VOperKind.STATEMENT ) {
				VStatement stat = (VStatement) op;
				stat.check(env);
			} else {
				op.inferType(env);
			}
		}
	}

	public int getNumCases() {
		int res = 0;
		for( int i = 0; i < getChildNum(); i++ ) {
			VOper op = getChild(i);
			if( op.getKind() == VOperKind.STATEMENT ) break;
			res++;
		}
		return res;
	}
	
	public VOper getCase(int index) {
		return getChild(index);
	}
	
	public VStatement getStatement() {
		return (VStatement) getChild(getNumCases());
	}
}
