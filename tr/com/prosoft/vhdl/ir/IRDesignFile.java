package com.prosoft.vhdl.ir;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;
import java.util.Map.Entry;

import com.prosoft.glue.HDLKind;
import com.prosoft.vhdl.lib.LibEnvironment;
import com.prosoft.vhdl.lib.Library;
import com.prosoft.vhdl.parser.VhdlParser;

public class IRDesignFile extends IRElement implements ILocalResolver {
	
	// временно здесь
	public VhdlParser parser;
	
	Library library;
	
	HashMap<String, IRPackage> packages = new HashMap<String, IRPackage>();
	
	ArrayList<IRContext> contexts = new ArrayList<IRContext>();
	
	HashMap<String, IRGeneric> definedGenerics = new HashMap<String, IRGeneric>();
	HashMap<String, IRNamedElement> map = new HashMap<String, IRNamedElement>();
	
	public IRDesignFile(Library library) {
		super(library);
		// добавляем стандартные типы
		this.library = library;
		advanceContext();
	}
	
	public IRContext getContext() {
		return contexts.get(contexts.size()-1);
	}
	
	public IRContext getPreviousContext() {
		return contexts.get(contexts.size()-2);
	}
	
	public void advanceContext() {
		contexts.add(new IRContext(this));
		if( !library.getName().equalsIgnoreCase("STD") ) {
			LibEnvironment.useAll(this, library.getLibEnvironment().getLibrary("STD"));
		}
	}
	
	public Library getLibrary() { return library; }
	
	public void put( IRNamedElement el ) {
		map.put(el.getName().toLowerCase(), el);
	}
	public void addDefinedGeneric( IRGeneric generic ) {
		definedGenerics.put(generic.getName().toLowerCase(), generic);
	}
	
	public IRGeneric getDefinedGeneric( String name ) {
		return definedGenerics.get(name.toLowerCase());
	}
	
	public IRContext[] getContexts() {
		return contexts.toArray(new IRContext[contexts.size()]);
	}
	
	public void add( IRPackage pack ) {
		String curName = pack.getName().toLowerCase();
		if(packages.get(curName)!=null) {
			parser.err.redeclaration(packages.get(curName), pack);
		}
		packages.put(curName, pack);
		put(pack);
	}
	
	public IRPackage[] getPackages() {
		return packages.values().toArray( new IRPackage[packages.size()] );
	}
	
	public IRPackage getPackage( String name ) {
		IRPackage res = packages.get(name.toLowerCase());
		if( res != null ) return res;
		IRNamedElement el = library.getElement(name);
		if( el != null || el instanceof IRPackage ) return (IRPackage) el;
		return null;
	}
	
	public IRPackage getOrCreatePackage( String name ) {
		// TODO Это используется для случая когда тело пакета встретилось, но такого пакета нет
		// возможно что такого не должно быть и это ошибка
		IRPackage res;
		res = getPackage(name);
		if( res != null ) return res;
		res = new IRPackage(name, getContext());
		add(res);
		getLibrary().putElement(res);
		return res;
	}
	
	
	public void use( IRNamedElement el ) {
		if( el == null ) return;
		if( el instanceof IRType ) {
			IRType type = (IRType) el;
			getContext().types.put(type, getContext());
			getContext().map.put(type.getName().toLowerCase(), type);
		} else if( el instanceof IRConstant ) {
			IRConstant cnst = (IRConstant) el;
			getContext().add(cnst);
		} else if( el instanceof IRSubProgram ) {
			IRSubProgram sub = (IRSubProgram) el;
			getContext().add(sub);
		} else if( el instanceof IREnumValue ) {
			IREnumValue en = (IREnumValue) el;
			getContext().add(en);
		} else if( el instanceof IRSubProgram ) {
			IRSubProgram sub = (IRSubProgram) el;
			getContext().add(sub);
		} else if( el instanceof IREntity ) {
			IREntity en = (IREntity) el;
			getContext().put(en);
		} else if( el instanceof IRPackage ) {
			IRPackage pack = (IRPackage) el;
			useAllInPackage(pack);
		} else if( el instanceof IRPhysicalUnits ) {
			IRPhysicalUnits ph = (IRPhysicalUnits) el;
			getContext().put(ph);
		} else if( el instanceof IRSignal ) {
			getContext().put(el);
		} else if( el instanceof IRUseAllObjects ) {
			useAll( ((IRUseAllObjects)el).getUseAllAt() );
		} else {
			throw new RuntimeException(el.toString() + " - " + el.getClass().toString());
		}
	}
	
	public void use( IRPackage pack, String element ) {
		IRNamedElement el = pack.getDeclarations().localResolve(element);
		use(el);
	}
	
	public void useAll( IRNamedElement el ) {
		if( el == null ) return;
		if( el instanceof IRPackage ) {
			useAllInPackage((IRPackage) el);
		} else if( el instanceof IREntity ) {
			
		} else if( el instanceof Library ) {
			useAllInLibrary((Library) el);
		} else {
			throw new RuntimeException(el.getName());
		}
	}

	public void useAllInPackage(IRPackage pack) {
		if( pack.getFullName().equalsIgnoreCase("work.standard_types") ) {
			int a = 0;
			a++;
		}
		getContext().put(pack);
		for( int i = 0; i < pack.declarations.constants.size(); i++ ) {
			IRConstant cnst = pack.declarations.constants.get(i);
			use(cnst);
		}
		for( int i = 0; i < pack.declarations.subprograms.size(); i++ ) {
			IRSubProgram sub = pack.declarations.subprograms.get(i);
			use(sub);
		}
		for( int i = 0; i < pack.declarations.enums.size(); i++ ) {
			IREnumValue en = pack.declarations.enums.get(i);
			use(en);
		}
		for( int i = 0; i < pack.declarations.units.size(); i++ ) {
			IRPhysicalUnits en = pack.declarations.units.get(i);
			use(en);
		}
		for( IRSignal sig : pack.declarations.signals ) {
			use(sig);
		}
		IRComponent[] comps = pack.comps.values().toArray(new IRComponent[pack.comps.size()]);
		for( int i = 0; i < comps.length; i++ ) {
			getContext().addComponentType(comps[i]);
		}
		IRType[] types = pack.declarations.types.getTypes();
		for( IRType t : types ) {
			use(t);
		}
//		Set<Entry<String,IRType>> types = pack.declarations.types.types.entrySet();
//		Iterator<Entry<String, IRType>> it = types.iterator();
//		while( it.hasNext() ) {
//			IRType type = it.next().getValue();
//			use(type);
//		}
	}
	
	public void useAllInLibrary(Library lib) {
		for( IRNamedElement el : lib.getElements() ) {
			use( el );
		}
	}
	
	public void libraryClosure() {
		advanceContext();
	}
	
	public void startOfPrimaryUnit() {
		
	}
	public void endOfPrimaryUnit() {
//		System.out.println("endOfPrimaryUnit() at line " + parser.token.beginLine);
//		primaryUnitEnded = true;
//		advanceContext();
	}
	
	public void startOfContextClosure() {
//		if( primaryUnitEnded ) {
//			System.out.println("startOfContextClosure() at line " + parser.token.beginLine);
//			primaryUnitEnded = false;
//			subprograms.subs.clear();
//		}
	}

	@Override
	public boolean contains(IRNamedElement el) {
		return map.containsValue(el);
	}

	@Override
	public IRNamedElement localResolve(String name) {
		return map.get(name.toLowerCase());
	}

	@Override
	public void localResolve(IRSubprogramSearchContext context) {
	}

}
