package com.prosoft.vhdl.ir;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.util.IROperVisitor;

public class IRProcedureCall extends IRStatement {
	
	IRFunctionCall call;

	public IRProcedureCall(IRFunctionCall call) {
		this.call = call;
		call.setParent(this);
		call.setProceduresOnly(true);
	}

	@Override
	public void getAccessedObjects(ArrayList<IROper> write,
			ArrayList<IROper> read) {
		call.getAccessedObjects(write, read, false);
	}

	@Override
	public void visitStatement(IROperVisitor visitor) {
		visitor.visit(null, 0, call);
	}

	@Override
	public IROper dup() {
		IRProcedureCall res = new IRProcedureCall(call.dup());
		res.dupChildrenAndCoordAndType(this);
		return res;
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.PROC_CALL;
	}

	public IRFunctionCall getCall() {
		return call;
	}

	@Override
	protected void semanticCheckInternal(IRErrorFactory err) throws CompilerError {
		call.semanticCheck(err);
	}

}
