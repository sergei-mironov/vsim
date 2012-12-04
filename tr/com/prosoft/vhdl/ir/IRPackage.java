package com.prosoft.vhdl.ir;

import java.util.ArrayList;
import java.util.HashMap;

import com.prosoft.vhdl.lib.Library;

public class IRPackage extends IRNamedElement implements ILocalResolver, IRComponentTypeHolder {
	
	public class Declaration extends IRElement implements ILocalResolver, IRSubProgramHolder, IRTypeHolder, 
	IRConstantHolder, IREnumHolder, IRAliasHolder, IPhysicalUnitsHolder, IRSignalHolder, IRComponentTypeHolder {
	
		public Declaration() {
			super(IRPackage.this);
		}

		IRTypes types = new IRTypes();
		HashMap<String, IRNamedElement> map = new HashMap<String, IRNamedElement>();
		IRSubprograms subprograms = new IRSubprograms();
		ArrayList<IRConstant> constants = new ArrayList<IRConstant>();
		ArrayList<IREnumValue> enums = new ArrayList<IREnumValue>();
		ArrayList<IRAlias> aliases = new ArrayList<IRAlias>();
		ArrayList<IRPhysicalUnits> units = new ArrayList<IRPhysicalUnits>();
		ArrayList<IRSignal> signals = new ArrayList<IRSignal>();
		
		protected void put( IRNamedElement el ) {
			map.put(el.getName().toLowerCase(), el);
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
		public IRNamedElement localResolve(String name) {
			return map.get(name.toLowerCase());
		}
	
		public ArrayList<IRAlias> getAliases() {
			return aliases;
		}

		@Override
		public void add(IRSubProgram sub) {
//			String subName = sub.getName().toLowerCase();
//			IRSubProgramsFamily fam = (IRSubProgramsFamily) map.get(subName);
//			if( fam == null ) {
//				fam = (IRSubProgramsFamily) designFile.resolve(subName);
//			}
//			if( fam == null ) {
//				fam = new IRSubProgramsFamily(sub.getName());
//				put(fam);
//			}
//			fam.put(sub);
			
			map.put(sub.getName().toLowerCase(), sub);
			map.put(sub.getCanonicalName(), sub);
			
			subprograms.add(sub);
		}
	
		@Override
		public void addType(IRType type) {
			types.put(type, this);
			put(type);
			type.setParent(IRPackage.this);
		}
	
		@Override
		public IRType getType(String name) {
			return types.get(name);
		}
	
		@Override
		public void add(IRConstant cnst) {
			put(cnst);
			constants.add(cnst);
		}

		@Override
		public void add(IREnumValue value) {
			put(value);
			enums.add(value);
		}

		@Override
		public void add(IRAlias alias) {
			put(alias);
			aliases.add(alias);
		}
		
		public IRTypes getTypes() {
			return types;
		}

		public void semanticCheck(IRErrorFactory err) throws CompilerError {
			for( int i = 0; i < aliases.size(); i++ ) {
				aliases.get(i).semanticCheck(err);
			}
			for( int i = 0; i < constants.size(); i++ ) {
				constants.get(i).semanticCheck(err);
			}
			for( int i = 0; i < subprograms.size(); i++ ) {
				subprograms.get(i).semanticCheck(err);
			}
		}
		
		public IRPackage getPackage() {
			return IRPackage.this;
		}

		@Override
		public void add(IRPhysicalUnits units) {
			put(units);
			this.units.add(units);
		}

		@Override
		public void add(IRSignal signal) {
			put(signal);
			signals.add(signal);
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

		@Override
		public void addComponentType(IRComponent comp) {
			IRPackage.this.addComponentType(comp);
		}

		@Override
		public IRComponent getComponent(String name) {
			return IRPackage.this.getComponent(name);
		}

	}
	
	public class Body extends IRElement implements ILocalResolver, IRSubProgramHolder, IRTypeHolder, IRConstantHolder, 
	IREnumHolder, IRAliasHolder, IPhysicalUnitsHolder, IRSignalHolder, IRComponentTypeHolder {
		
		public Body() {
			super(IRPackage.this.declarations);
		}

		IRTypes types = new IRTypes();
		HashMap<String, IRNamedElement> map = new HashMap<String, IRNamedElement>();
		IRSubprograms subprograms = new IRSubprograms();
		ArrayList<IRConstant> constants = new ArrayList<IRConstant>();
		ArrayList<IREnumValue> enums = new ArrayList<IREnumValue>();
		ArrayList<IRAlias> aliases = new ArrayList<IRAlias>();
		ArrayList<IRPhysicalUnits> units = new ArrayList<IRPhysicalUnits>();
		ArrayList<IRSignal> signals = new ArrayList<IRSignal>();
		
		@Override
		public boolean contains(IRNamedElement el) {
			return map.containsValue(el);
		}

		@Override
		public boolean containsType(IRType type) {
			return types.contains(type);
		}

		protected void put( IRNamedElement el ) {
			map.put(el.getName().toLowerCase(), el);
		}
	
		public ArrayList<IRAlias> getAliases() {
			return aliases;
		}

		@Override
		public IRNamedElement localResolve(String name) {
			return map.get(name.toLowerCase());
		}
	
		@Override
		public void add(IRSubProgram sub) {
//			String subName = sub.getName().toLowerCase();
//			IRSubProgramsFamily fam = (IRSubProgramsFamily) IRPackage.this.declarations.map.get(subName);
//			if( fam == null ) {
//				fam = (IRSubProgramsFamily) map.get(subName);
//			}
//			if( fam == null ) {
//				fam = (IRSubProgramsFamily) designFile.resolve(subName);
//			}
//			if( fam == null ) {
//				fam = new IRSubProgramsFamily(sub.getName());
//				put(fam);
//			}
//			fam.put(sub);
			
			map.put(sub.getName().toLowerCase(), sub);
			map.put(sub.getCanonicalName(), sub);
			
			subprograms.add(sub);
		}
	
		@Override
		public void addType(IRType type) {
			types.put(type, this);
			put(type);
			type.setParent(IRPackage.this);
		}
	
		@Override
		public IRType getType(String name) {
			return types.get(name);
		}
	
		@Override
		public void add(IRConstant cnst) {
			put(cnst);
			constants.add(cnst);
		}

		@Override
		public void add(IREnumValue value) {
			put(value);
			enums.add(value);
		}

		@Override
		public void add(IRAlias alias) {
			put(alias);
			aliases.add(alias);
		}

		public void semanticCheck(IRErrorFactory err) throws CompilerError {
			for( int i = 0; i < aliases.size(); i++ ) {
				aliases.get(i).semanticCheck(err);
			}
			for( int i = 0; i < constants.size(); i++ ) {
				constants.get(i).semanticCheck(err);
			}
			for( int i = 0; i < subprograms.size(); i++ ) {
				subprograms.get(i).semanticCheck(err);
			}
		}
		
		public IRTypes getTypes() {
			return types;
		}

		public IRPackage getPackage() {
			return IRPackage.this;
		}

		@Override
		public void add(IRPhysicalUnits units) {
			put(units);
			this.units.add(units);
		}

		@Override
		public void add(IRSignal signal) {
			put(signal);
			signals.add(signal);
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

		@Override
		public void addComponentType(IRComponent comp) {
			IRPackage.this.addComponentType(comp);
		}

		@Override
		public IRComponent getComponent(String name) {
			return IRPackage.this.getComponent(name);
		}

	}
	
	Declaration declarations = new Declaration();
	Body body = new Body();
	IRDesignFile designFile;
	
	public IRPackage(String name, IRContext context) {
		super(context, name);
		this.designFile = context.getDesignFile();
//		body.setParent(declarations);
	}

	public Declaration getDeclarations() {
		return declarations;
	}

	public Body getBody() {
		return body;
	}

	public IRDesignFile getDesignFile() {
		return designFile;
	}
	
	public Library getLibrary() {
		return designFile.getLibrary();
	}

	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		getDeclarations().semanticCheck(err);
		getBody().semanticCheck(err);
	}

	public String toString() {
		return getName();
	}

	@Override
	public IRNamedElement localResolve(String name) {
		IRNamedElement res;
		res = declarations.localResolve(name);
		if( res == null ) {
			body.localResolve(name);
		}
		return res;
	}

	@Override
	public void localResolve(IRSubprogramSearchContext context) {
		body.localResolve(context);
		declarations.localResolve(context);
	}
	
	@Override
	public boolean contains(IRNamedElement el) {
		return body.contains(el) || declarations.contains(el);
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

	public boolean isStandard() {
		return getFullName().equalsIgnoreCase("STD.STANDARD");
	}
}
