package com.prosoft.verilog.ir;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.CompilerError;

public class VModule extends VNamedElement implements IVParamHolder {
	
	ArrayList<VParameter> params = new ArrayList<VParameter>();
	ArrayList<VInitialOrAlways> constructs = new ArrayList<VInitialOrAlways>();
	ArrayList<VModuleInstance> instances = new ArrayList<VModuleInstance>();
	ArrayList<VStatement> concurrent = new ArrayList<VStatement>();
	final VType type;
	final VEnvironment env;

	public VModule(VEnvironment parent, String name) {
		super(name);
		type = new VTypeModule(this);
		env = new VEnvironment(parent, parent.err);
		parent.put(this);
	}
	
	public void addConcurrent( VStatement stat ) {
		concurrent.add(stat);
	}
	
	public void add( VInitialOrAlways constuct ) {
		constructs.add(constuct);
	}
	
	public void add( VModuleInstance inst ) {
		instances.add(inst);
	}

	public void add( VParameter param ) {
		params.add(param);
	}

	@Override
	public VType getType() {
		return type;
	}

	@Override
	public VEnvironment getEnvironment() {
		return env;
	}
	
	public ArrayList<VInitialOrAlways> getConstructs() {
		return constructs;
	}

	public ArrayList<VModuleInstance> getInstances() {
		return instances;
	}

	public ArrayList<VStatement> getConcurrent() {
		return concurrent;
	}

	public void check() throws CompilerError {
		env.semanticCheck();
		for( int i = 0; i < constructs.size(); i++ ) {
			constructs.get(i).check(env);
		}
		for( int i = 0; i < instances.size(); i++ ) {
			instances.get(i).semanticCheck();
		}
		for( int i = 0; i < concurrent.size(); i++ ) {
			concurrent.get(i).check(env);
		}
	}

	@Override
	public VNamedElementKind getElementKind() {
		return VNamedElementKind.MODULE;
	} 
}
