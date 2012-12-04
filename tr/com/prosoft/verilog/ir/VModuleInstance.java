package com.prosoft.verilog.ir;

import java.util.ArrayList;

import com.prosoft.glue.ComponentImplementation;
import com.prosoft.vhdl.ir.CompilerError;

public class VModuleInstance extends VNamedElement {
	
	String module;
	ArrayList<VOper> params = new ArrayList<VOper>();
	ArrayList<VOper> connections = new ArrayList<VOper>();
	
	ComponentImplementation component;

	public VModuleInstance(String module,
			ArrayList<VOper> params, String instanceName, ArrayList<VOper> connections) {
		super(instanceName);
		this.module = module;
		this.params = params;
		this.connections = connections;
	}

	@Override
	public VEnvironment getEnvironment() {
		throw new RuntimeException();
	}

	@Override
	public VType getType() {
		throw new RuntimeException();
	}

	public ComponentImplementation getComponent() {
		return component;
	}

	public ArrayList<VOper> getParams() {
		return params;
	}

	public ArrayList<VOper> getConnections() {
		return connections;
	}

	@Override
	public VNamedElementKind getElementKind() {
		return VNamedElementKind.MODULE_INSTANCE;
	}

	public void semanticCheck() throws CompilerError {
		// TODO Auto-generated method stub
		
	}
}
