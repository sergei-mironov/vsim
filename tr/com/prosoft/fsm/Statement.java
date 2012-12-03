package com.prosoft.fsm;

import com.prosoft.fsm.parser.Token;

public class Statement {

	Token[] tokens;

	public Statement(Token[] tokens) {
		this.tokens = tokens;
	}

	public Token[] getTokens() {
		return tokens;
	}
	
	
}
