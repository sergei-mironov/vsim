package com.prosoft.vhdl.ir;

import java.util.ArrayList;
import java.util.HashMap;

import com.prosoft.glue.ComponentImplementation;
import com.prosoft.vhdl.ir.util.IROperVisitor;

public class IRComponent extends IRNamedElement implements IRPortHolder, IRGenericHolder, ILocalResolver {
	
	ArrayList<IRPort> ports = new ArrayList<IRPort>();
	ArrayList<IRGeneric> gens = new ArrayList<IRGeneric>();
	
	ComponentImplementation implementation;
	
	HashMap<String, IRNamedElement> map = new HashMap<String, IRNamedElement>();

	public IRComponent(IRElement parent, String name) {
		super(parent, name);
	}
	
	@Override
	public boolean contains(IRNamedElement el) {
		return map.containsValue(el);
	}

	protected void put( IRNamedElement el ) {
		map.put(el.getName().toLowerCase(), el);
	}

	@Override
	public void add(IRPort port) {
		put(port);
		ports.add(port);
		port.setParent(this);
	}

	@Override
	public void add(IRGeneric gen) {
		put(gen);
		gens.add(gen);
		gen.setParent(this);
	}

	@Override
	public IRNamedElement localResolve(String name) {
		return map.get(name.toLowerCase());
	}

	public void semanticCheck( IRErrorFactory err ) {
	}

	@Override
	public void localResolve(IRSubprogramSearchContext context) {
	}

	public ComponentImplementation getImplementation() {
		return implementation;
	}

	public void setImplementation(ComponentImplementation implementation) {
		this.implementation = implementation;
	}

	
}
