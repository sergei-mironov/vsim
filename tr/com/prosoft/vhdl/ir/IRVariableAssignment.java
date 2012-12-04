package com.prosoft.vhdl.ir;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.util.IROperVisitor;

public class IRVariableAssignment extends IRStatement {
	
//	IROper target;
//	IROper value;
	
	public IRVariableAssignment(IROper target, IROper value) {
		super();
//		this.target = target;
//		this.value = value;
		setChild(0, target);
		setChild(1, value);
	}
	
	protected IRVariableAssignment() {}
	
	public IRVariableAssignment dup() {
		return (IRVariableAssignment) new IRVariableAssignment().dupChildrenAndCoordAndType(this);
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.VAR_ASGN;
	}

	@Override
	public void visitStatement(IROperVisitor visitor) {
		getChild(0).visit(visitor);
		getChild(1).visit(visitor);
	}

	@Override
	protected void semanticCheckInternal(IRErrorFactory err) throws CompilerError {
		if( getChild(0) instanceof IRVarOper && ((IRVarOper)getChild(0)).variable.getName().equalsIgnoreCase("correct") ) {
			int a = 0;
			a++;
		}
		// TODO нормальную проверку типов
		getChild(0).semanticCheck(err);
		IRType t1 = getChild(0).getType();
		setType( t1 );
		
		getChild(1).setDefinedType(t1);
			
		getChild(1).semanticCheck(err);
		IRType t2 = getChild(1).getType();
		if( t1 == null && t2 != null ) {
			getChild(0).setTypeIfNullAndSemanticCheck(t2, err);
			t1 = getChild(0).getType();
		}
		if( t1 == null || t2 == null ) return;
		if( !t1.isAssignableFrom( t2 ) ) {
			err.incompatibleTypes(t1, t2, getChild(1));
			t1.isAssignableFrom(t2);
			return;
		}
		getChild(0).checkWrite(IRObjectClass.VARIABLE, err);
		/*
		ArrayList<IROper> written = new ArrayList<IROper>();
		ArrayList<IROper> read = new ArrayList<IROper>();
		getChild(0).getAccessedObjects(written, read, true);
		VariableChecker ch = new VariableChecker(err);
		for( IROper op : written ) {
			op.visit(ch);
		}
		*/
	}
	
	@Override
	protected boolean requiresValuesAtChildren() {
		return true;
	}

	public String toString() {
		return getChild(0) + ":=" + getChild(1);
	}

	@Override
	public void getAccessedObjects(ArrayList<IROper> write,	ArrayList<IROper> read) {
		getChild(0).getAccessedObjects(write, read, true);
		getChild(1).getAccessedObjects(write, read, false);
	}

}
