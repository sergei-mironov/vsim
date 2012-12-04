package com.prosoft.vhdl.ir;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.util.IROperVisitor;

public class IRReportStatement extends IRStatement {
	
	String label;
	IROper expr, severity;
	
	public IRReportStatement(String label, IROper expr, IROper severity) {
		this.label = label;
		this.expr = expr;
		if( expr != null ) expr.setParent(this);
		this.severity = severity;
		if( severity != null ) severity.setParent(severity);
	}

	@Override
	public void getAccessedObjects(ArrayList<IROper> write,
			ArrayList<IROper> read) {
		if( expr != null ) expr.getAccessedObjects(write, read, false);
		if( severity != null ) severity.getAccessedObjects(write, read, false);
	}

	@Override
	public void visitStatement(IROperVisitor visitor) {
		if( expr != null ) expr.visit(visitor);
		if( severity != null ) severity.visit(visitor);
	}

	@Override
	public IROper dup() {
		IRReportStatement res = new IRReportStatement(label, expr!=null?expr.dup():null, severity!=null?severity.dup():null);
		res.dupChildrenAndCoordAndType(this);
		return res;
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.REPORT;
	}

	public IROper getExpr() {
		return expr;
	}

	public IROper getSeverity() {
		return severity;
	}

	@Override
	protected void semanticCheckInternal(IRErrorFactory err) throws CompilerError {
		if( expr != null ) {
			expr.setTypeIfNullAndSemanticCheck(err.parser.getStringType(), err);
		}
		if( severity != null ) {
			severity.setTypeIfNullAndSemanticCheck(err.parser.getSeverityType(), err);
		}
	}

}
