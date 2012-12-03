package com.prosoft.vhdl.ir;

import java.util.ArrayList;
import java.util.HashMap;

import com.prosoft.common.TextCoord;

public class IRSubProgram extends IRUniqueNamedElement implements IRVarHolder, IRConstantHolder, ILocalResolver, 
	IRAliasHolder, IRTypeHolder, IRSubProgramHolder, IPhysicalUnitsHolder {

	IRTypes types = new IRTypes();
	ArrayList<IRParameter> parameters = new ArrayList<IRParameter>();
	ArrayList<IRVariable> vars = new ArrayList<IRVariable>();
	ArrayList<IRConstant> constants = new ArrayList<IRConstant>();
	ArrayList<IRAlias> aliases = new ArrayList<IRAlias>();
	HashMap<String, IRNamedElement> map = new HashMap<String, IRNamedElement>();
	ArrayList<IRPhysicalUnits> units = new ArrayList<IRPhysicalUnits>();
	IRSubprograms subs = new IRSubprograms();
	IRStatement body;
	
	final ParameterHolder parameterHolder;
	
	public class ParameterHolder extends IRNamedElement implements IRVarHolder, IRSignalHolder, IRConstantHolder, IRPortHolder {

		public ParameterHolder(String name) {
			super(IRSubProgram.this, name);
		}

		@Override
		public void add(IRVariable var) {
			IRParameter param = new IRParameter(IRSubProgram.this, var.getName(), var.type, IRObjectClass.VARIABLE, var.direction, var.getInit(), var);
			parameters.add( param );
			var.setParameter(true);
			put(var);
		}

		@Override
		public void add(IRSignal sig) {
			IRParameter param = new IRParameter(IRSubProgram.this, sig.getName(), sig.type, IRObjectClass.SIGNAL, ((IRPort)sig).direction, sig.getInit(), sig );
			parameters.add( param );
			sig.setParameter(true);
			put(sig);
		}

		@Override
		public void add(IRConstant cnst) {
			IRParameter param = new IRParameter(IRSubProgram.this, cnst.getName(), cnst.type, IRObjectClass.CONSTANT, IRDirection.INPUT, cnst.getValue(), cnst);
			parameters.add( param );
			cnst.setParameter(true);
			put(cnst);
		}

		@Override
		public void add(IRPort port) {
			IRParameter param = new IRParameter(IRSubProgram.this, port.getName(), port.type, IRObjectClass.SIGNAL, port.direction, port.getInit(), port);
			parameters.add( param );
			port.setParameter(true);
			put(port);
		}
		
	}
	
	public IRSubProgram(IRSubProgramHolder parent, String name) {
		super((IRElement) parent, name);
		parameterHolder = new ParameterHolder(name + "_parameterHolder");
	}
	
	public IRNamedElement getParameterHolder() { return parameterHolder; };
	
	public boolean isDeclarationEqualsTo( IRSubProgram other ) {
		if( parameters.size() != other.parameters.size() ) return false;
		for( int i = 0; i < parameters.size(); i++ ) {
			IRParameter p1 = parameters.get(i);
			IRParameter p2 = other.parameters.get(i);
			if( p1.direction != p2.direction ) return false;
			if( p1.objectClass != p2.objectClass ) return false;
			if( !p1.type.isEqualTo(p2.type) ) return false;
			if( !p1.getName().equalsIgnoreCase(p2.getName()) ) return false;
		}
		return true;
	}
	
	public boolean isParameterTypeEqualTo( IRType[] types ) {
		if( parameters.size() != types.length ) return false;
		for( int i = 0; i < parameters.size(); i++ ) {
			//if( !parameters.get(i).getType().isAssignableFrom(types[i]) ) return false;
			String name1 = parameters.get(i).getType().getBaseTypeName();
			String name2 = types[i].getBaseTypeName();
			if( !name1.equalsIgnoreCase(name2) ) return false;
		}
		return true;
	}
	
	public IRType[] getParametersTypes() {
		IRType[] res = new IRType[parameters.size()];
		for( int i = 0; i < parameters.size(); i++ ) {
			res[i] = parameters.get(i).getType();
		}
		return res;
	}

	public String getCanonicalName() {
		StringBuffer res = new StringBuffer(getName() + "(");
		for( int i = 0; i < parameters.size(); i++ ) {
			res.append( parameters.get(i).getType().getOriginalType().getBaseTypeName() );
			if( i + 1 < parameters.size() ) res.append(",");
		}
		res.append(")");
		if( isFunction() ) {
			res.append(((IRFunction)this).getReturnType().getOriginalType().getBaseTypeName());
		}
		return res.toString().toLowerCase();
	}
	
	public static String getCanonicalName(TextCoord coord, String name, IRType[] params) {
		StringBuffer res = new StringBuffer(name + "(");
		for( int i = 0; i < params.length; i++ ) {
			if( params[i] == null ) {
				throw new RuntimeException("unknown type at " + coord);
			}
			res.append( params[i].getOriginalType().getName() );
			if( i + 1 < params.length ) res.append(",");
		}
		res.append(")");
		return res.toString().toLowerCase();
	}
	
	public IRStatement getBody() {
		return body;
	}

	public void setBody(IRStatement body) {
		this.body = body;
		body.setParent(this);
	}

	protected void put( IRNamedElement el ) {
		map.put(el.getName().toLowerCase(), el);
		el.setParent(this);
	}

	public void add( IRParameter param ) {
		parameters.add(param);
		param.setParent(this);
	}

	@Override
	public void add(IRVariable var) {
		vars.add(var);
		put(var);
		var.setParent(this);
	}

	@Override
	public void add(IRConstant cnst) {
		constants.add(cnst);
		put(cnst);
		cnst.setParent(this);
	}

	@Override
	public void add(IRAlias alias) {
		put(alias);
		aliases.add(alias);
		alias.setParent(this);
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
	
	public void copyImplementation(IRSubProgram sub) {
		body = sub.getBody();
		vars = sub.vars;
		constants = sub.constants;
		map = sub.map;
		parameters = sub.parameters; // копируем, т.к. параметры будут в map
	}
	
	public String toString() {
		return getName();
	}

	@Override
	public IRNamedElement localResolve(String name) {
		return map.get(name.toLowerCase());
	}
	
	public IRParameter getParameter(String name) {
		for( IRParameter p : parameters ) {
			if( p.getName().equalsIgnoreCase(name) ) return p;
		}
		return null;
	}
	
	public ArrayList<IRParameter> getParameters() {	return parameters; }
	public ArrayList<IRVariable> getVars() { return vars; }
	public ArrayList<IRConstant> getConstants() { return constants;	}
	public ArrayList<IRAlias> getAliases() { return aliases; }
	public IRTypes getTypes() { return types; }

	public boolean isFunction() { return false; }
	
//	logical_operator ::= "and", "or", "nand", "nor", "xor", "xnor"
//	relational_operator "=", "/=", "<", "<=", ">", ">="
//	shift_operator ::= "sll", "srl", "sla", "sra", "rol", "ror"
//	adding_operator ::= "+", "Ц", "&"
//	sign ::= "+", "Ц"
//	multiplying_operator ::= "*", "/", "mod", "rem"
//	miscellaneous_operator ::= "**", "abs", "not"
	
	String[] validBinaries = new String[] { "and", "or", "nand", "nor", "xor", "xnor", "=", "/=", "<", "<=", ">", ">=", "sll", "srl", "sla", "sra", "rol", "ror",
			"*", "/", "mod", "rem", "+", "-", "&", "**" };
	String[] validUnaries = new String[] { "+", "-", "abs", "not" };

	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		if( (!isFunction()) && getName().charAt(0) == '\"' ) {
			err.incorrectProcedureName(this);
		}
		if( isFunction() && getName().charAt(0) == '\"' ) {
			if( getParameters().size() < 1 || getParameters().size() > 2 ) {
				err.invalidOverloadedFunction(this);
			} else {
				String[] valid = getParameters().size() == 1 ? validUnaries : validBinaries;
				String name = getName();
				name = name.substring(1, name.length()-1);
				boolean found = false;
				for( String cur : valid ) {
					if( cur.equalsIgnoreCase(name) ) {
						found = true;
						break;
					}
				}
				if( !found ) {
					err.invalidOverloadedFunction(this);
				}
			}
		}
		for( int i = 0; i < aliases.size(); i++ ) {
			aliases.get(i).semanticCheck(err);
		}
		for( int i = 0; i < vars.size(); i++ ) {
			vars.get(i).semanticCheck(err);
		}
		for( int i = 0; i < constants.size(); i++ ) {
			constants.get(i).semanticCheck(err);
		}
		for( IRParameter p : parameters  ) {
			p.semanticCheck(err);
		}
		for( IRSubProgram sub : subs.subs ) {
			sub.semanticCheck(err);
		}
//		System.out.println("Checking subprogram: " + getName());
		if( body != null ) {
			body.semanticCheck(err);
		} else {
			if( !getFullName().startsWith("STD.") && !getFullName().startsWith("IEEE.") ) {
				err.subProgramHasNoBody(this);
			}
		}
	}

	@Override
	public boolean contains(IRNamedElement el) {
		return map.containsValue(el);
	}

	@Override
	public boolean containsType(IRType type) {
		return types.contains(type);
	}

	@Override
	public void localResolve(IRSubprogramSearchContext context) {
		subs.getMatchedByName(context);
	}
	
	static String stdName = "STD.STANDARD";

    public boolean isStandard()
    {
    	String full = getFullName();
    	String begin = full.substring(0, Math.min(full.length(), stdName.length()));
    	return begin.equalsIgnoreCase(stdName);
//        IRPackage pack = null;
//        if( getParent() instanceof IRPackage ) {
//            pack = (IRPackage) getParent();
//        } else if( getParent() instanceof IRPackage.Body ) {
//            pack = (IRPackage) ((IRPackage.Body)getParent()).getParent().getParent();
//        } else if( getParent() instanceof IRPackage.Declaration ) {
//            pack = (IRPackage) ((IRPackage.Declaration)getParent()).getParent(); 
//        }
//        if( pack != null ) {
//            return pack.getName().equalsIgnoreCase("STANDARD");
//        }
//        return true;
    }

	@Override
	public void add(IRSubProgram sub) {
		put(sub);
		subs.add(sub);
	}

	@Override
	public IRSubprograms getSubprograms() {
		return subs;
	}

	@Override
	public void add(IRPhysicalUnits units) {
		this.units.add(units);
		map.put(units.getName(), units);
	}

	@Override
	public void add(IREnumValue value) {
		map.put(value.getName().toLowerCase(), value);
	}

}
