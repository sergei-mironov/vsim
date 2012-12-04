package com.prosoft.fsm;

import com.prosoft.common.name.Name;

public class Transition {

	State owner;
	Name target;
	Oper condition;
	Statement statement;
	
	public Transition(State owner, Name target, Oper condition,
			Statement statement) {
		this.owner = owner;
		this.target = target;
		this.condition = condition;
		this.statement = statement;
	}

	public State getOwner() {
		return owner;
	}

	public Name getTargetName() {
		return target;
	}

	public Oper getCondition() {
		return condition;
	}

	public Statement getStatement() {
		return statement;
	}
	
	public State getTarget() {
		return owner.getState(target);
	}
}
