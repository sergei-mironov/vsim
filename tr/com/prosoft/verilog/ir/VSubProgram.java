package com.prosoft.verilog.ir;

import java.util.ArrayList;

public class VSubProgram extends VNamedElement implements IVarHolder {
	
	boolean isFunction;
	boolean isAutomatic;
	VEnvironment env;
	VModule owner;
	VTypeSubProgram type;
	ArrayList<VSubParameter> params = new ArrayList<VSubParameter>();
	ArrayList<VVariable> vars = new ArrayList<VVariable>();
	VStatement body;

	public VSubProgram(VModule owner, String name, boolean isFunction) {
		super(name);
		env = new VEnvironment(owner.getEnvironment(), owner.getEnvironment().err);
		type = new VTypeSubProgram(this);
		this.isFunction = isFunction;
	}
	
	public void add( VSubParameter param ) {
		params.add(param);
	}

	@Override
	public void add(VVariable var) {
		vars.add(var);
	}

	@Override
	public VEnvironment getEnvironment() {
		return env;
	}

	public boolean isFunction() {
		return isFunction;
	}

	public ArrayList<VSubParameter> getParams() {
		return params;
	}

	@Override
	public VType getType() {
		return type;
	}

	public ArrayList<VVariable> getVars() {
		return vars;
	}

	public VStatement getBody() {
		return body;
	}

	public void setBody(VStatement body) {
		this.body = body;
	}

	public boolean isAutomatic() {
		return isAutomatic;
	}

	public void setAutomatic(boolean isAutomatic) {
		this.isAutomatic = isAutomatic;
	}

	@Override
	public VNamedElementKind getElementKind() {
		return VNamedElementKind.SUBPROGRAM;
	}

}
