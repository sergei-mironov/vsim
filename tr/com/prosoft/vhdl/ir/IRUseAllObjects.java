package com.prosoft.vhdl.ir;

public class IRUseAllObjects extends IRNamedElement {
	
	IRNamedElement useAllAt;

	public IRUseAllObjects(IRNamedElement el) {
		super(el, el.getName());
		useAllAt = el;
	}

	public IRNamedElement getUseAllAt() {
		return useAllAt;
	}

}
