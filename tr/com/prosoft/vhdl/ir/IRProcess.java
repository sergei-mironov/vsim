package com.prosoft.vhdl.ir;

import java.util.ArrayList;
import java.util.HashMap;

import com.prosoft.vhdl.ir.util.IROperVisitor;

public class IRProcess extends IRFullNamedElement implements IRVarHolder, ILocalResolver, IRSubProgramHolder, 
	IRAliasHolder, IRConstantHolder, IRTypeHolder, ISensivityList, IPhysicalUnitsHolder {
	
//	IRArchitecture architecture;
	IRStatements statements = new IRStatements();
	ArrayList<IRVariable> vars = new ArrayList<IRVariable>();
	IRSubprograms subprograms = new IRSubprograms();
	ArrayList<IRAlias> aliases = new ArrayList<IRAlias>();
	ArrayList<IRConstant> constants = new ArrayList<IRConstant>();
	HashMap<String, IRNamedElement> map = new HashMap<String, IRNamedElement>();
	ArrayList<IRPhysicalUnits> units = new ArrayList<IRPhysicalUnits>();
	IRTypes types = new IRTypes();
	
	ArrayList<IROper> sensivityList = new ArrayList<IROper>();

	public IRProcess(String name, IRElement architecture) {
		super(architecture, name);
//		this.architecture = architecture;
		statements.setParent(this);
		if( name != null ) put(this);
	}

	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		if( "P".equalsIgnoreCase(getName()) ) {
			int a = 0;
			a++;
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
		for( int i = 0; i < subprograms.size(); i++ ) {
			subprograms.get(i).semanticCheck(err);
		}
		checkSensivityList(err);
		statements.semanticCheck(err);
	}

	public void visit(IROperVisitor visitor) {
		for( int i = 0; i < constants.size(); i++ ) {
			constants.get(i).visit(visitor);
		}
		for( int i = 0; i < statements.statements.size(); i++ ) {
			statements.statements.get(i).visitStatement(visitor);
		}
		for( int i = 0; i < subprograms.size(); i++ ) {
			if( subprograms.get(i).body != null )
				subprograms.get(i).body.visitStatement(visitor);
		}
	}
	
	protected void checkSensivityList( IRErrorFactory err ) throws CompilerError {
		for( IROper cur : sensivityList ) {
			cur.semanticCheck(err);
			cur.checkRead(IRObjectClass.SIGNAL, err);
		}
	}

	@Override
	public boolean containsType(IRType type) {
		return types.contains(type);
	}

	@Override
	public boolean contains(IRNamedElement el) {
		return map.containsValue(el);
	}

	protected void put(IRNamedElement el) {
		map.put(el.getName().toLowerCase(), el);
	}
	
	/* (non-Javadoc)
	 * @see com.prosoft.vhdl.ir.ISensivityList#addToSensivityList(com.prosoft.vhdl.ir.IROper)
	 */
	public void addToSensivityList( IROper sig ) {
		sensivityList.add(sig);
	}
	
	public ArrayList<IROper> getSensivityList() {
		return sensivityList;
	}

	@Override
	public void add(IRVariable var) {
		vars.add(var);
		put(var);
		var.setParent(this);
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
	public IRNamedElement localResolve(String name) {
		return map.get(name.toLowerCase());
	}

	public IRStatements getStatements() {
		return statements;
	}

	public void setStatements(IRStatements statements) {
		this.statements = statements;
		statements.setParent(this);
	}

	public IRArchitecture getArchitecture() {
		return (IRArchitecture) getParent();
	}

	public ArrayList<IRVariable> getVars() { return vars; }
	public ArrayList<IRConstant> getConstants() { return constants;	}
	public ArrayList<IRAlias> getAliases() { return aliases; }
	public IRTypes getTypes() { return types; }

	public IRSubprograms getSubprograms() {
		return subprograms;
	}

	@Override
	public void add(IRSubProgram sub) {
		map.put(sub.getName().toLowerCase(), sub);
		map.put(sub.getCanonicalName(), sub);
		subprograms.add(sub);
	}

	@Override
	public void add(IRAlias alias) {
		aliases.add(alias);
		put(alias);
	}

	@Override
	public void add(IRConstant cnst) {
		constants.add(cnst);
		put(cnst);
	}

	@Override
	public void localResolve(IRSubprogramSearchContext context) {
		subprograms.getMatchedByName(context);
	}

	@Override
	public void add(IRPhysicalUnits units) {
		this.units.add(units);
		put(units);
	}

	@Override
	public void add(IREnumValue value) {
		map.put(value.getName().toLowerCase(), value);
	}

}
