package com.prosoft.vhdl.ir;

import java.util.ArrayList;

import com.prosoft.vhdl.ir.util.IROperVisitor;
import com.prosoft.vhdl.parser.ParserBase.ImplementationRule;

public abstract class IRGenerateStatement extends IRStatement implements IConcurrentHolder, IProcessHolder, 
	IRComponentInstanceHolder, IRBlockHolder {

	String label;
	IRStatements statements = new IRStatements();
	IRStatements processed = new IRStatements();
	IRStatements concurent = new IRStatements();
	IRStatements processedConcurent = new IRStatements();
	ArrayList<IRComponentInstance> components = new ArrayList<IRComponentInstance>();
	ArrayList<IRComponentInstance> processedComponents = new ArrayList<IRComponentInstance>();
	ArrayList<IRBlock> blocks = new ArrayList<IRBlock>();
	
	IRGenerateStatement() {
		statements.setParent(this);
		processed.setParent(this);
		concurent.setParent(this);
		processed.setParent(this);
	}
	
	ArrayList<IRProcess> processes = new ArrayList<IRProcess>();
	
	@Override
	public void add(IRComponentInstance instance) {
		components.add(instance);
	}

	@Override
	public void visitStatement(IROperVisitor visitor) {
		statements.visitStatement(visitor);
		processed.visitStatement(visitor);
		for( int i = 0; i < processes.size(); i++ ) {
			processes.get(i).visit(visitor);
		}
	}
	
	public void add( IRStatement stat ) {
		statements.add(stat);
		stat.setParent(this);
	}
	
	public void add( IRProcess proc ) {
		processes.add(proc);
	}

	@Override
	public void add(IRBlock block) {
		blocks.add(block);
	}

	public String getLabel() {
		return label;
	}

	public IRStatements getStatements() {
		return statements;
	}

	public IRStatements getConcurent() {
		return concurent;
	}

	public ArrayList<IRComponentInstance> getComponents() {
		return components;
	}

	public ArrayList<IRProcess> getProcesses() {
		return processes;
	}

	public IRStatements getProcessedStatements() {
		return processed;
	}

	public ArrayList<IRComponentInstance> getProcessedComponents() {
		return processedComponents;
	}

	public IRStatements getProcessedConcurent() {
		return processedConcurent;
	}
	
	public ArrayList<IRBlock> getBlocks() {
		return blocks;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	@Override
	public void addConcurrent(IRStatement stat) {
		concurent.add(stat);
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

	public abstract void generate(IRErrorFactory err);

	@Override
	protected void semanticCheckInternal(IRErrorFactory err) throws CompilerError {
		statements.setParent(this);
		statements.semanticCheck(err);
		concurent.setParent(this);
		concurent.semanticCheck(err);
		for( int i = 0; i < processes.size(); i++ ) {
			processes.get(i).setParent(this);
			processes.get(i).semanticCheck(err);
		}
		for( int i = 0; i < components.size(); i++ ) {
			components.get(i).semanticCheck(err);
		}
		for( IRBlock bl : blocks ) {
			bl.semanticCheck(err);
		}
	}
}
