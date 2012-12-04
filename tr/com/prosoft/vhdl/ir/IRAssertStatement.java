package com.prosoft.vhdl.ir;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.util.IROperVisitor;

public class IRAssertStatement extends IRStatement {

	IROper condition, report, severity;

	public IRAssertStatement(IROper condition, IROper report, IROper severity) {
		condition.setParent(this);
		this.condition = condition;
		if( condition != null ) condition.setParent(this);
		this.report = report;
		if( report != null ) report.setParent(this);
		this.severity = severity;
		if( severity != null ) severity.setParent(this);
	}

	@Override
	public void getAccessedObjects(ArrayList<IROper> write,
			ArrayList<IROper> read) {
		condition.getAccessedObjects(write, read, false);
	}

	@Override
	public void visitStatement(IROperVisitor visitor) {
		condition.visit(visitor);
	}

	@Override
	public IROper dup() {
		IRAssertStatement res = new IRAssertStatement(condition!=null?condition.dup():null, report!=null?report.dup():null, severity!=null?severity.dup():null);
		res.dupChildrenAndCoordAndType(this);
		return res;
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.ASSERT;
	}

	public IROper getCondition() {
		return condition;
	}

	public IROper getReport() {
		return report;
	}

	public IROper getSeverity() {
		return severity;
	}

	@Override
	protected void semanticCheckInternal(IRErrorFactory err) throws CompilerError {
		if( report != null ) {
			if( report.getType() == null ) {
				report.setType(err.parser.getStringType());
			}
			report.semanticCheck(err);
		}
		if( severity != null ) {
			if( severity.getType() == null ) {
				severity.setType(err.parser.getSeverityType());
			}
			severity.semanticCheck(err);
		}
		if( condition.getType() == null ) {
			condition.setType(err.parser.getBoolean());
		}
		condition.semanticCheck(err);
	}
}
