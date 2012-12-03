package com.prosoft.fsm;

import java.util.ArrayList;

import com.prosoft.common.name.Name;

public abstract class StateHolder {
	
	ArrayList<State> states = new ArrayList<State>();
	ArrayList<Name> otherParents = new ArrayList<Name>();
	StateHolder parent;
	String name;
	String stateTag;

	public StateHolder( StateHolder parent, String name ) {
		this.parent = parent;
		this.name = name;
	}

	public void add( State action ) {
		states.add(action);
	}
	
	public void addOtherParent( Name parent ) {
		otherParents.add(parent);
	}
	
	public ArrayList<State> getStates() {
		return states;
	}

	public StateHolder getParent() {
		return parent;
	}

	public String getName() {
		return name;
	}

	public String getStateTag() {
		return stateTag;
	}

	public void setStateTag(String stateTag) {
		this.stateTag = stateTag;
	}

	public State getState( String name ) {
		for( int i = 0; i < states.size(); i++ ) {
			if( states.get(i).name.equals(name) ) {
				return states.get(i);
			}
		}
		return null;
	}
	
	public FSM getFSM() {
		if( this instanceof FSM ) return (FSM) this;
		return parent.getFSM();
	}
	
	public StateHolder resolve(Name name) {
		if( name.length() == 0 ) return getFSM();
		State state = getState(name.first());
		if( state != null ) {
			if( name.length() == 1 ) return state;
			return state.resolve(name.removeHead());
		} else {
			return getFSM().resolve(name);
		}
	}
	
	public State getState(Name name) {
		StateHolder res = getState(name.first());
		if( res != null ) {
			State st = (State) res.parent.resolve(name);
			return st;
		}
		return (State) getFSM().resolve(name);
	}
	
	public void getAllChildStates(ArrayList<State> res) {
		for( int i = 0; i < states.size(); i++ ) {
			res.add(states.get(i));
			states.get(i).getAllChildStates(res);
		}
	}

	public String toString() {
		return name;
	}
}
