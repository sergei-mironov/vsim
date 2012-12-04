package com.prosoft.fsm.gen;

import java.math.BigInteger;
import java.util.ArrayList;

import com.prosoft.fsm.FSM;
import com.prosoft.fsm.IDGenerator;
import com.prosoft.fsm.State;
import com.prosoft.fsm.StateHolder;
import com.prosoft.fsm.StateID;

public class DumbIDGenerator implements IDGenerator {
	
	BigInteger lastID = BigInteger.ZERO;
	
	protected void generateInternal( StateHolder holder ) {
		String stateID = holder.getStateTag();
		if( stateID == null ) stateID = "fsm";
		stateID += "_state";
		holder.setStateTag(stateID);
		ArrayList<State> states = holder.getStates();
		for( int i = 0; i < states.size(); i++ ) {
			State state = states.get(i);
			String tag = state.getName() + "_id";
			state.setStateID(new StateID(tag, lastID));
			lastID = lastID.add(BigInteger.ONE);
		}
		for( int i = 0; i < states.size(); i++ ) {
			State state = states.get(i);
			generateInternal(state);
		}
	}

	@Override
	public void generateIDs(FSM fsm) {
		generateInternal(fsm);
	}

}
