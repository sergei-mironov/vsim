package com.prosoft.vhdl.ir;

public class IRSignalOper extends IROper implements IRPrimaryReader, IObjectElement {
	
	IRSignal signal;

	public IRSignalOper(IRSignal signal) {
		super();
		this.signal = signal;
	}
	
	public IRSignalOper dup() {
		return (IRSignalOper) new IRSignalOper(signal).dupChildrenAndCoordAndType(this);
	}

	public IRSignal getSignal() {
		return signal;
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.SGNL;
	}

	public String toString() {
		return signal.getName();
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		setFixedType(signal.type);
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return false;
	}

	@Override
	public IRPrimary getPrimary() {
		return signal;
	}

	@Override
	public boolean isEqualTo(IROper op) {
		if( op instanceof IRSignalOper ) {
			return ((IRSignalOper)op).signal == signal;
		}
		return false;
	}

	@Override
	public IRObjectClass getObjectClass() {
		return IRObjectClass.SIGNAL;
	}

	boolean isPrimary = false;

	@Override
	public boolean isPrimary() {
		return isPrimary;
	}

	@Override
	public void setPrimary() {
		isPrimary = true;
	}

	@Override
	public IRNamedElement getTopmostObject() {
		return (getParent() instanceof IObjectElement) ? ((IObjectElement)getParent()).getTopmostObject() : getLocalObject();
	}

	@Override
	public IRNamedElement getLocalObject() {
		return signal;
	}

	@Override
	public IRNamedElement getTopmostValueableObject() {
		return signal;
	}
}
