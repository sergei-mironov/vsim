package com.prosoft.vhdl.gen.vir;

import java.util.HashMap;
import java.util.HashSet;

import com.prosoft.vhdl.ir.IRNamedElement;
import com.prosoft.vhdl.ir.IRPrimary;
import com.prosoft.vhdl.ir.IRSignal;
import com.prosoft.vhdl.ir.IUniqueNamedElement;

public class VNameSpace {

	HashMap<IRNamedElement, String> map = new HashMap<IRNamedElement, String>();
	HashSet<String> set = new HashSet<String>();
	
//	protected String getElementFullName(IUniqueNamedElement el) {
//		if( el instanceof IRSignal ) {
//			IRSignal sig = (IRSignal) el;
//			String res = sig.getName();
//			while( sig.getParent() != null ) {
//				sig = sig.getParent();
//				res = sig.getName() + "_" + res;
//			}
//			return res;
//		} else if( el instanceof IRNamedElement ){
//			IRNamedElement nel = (IRNamedElement) el;
//			return nel.getName().toLowerCase();
//		} else {
//			throw new RuntimeException(el.getClass().getSimpleName());
//		}
//	}
	
	public String getUniqueName(IRNamedElement el, String suggestedName) {
		String res = map.get(el);
		if( res != null ) return res;
		String newName = suggestedName;
		int index = 0;
		while( set.contains(newName) ) {
			newName = suggestedName + index++;
		}
		set.add(newName);
		map.put( (IRNamedElement) el, newName );
		return newName;
	}
	
//	public String getUniqueName(IRNamedElement el, String suggestedName) {
//		String res = map.get(el);
//		if( res != null ) return res;
//		String newName = suggestedName;
//		int index = 0;
//		while( set.contains(newName) ) {
//			newName = suggestedName + index++;
//		}
//		set.add(newName);
//		map.put( (IRNamedElement) el, newName );
//		return newName;
//	}
	
//	public String getUniqueName(IUniqueNamedElement el) {
//		String newName = getElementFullName(el);
//		// для параметров уникальные имена не генерируем
//		if( !(el instanceof IRPrimary && ((IRPrimary)el).isParameter()) ) {
//			newName = getUniqueName(el, newName);
//			el.setUniqueName(newName);
//		}
//		return newName;
//	}
}
