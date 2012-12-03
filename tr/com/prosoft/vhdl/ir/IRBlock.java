package com.prosoft.vhdl.ir;

import java.util.ArrayList;
import java.util.HashMap;

import com.prosoft.vhdl.ir.util.IROperVisitor;
import com.prosoft.vhdl.parser.ParserBase.ImplementationRule;

public class IRBlock extends IRFullNamedElement implements IRGenericHolder, IRPortHolder, ILocalResolver, IRTypeHolder, 
	IRSignalHolder, IRBlockHolder, IConcurrentHolder, IProcessHolder, IRComponentTypeHolder, IRComponentInstanceHolder, 
	IRConstantHolder, IRAliasHolder, IRSubProgramHolder {
	
	ArrayList<IRStatement> concurrent = new ArrayList<IRStatement>();
	ArrayList<IRGeneric> generics = new ArrayList<IRGeneric>();
	ArrayList<IRPort> ports = new ArrayList<IRPort>();
	ArrayList<IRSignal> signals = new ArrayList<IRSignal>();
	ArrayList<IRBlock> blocks = new ArrayList<IRBlock>();
	ArrayList<IRProcess> processes = new ArrayList<IRProcess>();
	ArrayList<IRConstant> constants = new ArrayList<IRConstant>();
	ArrayList<IRAlias> aliases = new ArrayList<IRAlias>();
	IRTypes types = new IRTypes();
	IRSubprograms subs = new IRSubprograms();
	IRStatement statement;
	
	HashMap<String, IRNamedElement> map = new HashMap<String, IRNamedElement>();

	public IRBlock(IRElement parent, String name) {
		super(parent, name);
	}

	@Override
	public boolean containsType(IRType type) {
		return types.contains(type);
	}

	@Override
	public boolean contains(IRNamedElement el) {
		return map.containsValue(el);
	}

	protected void put( IRNamedElement el ) {
		map.put(el.getName().toLowerCase(), el);
	}

	@Override
	public void add(IRGeneric gen) {
		put(gen);
		generics.add(gen);
	}

	@Override
	public void add(IRPort port) {
		put(port);
		ports.add(port);
	}

	@Override
	public void add(IRBlock block) {
		put(block);
		blocks.add(block);
	}

	@Override
	public void add(IRProcess process) {
		processes.add(process);
		if( process.getName() != null ) put(process);
	}

	@Override
	public void add(IRConstant cnst) {
		constants.add(cnst);
		put(cnst);
	}
	
	@Override
	public void add(IRAlias alias) {
		aliases.add(alias);
		put(alias);
	}

	@Override
	public void add(IRSubProgram sub) {
		subs.add(sub);
		map.put(sub.getName().toLowerCase(), sub);
		map.put(sub.getCanonicalName(), sub);
	}

	@Override
	public IRNamedElement localResolve(String name) {
		return map.get(name.toLowerCase());
	}

	@Override
	public void addType(IRType type) {
		types.put(type, this);
		type.setParent(this);
	}

	@Override
	public IRType getType(String name) {
		return types.get(name);
	}

	@Override
	public void add(IRSignal signal) {
		put(signal);
		signals.add(signal);
	}

	public IRStatement getStatement() {
		return statement;
	}

	public void setStatement(IRStatement statement) {
		this.statement = statement;
	}

	@Override
	public void addConcurrent(IRStatement stat) {
		concurrent.add(stat);
	}
	
	public void semanticCheck( IRErrorFactory err ) throws CompilerError {
		for( IRGeneric gen : generics ) {
			gen.semanticCheck(err);
		}
		for( IRPort p : ports ) {
			p.semanticCheck(err);
		}
		for( IRConstant c : constants ) {
			c.semanticCheck(err);
		}
		for( IRSignal s : signals ) {
			s.semanticCheck(err);
		}
		if( statement != null ) statement.semanticCheck(err);
		for( IRSubProgram s : subs.subs ) {
			s.semanticCheck(err);
		}
		for( IRBlock b : blocks ) {
			b.semanticCheck(err);
		}
		for( int i = 0; i < concurrent.size(); i++ ) {
			concurrent.get(i).semanticCheck(err);
		}
		for( int i = 0; i < processes.size(); i++ ) {
			processes.get(i).semanticCheck(err);
		}
		for( IRComponent c : comps.values() ) {
			c.semanticCheck(err);
		}
		for( IRComponentInstance c : components ) {
			c.semanticCheck(err);
		}
	}
	
	public void visit( IROperVisitor visitor ) {
		for( int i = 0; i < concurrent.size(); i++ ) {
			concurrent.get(i).visit(visitor);
		}
		for( int i = 0; i < processes.size(); i++ ) {
			processes.get(i).visit(visitor);
		}
		for( IRComponentInstance c : components ) {
			c.visit(visitor);
		}
	}

	public ArrayList<IRStatement> getConcurrent() {
		return concurrent;
	}
	
	public ArrayList<IRProcess> getProcesses() {
		return processes;
	}

	public ArrayList<IRSignal> getSignals() {
		return signals;
	}

	public ArrayList<IRBlock> getBlocks() {
		return blocks;
	}

	public ArrayList<IRAlias> getAliases() {
		return aliases;
	}

	public ArrayList<IRPort> getPorts() {
		return ports;
	}

	public ArrayList<IRConstant> getConstants() {
		return constants;
	}

	@Override
	public IRSubprograms getSubprograms() {
		return subs;
	}

	public IRTypes getTypes() {
		return types;
	}

	@Override
	public void localResolve(IRSubprogramSearchContext context) {
		subs.getMatchedByName(context);
	}

	public ArrayList<IRGeneric> getGenerics() {
		return generics;
	}

	ArrayList<IRComponentInstance> components = new ArrayList<IRComponentInstance>();
	ArrayList<ImplementationRule> rules = new ArrayList<ImplementationRule>();

	public void add( IRComponentInstance inst ) {
		components.add(inst);
		put(inst);
	}

	@Override
	public IRComponentInstance[] getComponentInstances() {
		return components.toArray(new IRComponentInstance[components.size()]);
	}

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
	public void add(IREnumValue value) {
		map.put(value.getName().toLowerCase(), value);
	}

}
