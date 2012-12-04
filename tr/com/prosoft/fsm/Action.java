package com.prosoft.fsm;

public class Action {

	State state;
	ActionKind kind;
	Statement statement;
	
	public Action(State state, ActionKind kind, Statement statement) {
		this.state = state;
		this.kind = kind;
		this.statement = statement;
	}

	public ActionKind getKind() {
		return kind;
	}

	public Statement getStatement() {
		return statement;
	}

	public State getState() {
		return state;
	}
	
	
}
