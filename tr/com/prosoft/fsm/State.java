package com.prosoft.fsm;

import java.util.ArrayList;

import com.prosoft.common.name.Name;

public class State extends StateHolder {
	
	ArrayList<Transition> transitions = new ArrayList<Transition>();
	ArrayList<Action> actions = new ArrayList<Action>();
	StateID stateID;
	Name fullName;

	public State(StateHolder parent, String name) {
		super(parent, name);
	}

	public void add( Transition transition ) {
		transitions.add(transition);
	}
	
	public void add( Action action ) {
		actions.add(action);
	}
	
	public StateID getStateID() {
		return stateID;
	}

	public void setStateID(StateID stateID) {
		this.stateID = stateID;
	}

	public ArrayList<Transition> getTransitions() {
		return transitions;
	}

	public ArrayList<Transition> getTransitions( boolean includeParent ) {
		if( !includeParent ) return transitions;
		ArrayList<Transition> res = new ArrayList<Transition>();
		getTransitionsFromAllParents(res, this);
		for( int i = 0; i < otherParents.size(); i++ ) {
			getTransitionsFromAllParents(res, (State) getParent().resolve(otherParents.get(i)) );
		}
		return res;
	}
	
	protected static void getTransitionsFromAllParents( ArrayList<Transition> res, State st ) {
		do {
			for( int i = 0; i < st.transitions.size(); i++ ) {
				Transition t = st.transitions.get(i);
				if( !res.contains(t) ) res.add(t);
			}
			if(st.parent instanceof FSM) break;
			st = (State) st.parent;
		} while( true );
	}

	public ArrayList<Action> getActions() {
		return actions;
	}
	
	public Name getFullName() {
		if( fullName == null ) {
			if( parent instanceof FSM ) {
				fullName = new Name(new String[]{name});
			} else {
				fullName = ((State)parent).getFullName().append(name);
			}
		}
		return fullName;
	}

	public void getActions( ArrayList<Action> res, ActionKind kind ) {
		for( int i = 0; i < actions.size(); i++ ) {
			Action act = actions.get(i);
			if( act.kind == kind ) {
				res.add(act);
			}
		}
	}
	
	public void getActions( ArrayList<Action> res, ActionKind kind, StateHolder upto, boolean parentIsFirst ) {
		if( upto == this ) return;
		if( parentIsFirst ) {
			if( parent instanceof State && parent != upto ) ((State)parent).getActions(res, kind, upto, parentIsFirst);
			for( int i = 0; i < otherParents.size(); i++ ) {
				State st = (State) ((State)parent).resolve(otherParents.get(i));
				Name topName = st.getFullName().getCommonPart(getFullName());
				StateHolder top = st.resolve(topName);
				st.getActions(res, kind, top, parentIsFirst);
			}
			getActions(res, kind);
		} else {
			getActions(res, kind);
			if( parent instanceof State && parent != upto ) ((State)parent).getActions(res, kind, upto, parentIsFirst);
			for( int i = 0; i < otherParents.size(); i++ ) {
				State st = (State) ((State)parent).resolve(otherParents.get(i));
				Name topName = st.getFullName().getCommonPart(getFullName());
				StateHolder top = st.resolve(topName);
				st.getActions(res, kind, top, parentIsFirst);
			}
		}
	}
}
