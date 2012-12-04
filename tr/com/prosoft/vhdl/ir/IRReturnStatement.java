package com.prosoft.vhdl.ir;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.util.IROperVisitor;

public class IRReturnStatement extends IRStatement {
	
	IRSubProgram subprogram;
	
	public IRReturnStatement( IRSubProgram subprogram, IROper expr ) {
		setChild(0, expr);
		this.subprogram = subprogram;
		if( expr != null ) {
			expr.setParent(this);
		}
	}
	
	public IRReturnStatement(IRSubProgram subprogram) {
		this.subprogram = subprogram;
	}
	
	public IRReturnStatement dup() {
		return (IRReturnStatement) new IRReturnStatement(subprogram).dupChildrenAndCoordAndType(this);
	}

	@Override
	public void visitStatement(IROperVisitor visitor) {
		getChild(0).visit(visitor);
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.RETURN;
	}

	@Override
	protected void semanticCheckInternal(IRErrorFactory err) throws CompilerError {
		if( subprogram.getName().equalsIgnoreCase("UNSIGNED_equal") ) {
			int a = 0;
			a++;
		}
		if( getChildNum() > 0 ) {
			setType( ((IRFunction)subprogram).getReturnType() );
			if( getChild(0).getType() == null )
				getChild(0).setType(getType());
			getChild(0).semanticCheck(err);
		}
	}

	@Override
	public void getAccessedObjects(ArrayList<IROper> write,	ArrayList<IROper> read) {
		getChild(0).getAccessedObjects(write, read, false);
	}
}
