package com.prosoft.vhdl.ir;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.util.IROperVisitor;

public abstract class IRStatement extends IROper {
	
	public abstract void visitStatement( IROperVisitor visitor );
	public abstract void getAccessedObjects( ArrayList<IROper> write, ArrayList<IROper> read );
	
	public final void visit( IROperVisitor visitor ) {
		throw new RuntimeException("use visitStatement() instead");
	}

	@Override
	public void getAccessedObjects(ArrayList<IROper> write,	ArrayList<IROper> read, boolean isWriteTarget) {
		throw new RuntimeException("use visitStatement(ArrayList<IROper> write,	ArrayList<IROper> read) instead");
	}
	
	@Override
	protected boolean requiresValuesAtChildren() {
		return false;
	}

	@Override
	public boolean isEqualTo(IROper op) {
		return false;
	}
	@Override
	public final void semanticCheck(IRErrorFactory err) throws CompilerError {
		try {
			semanticCheckInternal(err);
		} catch(CompilerError e){};
	}

	protected abstract void semanticCheckInternal(IRErrorFactory err) throws CompilerError;
	
}
