package com.prosoft.fsm;

import java.util.ArrayList;

public class FSM extends StateHolder {

	public FSM(String name) {
		super(null, name);
	}

	public ArrayList<State> getAllStates() {
		ArrayList<State> res = new ArrayList<State>();
		getAllChildStates(res);
		return res;
	}
}
