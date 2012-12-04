package com.prosoft.verilog.ir;

public class VCaseStatement extends VStatement {
	
	ValueSet caseType;
	public VCaseStatement( ValueSet caseType, VOper expr ) {
		this.caseType = caseType;
		setChildAt(0, expr);
	}
	
	public void add( VCaseElement el ) {
		setChildAt(getChildNum(), el);
	}

	@Override
	protected void check(VEnvironment env) {
		if( env.ensureType(VTypeKind.scalar, getChild(0), false) ) {
			VType exprType = getChild(0).getType();
			for( int i = 1; i < getChildNum(); i++ ) {
				VCaseElement el = (VCaseElement) getChild(i);
				el.check(env, exprType);
			}
		}
	}

	@Override
	public VStatementKind getStatementKind() {
		return VStatementKind.CASE;
	}

	public VOper getExpression() {
		return getChild(0);
	}
	
	public int getNumCases() {
		return getChildNum() - 1;
	}
	
	public VCaseElement getCase( int index ) {
		return (VCaseElement) getChild(index+1);
	}

	public ValueSet getCaseType() {
		return caseType;
	}
	
	
}
