package com.prosoft.vhdl.ir;

public class IRUniqueNamedElement extends IRNamedElement implements IUniqueNamedElement {
	
	String uniqueName;

	public IRUniqueNamedElement(IRElement parent, String name) {
		super(parent, name);
	}

	public String getUniqueName() {
		return uniqueName;
	}

	public void setUniqueName(String uniqueName) {
		this.uniqueName = uniqueName;
	}

}
