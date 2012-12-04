package com.prosoft.vhdl.ir;

import java.util.ArrayList;
import java.util.HashMap;

import com.prosoft.vhdl.ir.util.IROperVisitor;
import com.prosoft.vhdl.parser.ParserBase.ImplementationRule;

public class IRArchitecture extends IRNamedElement implements IRSubProgramHolder, IRVarHolder, IRConstantHolder, 
	IRSignalHolder, ILocalResolver, IREnumHolder, IRComponentInstanceHolder, IConcurrentHolder, IRBlockHolder, 
	IRTypeHolder, IProcessHolder, IRAliasHolder, IRComponentTypeHolder, IPhysicalUnitsHolder {
	
	IREntity entity;
	ArrayList<IRStatement> concurrent = new ArrayList<IRStatement>();
	ArrayList<IRAlias> aliases = new ArrayList<IRAlias>();
	ArrayList<IRProcess> processes = new ArrayList<IRProcess>();
	ArrayList<IRVariable> vars = new ArrayList<IRVariable>();
	ArrayList<IRSignal> signals = new ArrayList<IRSignal>();
	ArrayList<IRConstant> constants = new ArrayList<IRConstant>();
	IRSubprograms subprograms = new IRSubprograms();
	ArrayList<IREnumValue> enums = new ArrayList<IREnumValue>();
	ArrayList<IRComponentInstance> components = new ArrayList<IRComponentInstance>();
	ArrayList<IRBlock> blocks = new ArrayList<IRBlock>();
	HashMap<String, IRNamedElement> map = new HashMap<String, IRNamedElement>();
	ArrayList<IRPhysicalUnits> units = new ArrayList<IRPhysicalUnits>();
	IRTypes types = new IRTypes();
	
	public IRArchitecture(IRElement parent, String name, IREntity entity) {
		super(parent, name);
		this.entity = entity;
		if( entity != null ) entity.add(this);
	}
	
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		for( int i = 0; i < vars.size(); i++ ) {
			vars.get(i).semanticCheck(err);
		}
		for( int i = 0; i < signals.size(); i++ ) {
			signals.get(i).semanticCheck(err);
		}
		for( int i = 0; i < aliases.size(); i++ ) {
			aliases.get(i).semanticCheck(err);
		}
		for( int i = 0; i < constants.size(); i++ ) {
			constants.get(i).semanticCheck(err);
		}
		for( int i = 0; i < processes.size(); i++ ) {
			processes.get(i).semanticCheck(err);
		}
		for( int i = 0; i < subprograms.size(); i++ ) {
			subprograms.get(i).semanticCheck(err);
		}
		for( int i = 0; i < components.size(); i++ ) {
			components.get(i).semanticCheck(err);
		}
		for( int i = 0; i < blocks.size(); i++ ) {
			blocks.get(i).semanticCheck(err);
		}
		for( int i = 0; i < concurrent.size(); i++ ) {
			concurrent.get(i).semanticCheck(err);
		}
	}
	
	public void visit( IROperVisitor visitor ) {
		for( int i = 0; i < constants.size(); i++ ) {
			constants.get(i).visit(visitor);
		}
		for( int i = 0; i < concurrent.size(); i++ ) {
			concurrent.get(i).visitStatement(visitor);
		}
		for( int i = 0; i < processes.size(); i++ ) {
			processes.get(i).visit(visitor);
		}
		for( int i = 0; i < subprograms.size(); i++ ) {
			if( subprograms.get(i).body != null )
				subprograms.get(i).body.visitStatement(visitor);
		}
		for( int i = 0; i < components.size(); i++ ) {
			components.get(i).visit(visitor);
		}
		for( int i = 0; i < blocks.size(); i++ ) {
			blocks.get(i).visit(visitor);
		}
		for( int i = 0; i < concurrent.size(); i++ ) {
			concurrent.get(i).visitStatement(visitor);
		}
	}
	
	@Override
	public boolean contains(IRNamedElement el) {
		if( map.containsValue(el) ) return true;
		return entity.contains(el);
	}

	public void addConcurrent( IRStatement stat ) {
		if( stat == null ) {
			int a = 0;
			a++;
		}
		concurrent.add(stat);
	}

	protected void put(IRNamedElement el) {
		map.put(el.getName().toLowerCase(), el);
	}

	public void addType( IRType type ) {
		types.put(type, this);
		put(type);
		type.setParent(this);
	}
	
	public IRType getType( String name ) {
		return types.get(name);
	}
	
	public IRTypes getTypes() {
		return types;
	}
	
	public void add( IRProcess process ) {
		processes.add(process);
		if( process.getName() != null ) put(process);
	}
	
	public void add( IRAlias alias ) {
		aliases.add(alias);
		put(alias);
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
	
	public void add( IRBlock block ) {
		if( block.getName().equalsIgnoreCase("B1") ) {
			int a = 0;
			a++;
		}
		blocks.add(block);
		put(block);
	}
	
	public void add( IRComponentInstance inst ) {
		components.add(inst);
		put(inst);
	}

	@Override
	public IRNamedElement localResolve(String name) {
		IRNamedElement res = map.get(name.toLowerCase());
		if( res != null ) return res;
		if( entity == null ) return null;
		return entity.localResolve(name);
	}

	@Override
	public void add(IREnumValue value) {
		put(value);
		enums.add(value);
	}

	public IREntity getEntity() {
		return entity;
	}
	
	public ArrayList<IRSignal> getSignals() {
		return signals;
	}

	public ArrayList<IRProcess> getProcesses() {
		return processes;
	}

	public ArrayList<IRComponentInstance> getComponents() {
		return components;
	}

	public ArrayList<IRStatement> getConcurrent() {
		return concurrent;
	}

	public ArrayList<IRBlock> getBlocks() {
		return blocks;
	}

	public ArrayList<IRAlias> getAliases() {
		return aliases;
	}

	public ArrayList<IRConstant> getConstants() {
		return constants;
	}

	public ArrayList<IRVariable> getVars() {
		return vars;
	}

	@Override
	public void add(IRSubProgram sub) {
		map.put(sub.getName().toLowerCase(), sub);
		map.put(sub.getCanonicalName(), sub);
		subprograms.add(sub);
	}

	@Override
	public void localResolve(IRSubprogramSearchContext context) {
		subprograms.getMatchedByName(context);
		entity.localResolve(context);
	}

	@Override
	public IRSubprograms getSubprograms() {
		return subprograms;
	}

	@Override
	public boolean containsType(IRType type) {
		return types.contains(type);
	}

	@Override
	public IRComponentInstance[] getComponentInstances() {
		return components.toArray(new IRComponentInstance[components.size()]);
	}
	
	ArrayList<ImplementationRule> rules = new ArrayList<ImplementationRule>();

	@Override
	public void addImplementationRule(ImplementationRule rule) {
		rules.add(rule);
	}

	@Override
	public ArrayList<ImplementationRule> getImplementationRules() {
		return rules;
	}

	HashMap<String, IRComponent> comps = new HashMap<String, IRComponent>();

	@Override
	public void addComponentType(IRComponent comp) {
		comps.put(comp.getName().toLowerCase(), comp);
	}

	@Override
	public IRComponent getComponent(String name) {
		return comps.get(name.toLowerCase());
	}

	@Override
	public void add(IRPhysicalUnits units) {
		this.units.add(units);
		put(units);
	}


}
