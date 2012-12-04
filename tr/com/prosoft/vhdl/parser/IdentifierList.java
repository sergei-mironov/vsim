package com.prosoft.vhdl.parser;

import java.util.ArrayList;

public class IdentifierList {

	ArrayList<Token> list = new ArrayList<Token>();
	
	void add( Token id ) {
		list.add(id);
	}
	
	public String toString() {
		StringBuffer res = new StringBuffer();
		for( int i = 0; i < list.size(); i++ ) {
			res.append( list.get(i) + ", ");
		}
		return res.toString();
	}
	
	public boolean contains( String name ) {
		for( int i = 0; i < list.size(); i++ ) {
			if( name.equalsIgnoreCase(list.get(i).image)) return true;
		}
		return false;
	}
}
