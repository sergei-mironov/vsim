package com.prosoft.vhdl.ir;

import java.util.ArrayList;
import java.util.HashMap;

public class IRTypes {
	
	public static final boolean copyAnyWay = false;

	private HashMap<String, IRType> types = new HashMap<String, IRType>();
	private ArrayList<IRType> array = new ArrayList<IRType>();
	
	public IRType get( String name ) {
		IRType res = types.get(name.toLowerCase());
		if( copyAnyWay ) {
			if( res != null ) res = res.dup();
		} else {
			if( res instanceof IRangedElement ) {
//				res = (IRType) ((IRangedElement)res).dup();
			}
		}
		return res;
	}
	
	public void put( IRType type, IRTypeHolder holder ) {
		IRType old = types.get(type.getName());
		if( old != null ) {
			if( old.getPackage() != null && !old.getPackage().isStandard() ) {
//				type.getPackage().getLibrary().getEnvironment().err.redeclaration(old, type);
			}
		}
		types.put(type.getName().toLowerCase(), type);
		array.add(type);
		if( type.isEnum() ) {
			IRTypeEnum en = (IRTypeEnum) type;
			for( int i = 0; i < en.getNumValues(); i++ ) {
				holder.add(en.getValue(i));
			}
		}
	}
	
	public IRType[] getTypes() {
		return array.toArray( new IRType[array.size()] );
	}
	
	public void getTypes(ArrayList<IRType> res) {
		for( IRType t : array ) {
			res.add(t);
		}
	}
	
	public boolean contains(IRType type) {
		return types.containsValue(type);
	}
	
//	IRTypes putStdTypes() {
//        // перенес integer и real в standard.vhd, чтобы parent был
//        //		put( IRTypeInteger.TYPE );        
////		put( new IRTypeInteger("natural", true) );
////		put( new IRTypeReal(null, "real") );
////		put( IRTypeStdLogic.std_logic );
////		put( IRTypeStdLogic.std_ulogic );
////		put( IRTypeStdLogicVector.std_logic_vector() );
////		put( IRTypeStdLogicVector.std_ulogic_vector() );
//		return this;
//	}
}
