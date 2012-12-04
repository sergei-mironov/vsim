package com.prosoft.verilog.ir;

public class VStatements extends VStatement {

	@Override
	protected void check(VEnvironment env) {
		for( int i = 0; i < getChildNum(); i++ ) {
			getChild(i).check(env);
		}
	}

	@Override
	public VStatementKind getStatementKind() {
		return VStatementKind.STATEMENTS;
	}

	public void add( VStatement stat ) {
		setChildAt(getChildNum(), stat);
	}
	
	public VStatement getChild( int index ) {
		return (VStatement) super.getChild(index);
	}
}
