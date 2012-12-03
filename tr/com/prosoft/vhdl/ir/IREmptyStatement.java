package com.prosoft.vhdl.ir;

import java.util.ArrayList;

import com.prosoft.common.FullCoord;
import com.prosoft.vhdl.ir.util.IROperVisitor;

public class IREmptyStatement extends IRStatement {
	
	public IREmptyStatement(FullCoord source) {
		setFull(source);
	}
	public IREmptyStatement() {
	}

	@Override
	public void getAccessedObjects(ArrayList<IROper> write,
			ArrayList<IROper> read) {
	}

	@Override
	public void visitStatement(IROperVisitor visitor) {
	}

	@Override
	public IROper dup() {
		return new IREmptyStatement(getFull());
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.EMPTY_STATEMENT;
	}

	@Override
	protected void semanticCheckInternal(IRErrorFactory err) throws CompilerError {
	}

}
