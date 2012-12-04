package com.prosoft.verilog.ir;

import java.util.HashMap;

public class VNameSpace implements IVNamedSpace {

	VNameSpaceKind kind;
	HashMap<String, VNamedElement> els = new HashMap<String, VNamedElement>();
	
	public VNameSpace(VNameSpaceKind kind) {
		this.kind = kind;
	}

	@Override
	public VNamedElement get(String name) {
		return els.get(name);
	}

	@Override
	public void put(VNamedElement el) {
		if( els.containsKey(el.getName()) ) {
			System.err.println("Redefinition of " + el.getName());
		}
		els.put(el.getName(), el);
	}

	@Override
	public VNameSpaceKind getKind() {
		return kind;
	}
}
