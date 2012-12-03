package com.prosoft.vhdl.ir;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import com.prosoft.glue.HDLKind;

public class IRContext extends IRNamedElement implements IRConstantHolder, ILocalResolver, IRTypeHolder, IREnumHolder, 
    IRSubProgramHolder, IRComponentTypeHolder {
	
	static int index;
	
	IRTypes types = new IRTypes();
	IRSubprograms subprograms = new IRSubprograms();
	ArrayList<IRConstant> constants = new ArrayList<IRConstant>();
	ArrayList<IREntity> entities = new ArrayList<IREntity>();
	ArrayList<IREnumValue> enums = new ArrayList<IREnumValue>();
	HashMap<String, IRNamedElement> map = new HashMap<String, IRNamedElement>();

	public IRContext(IRDesignFile parent) {
		super(parent, "$context" + index++);
		IRType[] ts = types.getTypes();
		for( IRType t : ts ) {
			put(t);
		}
	}
	
	public IRDesignFile getDesignFile() {
		return (IRDesignFile) getParent();
	}

	public IREntity[] getEntities() {
		return entities.toArray( new IREntity[getContext().entities.size()] );
	}
	
	public void put( IRNamedElement el ) {
		map.put(el.getName().toLowerCase(), el);
	}

	@Override
	public void add(IRSubProgram sub) {
		map.put(sub.getName().toLowerCase(), sub);
		map.put(sub.getCanonicalName(), sub);
		subprograms.add(sub);
	}

	@Override
	public void add(IRConstant cnst) {
		constants.add(cnst);
		put(cnst);
	}

	@Override
	public IRNamedElement localResolve(String name) {
		return map.get(name.toLowerCase());
	}

	@Override
	public void addType(IRType type) {
		types.put(type, this);
		put(type);
		type.setParent(this);
	}

	@Override
	public IRType getType(String name) {
		return types.get(name);
	}

	@Override
	public void add(IREnumValue value) {
		put(value);
		enums.add(value);
	}

	public IRType[] getTypes() {
		return types.getTypes();
	}

	@Override
	public boolean containsType(IRType type) {
		return types.contains(type);
	}

	@Override
	public boolean contains(IRNamedElement el) {
		return map.containsValue(el);
	}

	public void addEntity( IREntity entity ) {
		entities.add(entity);
		getDesignFile().library.putElement(entity);
	}
	
	public IREntity getEntity( String name ) {
		/*
		Iterator<IREntity> it = entities.iterator();
		while( it.hasNext() ) {
			IREntity en = it.next();
			if( en.getName().equalsIgnoreCase(name) ) {
				return en;
			}
		}*/
		IRNamedElement el = getDesignFile().library.getElement(name.toLowerCase());
		if( el != null ) {
			if( el instanceof IREntity ) return (IREntity) el;
			if( el instanceof IRComponent ) {
				IRComponent comp = (IRComponent) el;
				if( comp.getImplementation() != null && comp.getImplementation().getKind() == HDLKind.VHDL ) {
					return comp.getImplementation().getEntity();
				}
			}
		}
		return null;
	}
	
	@Override
	public void localResolve(IRSubprogramSearchContext context) {
		subprograms.getMatchedByName(context);
	}

	@Override
	public IRSubprograms getSubprograms() {
		return subprograms;
	}

	HashMap<String, IRComponent> comps = new HashMap<String, IRComponent>();

	@Override
	public void addComponentType(IRComponent comp) {
		comps.put(comp.getName().toLowerCase(), comp);
	}

	@Override
	public IRComponent getComponent(String name) {
		IRComponent res = comps.get(name.toLowerCase());
		if( res != null ) return res;
		return getDesignFile().library.getComponent(name);
	}

}
