package com.prosoft.vhdl.ir;

public interface IObjectElement {

	void setPrimary();
	boolean isPrimary();
	IRObjectClass getObjectClass();
	IRNamedElement getTopmostObject();
	IRNamedElement getTopmostValueableObject();
	IRNamedElement getLocalObject();
}
