package com.prosoft.vhdl.ir;

import java.util.ArrayList;
import java.util.HashMap;

import com.prosoft.vhdl.lib.Library;

public class IREntity extends IRNamedElement implements IRVarHolder, IRConstantHolder, IRPortHolder, 
	ILocalResolver, IRSubProgramHolder, IRAliasHolder, IRGenericHolder, IRSignalHolder, IPhysicalUnitsHolder, IRTypeHolder, 
	IProcessHolder {
	
	ArrayList<IRVariable> vars = new ArrayList<IRVariable>();
	ArrayList<IRSignal> signals = new ArrayList<IRSignal>();
	ArrayList<IRConstant> constants = new ArrayList<IRConstant>();
	ArrayList<IRPort> ports = new ArrayList<IRPort>();
	ArrayList<IRArchitecture> arcs = new ArrayList<IRArchitecture>();
	IRSubprograms subprograms = new IRSubprograms();
	ArrayList<IRAlias> aliases = new ArrayList<IRAlias>();
	ArrayList<IRGeneric> gens = new ArrayList<IRGeneric>();
	ArrayList<IRPhysicalUnits> units = new ArrayList<IRPhysicalUnits>();
	ArrayList<IRProcess> processes = new ArrayList<IRProcess>();

	HashMap<String, IRNamedElement> map = new HashMap<String, IRNamedElement>();
	
	IRDesignFile designFile;
	
	IRTypes types = new IRTypes();
	
//	ArrayList<IRArchitecture> archs = new ArrayList<IRArchitecture>();

	public IREntity(IRContext context, String name) {
		super(context, name);
		this.designFile = context.getDesignFile();
		if( name.equalsIgnoreCase("primitives") ) {
			int a = 0;
			a++;
		}
	}
	
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		if( getName().equalsIgnoreCase("atmega128_twi_wake_up_tb") ) {
			int a = 0;
			a++;
		}
		for( int i = 0; i < gens.size(); i++ ) {
			gens.get(i).semanticCheck(err);
		}
		for( int i = 0; i < aliases.size(); i++ ) {
			aliases.get(i).semanticCheck(err);
		}
		for( int i = 0; i < constants.size(); i++ ) {
			constants.get(i).semanticCheck(err);
		}
		for( int i = 0; i < vars.size(); i++ ) {
			vars.get(i).semanticCheck(err);
		}
		for( int i = 0; i < signals.size(); i++ ) {
			signals.get(i).semanticCheck(err);
		}
		for( int i = 0; i < arcs.size(); i++ ) {
			arcs.get(i).semanticCheck(err);
		}
		for( int i = 0; i < subprograms.size(); i++ ) {
			subprograms.get(i).semanticCheck(err);
		}
		for( int i = 0; i < processes.size(); i++ ) {
			processes.get(i).semanticCheck(err);
		}
	}
	
	@Override
	public boolean contains(IRNamedElement el) {
		return map.containsValue(el);
	}

	protected void add( IRArchitecture arc ) {
		arcs.add(arc);
		map.put(arc.getName().toLowerCase(), arc);
	}
	
	public IRArchitecture[] getArchitectures() {
		return arcs.toArray( new IRArchitecture[arcs.size()] );
	}
	
	protected void put(IRNamedElement el) {
		map.put(el.getName().toLowerCase(), el);
	}

	public void add( IRVariable var ) {
		vars.add(var);
		put(var);
	}
	
	public void add( IRSignal sig ) {
		signals.add(sig);
		put(sig);
	}
	
	public void add( IRConstant cnst ) {
		constants.add(cnst);
		put(cnst);
	}
	
	public void add( IRPort port ) {
		ports.add(port);
		put(port);
	}

	public void add( IRAlias alias ) {
		aliases.add(alias);
		put(alias);
	}


	public ArrayList<IRPort> getPorts() {
		return ports;
	}
	
	@Override
	public IRNamedElement localResolve(String name) {
		return map.get(name.toLowerCase());
	}

	@Override
	public void add(IRSubProgram sub) {
		map.put(sub.getName().toLowerCase(), sub);
		map.put(sub.getCanonicalName(), sub);
		subprograms.add(sub);
	}

	@Override
	public void add(IRGeneric gen) {
		gens.add(gen);
		put(gen);
	}

	public ArrayList<IRGeneric> getGenerics() {
		return gens;
	}
	
	public IRDesignFile getDesignFile() {
		return designFile;
	}

	public ArrayList<IRAlias> getAliases() {
		return aliases;
	}

	public IRTypes getTypes() {
		return types;
	}

	@Override
	public void localResolve(IRSubprogramSearchContext context) {
		subprograms.getMatchedByName(context);
	}
	
	@Override
	public IRSubprograms getSubprograms() {
		return subprograms;
	}

	public ArrayList<IRConstant> getConstants() {
		return constants;
	}

	public IRArchitecture getArchitecture(String archToGen) {
		if( arcs.size() == 0 ) return null;
		if( archToGen == null ) return arcs.get(0);
		for( IRArchitecture arch : arcs ) {
			if( arch.getName().equalsIgnoreCase(archToGen) ) return arch;
		}
//		System.err.println("architecture " + archToGen + " undefined for entity " + getName());
		return null;
	}

	@Override
	public void add(IRPhysicalUnits units) {
		this.units.add(units);
		put(units);
	}

	@Override
	public void addType(IRType type) {
		if( type.getName().equalsIgnoreCase("t_rec1") ) {
			int a = 0;
			a++;
		}
		types.put(type, this);
	}

	@Override
	public boolean containsType(IRType type) {
		return types.contains(type);
	}

	@Override
	public IRType getType(String name) {
		return types.get(name);
	}

	@Override
	public void add(IRProcess process) {
		processes.add(process);
		if( process.getName() != null ) put(process);
	}

	public ArrayList<IRProcess> getProcesses() {
		return processes;
	}
	@Override
	public void add(IREnumValue value) {
		map.put(value.getName().toLowerCase(), value);
	}

	public ArrayList<IRSignal> getSignals() {
		return signals;
	}

}
