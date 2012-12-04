package com.prosoft.vhdl.ir;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.util.IROperVisitor;

public class IRExitStatement extends IRStatement {
	
	String label;
	IROper condition;

	public IRExitStatement(String label) {
		super();
		this.label = label;
	}
	
	public void setCondition(IROper condition) {
		this.condition = condition;
		condition.setParent(this);
	}

	@Override
	public void visitStatement(IROperVisitor visitor) {
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

	@Override
	public IROper dup() {
		IRExitStatement res = new IRExitStatement(label);
		res.setCondition(condition);
		res.dupChildrenAndCoordAndType(this);
		return res;
	}

	@Override
	public void getAccessedObjects(ArrayList<IROper> write, ArrayList<IROper> read) {
		condition.getAccessedObjects(write, read, false);
	}

}
