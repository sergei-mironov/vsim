package com.prosoft.vhdl.ir;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.util.IROperVisitor;

public class IRExitOrNextStatement extends IRStatement {
	
	String label;
	IROper condition;
	boolean isNext;

	public IRExitOrNextStatement(String label, boolean isNext) {
		super();
		this.label = label;
		this.isNext = isNext;
	}
	
	public void setCondition(IROper condition) {
		this.condition = condition;
		condition.setParent(this);
	}

	@Override
	public void visitStatement(IROperVisitor visitor) {
		if( condition != null ) 
			condition.visit(visitor);
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.EXIT;
	}

	@Override
	protected void semanticCheckInternal(IRErrorFactory err) throws CompilerError {
		if( condition != null ) 
			condition.semanticCheck(err);
	}

	public String getLabel() {
		return label;
	}

	public IROper getCondition() {
		return condition;
	}

	public boolean isNext() {
		return isNext;
	}

	@Override
	public IROper dup() {
		IRExitOrNextStatement res = new IRExitOrNextStatement(label, isNext());
		res.setCondition(condition);
		res.dupChildrenAndCoordAndType(this);
		return res;
	}

	@Override
	public void getAccessedObjects(ArrayList<IROper> write, ArrayList<IROper> read) {
		condition.getAccessedObjects(write, read, false);
	}

}
