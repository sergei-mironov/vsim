package com.prosoft.verilog.ir;

import java.util.ArrayList;

public class VInitialOrAlways extends VNamedElement {

	VStatement statement;
	boolean isAlways;
	
	VEnvironment env;
	
	public VInitialOrAlways(VModule owner, String name, VStatement statement, boolean isAlways) {
		super(name);
		this.statement = statement;
		this.isAlways = isAlways;
		env = new VEnvironment(owner.getEnvironment(), owner.getEnvironment().err);
	}

	public void check(VEnvironment env) {
		if( statement.control != null ) {
			statement.control.inferType(env);
		}
		statement.check(env);
	}

	@Override
	public VNamedElementKind getElementKind() {
		return VNamedElementKind.INIT_OR_ALWAYS;
	}

	@Override
	public VEnvironment getEnvironment() {
		return env;
	}

	@Override
	public VType getType() {
		throw new RuntimeException();
	}

	public VStatement getStatement() {
		return statement;
	}

	public boolean isAlways() {
		return isAlways;
	}

	public VEnvironment getEnv() {
		return env;
	}

	public void getAllReads(ArrayList<VOper> list) {
		statement.getAccessedObjects(new ArrayList<VOper>(), list, false);
	}
	
	
	
	
	
	
	
	
	
	
}
