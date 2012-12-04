package com.prosoft.vhdl.gen.java;

import java.util.HashMap;
import java.util.HashSet;

import com.prosoft.vhdl.ir.IRNamedElement;
import com.prosoft.vhdl.ir.IRSignal;

public class JavaNameSpace {

	HashMap<IRNamedElement, String> map = new HashMap<IRNamedElement, String>();
	HashSet<String> set = new HashSet<String>();
	
	protected String getElementFullName(IRNamedElement el) {
		if( el instanceof IRSignal ) {
			IRSignal sig = (IRSignal) el;
			String res = sig.getName();
			while( sig.getParent() != null ) {
				sig = (IRSignal) sig.getParent();
				res = sig.getName() + "_" + res;
			}
			return res;
		} else {
			return el.getName();
		}
	}
	
	public String getJavaName(IRNamedElement el) {
		String res = map.get(el);
		if( res != null ) return res;
		String newName = getElementFullName(el);
		int index = 0;
		while( set.contains(newName) ) {
			newName = getElementFullName(el) + index++;
		}
		set.add(newName);
		map.put(el, newName);
		return newName;
	}
}
