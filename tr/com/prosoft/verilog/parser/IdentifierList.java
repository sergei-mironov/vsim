package com.prosoft.verilog.parser;

import java.util.ArrayList;

public class IdentifierList {

	ArrayList<Token> ids = new ArrayList<Token>();
	
	void add( Token t ) {
		ids.add(t);
	}
}
