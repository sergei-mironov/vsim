package com.prosoft.vhdl.ir;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.util.IROperVisitor;

public class IRWaitStatement extends IRStatement implements ISensivityList {
	
	ArrayList<IROper> sensivityList = new ArrayList<IROper>();
	
	String label;
	IROper condition, timeout;
	
	public IRWaitStatement(IRElement parent, String label) {
		setParent(parent);
		this.label = label;
	}

	@Override
	public void getAccessedObjects(ArrayList<IROper> write,
			ArrayList<IROper> read) {
		for( int i = 0; i < sensivityList.size(); i++ ) {
			sensivityList.get(i).getAccessedObjects(write, read, false);
		}
		if( condition != null ) condition.getAccessedObjects(write, read, false);
		if( timeout != null ) timeout.getAccessedObjects(write, read, false);
	}

	@Override
	public void visitStatement(IROperVisitor visitor) {
		for( int i = 0; i < sensivityList.size(); i++ ) {
			sensivityList.get(i).visit(visitor);
		}
		if( condition != null ) condition.visit(visitor);
		if( timeout != null ) timeout.visit(visitor);
	}

	@Override
	public IROper dup() {
		IRWaitStatement res = new IRWaitStatement(getParent(), label);
		for( int i = 0; i < sensivityList.size(); i++ ) {
			res.sensivityList.add( sensivityList.get(i).dup() );
		}
		res.condition = condition!=null?condition.dup():null;
		res.timeout = timeout!=null?timeout.dup():null;
		res.dupChildrenAndCoordAndType(this);
		return res;
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.WAIT;
	}

	@Override
	protected void semanticCheckInternal(IRErrorFactory err) throws CompilerError {
		if( condition != null ) {
			condition.semanticCheck(err);
		}
		if( timeout != null ) {
			timeout.semanticCheck(err);
		}
	}

	@Override
	public void addToSensivityList(IROper sig) {
		sensivityList.add(sig);
	}

	public IROper getCondition() {
		return condition;
	}

	public void setCondition(IROper condition) {
		this.condition = condition;
		condition.setParent(this);
	}

	public IROper getTimeout() {
		return timeout;
	}

	public void setTimeout(IROper timeout) {
		this.timeout = timeout;
		timeout.setParent(this);
	}

	public ArrayList<IROper> getSensivityList() {
		return sensivityList;
	}

	public String getLabel() {
		return label;
	}

}
