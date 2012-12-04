package com.prosoft.vhdl.gen;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.IRArchitecture;

public class Scope {

	Scope parent;
	ArrayList<Scope> children = new ArrayList<Scope>();
	
	public Scope() {
	}
	
	IRArchitecture arch;
	public Scope(IRArchitecture arch) {
		this.arch = arch;
	}

	void setParent( Scope parent ) {
		this.parent = parent;
	}
	
	void addChild( Scope child ) {
		children.add(child);
	}
	
}
